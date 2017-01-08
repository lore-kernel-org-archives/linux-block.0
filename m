Return-Path: <hch@lst.de>
Date: Sun, 8 Jan 2017 11:01:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Merlin <marc@merlins.org>
Subject: Re: [PATCH 2/6] irq/affinity: Assign offline CPUs a vector
Message-ID: <20170108100152.GA26025@lst.de>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com> <1483569671-1462-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483569671-1462-3-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 04, 2017 at 05:41:07PM -0500, Keith Busch wrote:
> The offline CPUs need to assigned to something incase they come online
> later, otherwise anyone using the mapping for things other than affinity
> will have blank entries for that online CPU.

I don't really like the idea behind it.  Back when we came up with
this code I had some discussion with Thomas if we should do the
assignment only for online CPUs, or maybe for all possible CPUs.

Except for some big iron with physical node hotplug the difference
usually is just that some nodes have been temporarily offlined.  So
maybe we need to bite the bullet and move the irq and block code
to consider all possible cpus.
