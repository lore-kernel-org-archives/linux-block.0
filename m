Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754817AbdKAQ7V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Nov 2017 12:59:21 -0400
Date: Thu, 2 Nov 2017 00:59:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171101165902.GB7152@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <1509079996.3244.3.camel@wdc.com>
 <20171027053834.GA12858@ming.t460p>
 <1509395096.27259.15.camel@wdc.com>
 <20171031014728.GA12070@ming.t460p>
 <1509508448.2604.4.camel@wdc.com>
 <20171101040755.GB9527@ming.t460p>
 <1509554825.2530.32.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509554825.2530.32.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 01, 2017 at 04:47:06PM +0000, Bart Van Assche wrote:
> On Wed, 2017-11-01 at 12:08 +0800, Ming Lei wrote:
> > On Wed, Nov 01, 2017 at 03:54:09AM +0000, Bart Van Assche wrote:
> > > On Tue, 2017-10-31 at 09:47 +0800, Ming Lei wrote:
> > > > On Mon, Oct 30, 2017 at 08:24:57PM +0000, Bart Van Assche wrote:
> > > > > On Fri, 2017-10-27 at 13:38 +0800, Ming Lei wrote:
> > > > > > On Fri, Oct 27, 2017 at 04:53:18AM +0000, Bart Van Assche wrote:
> > > > > > > On Fri, 2017-10-27 at 12:43 +0800, Ming Lei wrote:
> > > > > > > > The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
> > > > > > > > by itself, and not necessary to waste CPU to do the expensive RESTART.
> > > > > > > > And Roman Pen reported that this RESTART cuts half of IOPS in his case.
> > > > > > > > 
> > > > > > > > The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
> > > > > > > > and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.
> > > > > > > 
> > > > > > > There are more block drivers than the SCSI core that share tags. If the
> > > > > > 
> > > > > > Could you share us what the other in-tree driver which share tags is?
> > > > > 
> > > > > I think the following in-tree drivers support shared tags (in alphabetical
> > > > > order):
> > > > > * null_blk. See also the shared_tags kernel module parameter.
> > > > > * nvme. See also nvme_alloc_ns().
> > > > > * scsi-mq.
> > > > 
> > > > For both null_blk and nvme, we don't need to deal with cross-queue RESTART,
> > > > because BLK_MQ_S_TAG_WAITING has handled it already.
> > > 
> > > blk_mq_dispatch_wait_add() returns immediately if BLK_MQ_S_TAG_WAITING is
> > > already set. Are you really sure that removing the restart mechanism doesn't
> > > break the NVMe driver if there are multiple namespaces?> 
> > If this flag is set, that means blk_mq_dispatch_wake() will be run when
> > driver tag is available, so the hw queue will be run at that time.
> 
> The only hw queue that will be rerun if BLK_MQ_S_TAG_WAITING is set is the hw
> queue for which that flag was set. Sorry but I don't think that mechanism by
> itself is sufficient to avoid queue lockups with the NVMe driver in case of
> shared namespaces. See also the description of commit da55f2cc7841 ("blk-mq:

Why?

> use sbq wait queues instead of restart for driver tags").

This commit just make sure that the hctx of BLK_MQ_S_TAG_WAITING will be
run again once there is driver tag available, see its commit log simply:

    However, we can still use the struct sbitmap_queue wait queues with a
    custom callback instead of blocking. This has a few benefits:
    
    1. It avoids iterating over all hardware queues when completing an I/O,
       which the current restart code has to do.
    2. It benefits from the existing rolling wakeup code.
    3. It avoids punting to another thread just to have it block.
    
The commit has described clearly that we don't need to iterate over all hw
queue when completing an I/O.

-- 
Ming
