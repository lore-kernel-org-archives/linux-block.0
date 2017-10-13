Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:57310 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758252AbdJMMrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so21511572wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:35 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 29/58] lightnvm: pblk: allocate bio size more accurately
Date: Fri, 13 Oct 2017 14:46:18 +0200
Message-Id: <20171013124647.32668-30-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Wait until we know the exact number of ppas to be sent to the device,
before allocating the bio.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-rb.c    |  5 +++--
 drivers/lightnvm/pblk-write.c | 20 ++++++++++----------
 drivers/lightnvm/pblk.h       |  4 ++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 05e6b2e..1173e23 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -552,12 +552,13 @@ unsigned int pblk_rb_read_to_bio_list(struct pblk_rb *rb, struct bio *bio,
  * persist data on the write buffer to the media.
  */
 unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
-				 struct bio *bio, unsigned int pos,
-				 unsigned int nr_entries, unsigned int count)
+				 unsigned int pos, unsigned int nr_entries,
+				 unsigned int count)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct request_queue *q = pblk->dev->q;
 	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
+	struct bio *bio = rqd->bio;
 	struct pblk_rb_entry *entry;
 	struct page *page;
 	unsigned int pad = 0, to_read = nr_entries;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 0c0481c..140a26e 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -534,24 +534,24 @@ static int pblk_submit_write(struct pblk *pblk)
 	if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
 		return 1;
 
-	bio = bio_alloc(GFP_KERNEL, pblk->max_write_pgs);
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-
-	rqd = pblk_alloc_rqd(pblk, WRITE);
-	rqd->bio = bio;
-
 	secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail, secs_to_flush);
 	if (secs_to_sync > pblk->max_write_pgs) {
 		pr_err("pblk: bad buffer sync calculation\n");
-		goto fail_put_bio;
+		return 1;
 	}
 
 	secs_to_com = (secs_to_sync > secs_avail) ? secs_avail : secs_to_sync;
 	pos = pblk_rb_read_commit(&pblk->rwb, secs_to_com);
 
-	if (pblk_rb_read_to_bio(&pblk->rwb, rqd, bio, pos, secs_to_sync,
+	bio = bio_alloc(GFP_KERNEL, secs_to_sync);
+
+	bio->bi_iter.bi_sector = 0; /* internal bio */
+	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+
+	rqd = pblk_alloc_rqd(pblk, WRITE);
+	rqd->bio = bio;
+
+	if (pblk_rb_read_to_bio(&pblk->rwb, rqd, pos, secs_to_sync,
 								secs_avail)) {
 		pr_err("pblk: corrupted write bio\n");
 		goto fail_put_bio;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 876b50f..9f16205 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -666,8 +666,8 @@ void pblk_rb_flush(struct pblk_rb *rb);
 
 void pblk_rb_sync_l2p(struct pblk_rb *rb);
 unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
-				 struct bio *bio, unsigned int pos,
-				 unsigned int nr_entries, unsigned int count);
+				 unsigned int pos, unsigned int nr_entries,
+				 unsigned int count);
 unsigned int pblk_rb_read_to_bio_list(struct pblk_rb *rb, struct bio *bio,
 				      struct list_head *list,
 				      unsigned int max);
-- 
2.9.3
