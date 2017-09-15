Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:44668 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdIOMgC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:36:02 -0400
Received: by mail-wm0-f41.google.com with SMTP id 189so2643374wmh.1
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:36:02 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: ensure right bad block calculation
Date: Fri, 15 Sep 2017 14:35:53 +0200
Message-Id: <1505478953-16915-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
References: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make sure that the variable controlling block threshold for allocating
extra metadata sectors in case of a line with bad blocks does not get a
negative value. Otherwise, the line will be marked as corrupted and
wasted.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9d9adcf3e141..7cf4b536d899 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -707,7 +707,7 @@ static int pblk_lines_init(struct pblk *pblk)
 		goto add_emeta_page;
 	}
 
-	lm->emeta_bb = geo->nr_luns - i;
+	lm->emeta_bb = geo->nr_luns > i ? geo->nr_luns - i : 0;
 
 	lm->min_blk_line = 1;
 	if (geo->nr_luns > 1)
-- 
2.7.4
