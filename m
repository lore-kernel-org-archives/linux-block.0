Return-Path: <hch@lst.de>
Date: Tue, 8 Nov 2016 16:11:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH] pci: add pci_irq_get_affinity_vector()
Message-ID: <20161108151150.GA14002@lst.de>
References: <1478591241-123356-1-git-send-email-hare@suse.de> <20161108145652.GA12817@lst.de> <40d6e3d4-7e63-0d23-3e5c-a877cebd539a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40d6e3d4-7e63-0d23-3e5c-a877cebd539a@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 08, 2016 at 04:08:51PM +0100, Hannes Reinecke wrote:
> The use-case here is that one needs to feed the MSI-X index into the driver 
> command structure. While we can extract that number trivially with scsi-mq, 
> but for scsi-sq we don't have such means.

> The main impetus of this RFC is to figure out if such a function would have 
> a chance of getting upstream, or if I have to continue use cpumaps in the 
> drivers.

There should be no need for a cpumap, nor should there be any need
for a lookup.  Driver will need the vector index for some admin ops,
but it can store it in it's driver-private queue structure (e.g. take
a look at the cq_vector field in NVMe).  Drivers really should not need
this during I/O, but if for some weird reason they do that driver specific
field is trivially reachable through the hw_ctx which gets passed to
->queue_rq.
