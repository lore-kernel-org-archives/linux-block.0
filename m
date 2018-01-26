Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752511AbeAZJb7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jan 2018 04:31:59 -0500
Date: Fri, 26 Jan 2018 17:31:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@fb.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        James Smart <james.smart@broadcom.com>,
        linux-block@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
Message-ID: <20180126093129.GA10926@ming.t460p>
References: <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
 <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
 <20180117062251.GC9487@ming.t460p>
 <977e9c62-c7f2-d1df-7d6b-5903f3b21cb6@oracle.com>
 <20180117095744.GF9487@ming.t460p>
 <53da00dc-3d46-dcdb-2be4-277f79a9888b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53da00dc-3d46-dcdb-2be4-277f79a9888b@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jianchao,

On Fri, Jan 19, 2018 at 11:05:35AM +0800, jianchao.wang wrote:
> Hi ming
> 
> Sorry for delayed report this.
> 
> On 01/17/2018 05:57 PM, Ming Lei wrote:
> > 2) hctx->next_cpu can become offline from online before __blk_mq_run_hw_queue
> > is run, there isn't warning, but once the IO is submitted to hardware,
> > after it is completed, how does the HBA/hw queue notify CPU since CPUs
> > assigned to this hw queue(irq vector) are offline? blk-mq's timeout
> > handler may cover that, but looks too tricky.
> 
> In theory, the irq affinity will be migrated to other cpu. This is done by

Yes, but the other CPU should belong to this irq's affinity, and if all
CPUs in the irq's affinity is DEAD, this irq vector will be shutdown,
and if there is in-flight IO or will be, then the completion for this
IOs won't be delivered to CPUs. And now seems we depend on queue's timeout
handler to handle them.

> fixup_irqs() in the context of stop_machine.


> However, in my test, I found this log:
> 
> [  267.161043] do_IRQ: 7.33 No irq handler for vector
> 
> The 33 is the vector used by nvme cq.
> The irq seems to be missed and sometimes IO hang occurred.

As I mentioned above, it shouldn't be strange to see in CPU offline/online
stress test.


-- 
Ming
