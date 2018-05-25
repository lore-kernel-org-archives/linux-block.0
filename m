Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Damien.LeMoal@wdc.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: bgurney@redhat.com,
	Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH 1/2] block: __elevator_change: add try_loading parameter
Date: Fri, 25 May 2018 17:14:31 -0400
Message-Id: <20180525211432.20359-2-jmoyer@redhat.com>
In-Reply-To: <20180525211432.20359-1-jmoyer@redhat.com>
References: <20180525211432.20359-1-jmoyer@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The next patch will add a caller that can't trigger module loads.
Also export this function for that caller.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 block/blk.h      | 2 ++
 block/elevator.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index b034fd2..f6c3cc1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -233,6 +233,8 @@ static inline void elv_deactivate_rq(struct request_queue *q, struct request *rq
 
 int elv_register_queue(struct request_queue *q);
 void elv_unregister_queue(struct request_queue *q);
+int __elevator_change(struct request_queue *q, const char *name,
+		      bool try_loading);
 
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
 
diff --git a/block/elevator.c b/block/elevator.c
index e87e9b4..5a91a43 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1075,7 +1075,8 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 /*
  * Switch this queue to the given IO scheduler.
  */
-static int __elevator_change(struct request_queue *q, const char *name)
+int __elevator_change(struct request_queue *q, const char *name,
+		      bool try_loading)
 {
 	char elevator_name[ELV_NAME_MAX];
 	struct elevator_type *e;
@@ -1091,7 +1092,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 		return elevator_switch(q, NULL);
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
-	e = elevator_get(q, strstrip(elevator_name), true);
+	e = elevator_get(q, strstrip(elevator_name), try_loading);
 	if (!e)
 		return -EINVAL;
 
@@ -1119,7 +1120,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 	if (!(q->mq_ops || q->request_fn) || !elv_support_iosched(q))
 		return count;
 
-	ret = __elevator_change(q, name);
+	ret = __elevator_change(q, name, true);
 	if (!ret)
 		return count;
 
-- 
2.8.2.335.g4bb51ae
