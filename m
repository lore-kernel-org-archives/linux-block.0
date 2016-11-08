Return-Path: <hare@suse.de>
Subject: Re: [RFC PATCH] pci: add pci_irq_get_affinity_vector()
To: Christoph Hellwig <hch@lst.de>
References: <1478591241-123356-1-git-send-email-hare@suse.de>
 <20161108145652.GA12817@lst.de>
 <40d6e3d4-7e63-0d23-3e5c-a877cebd539a@suse.de>
 <20161108151150.GA14002@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <85806bd8-b4a5-8820-cf7a-207a38fe5505@suse.de>
Date: Tue, 8 Nov 2016 16:20:20 +0100
MIME-Version: 1.0
In-Reply-To: <20161108151150.GA14002@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 04:11 PM, Christoph Hellwig wrote:
> On Tue, Nov 08, 2016 at 04:08:51PM +0100, Hannes Reinecke wrote:
>> The use-case here is that one needs to feed the MSI-X index into the driver
>> command structure. While we can extract that number trivially with scsi-mq,
>> but for scsi-sq we don't have such means.
>
>> The main impetus of this RFC is to figure out if such a function would have
>> a chance of getting upstream, or if I have to continue use cpumaps in the
>> drivers.
>
> There should be no need for a cpumap, nor should there be any need
> for a lookup.  Driver will need the vector index for some admin ops,
> but it can store it in it's driver-private queue structure (e.g. take
> a look at the cq_vector field in NVMe).  Drivers really should not need
> this during I/O, but if for some weird reason they do that driver specific
> field is trivially reachable through the hw_ctx which gets passed to
> ->queue_rq.

I did mention that this is trivial for scsi-mq, right?
The issue here is scsi-sq.
(Much as you despise it).

As long a scsi-mq is not the standard we _have_ to provide a way of 
retaining the original functionality which allowed for interrupt 
distribution even for scsi-sq.
Hence either the driver has to keep this functionality (looking up 
msi-index based on a give scsi command) internal within the driver or we 
provide a common function allowing drivers to look it up.

And my patch is aiming to provide the latter.
If you don't agree with it or think it'll be pointless, fine, I'll go 
ahead and modify the drivers.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
