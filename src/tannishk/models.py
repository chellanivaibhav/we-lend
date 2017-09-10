from __future__ import unicode_literals

from django.db import models

# Create your models here.

class User(models.Model):
	username = models.CharField(max_length=100,blank=True,default='')
	password = models.CharField(max_length=100,blank=True,default='')
	wallet_number = models.CharField(max_length=120)
	aadhar_number = models.IntegerField()
	rating = models.IntegerField()
	is_bank = models.BooleanField(default=True)

class UserData(models.Model):
	num = models.CharField(max_length=200)

	def __str__(self):
		return self.num

class Community(models.Model):
	name = models.CharField(max_length = 120)
	members = models.ManyToManyField(UserData)
	rating = models.IntegerField()
	Desc = models.TextField() 

