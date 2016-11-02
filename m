Subject: Re: [PATCH 5/8] block: add code to track actual device queue depth
To: Christoph Hellwig <hch@lst.de>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-6-git-send-email-axboe@fb.com>
 <20161102145908.GI13964@lst.de>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, jack@suse.cz
From: Jens Axboe <axboe@fb.com>
Message-ID: <c2295532-22a0-0c70-d6f9-7e13e76a1906@fb.com>
Date: Wed, 2 Nov 2016 09:02:08 -0600
MIME-Version: 1.0
In-Reply-To: <20161102145908.GI13964@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/02/2016 08:59 AM, Christoph Hellwig wrote:
> On Tue, Nov 01, 2016 at 03:08:48PM -0600, Jens Axboe wrote:
>> For blk-mq, ->nr_requests does track queue depth, at least at init
>> time. But for the older queue paths, it's simply a soft setting.
>> On top of that, it's generally larger than the hardware setting
>> on purpose, to allow backup of requests for merging.
>>
>> Fill a hole in struct request with a 'queue_depth' member, that
>
> That would be struct request_queue..

Good catch, will fix.

>>  /**
>> + * blk_set_queue_depth - tell the block layer about the device queue depth
>> + * @q:		the request queue for the device
>> + * @depth:		queue depth
>> + *
>> + */
>> +void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
>> +{
>> +	q->queue_depth = depth;
>> +}
>> +EXPORT_SYMBOL(blk_set_queue_depth);
>
> Do we really need this wrapper?

Not necessarily, just seems like a nicer API than manually setting the
field. Not a big deal to me, though.

>> +++ b/drivers/scsi/scsi.c
>> @@ -621,6 +621,9 @@ int scsi_change_queue_depth(struct scsi_device *sdev, int depth)
>>  		wmb();
>>  	}
>>
>> +	if (sdev->request_queue)
>> +		blk_set_queue_depth(sdev->request_queue, depth);
>> +
>>  	return sdev->queue_depth;
>
> Can we kill the scsi_device queue_depth member and just always use
> the request_queue one?

Yes. I'd prefer that we do that through the SCSI tree, once this is in
though.


-- 
Jens Axboe
