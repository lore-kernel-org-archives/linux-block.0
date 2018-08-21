Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
To: Jens Axboe <axboe@kernel.dk>
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534749606-7311-2-git-send-email-jianchao.w.wang@oracle.com>
 <048cdf08-6c9e-f54a-1e5c-f1d40fb2ecdb@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a9379a69-cfaf-56b5-9c2b-b4c4e35f6a67@oracle.com>
Date: Tue, 21 Aug 2018 15:18:24 +0800
MIME-Version: 1.0
In-Reply-To: <048cdf08-6c9e-f54a-1e5c-f1d40fb2ecdb@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 08/20/2018 10:45 PM, Jens Axboe wrote:
> On 8/20/18 1:20 AM, Jianchao Wang wrote:
>> @@ -2913,6 +2906,29 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>  		blk_mq_freeze_queue(q);
>>  
>> +	/*
>> +	 * switch io scheduler to NULL to clean up the data in it.
>> +	 * will get it back after update mapping between cpu and hw queues.
>> +	 */
> 
> "Switch IO scheduler to 'none', cleaning up the data associated with
> the previous scheduler. We'll switch back once we're done updating
> the new sw to hw queue mappings.
> 
>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +		if (!q->elevator) {
>> +			q->elv_type = NULL;
>> +			continue;
>> +		}
>> +		q->elv_type = q->elevator->type;
>> +		mutex_lock(&q->sysfs_lock);
>> +		/*
>> +		 * After elevator_switch_mq, the previous elevator_queue will be
>> +		 * released by elevator_release. The reference of the io scheduler
>> +		 * module get by elevator_get will also be put. So we need to get
>> +		 * a reference of the io scheduler module here to prevent it to be
>> +		 * removed.
>> +		 */
>> +		__module_get(q->elv_type->elevator_owner);
>> +		elevator_switch_mq(q, NULL);
>> +		mutex_unlock(&q->sysfs_lock);
>> +	}
> 
> I don't hate this, but I also find it pretty annoying to put local state
> into the queue itself. It would be much nicer _not_ to have ->elv_type
> in the queue itself. That would need an allocation, however...
> 
> Apart from those two things, looks fine to me.
> 

Thanks very much for your comment.
I have reworked this patch based on your kindly suggestion and posted the V4.

Thanks
Jianchao
