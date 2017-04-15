Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754390AbdDOMko (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 08:40:44 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] block: respect BLK_MQ_F_NO_SCHED
Date: Sat, 15 Apr 2017 20:38:22 +0800
Message-Id: <20170415123825.32716-2-ming.lei@redhat.com>
In-Reply-To: <20170415123825.32716-1-ming.lei@redhat.com>
References: <20170415123825.32716-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If one driver claims that it doesn't support io scheduler via
BLK_MQ_F_NO_SCHED, we should not allow to change and show the
availabe io schedulers.

This patch adds check to enhance this behaviour.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index dbeecf7be719..4d9084a14c10 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1098,12 +1098,20 @@ int elevator_change(struct request_queue *q, const char *name)
 }
 EXPORT_SYMBOL(elevator_change);
 
+static inline bool elv_support_iosched(struct request_queue *q)
+{
+	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
+				BLK_MQ_F_NO_SCHED))
+		return false;
+	return true;
+}
+
 ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 			  size_t count)
 {
 	int ret;
 
-	if (!(q->mq_ops || q->request_fn))
+	if (!(q->mq_ops || q->request_fn) || !elv_support_iosched(q))
 		return count;
 
 	ret = __elevator_change(q, name);
@@ -1135,7 +1143,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 			len += sprintf(name+len, "[%s] ", elv->elevator_name);
 			continue;
 		}
-		if (__e->uses_mq && q->mq_ops)
+		if (__e->uses_mq && q->mq_ops && elv_support_iosched(q))
 			len += sprintf(name+len, "%s ", __e->elevator_name);
 		else if (!__e->uses_mq && !q->mq_ops)
 			len += sprintf(name+len, "%s ", __e->elevator_name);
-- 
2.9.3
