Return-Path: <hch@lst.de>
Date: Fri, 18 Aug 2017 13:24:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq-pci: add a fallback when pci_irq_get_affinity
	returns NULL
Message-ID: <20170818112413.GA7700@lst.de>
References: <20170817102447.28819-1-hch@lst.de> <20170817203742.GC2459@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817203742.GC2459@vader>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17, 2017 at 01:37:42PM -0700, Omar Sandoval wrote:
> On Thu, Aug 17, 2017 at 12:24:47PM +0200, Christoph Hellwig wrote:
> > While pci_irq_get_affinity should never fail for SMP kernel that
> > implement the affinity mapping, it will always return NULL in the
> > UP case, so provide a fallback mapping of all queues to CPU 0 in
> > that case.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> Has nvme been fixed to not crash if blk_mq_alloc_tag_set() fails?

No - Sagi didn't like the little fix from Max and no one else
has followed up.  I'll take a look.
