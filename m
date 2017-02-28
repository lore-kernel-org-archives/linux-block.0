Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Tue, 28 Feb 2017 11:57:20 -0500
From: Keith Busch <keith.busch@intel.com>
To: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCHv2 2/2] nvme: Complete all stuck requests
Message-ID: <20170228165719.GA23236@localhost.localdomain>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
 <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
 <20170227150107.GA5789@localhost.localdomain>
 <4c952c67-9871-249d-86b0-5f81acf00571@grimberg.me>
 <20170227191459.GA1170@localhost.localdomain>
 <913d4d24-b80b-b7f6-2374-8095bc6fc047@intel.com>
MIME-Version: 1.0
In-Reply-To: <913d4d24-b80b-b7f6-2374-8095bc6fc047@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Marc MERLIN <marc@merlins.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 28, 2017 at 08:42:19AM +0100, Artur Paszkiewicz wrote:
> 
> I'm observing the same thing when hibernating during mdraid resync on
> nvme - it hangs in blk_mq_freeze_queue_wait() after "Disabling non-boot
> CPUs ...".

The patch guarantees forward progress for blk-mq's hot-cpu notifier on
nvme request queues by failing all entered requests. It sounds like some
part of your setup needs those requests to succeed in order to hibernate.

If your mdraid uses a stacking request_queue that submits retries while
it's request queue is entered, that may explain how you remain stuck
at blk_mq_freeze_queue_wait.

> This patch did not help but when I put nvme_wait_freeze()
> right after nvme_start_freeze() it appeared to be working. Maybe the
> difference here is that requests are submitted from a non-freezable
> kernel thread (md sync_thread)?

Wait freeze prior to quiescing the queue is ok when the controller is
functioning, but it'd be impossible to complete a reset if the controller
is in a failed or degraded state.

We probably want to give those requests a chance to succeed, and I think
we'd need to be able to timeout the freeze wait. Below are two patches
I tested. Prior to these, the fio test would report IO errors from some
of its jobs; no errors with these.

---
 block/blk-mq.c         | 9 +++++++++
 include/linux/blk-mq.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8da2c04..a5e66a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -81,6 +81,15 @@ void blk_mq_freeze_queue_wait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
+int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
+				     unsigned long timeout)
+{
+	return wait_event_timeout(q->mq_freeze_wq,
+					percpu_ref_is_zero(&q->q_usage_counter),
+					timeout);
+}
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
+
 /*
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8dacf68..b296a90 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -246,6 +246,8 @@ void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
+int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
+				     unsigned long timeout);
 int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
-- 

---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 18 ++++++++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9e99b94..9b3b57f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2355,6 +2355,20 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
+void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
+		if (timeout <= 0)
+			break;
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
+
 void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 62af901..2aa20e3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -296,6 +296,7 @@ void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
+void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b266fb9..a7a423f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1691,22 +1691,32 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i, queues;
 	u32 csts = -1;
+	bool dead;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	del_timer_sync(&dev->watchdog_timer);
 
 	mutex_lock(&dev->shutdown_lock);
 	if (shutdown)
 		nvme_start_freeze(&dev->ctrl);
-	if (pci_is_enabled(to_pci_dev(dev->dev))) {
-		nvme_stop_queues(&dev->ctrl);
+	if (pci_is_enabled(pdev))
 		csts = readl(dev->bar + NVME_REG_CSTS);
-	}
+	dead = (csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
+		pdev->error_state  != pci_channel_io_normal;
+
+	/*
+	 * Give the controller a chance to complete all entered requests if
+	 * doing a safe shutdown.
+	 */
+	if (!dead && shutdown)
+		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+	nvme_stop_queues(&dev->ctrl);
 
 	queues = dev->online_queues - 1;
 	for (i = dev->queue_count - 1; i > 0; i--)
 		nvme_suspend_queue(dev->queues[i]);
 
-	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
+	if (dead) {
 		/* A device might become IO incapable very soon during
 		 * probe, before the admin queue is configured. Thus,
 		 * queue_count can be 0 here.
-- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
