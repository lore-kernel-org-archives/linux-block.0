Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:49917 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdJXN4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2017 09:56:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id b189so15806124wmd.4
        for <linux-block@vger.kernel.org>; Tue, 24 Oct 2017 06:56:21 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: axboe@fb.com
Cc: mb@lightnvm.io, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove testing leftover
Date: Tue, 24 Oct 2017 15:56:13 +0200
Message-Id: <1508853373-17796-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1508853373-17796-1-git-send-email-javier@cnexlabs.com>
References: <1508853373-17796-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

fixes: 8bd400204bd5 ("lightnvm: pblk: cleanup unused and static functions")
Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 6b64288de6f7..90961033a79f 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -860,11 +860,6 @@ int pblk_rl_is_limit(struct pblk_rl *rl);
 int pblk_sysfs_init(struct gendisk *tdisk);
 void pblk_sysfs_exit(struct gendisk *tdisk);
 
-static inline void test(size_t a)
-{
-	a += 1;
-}
-
 static inline void *pblk_malloc(size_t size, int type, gfp_t flags)
 {
 	if (type == PBLK_KMALLOC_META)
-- 
2.7.4
