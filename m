Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61BCEB64DD
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 06:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjHIGTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHIGTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 02:19:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EAF1BF2
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 23:19:44 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLKcj0tdjzmXLj;
        Wed,  9 Aug 2023 14:18:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 14:19:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:19:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <yangyingliang@huawei.com>
Subject: [PATCH -next] block/swim: remove unnecessary check of res
Date:   Wed, 9 Aug 2023 14:16:39 +0800
Message-ID: <20230809061639.1040093-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The resource is checked in probe function, so there is
no need do this check in remove function.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/block/swim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index f85b6af414b4..6f7b5e15fd6d 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -933,8 +933,7 @@ static int swim_remove(struct platform_device *dev)
 		floppy_eject(&swd->unit[drive]);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
+	release_mem_region(res->start, resource_size(res));
 
 	kfree(swd);
 
-- 
2.25.1

