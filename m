Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/6] block: make part_in_flight() take an array of two
 ints
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com,
 bart.vanassche@wdc.com
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-4-git-send-email-axboe@kernel.dk>
 <20170808224256.GE4072@vader.DHCP.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7a99b84f-3f2e-85cc-ee1f-f4dfcc30f46d@kernel.dk>
Date: Tue, 8 Aug 2017 17:45:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170808224256.GE4072@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/08/2017 04:42 PM, Omar Sandoval wrote:
> On Fri, Aug 04, 2017 at 09:04:19AM -0600, Jens Axboe wrote:
>> Instead of returning the count that matches the partition, pass
>> in an array of two ints. Index 0 will be filled with the inflight
>> count for the partition in question, and index 1 will filled
>> with the root infligh count, if the partition passed in is not the
>> root.
>>
>> This is in preparation for being able to calculate both in one
>> go.
> 
> One tiny comment below, besides that
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 7f7427e00f9c..a9c8ea632fdc 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -378,11 +378,17 @@ static inline void part_dec_in_flight(struct request_queue *q,
>>  		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
>>  }
>>  
>> -static inline int part_in_flight(struct request_queue *q,
>> -				 struct hd_struct *part)
>> +static inline void part_in_flight(struct request_queue *q,
>> +				  struct hd_struct *part,
>> +				  unsigned int inflight[2])
>>  {
>> -	return atomic_read(&part->in_flight[0]) +
>> +	inflight[0] = atomic_read(&part->in_flight[0]) +
>>  			atomic_read(&part->in_flight[1]);
> 
> It makes me a little nervous here that we only initialize inflight[1] if
> part is not part0, that seems a little subtle and easy to miss. Can we
> change the line above to this?
> 
> inflight[0] = inflight[1] = (atomic_read(&part->in_flight[0]) +
> 			     atomic_read(&part->in_flight[1]));

Yes good point, I'll make that change.

-- 
Jens Axboe
