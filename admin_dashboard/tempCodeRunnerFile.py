class fees(models.Model):
    
    fee_id = models.CharField(max_length=50, null=True),
    value = models.DecimalField(max_digits=6, decimal_places = 2, null=True)

    class Meta:
        db_table = 'fees'
