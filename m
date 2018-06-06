Return-Path: <hch@lst.de>
Date: Wed, 6 Jun 2018 16:42:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: always set partition number to '0' in
	blk_partition_remap()
Message-ID: <20180606144218.GB20487@lst.de>
References: <20180606142218.64220-1-hare@suse.de> <25f0db7b-ccac-88f6-76e7-99d1b94e11f9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25f0db7b-ccac-88f6-76e7-99d1b94e11f9@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 06, 2018 at 08:26:56AM -0600, Jens Axboe wrote:
> On 6/6/18 8:22 AM, Hannes Reinecke wrote:
> > blk_partition_remap() will only clear bi_partno if an actual remapping
> > has happened. But flush request et al don't have an actual size, so
> > the remapping doesn't happen and bi_partno is never cleared.
> > So for stacked devices blk_partition_remap() will be called on each level.
> > If (as is the case for native nvme multipathing) one of the lower-level
> > devices do _not_support partitioning a spurious I/O error is generated.
> 
> Just move it down, we're now clearing it for both cases.

Agreed.
