Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:58772 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdITTuX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2017 15:50:23 -0400
Date: Wed, 20 Sep 2017 22:50:21 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: fix error path in pblk_lines_alloc_metadata
Message-ID: <20170920195019.GA25759@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use appropriate memory free calls based on allocation type used and
also fix number of times free is called if kmalloc fails.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 7cf4b53..470ef04 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -624,12 +624,16 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
 
 fail_free_emeta:
 	while (--i >= 0) {
-		vfree(l_mg->eline_meta[i]->buf);
+		if (l_mg->emeta_alloc_type == PBLK_VMALLOC_META)
+			vfree(l_mg->eline_meta[i]->buf);
+		else
+			kfree(l_mg->eline_meta[i]->buf);
 		kfree(l_mg->eline_meta[i]);
 	}
 
+	i = PBLK_DATA_LINES;
 fail_free_smeta:
-	for (i = 0; i < PBLK_DATA_LINES; i++)
+	while (--i >= 0)
 		kfree(l_mg->sline_meta[i]);
 
 	return -ENOMEM;
-- 
2.5.0
