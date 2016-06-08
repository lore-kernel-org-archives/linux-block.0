Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16072 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbcFHWSL (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 18:18:11 -0400
Date: Wed, 8 Jun 2016 18:25:57 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lin <mlin@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 0/2] check the number of hw queues mapped to sw queues
Message-ID: <20160608222557.GC1696@localhost.localdomain>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465415292-9416-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 08, 2016 at 03:48:10PM -0400, Ming Lin wrote:
> Back to Jan 2016, I send a patch:
> [PATCH] blk-mq: check if all HW queues are mapped to cpu
> http://www.spinics.net/lists/linux-block/msg01038.html
> 
> It adds check code to blk_mq_update_queue_map().
> But it seems too aggresive because it's not an error that some hw queues
> were not mapped to sw queues.
> 
> So this series just add a new function blk_mq_hctx_mapped() to check
> how many hw queues were mapped. And the driver(for example, nvme-rdma)
> that cares about it will do the check.

Wouldn't you prefer all 6 get assigned in this scenario instead of
utilizing fewer resources than your controller provides? I would like
blk-mq to use them all.

I've been trying to change blk_mq_update_queue_map to do this, but it's
not as easy as it sounds. The following is the simplest patch I came
up with that gets a better mapping *most* of the time.

I have 31 queues and 32 CPUs, and these are the results:

  # for i in $(ls -1v /sys/block/nvme0n1/mq/); do
      printf "hctx_idx %2d: " $i
      cat /sys/block/nvme0n1/mq/$i/cpu_list
    done

Before:

hctx_idx  0: 0, 16
hctx_idx  1: 1, 17
hctx_idx  3: 2, 18
hctx_idx  5: 3, 19
hctx_idx  7: 4, 20
hctx_idx  9: 5, 21
hctx_idx 11: 6, 22
hctx_idx 13: 7, 23
hctx_idx 15: 8, 24
hctx_idx 17: 9, 25
hctx_idx 19: 10, 26
hctx_idx 21: 11, 27
hctx_idx 23: 12, 28
hctx_idx 25: 13, 29
hctx_idx 27: 14, 30
hctx_idx 29: 15, 31

After:

hctx_id  0: 0, 16
hctx_id  1: 1
hctx_id  2: 2
hctx_id  3: 3
hctx_id  4: 4
hctx_id  5: 5
hctx_id  6: 6
hctx_id  7: 7
hctx_id  8: 8
hctx_id  9: 9
hctx_id 10: 10
hctx_id 11: 11
hctx_id 12: 12
hctx_id 13: 13
hctx_id 14: 14
hctx_id 15: 15
hctx_id 16: 17
hctx_id 17: 18
hctx_id 18: 19
hctx_id 19: 20
hctx_id 20: 21
hctx_id 21: 22
hctx_id 22: 23
hctx_id 23: 24
hctx_id 24: 25
hctx_id 25: 26
hctx_id 26: 27
hctx_id 27: 28
hctx_id 28: 29
hctx_id 29: 30
hctx_id 30: 31

---
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index d0634bc..941c406 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -75,11 +75,12 @@ int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
 		*/
 		first_sibling = get_first_sibling(i);
 		if (first_sibling == i) {
-			map[i] = cpu_to_queue_index(nr_uniq_cpus, nr_queues,
-							queue);
+			map[i] = cpu_to_queue_index(max(nr_queues, (nr_cpus - queue)), nr_queues, queue);
 			queue++;
-		} else
+		} else {
 			map[i] = map[first_sibling];
+			--nr_cpus;
+		}
 	}

 	free_cpumask_var(cpus);
--
