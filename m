Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34893 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdF3P5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:57:00 -0400
Received: by mail-wm0-f42.google.com with SMTP id w126so113905023wme.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:56:59 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 08/10] lightnvm: pblk: add initialization check
Date: Fri, 30 Jun 2017 17:56:41 +0200
Message-Id: <1498838203-21539-9-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a sanity check to the pblk initialization sequence in order to
ensure that enough LUNs have been allocated to store the line metadata.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 025d8fe52154..1b0f61233c21 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -716,6 +716,12 @@ static int pblk_lines_init(struct pblk *pblk)
 	lm->emeta_bb = geo->nr_luns - i;
 	lm->min_blk_line = 1 + DIV_ROUND_UP(lm->smeta_sec + lm->emeta_sec[0],
 							geo->sec_per_blk);
+	if (lm->min_blk_line > lm->blk_per_line) {
+		pr_err("pblk: config. not supported. Min. LUN in line:%d\n",
+							lm->blk_per_line);
+		ret = -EINVAL;
+		goto fail;
+	}
 
 	ret = pblk_lines_alloc_metadata(pblk);
 	if (ret)
-- 
2.7.4
