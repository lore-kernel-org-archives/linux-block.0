Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeAQJ6G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 04:58:06 -0500
Date: Wed, 17 Jan 2018 17:57:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        James Smart <james.smart@broadcom.com>,
        Jens Axboe <axboe@fb.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
Message-ID: <20180117095744.GF9487@ming.t460p>
References: <20180112025306.28004-3-ming.lei@redhat.com>
 <0d36c16b-cb4b-6088-fdf3-2fe5d8f33cd7@oracle.com>
 <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
 <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
 <20180117062251.GC9487@ming.t460p>
 <977e9c62-c7f2-d1df-7d6b-5903f3b21cb6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <977e9c62-c7f2-d1df-7d6b-5903f3b21cb6@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jianchao,

On Wed, Jan 17, 2018 at 04:09:11PM +0800, jianchao.wang wrote:
> Hi ming 
> 
> Thanks for your kindly response.
> 
> On 01/17/2018 02:22 PM, Ming Lei wrote:
> > This warning can't be removed completely, for example, the CPU figured
> > in blk_mq_hctx_next_cpu(hctx) can be put on again just after the
> > following call returns and before __blk_mq_run_hw_queue() is scheduled
> > to run.
> > 
> > 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work, msecs_to_jiffies(msecs))
> We could use cpu_active in __blk_mq_run_hw_queue() to narrow the window.
> There is a big gap between cpu_online and cpu_active. rebind_workers is also between them.

This warning is harmless, also you can't reproduce it without help of your
special patch, I guess, :-) So the window shouldn't be a big deal. 

But it can be a problem about the delay(msecs_to_jiffies(msecs)) passed to
kblockd_mod_delayed_work_on(), because during the period:

1) hctx->next_cpu can become online from offline before __blk_mq_run_hw_queue
is run, your warning is triggered, but it is harmless

2) hctx->next_cpu can become offline from online before __blk_mq_run_hw_queue
is run, there isn't warning, but once the IO is submitted to hardware,
after it is completed, how does the HBA/hw queue notify CPU since CPUs
assigned to this hw queue(irq vector) are offline? blk-mq's timeout
handler may cover that, but looks too tricky.

> 
> > 
> > Just be curious how you trigger this issue? And is it triggered in CPU
> > hotplug stress test? Or in a normal use case?
> 
> In fact, this is my own investigation about whether the .queue_rq to one hardware queue could be executed on
> the cpu where it is not mapped. Finally, found this hole when cpu hotplug.
> I did the test on NVMe device which has 1-to-1 mapping between cpu and hctx.
>  - A special patch that could hold some requests on ctx->rq_list though .get_budget
>  - A script issues IOs with fio
>  - A script online/offline the cpus continuously

Thanks for sharing your reproduction approach.

Without a handler for CPU hotplug, it isn't easy to avoid the warning
completely in __blk_mq_run_hw_queue().

> At first, just the warning above. Then after this patch was introduced, panic came up.

We have to fix the panic, so I will post the patch you tested in this thread.

Thanks,
Ming
