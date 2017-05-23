Return-Path: <hch@lst.de>
Date: Tue, 23 May 2017 11:35:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] genirq/affinity: assign vectors to all present CPUs
Message-ID: <20170523093555.GA23632@lst.de>
References: <20170519085756.29742-1-hch@lst.de> <20170519085756.29742-3-hch@lst.de> <alpine.DEB.2.20.1705212028280.3023@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1705212028280.3023@nanos>
List-ID: <linux-block@vger.kernel.org>

On Sun, May 21, 2017 at 08:31:47PM +0200, Thomas Gleixner wrote:
> On Fri, 19 May 2017, Christoph Hellwig wrote:
> > -	/* Stabilize the cpumasks */
> > -	get_online_cpus();
> 
> How is that protected against physical CPU hotplug? Physical CPU hotplug
> manipulates the present mask.

It does indeed seem to.  Documentation/core-api/cpu_hotplug.rst claims
there are no locking rules for manipulations of cpu_present_mask,
maybe it needs and update to mention get/put_online_cpus() ?

Or maybe I should just switch to possible_cpu mask here like a lot of
code seems to do to avoid the hot plug issues, but that might be a bit
of a waste.
