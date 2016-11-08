Return-Path: <hare@suse.de>
Subject: Re: [RFC PATCH] pci: add pci_irq_get_affinity_vector()
To: Christoph Hellwig <hch@lst.de>
References: <1478591241-123356-1-git-send-email-hare@suse.de>
 <20161108145652.GA12817@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <40d6e3d4-7e63-0d23-3e5c-a877cebd539a@suse.de>
Date: Tue, 8 Nov 2016 16:08:51 +0100
MIME-Version: 1.0
In-Reply-To: <20161108145652.GA12817@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 03:56 PM, Christoph Hellwig wrote:
> On Tue, Nov 08, 2016 at 08:47:21AM +0100, Hannes Reinecke wrote:
>> Add a reverse-mapping function to return the interrupt vector for
>> any CPU if interrupt affinity is enabled.
>
> What's the use case of it?
>
> Also as-is this won't work due to the non-affinity vectors that
> have the affinity set to all cpus.  It will get even worse if we have
> to support things like virtio_net that have multiple interrupts per
> CPU due to the send and receive virtqueues.
>
The use-case here is that one needs to feed the MSI-X index into the 
driver command structure. While we can extract that number trivially 
with scsi-mq, but for scsi-sq we don't have such means.

So if we start assigning interrupt affinity per default we need to 
figure out the msi-x index from a given SCSI command.
Currently most of these drivers keep an internal CPU map which I'd love 
to get rid of.
Hence this patch.

And before you complain: Yes, this patch is wrong; it returns the vector 
and not the index (which is what I'm after).
I found that on my test machine :-(

The main impetus of this RFC is to figure out if such a function would 
have a chance of getting upstream, or if I have to continue use cpumaps 
in the drivers.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
