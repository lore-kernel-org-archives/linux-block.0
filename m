Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B88CC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B0964EC6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBBBmz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:42:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12001 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhBBBmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 20:42:55 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DV6w41fFKzjHjF;
        Tue,  2 Feb 2021 09:40:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 09:42:05 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mb@lightnvm.io>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] lightnvm: fix unnecessary NULL check warnings
Date:   Tue, 2 Feb 2021 09:41:45 +0800
Message-ID: <1612230105-31365-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove NULL checks before vfree() to fix these warnings:
./drivers/lightnvm/pblk-gc.c:27:2-7: WARNING: NULL check before some
freeing functions is not needed.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/lightnvm/pblk-gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 2581eeb..b31658b 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -23,8 +23,7 @@
 
 static void pblk_gc_free_gc_rq(struct pblk_gc_rq *gc_rq)
 {
-	if (gc_rq->data)
-		vfree(gc_rq->data);
+	vfree(gc_rq->data);
 	kfree(gc_rq);
 }
 
-- 
2.7.4

