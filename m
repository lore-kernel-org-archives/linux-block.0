Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA0C35641
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 07:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691AF20801
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 07:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgBUHQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:16:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgBUHQc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 02:16:32 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0170ABA3D270B408D46D;
        Fri, 21 Feb 2020 15:16:24 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 15:16:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <axboe@kernel.dk>, <arnd@arndb.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] block: scsi-ioctl: remove duplicated include <scsi/sg.h>
Date:   Fri, 21 Feb 2020 15:16:00 +0800
Message-ID: <20200221071600.17032-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 block/scsi_ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index b4e73d5..20addda 100644
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


