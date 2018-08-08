Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH 09/14] SCSI: create admin queue for each host
To: Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>
References: <20180807174433.8374-1-ming.lei@redhat.com>
 <20180807174433.8374-10-ming.lei@redhat.com>
 <dd553e06-738e-37cb-ec4a-c8b695cb1b79@oracle.com>
 <CACVXFVN-4aWUevkyYM3ViNym4nnsNwy_hhpNG-HTk758E8hJ2w@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b6bbd42f-503f-d409-1b0b-4977f0a8240c@oracle.com>
Date: Wed, 8 Aug 2018 15:34:18 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVN-4aWUevkyYM3ViNym4nnsNwy_hhpNG-HTk758E8hJ2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 08/08/2018 03:11 PM, Ming Lei wrote:
> On Wed, Aug 8, 2018 at 1:57 PM, jianchao.wang
> <jianchao.w.wang@oracle.com> wrote:
>> Hi Ming
>>
>> On 08/08/2018 01:44 AM, Ming Lei wrote:
>>>
>>> +static struct request_queue *scsi_mq_alloc_admin_queue(struct Scsi_Host *shost)
>>> +{
>>> +     struct request_queue *q = __blk_mq_init_queue(&shost->tag_set,
>>> +                     QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
>>> +     if (IS_ERR(q))
>>> +             return NULL;
>>> +
>>> +     q->mq_ops = &scsi_mq_admin_ops;
>>> +
>>> +     __scsi_init_queue(shost, q);
>>> +
>>> +     return q;
>>> +}
>>
>> In your patch set, the logical adminq per host is standalone request_queue which share
>> the tagset with other request_queue.
>>
>> Due to the hctx_may_queue,
>> If only one LUN, the adminq will take away half of the driver tags when
>> the adminq is active.
> 
> Most of times, the admin queue is inactive, so it shouldn't be a big deal.
> 
>> And when multiple LUNs, all of the LUNs have to share the limited budget of tags
>> of the adminq.
>> This is unacceptable.
> 
> That can be solved easily, such as, let __blk_mq_tag_busy() not take
> account of admin queue, will do it in V2.
> 
>>
>> And also, not all the admin request is send out through scsi_execute, maybe SG_IO.
>> So the admin queue here looks more like the pm queue ?
> 
> SG_IO should be covered by IO queue in which SCSI_PASSTHROUGH
> is enabled. It is reasonable too since SG_IO can be normal IO from
> userspace.
> 

I just concern too much complexity would be introduced by this logical admin queue. ;)

Thanks
Jianchao

 
