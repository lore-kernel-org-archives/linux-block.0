Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 18 Sep 2017 22:10:37 -0700
From: Anish Jhaveri <anish.jhaveri@paviliondata.com>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 00/10] nvme multipath support on top of nvme-4.13 branch
Message-ID: <20170919051036.ttno3memte777ddx@haynes>
References: <20170912042048.pdbyl6vsoeui6bnp@haynes>
 <20170915180701.GA8981@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170915180701.GA8981@lst.de>
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 15, 2017 at 08:07:01PM +0200, Christoph Hellwig wrote:
> Hi Anish,
> 
> I looked over the code a bit, and I'm rather confused by the newly
> added commands.  Which controller supports them?  Also the NVMe
> working group went down a very different way with the ALUA approch,
> which uses different grouping concepts and doesn't require path
> activations - for Linux we'd really like to stick to only standardized
> multipath implementations.
Hi Christoph, 
Thanks for looking over the code. The newly added commands were to
support Asymmetric NVME Namespace Subsystem. Though, I can remove
those commands and make it active-active configuration. I noticed
you have sent out the review with changes adding new structures
and functions which makes it very similar in terms of implementation.
The only reason I proposed given changes, as it doesn't require any 
change to kernel. 
