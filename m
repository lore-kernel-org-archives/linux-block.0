Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37313 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeJISbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so680552pfi.4
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:15:23 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 38/45] lightnvm: pblk: remove unused function
Date: Tue,  9 Oct 2018 13:12:08 +0200
Message-Id: <20181009111215.7653-39-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Removed unused function in pblk-rb.c

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c | 26 --------------------------
 drivers/lightnvm/pblk.h    |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index c26eab2ba8bd..82829e8151db 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -729,32 +729,6 @@ unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb)
 	return (submitted < to_flush) ? (to_flush - submitted) : 0;
 }
 
-/*
- * Scan from the current position of the sync pointer to find the entry that
- * corresponds to the given ppa. This is necessary since write requests can be
- * completed out of order. The assumption is that the ppa is close to the sync
- * pointer thus the search will not take long.
- *
- * The caller of this function must guarantee that the sync pointer will no
- * reach the entry while it is using the metadata associated with it. With this
- * assumption in mind, there is no need to take the sync lock.
- */
-struct pblk_rb_entry *pblk_rb_sync_scan_entry(struct pblk_rb *rb,
-					      struct ppa_addr *ppa)
-{
-	unsigned int sync, subm, count;
-	unsigned int i;
-
-	sync = READ_ONCE(rb->sync);
-	subm = READ_ONCE(rb->subm);
-	count = pblk_rb_ring_count(subm, sync, rb->nr_entries);
-
-	for (i = 0; i < count; i++)
-		sync = (sync + 1) & (rb->nr_entries - 1);
-
-	return NULL;
-}
-
 int pblk_rb_tear_down_check(struct pblk_rb *rb)
 {
 	struct pblk_rb_entry *entry;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index e710f6db2a35..22586b78198a 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -760,8 +760,6 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_sync_advance(struct pblk_rb *rb, unsigned int nr_entries);
-struct pblk_rb_entry *pblk_rb_sync_scan_entry(struct pblk_rb *rb,
-					      struct ppa_addr *ppa);
 void pblk_rb_sync_end(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb);
 
-- 
2.17.1
