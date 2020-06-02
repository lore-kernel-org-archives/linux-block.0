Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF2FC433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 07:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1401F20738
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 07:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFBHSR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:18:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgFBHSQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 03:18:16 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A946942CB0CF275F6D9;
        Tue,  2 Jun 2020 15:18:10 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 15:18:04 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <mb@lightnvm.io>, <axboe@fb.com>, <jg@lightnvm.io>,
        <matias@cnexlabs.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] lightnvm: pblk: Fix kobject memleak
Date:   Tue, 2 Jun 2020 15:17:46 +0800
Message-ID: <20200602071746.73020-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the error return path from kobject_init_and_add() is not
followed by a call to kobject_put() - which means we are leaking
the kobject.

Fix it by adding a call to kobject_put() in the error path of
kobject_init_and_add().

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/lightnvm/pblk-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 6387302..a8cb89b 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -710,6 +710,7 @@ int pblk_sysfs_init(struct gendisk *tdisk)
 					kobject_get(&parent_dev->kobj),
 					"%s", "pblk");
 	if (ret) {
+		kobject_put(&pblk->kobj);
 		pblk_err(pblk, "could not register\n");
 		return ret;
 	}
-- 
1.8.3.1

