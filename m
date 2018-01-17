Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbeAQKRv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 05:17:51 -0500
Date: Wed, 17 Jan 2018 18:17:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
        linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        James Smart <james.smart@broadcom.com>,
        Jens Axboe <axboe@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
Message-ID: <20180117101731.GG9487@ming.t460p>
References: <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
 <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
 <20180117062251.GC9487@ming.t460p>
 <977e9c62-c7f2-d1df-7d6b-5903f3b21cb6@oracle.com>
 <20180117095744.GF9487@ming.t460p>
 <cd8ebf2d-3215-d1a2-7fce-54f1590e41e3@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cd8ebf2d-3215-d1a2-7fce-54f1590e41e3@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 17, 2018 at 11:07:48AM +0100, Christian Borntraeger wrote:
> 
> 
> On 01/17/2018 10:57 AM, Ming Lei wrote:
> > Hi Jianchao,
> > 
> > On Wed, Jan 17, 2018 at 04:09:11PM +0800, jianchao.wang wrote:
> >> Hi ming 
> >>
> >> Thanks for your kindly response.
> >>
> >> On 01/17/2018 02:22 PM, Ming Lei wrote:
> >>> This warning can't be removed completely, for example, the CPU figured
> >>> in blk_mq_hctx_next_cpu(hctx) can be put on again just after the
> >>> following call returns and before __blk_mq_run_hw_queue() is scheduled
> >>> to run.
> >>>
> >>> 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work, msecs_to_jiffies(msecs))
> >> We could use cpu_active in __blk_mq_run_hw_queue() to narrow the window.
> >> There is a big gap between cpu_online and cpu_active. rebind_workers is also between them.
> > 
> > This warning is harmless, also you can't reproduce it without help of your
> > special patch, I guess, :-) So the window shouldn't be a big deal. 
> 
> FWIW, every WARN_ON is problematic since there are people running with panic_on_warn.
> If a condition can happen we should not use WARN_ON but something else.

Agree, printk() should be fine, IMO.


-- 
Ming
