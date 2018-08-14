Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH V2 04/17] blk-mq: don't reserve tags for admin queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-5-ming.lei@redhat.com>
 <14c6e892-b05f-7422-0fd3-da45a645d3ba@oracle.com>
 <20180813104822.GA18557@ming.t460p>
 <85e5fb60-fdf1-436e-8bc1-5480d5b2b17f@oracle.com>
 <20180814021045.GA32541@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <fb924241-9d4e-e0bb-096a-45054eb9b2fa@oracle.com>
Date: Tue, 14 Aug 2018 10:47:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180814021045.GA32541@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 08/14/2018 10:10 AM, Ming Lei wrote:
> On Tue, Aug 14, 2018 at 09:29:25AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 08/13/2018 06:48 PM, Ming Lei wrote:
>>> It is nothing to do with where the admin request is sent, so no any
>>> difference wrt. this issue between with and without this patchset,
>>> right?
>>
>> I'm afraid not.
>>
>> For example:
>>   A scsi host has 8 LUNs associated with it.
>>   Before this patch set,
>>   When we send out the admin command, the budget is _per_ LUN, 1/8 of the total tags.
>>   After this patch set,
>>   When we send out the admin command, the budget is equal to _one_ LUN, 1/8 of the total tags.
>>
>> However, the 1/8 above is different.
>>   Before the patch set, every LUN's admin command has 1/8 budget to use which is per LUN.
> 
> Strictly speaking, it is that all admin command and all other IOs share the 1/8 budget
> if they aimed at same LUN.

Yes.

> 
>>   After this patch set, all the 8 LUNs admin command has to share the 1/8 budget.
> 
> That only means number of active admin commands won't be bigger than 1/8 budget, which
> is one extra implicit limit on admin queue. However, other LUN's budget is still 1/8.
> 
> So performance for IO queue won't be affected at all, will it?
> 
> scsi_execute_* can't be called often, it is really in slow path, so I
> don't think there is any possible performance effect with this patch, or do
> you have other performance concern wrt. this patch?
> 
> We still have q->queue_depth for enhancing any limit for admin queue, but up to now,
> not see it is necessary.
> 

I agree with you that the performance will not be affected.
But the adminq's budget here looks weird.
We don't reserve budget for admin queue (not count tag->active_queues for it).
But the admin queue has to comply to the limit in hctx_may_queue.

Since the there isn't many in-flight admin commands usually, we could take
admin queue here out of the limit of hctx_may_queue, then things could be clearer. :)

Thanks
Jianchao
