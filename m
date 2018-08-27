Return-Path: <jpittman@redhat.com>
From: John Pittman <jpittman@redhat.com>
To: axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH] block: bsg: move atomic_t ref_count variable to refcount API
Date: Mon, 27 Aug 2018 14:33:05 -0400
Message-Id: <20180827183305.27722-1-jpittman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Currently, variable ref_count within the bsg_device struct is of
type atomic_t.  For variables being used as reference counters,
the refcount API should be used instead of atomic.  The newer
refcount API works to prevent counter overflows and use-after-free
bugs.  So, move this varable from the atomic API to refcount,
potentially avoiding the issues mentioned.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 block/bsg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index db588add6ba6..9a442c23a715 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -37,7 +37,7 @@ struct bsg_device {
 	struct request_queue *queue;
 	spinlock_t lock;
 	struct hlist_node dev_list;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	char name[20];
 	int max_queue;
 };
@@ -252,7 +252,7 @@ static int bsg_put_device(struct bsg_device *bd)
 
 	mutex_lock(&bsg_mutex);
 
-	if (!atomic_dec_and_test(&bd->ref_count)) {
+	if (!refcount_dec_and_test(&bd->ref_count)) {
 		mutex_unlock(&bsg_mutex);
 		return 0;
 	}
@@ -290,7 +290,7 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 
 	bd->queue = rq;
 
-	atomic_set(&bd->ref_count, 1);
+	refcount_set(&bd->ref_count, 1);
 	hlist_add_head(&bd->dev_list, bsg_dev_idx_hash(iminor(inode)));
 
 	strncpy(bd->name, dev_name(rq->bsg_dev.class_dev), sizeof(bd->name) - 1);
@@ -308,7 +308,7 @@ static struct bsg_device *__bsg_get_device(int minor, struct request_queue *q)
 
 	hlist_for_each_entry(bd, bsg_dev_idx_hash(minor), dev_list) {
 		if (bd->queue == q) {
-			atomic_inc(&bd->ref_count);
+			refcount_inc(&bd->ref_count);
 			goto found;
 		}
 	}
-- 
2.17.1
