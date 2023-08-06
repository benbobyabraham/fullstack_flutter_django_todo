from django.db import models

class Todo(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=200)
    isDone = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return self.title[:20]