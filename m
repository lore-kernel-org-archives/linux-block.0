Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH] blk-mq: move timeout handling from queue to tagset
To: Keith Busch <keith.busch@linux.intel.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "hch@lst.de" <hch@lst.de>
References: <20180718170018.31395-1-keith.busch@intel.com>
 <11f7a7aff754b9bb0e4243ac4502319f376378c3.camel@wdc.com>
 <20180718174534.GC30873@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8c7c5d05-c5aa-8553-2ae4-c9fa5a11a32a@oracle.com>
Date: Thu, 19 Jul 2018 17:15:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180718174534.GC30873@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Keith

On 07/19/2018 01:45 AM, Keith Busch wrote:
>>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>  		/*
>>>  		 * Request timeouts are handled as a forward rolling timer. If
>>>  		 * we end up here it means that no requests are pending and
>>> @@ -881,7 +868,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
>>>  				blk_mq_tag_idle(hctx);
>>>  		}
>>>  	}
>>> -	blk_queue_exit(q);

The tags sharing fairness mechanism between different request_queues cannot work well here.
When timer is per-request_queue, if there is no request on one request_queue,
it could be idled. But now, with per-tagset timer, we cannot detect the idle one at all.


>   
>>> +	timer_setup(&set->timer, blk_mq_timed_out_timer, 0);
>>> +	INIT_WORK(&set->timeout_work, blk_mq_timeout_work);
>>> [ ... ]
>>> --- a/include/linux/blk-mq.h
>>> +++ b/include/linux/blk-mq.h
>>> @@ -86,6 +86,8 @@ struct blk_mq_tag_set {
>>>  
>>>  	struct blk_mq_tags	**tags;
>>>  
>>> +	struct timer_list	timer;
>>> +	struct work_struct	timeout_work;
>> Can the timer and timeout_work data structures be replaced by a single
>> delayed_work instance?
> I think so. I wanted to keep blk_add_timer relatively unchanged for this
> proposal, so I followed the existing pattern with the timer kicking the
> work. I don't see why that extra indirection is necessary, so I think
> it's a great idea. Unless anyone knows a reason not to, we can collapse
> this into a single delayed work for both mq and legacy as a prep patch
> before this one.

mod_delayed_work_on is very tricky in our scenario. It will grab the pending
work entry and queue it again.

delayed_work.timer trigger
queue_work timeout_work          delayed_work.timer not pending
                                 mod_delayed_work_on
                                   grab the pending timeout_work
                                 re-arm the timer

The timeout_work would not be run.

Thanks
Jianchao
