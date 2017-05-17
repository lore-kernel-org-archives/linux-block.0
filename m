Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] nvme: avoid to hang in remove disk
Date: Wed, 17 May 2017 09:27:29 +0800
Message-Id: <20170517012729.13469-3-ming.lei@redhat.com>
In-Reply-To: <20170517012729.13469-1-ming.lei@redhat.com>
References: <20170517012729.13469-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

If some writeback requests are submitted just before queue is killed,
and these requests may not be canceled in nvme_dev_disable() because
they are not started yet, it is still possible for blk-mq to hold
these requests in .requeue list.

So we have to abort these requests first before del_gendisk(), because
del_gendisk() may wait for completion of these requests.

Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..8eaeea86509a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2097,6 +2097,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 					&nvme_ns_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
+		/*
+		 * If queue is dead, we have to abort requests in
+		 * requeue list because fsync_bdev() in removing disk
+		 * path may wait for these IOs, which can't
+		 * be submitted to hardware too.
+		 */
+		if (blk_queue_dying(ns->queue))
+			blk_mq_abort_requeue_list(ns->queue);
 		del_gendisk(ns->disk);
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
-- 
2.9.3
