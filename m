Return-Path: <hch@lst.de>
Date: Mon, 23 Jan 2017 19:30:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Merlin <marc@merlins.org>
Subject: Re: [PATCH 1/6] irq/affinity: Assign all online CPUs to vectors
Message-ID: <20170123183050.GA23791@lst.de>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com> <1483569671-1462-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483569671-1462-2-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 04, 2017 at 05:41:06PM -0500, Keith Busch wrote:
> This patch makes sure all online CPUs are assigned to vectors in
> cases where the nodes don't have the same number of online CPUs.
> The calculation for how many vectors needs to be assigned should account
> for the number of CPUs for a particular node on each round of assignment
> in order to ensure all online CPUs are assigned a vector when they don't
> evenly divide, and calculate extras accordingly.
> 
> Since we attempt to divide evently among the nodes, this may still result
> in unused vectors if some nodes have fewer CPUs than nodes previosuly
> set up, but at least every online CPU will be assigned to something.

This looks fine:

I think we still should switch to something like all present or possible
cpus for MSI-X vector and blk-mq queue assignment, though reduce
the needs for this:

Reviewed-by: Christoph Hellwig <hch@lst.de>
