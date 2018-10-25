Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 08/28] scsi: kill off the legacy IO path
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
 Himanshu Madhani <himanshu.madhani@cavium.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-9-axboe@kernel.dk> <1540503399.66186.60.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <30e6eb38-dda5-f4c1-c715-379864268147@kernel.dk>
Date: Thu, 25 Oct 2018 16:18:29 -0600
MIME-Version: 1.0
In-Reply-To: <1540503399.66186.60.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 3:36 PM, Bart Van Assche wrote:
> On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
>> @@ -3265,25 +3261,17 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	    base_vha->mgmt_svr_loop_id, host->sg_tablesize);
>>  
>>  	if (ha->mqenable) {
>> -		bool mq = false;
>>  		bool startit = false;
>>  
>> -		if (QLA_TGT_MODE_ENABLED()) {
>> -			mq = true;
>> +		if (QLA_TGT_MODE_ENABLED())
>>  			startit = false;
>> -		}
>>  
>> -		if ((ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED) &&
>> -		    shost_use_blk_mq(host)) {
>> -			mq = true;
>> +		if (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED)
>>  			startit = true;
>> -		}
>>  
>> -		if (mq) {
>> -			/* Create start of day qpairs for Block MQ */
>> -			for (i = 0; i < ha->max_qpairs; i++)
>> -				qla2xxx_create_qpair(base_vha, 5, 0, startit);
>> -		}
>> +		/* Create start of day qpairs for Block MQ */
>> +		for (i = 0; i < ha->max_qpairs; i++)
>> +			qla2xxx_create_qpair(base_vha, 5, 0, startit);
>>  	}
>>  
>>  	if (ha->flags.running_gold_fw)
> 
> (+Himanshu)
> 
> Since I'm not sure that "mq" in the above code refers to "scsi-mq" nor that it
> refers to "blk-mq", I'm not sure the above changes should be included in this
> patch. Himanshu, can you have a look?

There's literally a comment there that says "for Block MQ" :-)

>> +static ssize_t
>> +show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	return snprintf(buf, 20, "1\n");
>> +}
>> +static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
> 
> The pattern "snprintf(buf, 20, ...)" looks like cargo-cult programming to me.
> Please consider changing "snprintf(buf, 20, " into "sprintf(buf, ".

Good point, I'll do that.

-- 
Jens Axboe
