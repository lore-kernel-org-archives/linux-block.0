Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36331 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdG0Ot6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2017 10:49:58 -0400
Received: by mail-wm0-f52.google.com with SMTP id t201so101621938wmt.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2017 07:49:57 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
Subject: [PATCH] lightnvm: pblk: advance bio according to lba index
Date: Thu, 27 Jul 2017 16:49:50 +0200
Message-Id: <1501166990-24366-2-git-send-email-javier@javigon.com>
In-Reply-To: <1501166990-24366-1-git-send-email-javier@javigon.com>
References: <1501166990-24366-1-git-send-email-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a lba either hits the cache or corresponds to an empty entry in the
L2P table, we need to advance the bio according to the position in which
the lba is located. Otherwise, we will copy data in the wrong page, thus
causing data corruption for the application.

In case of a cache hit, we assumed that bio->bi_iter.bi_idx would
contain the correct index, but this is no necessarily true. Instead, use
the local bio advance counter and iterator. This guarantees that lbas
hitting the cache are copied into the right bv_page.

In case of an empty L2P entry, we omitted to advance the bio. In the
cases when the same I/O also contains a cache hit, data corresponding
to this lba will be copied to the wrong bv_page. Fix this by advancing
the bio as we do in the case of a cache hit.

Fixes: a4bd217b4326 lightnvm: physical block device (pblk) target

Signed-off-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/pblk-rb.c   |  4 ++--
 drivers/lightnvm/pblk-read.c | 19 ++++++++++++++-----
 drivers/lightnvm/pblk.h      |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 5ecc154f6831..2e88c3d6d9a1 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -657,7 +657,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
  * be directed to disk.
  */
 int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
-			struct ppa_addr ppa, int bio_iter)
+			struct ppa_addr ppa, int bio_iter, int advanced_bio)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_rb_entry *entry;
@@ -694,7 +694,7 @@ int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
 	 * filled with data from the cache). If part of the data resides on the
 	 * media, we will read later on
 	 */
-	if (unlikely(!bio->bi_iter.bi_idx))
+	if (unlikely(!advanced_bio))
 		bio_advance(bio, bio_iter * PBLK_EXPOSED_PAGE_SIZE);
 
 	data = bio_data(bio);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 4e5c48f3de62..b1c554e374f7 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -26,7 +26,7 @@
  */
 static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 				sector_t lba, struct ppa_addr ppa,
-				int bio_iter)
+				int bio_iter, int advanced_bio)
 {
 #ifdef CONFIG_NVM_DEBUG
 	/* Callers must ensure that the ppa points to a cache address */
@@ -34,7 +34,8 @@ static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 	BUG_ON(!pblk_addr_in_cache(ppa));
 #endif
 
-	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba, ppa, bio_iter);
+	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba, ppa,
+						bio_iter, advanced_bio);
 }
 
 static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
@@ -62,14 +63,21 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 retry:
 		if (pblk_ppa_empty(p)) {
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			continue;
+
+			if (unlikely(!advanced_bio)) {
+				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
+				advanced_bio = 1;
+			}
+
+			goto next;
 		}
 
 		/* Try to read from write buffer. The address is later checked
 		 * on the write buffer to prevent retrieving overwritten data.
 		 */
 		if (pblk_addr_in_cache(p)) {
-			if (!pblk_read_from_cache(pblk, bio, lba, p, i)) {
+			if (!pblk_read_from_cache(pblk, bio, lba, p, i,
+								advanced_bio)) {
 				pblk_lookup_l2p_seq(pblk, &p, lba, 1);
 				goto retry;
 			}
@@ -83,6 +91,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			rqd->ppa_list[j++] = p;
 		}
 
+next:
 		if (advanced_bio)
 			bio_advance(bio, PBLK_EXPOSED_PAGE_SIZE);
 	}
@@ -282,7 +291,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	 * write buffer to prevent retrieving overwritten data.
 	 */
 	if (pblk_addr_in_cache(ppa)) {
-		if (!pblk_read_from_cache(pblk, bio, lba, ppa, 0)) {
+		if (!pblk_read_from_cache(pblk, bio, lba, ppa, 0, 1)) {
 			pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
 			goto retry;
 		}
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0c5692cc2f60..0e77d069f080 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -670,7 +670,7 @@ unsigned int pblk_rb_read_to_bio_list(struct pblk_rb *rb, struct bio *bio,
 				      struct list_head *list,
 				      unsigned int max);
 int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
-			struct ppa_addr ppa, int bio_iter);
+			struct ppa_addr ppa, int bio_iter, int advanced_bio);
 unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
-- 
2.7.4
