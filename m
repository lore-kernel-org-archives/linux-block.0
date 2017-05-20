Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
Date: Sat, 20 May 2017 11:56:03 +0800
Message-Id: <20170520035605.21785-2-ming.lei@redhat.com>
In-Reply-To: <20170520035605.21785-1-ming.lei@redhat.com>
References: <20170520035605.21785-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Inside nvme_kill_queues(), we have to start hw queues for
draining requests in sw queues, .dispatch list and requeue list,
so use blk_mq_start_hw_queues() instead of blk_mq_start_stopped_hw_queues()
which only run queues if queues are stopped, but the queues may have
been started already, for example nvme_start_queues() is called in reset work
function.

blk_mq_start_hw_queues() run hw queues in current context, instead
of running asynchronously like before. Given nvme_kill_queues() is
run from either remove context or reset worker context, both are fine
to run hw queue directly. And the mutex of namespaces_mutex isn't a
problem too becasue nvme_start_freeze() runs hw queue in this way
already.

Cc: stable@vger.kernel.org
Reported-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..ce0d96913ee6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2437,7 +2437,13 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
 		blk_mq_abort_requeue_list(ns->queue);
-		blk_mq_start_stopped_hw_queues(ns->queue, true);
+
+		/*
+		 * We have to force to start queues for avoiding hang
+		 * forever, and we have to make sure that queues won't
+		 * be stopped forever from now on.
+		 */
+		blk_mq_start_hw_queues(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.9.4
