Return-Path: <SRS0=uz0K=DY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31247C433DF
	for <linux-block@archiver.kernel.org>; Sat, 17 Oct 2020 05:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F291520714
	for <linux-block@archiver.kernel.org>; Sat, 17 Oct 2020 05:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411658AbgJQFjh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Oct 2020 01:39:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410580AbgJQFjh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Oct 2020 01:39:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DEE45B83F56DE504B572;
        Sat, 17 Oct 2020 09:51:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 17 Oct 2020 09:51:43 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <Damien.LeMoal@wdc.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] skd_main: remove unused including <linux/version.h>
Date:   Sat, 17 Oct 2020 09:52:29 +0800
Message-ID: <1602899549-8241-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/block/skd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ae6454c..a962b45 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -25,7 +25,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 #include <linux/scatterlist.h>
-#include <linux/version.h>
 #include <linux/err.h>
 #include <linux/aer.h>
 #include <linux/wait.h>
-- 
2.7.4

