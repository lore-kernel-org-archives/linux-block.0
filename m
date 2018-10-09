Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35716 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeJIScN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:32:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so686425pff.2
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:15:47 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 45/45] lightnvm: pblk: guarantee that backpointer is respected on writer stall
Date: Tue,  9 Oct 2018 13:12:15 +0200
Message-Id: <20181009111215.7653-46-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

pblk's write buffer must guarantee that it respects the device's
constrains for reads (i.e., mw_cunits). This is done by maintaining a
backpointer that updates the L2P table as entries wrap up, making them
point to the media instead of pointing to the write buffer.

This mechanism can race in case that the write thread stalls, as the
write pointer will protect the last written entry, thus disregarding the
read constrains.

This patch adds an extra check on wrap up, making sure that the
threshold is respected at all times, preventing new entries to overwrite
committed data, also in case of write thread stall.

Reported-by: Heiner Litz <hlitz@ucsc.edu>
Signed-off-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Heiner Litz <hlitz@ucsc.edu>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 5 +++--
 drivers/lightnvm/pblk-rb.c   | 9 +++++++--
 drivers/lightnvm/pblk.h      | 8 +++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e5239aba806b..13822594647c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -193,8 +193,9 @@ static int pblk_rwb_init(struct pblk *pblk)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	unsigned long buffer_size;
-	int pgs_in_buffer;
+	int pgs_in_buffer, threshold;
 
+	threshold = geo->mw_cunits * geo->all_luns;
 	pgs_in_buffer = (max(geo->mw_cunits, geo->ws_opt) + geo->ws_opt)
 								* geo->all_luns;
 
@@ -203,7 +204,7 @@ static int pblk_rwb_init(struct pblk *pblk)
 	else
 		buffer_size = pgs_in_buffer;
 
-	return pblk_rb_init(&pblk->rwb, buffer_size, geo->csecs);
+	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
 }
 
 /* Minimum pages needed within a lun */
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index f653faa6a9ed..b1f4b51783f4 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -56,7 +56,8 @@ static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
  * allocated and their size must be a power of two
  * (Documentation/core-api/circular-buffers.rst)
  */
-int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
+		 unsigned int seg_size)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_rb_entry *entries;
@@ -79,6 +80,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
 	rb->seg_size = (1 << power_seg_sz);
 	rb->nr_entries = (1 << power_size);
 	rb->mem = rb->subm = rb->sync = rb->l2p_update = 0;
+	rb->back_thres = threshold;
 	rb->flush_point = EMPTY_ENTRY;
 
 	spin_lock_init(&rb->w_lock);
@@ -404,11 +406,14 @@ static int __pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
 {
 	unsigned int mem;
 	unsigned int sync;
+	unsigned int threshold;
 
 	sync = READ_ONCE(rb->sync);
 	mem = READ_ONCE(rb->mem);
 
-	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < nr_entries)
+	threshold = nr_entries + rb->back_thres;
+
+	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < threshold)
 		return 0;
 
 	if (pblk_rb_update_l2p(rb, nr_entries, mem, sync))
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0f98ea24ee59..02bb2e98f8a9 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -203,6 +203,11 @@ struct pblk_rb {
 					 * will be 4KB
 					 */
 
+	unsigned int back_thres;	/* Threshold that shall be maintained by
+					 * the backpointer in order to respect
+					 * geo->mw_cunits on a per chunk basis
+					 */
+
 	struct list_head pages;		/* List of data pages */
 
 	spinlock_t w_lock;		/* Write lock */
@@ -734,7 +739,8 @@ struct pblk_line_ws {
 /*
  * pblk ring buffer operations
  */
-int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_sz);
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
+		 unsigned int seg_sz);
 int pblk_rb_may_write_user(struct pblk_rb *rb, struct bio *bio,
 			   unsigned int nr_entries, unsigned int *pos);
 int pblk_rb_may_write_gc(struct pblk_rb *rb, unsigned int nr_entries,
-- 
2.17.1
