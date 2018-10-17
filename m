Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: hch@lst.de, keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] blk-mq: retrieve bios before update nr_hw_queues
Date: Wed, 17 Oct 2018 17:07:11 +0800
Message-Id: <1539767232-9389-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

retrieve bios of all requests on queue to drain requests, then
needn't depend on storage device to drain the queue any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f75598b..6d89d3e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3085,7 +3085,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue(q);
+		blk_freeze_queue_start(q);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_sched_retrieve_bios(q);
 	/*
 	 * Sync with blk_mq_queue_tag_busy_iter.
 	 */
-- 
2.7.4
