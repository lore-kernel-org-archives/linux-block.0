Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55C9C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611DD21D92
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgIKLB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:01:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgIKLBY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 07:01:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D49225848A52440E4C79;
        Fri, 11 Sep 2020 19:01:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Sep 2020 19:01:11 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] scsi: core: Remove the unused include statements
Date:   Fri, 11 Sep 2020 18:58:52 +0800
Message-ID: <1599821932-22682-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi/sg.h is included more than once, Remove the one that isn't
necessary.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 block/scsi_ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f0..4421e61 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -37,8 +37,6 @@ const unsigned char scsi_command_size_tbl[8] =
 };
 EXPORT_SYMBOL(scsi_command_size_tbl);
 
-#include <scsi/sg.h>
-
 static int sg_get_version(int __user *p)
 {
 	static const int sg_version_num = 30527;
-- 
2.7.4

