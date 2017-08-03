Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] blk-mq: provide internal in-flight variant
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-4-git-send-email-axboe@kernel.dk>
 <1501792912.2922.18.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fcb20ac-8744-4080-c5a2-d6dad771ee97@kernel.dk>
Date: Thu, 3 Aug 2017 14:45:23 -0600
MIME-Version: 1.0
In-Reply-To: <1501792912.2922.18.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/03/2017 02:41 PM, Bart Van Assche wrote:
> On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
>> We don't have to inc/dec some counter, since we can just
>> iterate the tags. That makes inc/dec a noop, but means we
>> have to iterate busy tags to get an in-flight count.
>> [ ... ]
>> +unsigned int blk_mq_in_flight(struct request_queue *q,
>> +			       struct hd_struct *part)
>> +{
>> +	struct mq_inflight mi = { .part = part, .inflight = 0 };
> 
> Hello Jens,
> 
> A minor stylistic comment: since a C compiler is required to
> initialize to zero all member variables that have not been initialized
> explicitly I think ".inflight = 0" can be left out.

It can, I'll kill it.

>> diff --git a/block/genhd.c b/block/genhd.c
>> index f735af67a0c9..ad5dc567d57f 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -45,6 +45,35 @@ static void disk_add_events(struct gendisk *disk);
>>  static void disk_del_events(struct gendisk *disk);
>>  static void disk_release_events(struct gendisk *disk);
>>  
>> +void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
>> +{
>> +	if (q->mq_ops)
>> +		return;
>> +
>> +	atomic_inc(&part->in_flight[rw]);
>> +	if (part->partno)
>> +		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
>> +}
>> [ ... ]
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 7f7427e00f9c..f2c5096b3a7e 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -362,28 +362,9 @@ static inline void free_part_stats(struct hd_struct *part)
>>  #define part_stat_sub(cpu, gendiskp, field, subnd)			\
>>  	part_stat_add(cpu, gendiskp, field, -subnd)
>>  
>> -static inline void part_inc_in_flight(struct request_queue *q,
>> -				      struct hd_struct *part, int rw)
>> -{
>> -	atomic_inc(&part->in_flight[rw]);
>> -	if (part->partno)
>> -		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
>> -}
>> [ ... ]
> 
> Sorry but to me it seems like this part of the patch does match with
> the patch description? The patch description mentions that inc and dec
> become a noop but it seems to me that these functions have been
> uninlined instead of making these a noop?

The inc/dec goes away for mq, the non-mq path still has to use them. I just
move them as well. Could be a prep patch, but it's just moving the code out
of the header and into a normal C file instead.

-- 
Jens Axboe
