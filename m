Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55989 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbdJMMrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id u138so21646305wmu.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:48 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 43/58] lightnvm: pblk: reduce arguments in __pblk_rb_update_l2p
Date: Fri, 13 Oct 2017 14:46:32 +0200
Message-Id: <20171013124647.32668-44-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

We already pass the structure pointer so no need to pass the member.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-rb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 1173e23..b8f78e4 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -201,8 +201,7 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int nr_entries)
 	return subm;
 }
 
-static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
-				unsigned int to_update)
+static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_line *line;
@@ -213,7 +212,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
 	int flags;
 
 	for (i = 0; i < to_update; i++) {
-		entry = &rb->entries[*l2p_upd];
+		entry = &rb->entries[rb->l2p_update];
 		w_ctx = &entry->w_ctx;
 
 		flags = READ_ONCE(entry->w_ctx.flags);
@@ -230,7 +229,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
 		line = &pblk->lines[pblk_tgt_ppa_to_line(w_ctx->ppa)];
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
-		*l2p_upd = (*l2p_upd + 1) & (rb->nr_entries - 1);
+		rb->l2p_update = (rb->l2p_update + 1) & (rb->nr_entries - 1);
 	}
 
 	pblk_rl_out(&pblk->rl, user_io, gc_io);
@@ -258,7 +257,7 @@ static int pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int nr_entries,
 
 	count = nr_entries - space;
 	/* l2p_update used exclusively under rb->w_lock */
-	ret = __pblk_rb_update_l2p(rb, &rb->l2p_update, count);
+	ret = __pblk_rb_update_l2p(rb, count);
 
 out:
 	return ret;
@@ -280,7 +279,7 @@ void pblk_rb_sync_l2p(struct pblk_rb *rb)
 	sync = smp_load_acquire(&rb->sync);
 
 	to_update = pblk_rb_ring_count(sync, rb->l2p_update, rb->nr_entries);
-	__pblk_rb_update_l2p(rb, &rb->l2p_update, to_update);
+	__pblk_rb_update_l2p(rb, to_update);
 
 	spin_unlock(&rb->w_lock);
 }
-- 
2.9.3
