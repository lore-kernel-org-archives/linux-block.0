Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36235 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbdIFKwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:50 -0400
Received: by mail-wm0-f49.google.com with SMTP id i145so28015795wmf.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:50 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 14/18] lightnvm: pblk: simplify path on REQ_PREFLUSH
Date: Wed,  6 Sep 2017 12:51:07 +0200
Message-Id: <1504695071-25928-15-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On REQ_PREFLUSH, directly tag the I/O context flags to signal a flush in
the write to cache path, instead of finding the correct entry context
and imposing a memory barrier. This simplifies the code and might
potentially prevent race conditions when adding functionality to the
write path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-cache.c | 4 +++-
 drivers/lightnvm/pblk-rb.c    | 8 +-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index 1d6b8e3585f1..0d227ef7d1b9 100644
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
index 74c768ce09ef..05e6b2e9221d 100644
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
2.7.4
