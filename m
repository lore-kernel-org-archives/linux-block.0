Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38563 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdF3P5G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:57:06 -0400
Received: by mail-wm0-f52.google.com with SMTP id b184so50447952wme.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:57:05 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 09/10] lightnvm: pblk: verify that cache read is still valid
Date: Fri, 30 Jun 2017 17:56:42 +0200
Message-Id: <1498838203-21539-10-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a read is directed to the cache, we risk that the lba has been
updated during the time we made the L2P table lookup and the time we are
actually reading form the cache. We intentionally not hold the L2P lock
not to block other threads.

While strict ordering is not a guarantee at this level (unless REQ_FLUSH
has been previously issued), we have experience that some databases that
have recently implemented direct I/O support, issue metadata reads very
close to the writes, without issuing a fsync in the middle. An easy way
to support them while they is to make an extra effort and check the L2P
map right before reading the cache.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c   | 15 ++++++++++++---
 drivers/lightnvm/pblk-read.c |  3 +--
 drivers/lightnvm/pblk.h      | 10 +++++++++-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 7300be98e831..5ecc154f6831 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -150,6 +150,7 @@ static void clean_wctx(struct pblk_w_ctx *w_ctx)
 	/* Release flags on context. Protect from writes and reads */
 	smp_store_release(&w_ctx->flags, PBLK_WRITABLE_ENTRY);
 	pblk_ppa_set_empty(&w_ctx->ppa);
+	w_ctx->lba = ADDR_EMPTY;
 }
 
 #define pblk_rb_ring_count(head, tail, size) CIRC_CNT(head, tail, size)
@@ -656,15 +657,17 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
  * be directed to disk.
  */
 int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
-			u64 pos, int bio_iter)
+			struct ppa_addr ppa, int bio_iter)
 {
+	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_rb_entry *entry;
 	struct pblk_w_ctx *w_ctx;
+	struct ppa_addr l2p_ppa;
+	u64 pos = pblk_addr_to_cacheline(ppa);
 	void *data;
 	int flags;
 	int ret = 1;
 
-	spin_lock(&rb->w_lock);
 
 #ifdef CONFIG_NVM_DEBUG
 	/* Caller must ensure that the access will not cause an overflow */
@@ -674,8 +677,14 @@ int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
 	w_ctx = &entry->w_ctx;
 	flags = READ_ONCE(w_ctx->flags);
 
+	spin_lock(&rb->w_lock);
+	spin_lock(&pblk->trans_lock);
+	l2p_ppa = pblk_trans_map_get(pblk, lba);
+	spin_unlock(&pblk->trans_lock);
+
 	/* Check if the entry has been overwritten or is scheduled to be */
-	if (w_ctx->lba != lba || flags & PBLK_WRITABLE_ENTRY) {
+	if (!pblk_ppa_comp(l2p_ppa, ppa) || w_ctx->lba != lba ||
+						flags & PBLK_WRITABLE_ENTRY) {
 		ret = 0;
 		goto out;
 	}
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 31d4869b0500..4e5c48f3de62 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -34,8 +34,7 @@ static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 	BUG_ON(!pblk_addr_in_cache(ppa));
 #endif
 
-	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba,
-					pblk_addr_to_cacheline(ppa), bio_iter);
+	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba, ppa, bio_iter);
 }
 
 static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index bf5b73fb345f..15931381348c 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -670,7 +670,7 @@ unsigned int pblk_rb_read_to_bio_list(struct pblk_rb *rb, struct bio *bio,
 				      struct list_head *list,
 				      unsigned int max);
 int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
-			u64 pos, int bio_iter);
+			struct ppa_addr ppa, int bio_iter);
 unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
@@ -1037,6 +1037,14 @@ static inline void pblk_ppa_set_empty(struct ppa_addr *ppa_addr)
 	ppa_addr->ppa = ADDR_EMPTY;
 }
 
+static inline bool pblk_ppa_comp(struct ppa_addr lppa, struct ppa_addr rppa)
+{
+	if (lppa.ppa == rppa.ppa)
+		return true;
+
+	return false;
+}
+
 static inline int pblk_addr_in_cache(struct ppa_addr ppa)
 {
 	return (ppa.ppa != ADDR_EMPTY && ppa.c.is_cached);
-- 
2.7.4
