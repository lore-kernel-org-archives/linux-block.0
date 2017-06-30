Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34834 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdF3P5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:57:04 -0400
Received: by mail-wm0-f42.google.com with SMTP id w126so113902281wme.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:56:53 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 02/10] lightnvm: pblk: fix double-free on pblk init
Date: Fri, 30 Jun 2017 17:56:35 +0200
Message-Id: <1498838203-21539-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Prevent pblk->lines being double freed in case of an error during pblk
initialization.

Fixes: dd2a43437337: "lightnvm: pblk: sched. metadata on write thread"
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8bdaf7e0e00b..b3fc310aa51c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -812,8 +812,6 @@ static int pblk_lines_init(struct pblk *pblk)
 fail_free_lines:
 	while (--i >= 0)
 		pblk_free_line_bitmaps(&pblk->lines[i]);
-
-	kfree(pblk->lines);
 fail_free_bb_aux:
 	kfree(l_mg->bb_aux);
 fail_free_bb_template:
-- 
2.7.4
