from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from tannishk.models import User,Community,UserData
from tannishk.serializers import UserSerializer,CommunitySerializer
from django.views.decorators.csrf import csrf_exempt
@csrf_exempt
def user_list(request):
	if request.method =='GET':
		users = User.objects.all()
		serializer = UserSerializer(users,many=True)
		return JsonResponse(serializer.data,safe = False)

	elif request.method == 'POST':
		serializer = UserSerializer(data=request.data)
		if serializer.is_valid():
			serializer.save()
			return Response(serializer.data,status = status.HTTP_201_CREATED)
		return Response(serializer.error,status=status.HTTP_400_BAD_REQUEST)

@csrf_exempt
def user_detail(request, wallet_number):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        user = User.objects.get(wallet_number = wallet_number)
    except User.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = UserSerializer(user)
        return JsonResponse(serializer.data)

@csrf_exempt
def community_create(request):
	if request.method =='GET':
		communities = Community.objects.all()
		serializer = CommunitySerializer(communities,many=True)
		return JsonResponse(serializer.data,safe = False)

	elif request.method == 'POST':
		serializer = CommunitySerializer(data=request.data)
		if serializer.is_valid():
			serializer.save()
			return Response(serializer.data,status = status.HTTP_201_CREATED)
		return Response(serializer.error,status=status.HTTP_400_BAD_REQUEST)
@csrf_exempt
def community_add(request,id,wallet_number):
	#if request.method == 'GET':
	try:
		community = Community.objects.get(pk = id)
	except Community.DoesNotExist:
		return HttpResponse(status=404)

	community.members.add(UserData.objects.create(num=wallet_number))
	community.save()
	if request.method == 'GET':
		serializer = CommunitySerializer(community)
    	return JsonResponse(serializer.data)
@csrf_exempt
def community_id(request,id):
	try:
		community=Community.objects.get(pk=id)
	except Community.DoesNotExist:
		return HttpResponse(status=404)
	if request.method == 'GET':
		serializer=CommunitySerializer(community)
    	return JsonResponse(serializer.data)	
