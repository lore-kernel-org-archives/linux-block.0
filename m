Return-Path: <tglx@linutronix.de>
Date: Wed, 9 Nov 2016 08:51:35 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: support for partial irq affinity assignment V3
In-Reply-To: <f5270fd9-488f-a954-ba3c-1f7800820731@kernel.dk>
Message-ID: <alpine.DEB.2.20.1611090849450.3501@nanos>
References: <1478654107-7384-1-git-send-email-hch@lst.de> <f5270fd9-488f-a954-ba3c-1f7800820731@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 8 Nov 2016, Jens Axboe wrote:

> On 11/08/2016 06:15 PM, Christoph Hellwig wrote:
> > This series adds support for automatic interrupt assignment to devices
> > that have a few vectors that are set aside for admin or config purposes
> > and thus should not fall into the general per-cpu assginment pool.
> > 
> > The first patch adds that support to the core IRQ and PCI/msi code,
> > and the second is a small tweak to a block layer helper to make use
> > of it.  I'd love to have both go into the same tree so that consumers
> > of this (e.g. the virtio, scsi and rdma trees) only need to pull in
> > one of these trees as dependency.
> 
> Series looks good to me, you can add my Acked-by to all of them.

It's available from

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block

for you to pull into the block tree so you can apply the block changes.

Thanks,

	tglx
