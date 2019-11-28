Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB18C43141
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 03:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D70215F2
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 03:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfK1DCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 22:02:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbfK1DCX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 22:02:23 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BF23E3B45CB538E0BF0B;
        Thu, 28 Nov 2019 11:02:19 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 11:02:10 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <axboe@kernel.dk>, <drbd-dev@lists.linbit.com>,
        <linux-block@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/3] block: sunvdc: Remove unneeded semicolon
Date:   Thu, 28 Nov 2019 11:09:31 +0800
Message-ID: <1574910572-42062-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
References: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes coccicheck warning:

drivers/block/sunvdc.c:637:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/block/sunvdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 6b2fd63..571612e 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -634,7 +634,7 @@ static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
 	case VD_OP_GET_EFI:
 	case VD_OP_SET_EFI:
 		return -EOPNOTSUPP;
-	};
+	}

 	map_perm |= LDC_MAP_SHADOW | LDC_MAP_DIRECT | LDC_MAP_IO;

--
2.7.4

