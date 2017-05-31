Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdEaMiD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 08:38:03 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org
Subject: [PATCH v3 4/9] nvme: host: unquiesce queue in nvme_kill_queues()
Date: Wed, 31 May 2017 20:37:01 +0800
Message-Id: <20170531123706.20885-5-ming.lei@redhat.com>
In-Reply-To: <20170531123706.20885-1-ming.lei@redhat.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
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
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3f189e54d10..e44326d5cf19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2448,6 +2448,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
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
