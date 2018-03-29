Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33178 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeC2WHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id x70-v6so3501660lfa.0
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:13 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 11/37] lightnvm: pblk: prevent race in pblk_rb_flush_point_set
Date: Fri, 30 Mar 2018 00:04:58 +0200
Message-Id: <20180329220524.30363-12-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Make sure that we are not advancing the sync pointer while
we're adding bios to the write buffer entry completion list.

This race condition results in bios not completing and was identified
by a hang when running xfstest generic/113.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 8b1434060fb3..52fdd85dbc97 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -355,10 +355,13 @@ static int pblk_rb_flush_point_set(struct pblk_rb *rb, struct bio *bio,
 	struct pblk_rb_entry *entry;
 	unsigned int sync, flush_point;
 
+	pblk_rb_sync_init(rb, NULL);
 	sync = READ_ONCE(rb->sync);
 
-	if (pos == sync)
+	if (pos == sync) {
+		pblk_rb_sync_end(rb, NULL);
 		return 0;
+	}
 
 #ifdef CONFIG_NVM_DEBUG
 	atomic_inc(&rb->inflight_flush_point);
@@ -367,8 +370,6 @@ static int pblk_rb_flush_point_set(struct pblk_rb *rb, struct bio *bio,
 	flush_point = (pos == 0) ? (rb->nr_entries - 1) : (pos - 1);
 	entry = &rb->entries[flush_point];
 
-	pblk_rb_sync_init(rb, NULL);
-
 	/* Protect flush points */
 	smp_store_release(&rb->flush_point, flush_point);
 
-- 
2.11.0
