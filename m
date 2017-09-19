Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 18 Sep 2017 21:40:10 -0700
To: Hannes Reinecke <hare@suse.de>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, keith.busch@intel.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 00/10] nvme multipath support on top of nvme-4.13 branch
Message-ID: <20170919044010.l2ja4k23xk6gipkl@haynes>
References: <20170912042048.pdbyl6vsoeui6bnp@haynes>
 <a4e8f78f-34a7-5ba5-424a-0aaba62bc597@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a4e8f78f-34a7-5ba5-424a-0aaba62bc597@suse.de>
From: anish.jhaveri@paviliondata.com
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 08:57:13AM +0200, Hannes Reinecke wrote:
> In general I am _not_ in favour of this approach.
> 
> This is essentially the same level of multipath support we had in the
> old qlogic and lpfc drivers in 2.4/2.6 series, and it took us _years_ to
> get rid of this.
> Main objection here is that it will be really hard (if not impossible)
> to use the same approach for other subsystems (eg SCSI), so we'll end up
> having different multipath implementations depending on which subsystem
> is being used.
> Which really is a maintenance nightmare.
> 
> I'm not averse to having other multipath implementations in the kernel,
> but it really should be abstracted so that other subsystems can _try_ to
> leverage it.

Got it. Thanks! 
