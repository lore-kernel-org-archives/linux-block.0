Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always set partition number to '0' in
 blk_partition_remap()
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20180607082944.41676-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3d45f792-f00e-0955-3acf-466e73050a9c@kernel.dk>
Date: Thu, 7 Jun 2018 06:56:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180607082944.41676-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/7/18 2:29 AM, Hannes Reinecke wrote:
> blk_partition_remap() will only clear bi_partno if an actual remapping
> has happened. But flush request et al don't have an actual size, so
> the remapping doesn't happen and bi_partno is never cleared.
> So for stacked devices blk_partition_remap() will be called on each level.
> If (as is the case for native nvme multipathing) one of the lower-level
> devices do _not_support partitioning a spurious I/O error is generated.

That's better, applied.

-- 
Jens Axboe
