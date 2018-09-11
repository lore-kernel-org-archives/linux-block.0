Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] blk-mq: retrieve bios before update nr_hw_queues
Date: Tue, 11 Sep 2018 17:48:12 +0800
Message-Id: <1536659294-2321-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

retrieve bios of requests on queue to drain requests, then:
 - avoid fail requests on dying hw queue
 - needn't depend on storage device to drain the queue any more

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3d59741..adc14f0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3013,7 +3013,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue(q);
+		blk_freeze_queue_start(q);
+
+	/*
+	 * Wait the percpu ref to be switched to atomic mode.
+	 */
+	synchronize_sched();
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_sched_retrieve_bios(q);
 	/*
 	 * Sync with blk_mq_queue_tag_busy_iter.
 	 */
-- 
2.7.4
