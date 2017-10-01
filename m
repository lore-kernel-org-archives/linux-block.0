Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:63397 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbdJANX4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Oct 2017 09:23:56 -0400
Date: Sun, 1 Oct 2017 16:23:54 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 2/6] lightnvm: pblk: reduce arguments in __pblk_rb_update_l2p
Message-ID: <20171001132352.GA5697@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We already pass the structure pointer so no need to pass the member.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-rb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 05e6b2e..920ffac 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -201,9 +201,9 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int nr_entries)
 	return subm;
 }
 
-static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
-				unsigned int to_update)
+static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 {
+	unsigned int l2p_update = rb->l2p_update;
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_line *line;
 	struct pblk_rb_entry *entry;
@@ -213,7 +213,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
 	int flags;
 
 	for (i = 0; i < to_update; i++) {
-		entry = &rb->entries[*l2p_upd];
+		entry = &rb->entries[l2p_update];
 		w_ctx = &entry->w_ctx;
 
 		flags = READ_ONCE(entry->w_ctx.flags);
@@ -230,7 +230,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
 		line = &pblk->lines[pblk_tgt_ppa_to_line(w_ctx->ppa)];
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
-		*l2p_upd = (*l2p_upd + 1) & (rb->nr_entries - 1);
+		rb->l2p_update = (l2p_update + 1) & (rb->nr_entries - 1);
 	}
 
 	pblk_rl_out(&pblk->rl, user_io, gc_io);
@@ -258,7 +258,7 @@ static int pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int nr_entries,
 
 	count = nr_entries - space;
 	/* l2p_update used exclusively under rb->w_lock */
-	ret = __pblk_rb_update_l2p(rb, &rb->l2p_update, count);
+	ret = __pblk_rb_update_l2p(rb, count);
 
 out:
 	return ret;
@@ -280,7 +280,7 @@ void pblk_rb_sync_l2p(struct pblk_rb *rb)
 	sync = smp_load_acquire(&rb->sync);
 
 	to_update = pblk_rb_ring_count(sync, rb->l2p_update, rb->nr_entries);
-	__pblk_rb_update_l2p(rb, &rb->l2p_update, to_update);
+	__pblk_rb_update_l2p(rb, to_update);
 
 	spin_unlock(&rb->w_lock);
 }
-- 
2.7.4
