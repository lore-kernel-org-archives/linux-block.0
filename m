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
Subject: [PATCH v3 1/3] nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
Date: Mon, 22 May 2017 23:05:03 +0800
Message-Id: <20170522150505.452-2-ming.lei@redhat.com>
In-Reply-To: <20170522150505.452-1-ming.lei@redhat.com>
References: <20170522150505.452-1-ming.lei@redhat.com>
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
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..40d5e4a9e8d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2437,7 +2437,13 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
 		blk_mq_abort_requeue_list(ns->queue);
-		blk_mq_start_stopped_hw_queues(ns->queue, true);
+
+		/*
+		 * Forcibly start all queues to avoid having stuck requests.
+		 * Note that we must ensure the queues are not stopped
+		 * when the final removal happens.
+		 */
+		blk_mq_start_hw_queues(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.9.4
