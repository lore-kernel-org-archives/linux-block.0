Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37297 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdF3P5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:57:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id i127so50617951wma.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:57:04 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 03/10] lightnvm: pblk: remove unused return variable
Date: Fri, 30 Jun 2017 17:56:36 +0200
Message-Id: <1498838203-21539-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove unused variable.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 22e6f2ad4aee..95fb434e2f01 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -322,7 +322,7 @@ static ssize_t pblk_sysfs_gc_force(struct pblk *pblk, const char *page,
 				   size_t len)
 {
 	size_t c_len;
-	int ret, force;
+	int force;
 
 	c_len = strcspn(page, "\n");
 	if (c_len >= len)
@@ -331,7 +331,7 @@ static ssize_t pblk_sysfs_gc_force(struct pblk *pblk, const char *page,
 	if (kstrtouint(page, 0, &force))
 		return -EINVAL;
 
-	ret = pblk_gc_sysfs_force(pblk, force);
+	pblk_gc_sysfs_force(pblk, force);
 
 	return len;
 }
-- 
2.7.4
