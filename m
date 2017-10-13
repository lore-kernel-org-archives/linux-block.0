Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53854 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758251AbdJMMre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id q132so21529590wmd.2
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:34 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 28/58] lightnvm: pblk: simplify path on REQ_PREFLUSH
Date: Fri, 13 Oct 2017 14:46:17 +0200
Message-Id: <20171013124647.32668-29-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

On REQ_PREFLUSH, directly tag the I/O context flags to signal a flush in
the write to cache path, instead of finding the correct entry context
and imposing a memory barrier. This simplifies the code and might
potentially prevent race conditions when adding functionality to the
write path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-cache.c | 4 +++-
 drivers/lightnvm/pblk-rb.c    | 8 +-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index 1d6b8e3..0d227ef 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -43,8 +43,10 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
 	if (unlikely(!bio_has_data(bio)))
 		goto out;
 
+	pblk_ppa_set_empty(&w_ctx.ppa);
 	w_ctx.flags = flags;
-	pblk_ppa_set_empty(&w_ctx.ppa);
+	if (bio->bi_opf & REQ_PREFLUSH)
+		w_ctx.flags |= PBLK_FLUSH_ENTRY;
 
 	for (i = 0; i < nr_entries; i++) {
 		void *data = bio_data(bio);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 74c768c..05e6b2e 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -355,7 +355,6 @@ static int pblk_rb_sync_point_set(struct pblk_rb *rb, struct bio *bio,
 {
 	struct pblk_rb_entry *entry;
 	unsigned int subm, sync_point;
-	int flags;
 
 	subm = READ_ONCE(rb->subm);
 
@@ -369,12 +368,6 @@ static int pblk_rb_sync_point_set(struct pblk_rb *rb, struct bio *bio,
 	sync_point = (pos == 0) ? (rb->nr_entries - 1) : (pos - 1);
 	entry = &rb->entries[sync_point];
 
-	flags = READ_ONCE(entry->w_ctx.flags);
-	flags |= PBLK_FLUSH_ENTRY;
-
-	/* Release flags on context. Protect from writes */
-	smp_store_release(&entry->w_ctx.flags, flags);
-
 	/* Protect syncs */
 	smp_store_release(&rb->sync_point, sync_point);
 
@@ -454,6 +447,7 @@ static int pblk_rb_may_write_flush(struct pblk_rb *rb, unsigned int nr_entries,
 
 	/* Protect from read count */
 	smp_store_release(&rb->mem, mem);
+
 	return 1;
 }
 
-- 
2.9.3
