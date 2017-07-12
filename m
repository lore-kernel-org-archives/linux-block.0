Return-Path: <houtao1@huawei.com>
From: Hou Tao <houtao1@huawei.com>
To: <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <axboe@kernel.dk>
Subject: [PATCH] block, bfq: fix typos in comments about B-WF2Q+ algorithm
Date: Wed, 12 Jul 2017 15:25:01 +0800
Message-ID: <1499844301-6312-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The start time of eligible entity should be less than or equal to
the current virtual time, and the entity in idle tree has a finish
time being greater than the current virtual time.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/bfq-iosched.h | 2 +-
 block/bfq-wf2q.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 5c3bf98..32feddab 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -52,7 +52,7 @@ struct bfq_entity;
 struct bfq_service_tree {
 	/* tree for active entities (i.e., those backlogged) */
 	struct rb_root active;
-	/* tree for idle entities (i.e., not backlogged, with V <= F_i)*/
+	/* tree for idle entities (i.e., not backlogged, with V < F_i)*/
 	struct rb_root idle;
 
 	/* idle entity with minimum F_i */
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 8726ede..d03d7b6 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1268,7 +1268,7 @@ static void bfq_update_vtime(struct bfq_service_tree *st, u64 new_value)
  *
  * This function searches the first schedulable entity, starting from the
  * root of the tree and going on the left every time on this side there is
- * a subtree with at least one eligible (start >= vtime) entity. The path on
+ * a subtree with at least one eligible (start <= vtime) entity. The path on
  * the right is followed only if a) the left subtree contains no eligible
  * entities and b) no eligible entity has been found yet.
  */
-- 
2.5.0
