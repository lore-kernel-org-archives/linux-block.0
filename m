Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbdFFPXx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 11:23:53 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org
Subject: [PATCH v5 07/12] nvme: host: unquiesce queue in nvme_kill_queues()
Date: Tue,  6 Jun 2017 23:22:05 +0800
Message-Id: <20170606152210.22806-8-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-1-ming.lei@redhat.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When nvme_kill_queues() is run, queues may be in
quiesced state, so we forcibly unquiesce queues to avoid
blocking dispatch, and I/O hang can be avoided in
remove path.

Peviously we use blk_mq_start_stopped_hw_queues() as
counterpart of blk_mq_quiesce_queue(), now we have
introduced blk_mq_unquiesce_queue(), so use it explicitly.

Cc: linux-nvme@lists.infradead.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3f189e54d10..d4e5fc95da4b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2438,6 +2438,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
+
+	/* Forcibly unquiesce queues to avoid blocking dispatch */
+	blk_mq_unquiesce_queue(ctrl->admin_q);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*
 		 * Revalidating a dead namespace sets capacity to 0. This will
@@ -2448,6 +2451,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
 
+		/* Forcibly unquiesce queues to avoid blocking dispatch */
+		blk_mq_unquiesce_queue(ns->queue);
+
 		/*
 		 * Forcibly start all queues to avoid having stuck requests.
 		 * Note that we must ensure the queues are not stopped
-- 
2.9.4
