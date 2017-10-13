Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51282 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758034AbdJMMrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id f4so21572804wme.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:11 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 05/58] lightnvm: pblk: fix error path in pblk_lines_alloc_metadata
Date: Fri, 13 Oct 2017 14:45:54 +0200
Message-Id: <20171013124647.32668-6-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

Use appropriate memory free calls based on allocation type used and
also fix number of times free is called if kmalloc fails.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 6df65d1..05665a7 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -630,7 +630,10 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
 
 fail_free_emeta:
 	while (--i >= 0) {
-		vfree(l_mg->eline_meta[i]->buf);
+		if (l_mg->emeta_alloc_type == PBLK_VMALLOC_META)
+			vfree(l_mg->eline_meta[i]->buf);
+		else
+			kfree(l_mg->eline_meta[i]->buf);
 		kfree(l_mg->eline_meta[i]);
 	}
 
-- 
2.9.3
