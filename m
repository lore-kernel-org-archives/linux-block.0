Return-Path: <BATV+7138d8dfc060164c836f+5389+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 10/14] nvmet: mask pending AERs
Date: Sat, 26 May 2018 12:27:31 +0200
Message-Id: <20180526102735.31404-11-hch@lst.de>
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Per section 5.2 of the NVMe 1.3 spec:

  "When the controller posts a completion queue entry for an outstanding
  Asynchronous Event Request command and thus reports an asynchronous
  event, subsequent events of that event type are automatically masked by
  the controller until the host clears that event. An event is cleared by
  reading the log page associated with that event using the Get Log Page
  command (see section 5.14)."

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 drivers/nvme/target/core.c      | 2 ++
 drivers/nvme/target/nvmet.h     | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 20d9ce5064f8..d7b6293e830b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -141,6 +141,7 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 	if (!status)
 		status = nvmet_zero_sgl(req, len, req->data_len - len);
 	ctrl->nr_changed_ns = 0;
+	clear_bit(NVME_AEN_CFG_NS_ATTR, &ctrl->aen_masked);
 	mutex_unlock(&ctrl->lock);
 out:
 	nvmet_req_complete(req, status);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 53e2386b73cf..932bdc46cd5c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -164,6 +164,8 @@ static void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 		nvmet_add_to_changed_ns_log(ctrl, nsid);
 		if (!(READ_ONCE(ctrl->aen_enabled) & NVME_AEN_CFG_NS_ATTR))
 			continue;
+		if (test_and_set_bit(NVME_AEN_CFG_NS_ATTR, &ctrl->aen_masked))
+			continue;
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
 				NVME_AER_NOTICE_NS_CHANGED,
 				NVME_LOG_CHANGED_NS);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 50c8300ea572..e63ab3c0c655 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -126,6 +126,7 @@ struct nvmet_ctrl {
 	u32			kato;
 
 	u32			aen_enabled;
+	unsigned long		aen_masked;
 	struct nvmet_req	*async_event_cmds[NVMET_ASYNC_EVENTS];
 	unsigned int		nr_async_event_cmds;
 	struct list_head	async_events;
-- 
2.17.0
