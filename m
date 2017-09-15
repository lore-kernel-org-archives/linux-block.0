Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:45357 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdIOMZw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:25:52 -0400
Received: by mail-wm0-f47.google.com with SMTP id g206so7900857wme.0
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:25:51 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 08/11] lightnvm: pblk: allocate bio size more accurately
Date: Fri, 15 Sep 2017 14:25:36 +0200
Message-Id: <1505478339-13089-9-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
References: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Wait until we know the exact number of ppas to be sent to the device,
before allocating the bio.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c    |  5 +++--
 drivers/lightnvm/pblk-write.c | 20 ++++++++++----------
 drivers/lightnvm/pblk.h       |  4 ++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 05e6b2e9221d..1173e2380137 100644
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
index 4cea2f76d4e2..d440dbbe018d 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -537,24 +537,24 @@ static int pblk_submit_write(struct pblk *pblk)
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
index 2b6ec6b7a794..74fa189a94e1 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -665,8 +665,8 @@ void pblk_rb_flush(struct pblk_rb *rb);
 
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
2.7.4
