Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB27C433DB
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 01:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112B22222B
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 01:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgLZB2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Dec 2020 20:28:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9929 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgLZB2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Dec 2020 20:28:18 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D2mPb6XQyzhx9m;
        Sat, 26 Dec 2020 09:26:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 26 Dec 2020 09:27:33 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <josh.h.morris@us.ibm.com>, <pjk1939@linux.ibm.com>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] rsxx: remove unused including <linux/version.h>
Date:   Sat, 26 Dec 2020 09:27:36 +0800
Message-ID: <1608946056-8190-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/block/rsxx/rsxx_priv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rsxx/rsxx_priv.h b/drivers/block/rsxx/rsxx_priv.h
index 4861669..61479779 100644
--- a/drivers/block/rsxx/rsxx_priv.h
+++ b/drivers/block/rsxx/rsxx_priv.h
@@ -11,7 +11,6 @@
 #ifndef __RSXX_PRIV_H__
 #define __RSXX_PRIV_H__
 
-#include <linux/version.h>
 #include <linux/semaphore.h>
 
 #include <linux/fs.h>
-- 
2.7.4

