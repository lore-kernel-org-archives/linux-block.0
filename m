Return-Path: <prvs=11505706e0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/7] elevator: make the rqhash helpers exported
Date: Thu, 8 Dec 2016 13:13:21 -0700
Message-ID: <1481228005-9245-4-git-send-email-axboe@fb.com>
In-Reply-To: <1481228005-9245-1-git-send-email-axboe@fb.com>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/elevator.c         | 8 ++++----
 include/linux/elevator.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index a18a5db274e4..40f0c04e5ad3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -248,13 +248,13 @@ static inline void __elv_rqhash_del(struct request *rq)
 	rq->rq_flags &= ~RQF_HASHED;
 }
 
-static void elv_rqhash_del(struct request_queue *q, struct request *rq)
+void elv_rqhash_del(struct request_queue *q, struct request *rq)
 {
 	if (ELV_ON_HASH(rq))
 		__elv_rqhash_del(rq);
 }
 
-static void elv_rqhash_add(struct request_queue *q, struct request *rq)
+void elv_rqhash_add(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -263,13 +263,13 @@ static void elv_rqhash_add(struct request_queue *q, struct request *rq)
 	rq->rq_flags |= RQF_HASHED;
 }
 
-static void elv_rqhash_reposition(struct request_queue *q, struct request *rq)
+void elv_rqhash_reposition(struct request_queue *q, struct request *rq)
 {
 	__elv_rqhash_del(rq);
 	elv_rqhash_add(q, rq);
 }
 
-static struct request *elv_rqhash_find(struct request_queue *q, sector_t offset)
+struct request *elv_rqhash_find(struct request_queue *q, sector_t offset)
 {
 	struct elevator_queue *e = q->elevator;
 	struct hlist_node *next;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index f219c9aed360..b276e9ef0e0b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -108,6 +108,11 @@ struct elevator_type
 
 #define ELV_HASH_BITS 6
 
+void elv_rqhash_del(struct request_queue *q, struct request *rq);
+void elv_rqhash_add(struct request_queue *q, struct request *rq);
+void elv_rqhash_reposition(struct request_queue *q, struct request *rq);
+struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
+
 /*
  * each queue has an elevator_queue associated with it
  */
-- 
2.7.4
