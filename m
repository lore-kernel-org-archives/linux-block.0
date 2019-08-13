Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF3AC32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 11:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6169A206C2
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 11:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfHMLQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:16:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbfHMLQz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 07:16:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5F79F4EC62BA6836A756;
        Tue, 13 Aug 2019 19:16:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 19:16:42 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <tim@cyberelk.net>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] paride/pcd: need to check if cd->disk is null in pcd_detect
Date:   Tue, 13 Aug 2019 19:23:12 +0800
Message-ID: <1565695392-140970-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If alloc_disk fails in pcd_init_units, cd->disk & pi are empty, we need
to check if cd->disk is null in pcd_detect.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/block/paride/pcd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index bfca80d..636bfea 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -723,9 +723,9 @@ static int pcd_detect(void)
 	k = 0;
 	if (pcd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
 		cd = pcd;
-		if (pi_init(cd->pi, 1, -1, -1, -1, -1, -1, pcd_buffer,
-			    PI_PCD, verbose, cd->name)) {
-			if (!pcd_probe(cd, -1, id) && cd->disk) {
+		if (cd->disk && pi_init(cd->pi, 1, -1, -1, -1, -1, -1,
+			    pcd_buffer, PI_PCD, verbose, cd->name)) {
+			if (!pcd_probe(cd, -1, id)) {
 				cd->present = 1;
 				k++;
 			} else
@@ -736,11 +736,13 @@ static int pcd_detect(void)
 			int *conf = *drives[unit];
 			if (!conf[D_PRT])
 				continue;
+			if (!cd->disk)
+				continue;
 			if (!pi_init(cd->pi, 0, conf[D_PRT], conf[D_MOD],
 				     conf[D_UNI], conf[D_PRO], conf[D_DLY],
 				     pcd_buffer, PI_PCD, verbose, cd->name))
 				continue;
-			if (!pcd_probe(cd, conf[D_SLV], id) && cd->disk) {
+			if (!pcd_probe(cd, conf[D_SLV], id)) {
 				cd->present = 1;
 				k++;
 			} else
--
2.7.4

