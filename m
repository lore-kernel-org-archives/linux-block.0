Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: always set partition number to '0' in
 blk_partition_remap()
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20180606142218.64220-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <25f0db7b-ccac-88f6-76e7-99d1b94e11f9@kernel.dk>
Date: Wed, 6 Jun 2018 08:26:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180606142218.64220-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/6/18 8:22 AM, Hannes Reinecke wrote:
> blk_partition_remap() will only clear bi_partno if an actual remapping
> has happened. But flush request et al don't have an actual size, so
> the remapping doesn't happen and bi_partno is never cleared.
> So for stacked devices blk_partition_remap() will be called on each level.
> If (as is the case for native nvme multipathing) one of the lower-level
> devices do _not_support partitioning a spurious I/O error is generated.

Just move it down, we're now clearing it for both cases.

diff --git a/block/blk-core.c b/block/blk-core.c
index 3f56be15f17e..cf0ee764b908 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2220,10 +2220,10 @@ static inline int blk_partition_remap(struct bio *bio)
 		if (bio_check_eod(bio, part_nr_sects_read(p)))
 			goto out;
 		bio->bi_iter.bi_sector += p->start_sect;
-		bio->bi_partno = 0;
 		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
 				      bio->bi_iter.bi_sector - p->start_sect);
 	}
+	bio->bi_partno = 0;
 	ret = 0;
 out:
 	rcu_read_unlock();

-- 
Jens Axboe
