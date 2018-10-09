Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f172.google.com ([209.85.215.172]:37736 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJISbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:53 -0400
Received: by mail-pg1-f172.google.com with SMTP id c10-v6so658007pgq.4
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:15:26 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 39/45] lightnvm: pblk: encapsulate rb pointer operations
Date: Tue,  9 Oct 2018 13:12:09 +0200
Message-Id: <20181009111215.7653-40-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

pblk's read/write buffer is always a power-of-2, thus wrapping up the
buffer can be done with a bit mask. Since this is an implementation
detail internal to the write buffer, make a helper that hides pointer
increment + wrap, and allows to transparently relax this assumption in
the future.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c    | 21 +++++++++++++--------
 drivers/lightnvm/pblk-write.c |  7 ++-----
 drivers/lightnvm/pblk.h       |  2 ++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 82829e8151db..e46d8cb9d28b 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -169,6 +169,12 @@ static unsigned int pblk_rb_space(struct pblk_rb *rb)
 	return pblk_rb_ring_space(rb, mem, sync, rb->nr_entries);
 }
 
+unsigned int pblk_rb_ptr_wrap(struct pblk_rb *rb, unsigned int p,
+			      unsigned int nr_entries)
+{
+	return (p + nr_entries) & (rb->nr_entries - 1);
+}
+
 /*
  * Buffer count is calculated with respect to the submission entry signaling the
  * entries that are available to send to the media
@@ -195,8 +201,7 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int nr_entries)
 
 	subm = READ_ONCE(rb->subm);
 	/* Commit read means updating submission pointer */
-	smp_store_release(&rb->subm,
-				(subm + nr_entries) & (rb->nr_entries - 1));
+	smp_store_release(&rb->subm, pblk_rb_ptr_wrap(rb, subm, nr_entries));
 
 	return subm;
 }
@@ -229,7 +234,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
-		rb->l2p_update = (rb->l2p_update + 1) & (rb->nr_entries - 1);
+		rb->l2p_update = pblk_rb_ptr_wrap(rb, rb->l2p_update, 1);
 	}
 
 	pblk_rl_out(&pblk->rl, user_io, gc_io);
@@ -408,7 +413,7 @@ static int pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
 		return 0;
 
 	/* Protect from read count */
-	smp_store_release(&rb->mem, (*pos + nr_entries) & (rb->nr_entries - 1));
+	smp_store_release(&rb->mem, pblk_rb_ptr_wrap(rb, *pos, nr_entries));
 	return 1;
 }
 
@@ -432,7 +437,7 @@ static int pblk_rb_may_write_flush(struct pblk_rb *rb, unsigned int nr_entries,
 	if (!__pblk_rb_may_write(rb, nr_entries, pos))
 		return 0;
 
-	mem = (*pos + nr_entries) & (rb->nr_entries - 1);
+	mem = pblk_rb_ptr_wrap(rb, *pos, nr_entries);
 	*io_ret = NVM_IO_DONE;
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
@@ -572,7 +577,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 		/* Release flags on context. Protect from writes */
 		smp_store_release(&entry->w_ctx.flags, flags);
 
-		pos = (pos + 1) & (rb->nr_entries - 1);
+		pos = pblk_rb_ptr_wrap(rb, pos, 1);
 	}
 
 	if (pad) {
@@ -652,7 +657,7 @@ int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
 
 struct pblk_w_ctx *pblk_rb_w_ctx(struct pblk_rb *rb, unsigned int pos)
 {
-	unsigned int entry = pos & (rb->nr_entries - 1);
+	unsigned int entry = pblk_rb_ptr_wrap(rb, pos, 0);
 
 	return &rb->entries[entry].w_ctx;
 }
@@ -698,7 +703,7 @@ unsigned int pblk_rb_sync_advance(struct pblk_rb *rb, unsigned int nr_entries)
 		}
 	}
 
-	sync = (sync + nr_entries) & (rb->nr_entries - 1);
+	sync = pblk_rb_ptr_wrap(rb, sync, nr_entries);
 
 	/* Protect from counts */
 	smp_store_release(&rb->sync, sync);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 277abc8633f7..fa8726493b39 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -140,12 +140,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 	struct pblk_w_ctx *w_ctx;
 	struct ppa_addr ppa_l2p;
 	int flags;
-	unsigned int pos, i;
+	unsigned int i;
 
 	spin_lock(&pblk->trans_lock);
-	pos = sentry;
 	for (i = 0; i < nr_entries; i++) {
-		entry = &rb->entries[pos];
+		entry = &rb->entries[pblk_rb_ptr_wrap(rb, sentry, i)];
 		w_ctx = &entry->w_ctx;
 
 		/* Check if the lba has been overwritten */
@@ -164,8 +163,6 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
-
-		pos = (pos + 1) & (rb->nr_entries - 1);
 	}
 	spin_unlock(&pblk->trans_lock);
 }
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 22586b78198a..7660811aa8af 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -760,6 +760,8 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_sync_advance(struct pblk_rb *rb, unsigned int nr_entries);
+unsigned int pblk_rb_ptr_wrap(struct pblk_rb *rb, unsigned int p,
+			      unsigned int nr_entries);
 void pblk_rb_sync_end(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb);
 
-- 
2.17.1
