Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8EAC433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EA42184E
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbfHIJUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:20:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbfHIJUc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 05:20:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7DFAFB7196D647A76A86;
        Fri,  9 Aug 2019 17:20:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:20:22 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-block@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH -next] lightnvm: Fix unused variable warning
Date:   Fri, 9 Aug 2019 17:18:16 +0800
Message-ID: <1565342296-45355-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drivers/lightnvm/pblk-read.c: In function ‘pblk_submit_read_gc’:
drivers/lightnvm/pblk-read.c:421:18: warning: unused variable ‘geo’ [-Wunused-variable]
  struct nvm_geo *geo = &dev->geo;
                  ^
Fixes: ba6f7da99aaf ("lightnvm: remove set but not used variables 'data_len' and 'rq_len'")
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/lightnvm/pblk-read.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 0cdc48f9cfbf..8efd14e683dc 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -417,8 +417,6 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 
 int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct nvm_rq rqd;
 	int ret = NVM_IO_OK;
 
-- 
2.7.4

