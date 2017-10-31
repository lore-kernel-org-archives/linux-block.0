Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753247AbdJaBrs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2017 21:47:48 -0400
Date: Tue, 31 Oct 2017 09:47:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171031014728.GA12070@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <1509079996.3244.3.camel@wdc.com>
 <20171027053834.GA12858@ming.t460p>
 <1509395096.27259.15.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509395096.27259.15.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 30, 2017 at 08:24:57PM +0000, Bart Van Assche wrote:
> On Fri, 2017-10-27 at 13:38 +0800, Ming Lei wrote:
> > On Fri, Oct 27, 2017 at 04:53:18AM +0000, Bart Van Assche wrote:
> > > On Fri, 2017-10-27 at 12:43 +0800, Ming Lei wrote:
> > > > The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
> > > > by itself, and not necessary to waste CPU to do the expensive RESTART.
> > > > And Roman Pen reported that this RESTART cuts half of IOPS in his case.
> > > > 
> > > > The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
> > > > and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.
> > > 
> > > There are more block drivers than the SCSI core that share tags. If the
> > 
> > Could you share us what the other in-tree driver which share tags is?
> 
> I think the following in-tree drivers support shared tags (in alphabetical
> order):
> * null_blk. See also the shared_tags kernel module parameter.
> * nvme. See also nvme_alloc_ns().

For both null_blk and nvme, we don't need to deal with cross-queue RESTART,
because BLK_MQ_S_TAG_WAITING has handled it already.

> * scsi-mq.
> 
> Please note that the queue_rq() function of *all* these drivers can return
> BLK_STS_RESOURCE.

Yes, but this patch doesn't remove the RESTART for the current hctx, and
only removed the part of handling cross-queue RESTART.

> 
> > Actually SCSI's RESTART is very thin, and it is just the per-host starved_list.
> 
> Do you see any reason that would prevent to move that mechanism from scsi-mq
> into the blk-mq core?

I don't see it is required from SCSI's view since this way has been run
for SCSI for long time, and we don't have this requirement for other
in-tree drivers meantime.

Also as I mentioned before, driver has more knowledge than generic block
layer for making it more efficiently.

Thanks,
Ming
