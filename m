Return-Path: <hare@suse.de>
Subject: Re: [PATCH 00/10] nvme multipath support on top of nvme-4.13 branch
To: Anish M Jhaveri <anish.jhaveri@paviliondata.com>, keith.busch@intel.com
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20170912042048.pdbyl6vsoeui6bnp@haynes>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a4e8f78f-34a7-5ba5-424a-0aaba62bc597@suse.de>
Date: Wed, 13 Sep 2017 08:57:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170912042048.pdbyl6vsoeui6bnp@haynes>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/12/2017 06:20 AM, Anish M Jhaveri wrote:
> Hello everyone,
> Please find patchset for supporting Multipathing using nvme namespace 
> and nvme controller. 
> 
> Basic idea behind the design and implementation is to re-use the same 
> logic which is between generic nvme namespace and it's controller. 
> One controller to many namespaces. Similarly, this implementation uses
> one multipath controller and sibling namespaces.
> It creates a head multipath nvme namespace as soon as it find a nvme
> namespace during enumeration which has property of being shared. Prior
> to creating new head multipath device, nvme namespace check for match-
> ing NGUID, if it finds one, this nvme namespace is added as a sibling
> to that given namespaces head device. 
> Failover is triggered either due to keep-alive timer expiration or RDMA
>  timeout. Selection is of device is based on first available standby
> device. As of present this implementation support Active-Standby multi-
> path model.
> On selection of device, a command is sent to target for acknowledgement 
> of active device. In meanwhile if any IO are received, they get queued 
> under head multipath device congestion queue and processed as soon as
> a single path becomes active. In scenario where new active path results
> in failure, it will cancel those IOs after multiple retries.
> 
> I have gone through the solutiion Christoph Hellwig suggested and this
> one follow similar path except for it doesn't require any change from 
> kernel and will work prior version of kernel.
> It can made standalone module and be used with other block devices as
> we open any block device handle.
> 
> It has been tested with interface up/down on host and target, target
> node crash and disconnect command. Performance has been tested with
> multiple multipath devices on single host and there is un-noticeable
>  difference in numbers. 
> 
In general I am _not_ in favour of this approach.

This is essentially the same level of multipath support we had in the
old qlogic and lpfc drivers in 2.4/2.6 series, and it took us _years_ to
get rid of this.
Main objection here is that it will be really hard (if not impossible)
to use the same approach for other subsystems (eg SCSI), so we'll end up
having different multipath implementations depending on which subsystem
is being used.
Which really is a maintenance nightmare.

I'm not averse to having other multipath implementations in the kernel,
but it really should be abstracted so that other subsystems can _try_ to
leverage it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
