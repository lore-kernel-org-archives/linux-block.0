Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750811AbeCLJJa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Mar 2018 05:09:30 -0400
Date: Mon, 12 Mar 2018 17:09:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, Jianchao Wang <jianchao.w.wang@oracle.com>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
Message-ID: <20180312090827.GB23903@ming.t460p>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
 <20180309172445.GC14765@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180309172445.GC14765@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 09, 2018 at 10:24:45AM -0700, Keith Busch wrote:
> On Thu, Mar 08, 2018 at 08:42:20AM +0100, Christoph Hellwig wrote:
> > 
> > So I suspect we'll need to go with a patch like this, just with a way
> > better changelog.
> 
> I have to agree this is required for that use case. I'll run some
> quick tests and propose an alternate changelog.
> 
> Longer term, the current way we're including offline present cpus either
> (a) has the driver allocate resources it can't use or (b) spreads the
> ones it can use thinner than they need to be. Why don't we rerun the
> irq spread under a hot cpu notifier for only online CPUs?

4b855ad371 ("blk-mq: Create hctx for each present CPU") removes handling
mapping change via hot cpu notifier. Not only code is cleaned up, but
also fixes very complicated queue dependency issue:

- loop/dm-rq queue depends on underlying queue
- for NVMe, IO queue depends on admin queue

If freezing queue can be avoided in CPU notifier, it should be fine to
do that, otherwise it need to be avoided.

Thanks,
Ming
