from rest_framework import serializers
from tannishk.models import User,Community,UserData

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'password', 'wallet_number', 'aadhar_number', 'rating', 'is_bank')

class CommunitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Community
        fields = ('id', 'name', 'members', 'rating', 'Desc')
        depth=1

class UserDataSerializer(serializers.ModelSerializer):
	class Meta:
		model = UserData
		fields = ('num')