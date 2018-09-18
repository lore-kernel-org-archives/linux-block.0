Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46821 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeIRNel (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so1079680edr.13
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 01:03:14 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/4] lightnvm: pblk: remove unused function
Date: Tue, 18 Sep 2018 10:03:02 +0200
Message-Id: <1537257785-31630-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Removed unused function in pblk-rb.c

Signed-off-by: Javier González <javier@cnexlabs.com>
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
index 127ee99c3efc..e70ece87a9f4 100644
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
2.7.4
