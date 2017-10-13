Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54990 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758302AbdJMMro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id i124so21517571wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:43 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 38/58] lightnvm: pblk: ensure right bad block calculation
Date: Fri, 13 Oct 2017 14:46:27 +0200
Message-Id: <20171013124647.32668-39-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Make sure that the variable controlling block threshold for allocating
extra metadata sectors in case of a line with bad blocks does not get a
negative value. Otherwise, the line will be marked as corrupted and
wasted.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3c37491..c7239c4 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -710,7 +710,7 @@ static int pblk_lines_init(struct pblk *pblk)
 		goto add_emeta_page;
 	}
 
-	lm->emeta_bb = geo->nr_luns - i;
+	lm->emeta_bb = geo->nr_luns > i ? geo->nr_luns - i : 0;
 
 	lm->min_blk_line = 1;
 	if (geo->nr_luns > 1)
-- 
2.9.3
