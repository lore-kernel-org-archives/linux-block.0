Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 09/30] scsi: kill off the legacy IO path
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20181031175922.8849-1-axboe@kernel.dk>
 <20181031175922.8849-10-axboe@kernel.dk> <20181101211156.GE18005@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ab3555e6-cf64-8faa-0469-75d890f49027@kernel.dk>
Date: Thu, 1 Nov 2018 16:31:41 -0600
MIME-Version: 1.0
In-Reply-To: <20181101211156.GE18005@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/1/18 3:11 PM, Omar Sandoval wrote:
>> -		if ((ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED) &&
>> -		    shost_use_blk_mq(host)) {
>> -			mq = true;
>> +		if (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED)
>>  			startit = true;
>> -		}
> 
> This could just be
> 
> 		startit = (QLA_TGT_MODE_ENABLED() ||
> 			   (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED));

I agree, just didn't want to make changes that would be harder to
verify. So kept as much as the original style as possible.

>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index fc1356d101b0..99db3f4316b5 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -780,11 +780,8 @@ MODULE_LICENSE("GPL");
>>  module_param(scsi_logging_level, int, S_IRUGO|S_IWUSR);
>>  MODULE_PARM_DESC(scsi_logging_level, "a bit mask of logging levels");
>>  
>> -#ifdef CONFIG_SCSI_MQ_DEFAULT
>> +/* Kill module parameter */
> 
> Is this a leftover todo comment for yourself, or a note for the future?
> If the latter, I think it could be clearer.

It's just a note for the future. I'll improve it.

>> -		unsigned long flags;
>> -
>> -		if (bidi_bytes)
>> -			scsi_release_bidi_buffers(cmd);
>> -		scsi_release_buffers(cmd);
>> -		scsi_put_command(cmd);
>> +	/*
>> +	 * In the MQ case the command gets freed by __blk_mq_end_request,
>> +	 * so we have to do all cleanup that depends on it earlier.
>> +	 *
>> +	 * We also can't kick the queues from irq context, so we
>> +	 * will have to defer it to a workqueue.
>> +	 */
> 
> This comment is slightly stale, since everything is the MQ case now.

Agree, but it's just copied over. Not a huge deal since it's generally
applicable, there's just no alternative :-)

>> @@ -367,7 +367,6 @@ store_shost_eh_deadline(struct device *dev, struct device_attribute *attr,
>>  
>>  static DEVICE_ATTR(eh_deadline, S_IRUGO | S_IWUSR, show_shost_eh_deadline, store_shost_eh_deadline);
>>  
>> -shost_rd_attr(use_blk_mq, "%d\n");
>>  shost_rd_attr(unique_id, "%u\n");
>>  shost_rd_attr(cmd_per_lun, "%hd\n");
>>  shost_rd_attr(can_queue, "%hd\n");
>> @@ -386,6 +385,13 @@ show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
>>  }
>>  static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
>>  
>> +static ssize_t
>> +show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	return snprintf(buf, 20, "1\n");
>> +}
> 
> Looks like you forgot to change this to sprintf()

Indeed, I'll make that change.

Thanks for the review!

-- 
Jens Axboe
