Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF78C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4693A613CD
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 06:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbhI2GmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:42:18 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35148 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244342AbhI2GmS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 02:42:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uq.1tyG_1632897635;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Uq.1tyG_1632897635)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 14:40:36 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tim@cyberelk.net
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] pcd: capture error codes on pcd_probe() and pf_probe()
Date:   Wed, 29 Sep 2021 14:40:29 +0800
Message-Id: <1632897629-84965-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No error code were being captured when pcd_probe() and
pf_probe() fail, capture them by assigning them to ret.

Clean up smatch warning:
drivers/block/paride/pcd.c:939 pcd_init_unit() warn: missing error code
'ret'
drivers/block/paride/pf.c:963 pf_init_unit() warn: missing error code
'ret'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/block/paride/pcd.c | 3 ++-
 drivers/block/paride/pf.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 4cc0d14..9ae8859 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -935,7 +935,8 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 	if (!pi_init(cd->pi, autoprobe, port, mode, unit, protocol, delay,
 			pcd_buffer, PI_PCD, verbose, cd->name))
 		goto out_free_disk;
-	if (pcd_probe(cd, ms))
+	ret = pcd_probe(cd, ms);
+	if (ret)
 		goto out_pi_release;
 
 	cd->present = 1;
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 380d80e..7b9acfc 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -959,7 +959,8 @@ static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
 	if (!pi_init(pf->pi, autoprobe, port, mode, unit, protocol, delay,
 			pf_scratch, PI_PF, verbose, pf->name))
 		goto out_free_disk;
-	if (pf_probe(pf))
+	ret = pf_probe(pf);
+	if (ret)
 		goto out_pi_release;
 
 	ret = add_disk(disk);
-- 
1.8.3.1

