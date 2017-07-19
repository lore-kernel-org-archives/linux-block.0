Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:49246 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbdGSBro (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Tue, 18 Jul 2017 21:47:44 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mingo@kernel.org, peterz@infradead.org, jack@suse.cz,
        torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com,
        hch@infradead.org, ldufour@linux.vnet.ibm.com, mhocko@suse.com,
        mgorman@techsingularity.net, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, axboe@fb.com,
        linux-block@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 17/17] block/cfq: cache rightmost rb_node
Date: Tue, 18 Jul 2017 18:46:03 -0700
Message-Id: <20170719014603.19029-18-dave@stgolabs.net>
In-Reply-To: <20170719014603.19029-1-dave@stgolabs.net>
References: <20170719014603.19029-1-dave@stgolabs.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For the same reasons we already cache the leftmost pointer,
apply the same optimization for rb_last() calls. Users must
explicitly do this as rb_root_cached only deals with the
smallest node.

Cc: axboe@fb.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
This is part of the rbtree internal caching series:
https://lwn.net/Articles/726809/

 block/cfq-iosched.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 92c31683a2bb..57ec45fd4590 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -94,11 +94,13 @@ struct cfq_ttime {
  */
 struct cfq_rb_root {
 	struct rb_root_cached rb;
+	struct rb_node *rb_rightmost;
 	unsigned count;
 	u64 min_vdisktime;
 	struct cfq_ttime ttime;
 };
 #define CFQ_RB_ROOT	(struct cfq_rb_root) { .rb = RB_ROOT_CACHED, \
+			.rb_rightmost = NULL,			     \
 			.ttime = {.last_end_request = ktime_get_ns(),},}
 
 /*
@@ -1183,6 +1185,9 @@ static struct cfq_group *cfq_rb_first_group(struct cfq_rb_root *root)
 
 static void cfq_rb_erase(struct rb_node *n, struct cfq_rb_root *root)
 {
+	if (root->rb_rightmost == n)
+		root->rb_rightmost = rb_next(n);
+
 	rb_erase_cached(n, &root->rb);
 	RB_CLEAR_NODE(n);
 
@@ -1239,20 +1244,24 @@ __cfq_group_service_tree_add(struct cfq_rb_root *st, struct cfq_group *cfqg)
 	struct rb_node *parent = NULL;
 	struct cfq_group *__cfqg;
 	s64 key = cfqg_key(st, cfqg);
-	bool leftmost = true;
+	bool leftmost = true, rightmost = true;
 
 	while (*node != NULL) {
 		parent = *node;
 		__cfqg = rb_entry_cfqg(parent);
 
-		if (key < cfqg_key(st, __cfqg))
+		if (key < cfqg_key(st, __cfqg)) {
 			node = &parent->rb_left;
-		else {
+			rightmost = false;
+		} else {
 			node = &parent->rb_right;
 			leftmost = false;
 		}
 	}
 
+	if (rightmost)
+		st->rb_rightmost = &cfqg->rb_node;
+
 	rb_link_node(&cfqg->rb_node, parent, node);
 	rb_insert_color_cached(&cfqg->rb_node, &st->rb, leftmost);
 }
@@ -1355,7 +1364,7 @@ cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
 	 * so that groups get lesser vtime based on their weights, so that
 	 * if group does not loose all if it was not continuously backlogged.
 	 */
-	n = rb_last(&st->rb.rb_root);
+	n = st->rb_rightmost;
 	if (n) {
 		__cfqg = rb_entry_cfqg(n);
 		cfqg->vdisktime = __cfqg->vdisktime +
@@ -2204,7 +2213,7 @@ static void cfq_service_tree_add(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	st = st_for(cfqq->cfqg, cfqq_class(cfqq), cfqq_type(cfqq));
 	if (cfq_class_idle(cfqq)) {
 		rb_key = CFQ_IDLE_DELAY;
-		parent = rb_last(&st->rb.rb_root);
+		parent = st->rb_rightmost;
 		if (parent && parent != &cfqq->rb_node) {
 			__cfqq = rb_entry(parent, struct cfq_queue, rb_node);
 			rb_key += __cfqq->rb_key;
-- 
2.12.0
