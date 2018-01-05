Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37976 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeAENQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:16:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id 64so2416229wme.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:16:55 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 15/25] lightnvm: pblk: prevent premature sync point resets
Date: Fri,  5 Jan 2018 14:16:11 +0100
Message-Id: <20180105131621.20808-16-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we protect flush pointer updates with a lock, we risk
resetting new flush points before we've synced all sectors
up to that point.

This patch protects new flush points with the same spin lock
that is being held when advancing the sync pointer and
resetting completed flush points.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-rb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 672ef8c..ec8fc31 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -367,17 +367,17 @@ static int pblk_rb_flush_point_set(struct pblk_rb *rb, struct bio *bio,
 	flush_point = (pos == 0) ? (rb->nr_entries - 1) : (pos - 1);
 	entry = &rb->entries[flush_point];
 
+	pblk_rb_sync_init(rb, NULL);
+
 	/* Protect flush points */
 	smp_store_release(&rb->flush_point, flush_point);
 
-	if (!bio)
-		return 0;
+	if (bio)
+		bio_list_add(&entry->w_ctx.bios, bio);
 
-	spin_lock_irq(&rb->s_lock);
-	bio_list_add(&entry->w_ctx.bios, bio);
-	spin_unlock_irq(&rb->s_lock);
+	pblk_rb_sync_end(rb, NULL);
 
-	return 1;
+	return bio ? 1 : 0;
 }
 
 static int __pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
-- 
2.9.3
