Return-Path: <hch@lst.de>
Date: Thu, 8 Jun 2017 08:58:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] blk-mq: create hctx for each present CPU
Message-ID: <20170608065850.GA12803@lst.de>
References: <20170603140403.27379-1-hch@lst.de> <20170603140403.27379-8-hch@lst.de> <20170607220411.GF7481@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607220411.GF7481@vader.DHCP.thefacebook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 07, 2017 at 03:04:11PM -0700, Omar Sandoval wrote:
> On Sat, Jun 03, 2017 at 04:04:02PM +0200, Christoph Hellwig wrote:
> > Currently we only create hctx for online CPUs, which can lead to a lot
> > of churn due to frequent soft offline / online operations.  Instead
> > allocate one for each present CPU to avoid this and dramatically simplify
> > the code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Oh man, this cleanup is great. Did you run blktests on this? block/008
> does a bunch of hotplugging while I/O is running.

I haven't run blktests yet, in fact when I did the work blktests didn't
exist yet.   But thanks for the reminder, I'll run it now.
