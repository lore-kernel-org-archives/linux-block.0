Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC5C001DB
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 08:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjHJItE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjHJItE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 04:49:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6E2127
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 01:49:01 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM0sf23R5zTmXR;
        Thu, 10 Aug 2023 16:47:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:48:58 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <ming.lei@redhat.com>, <axboe@kernel.dk>, <a.hindborg@samsung.com>
CC:     <lizetao1@huawei.com>, <linux-block@vger.kernel.org>
Subject: [PATCH -next] ublk: Fix signedness bug returning warning
Date:   Thu, 10 Aug 2023 16:48:36 +0800
Message-ID: <20230810084836.3535322-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are two warnings reported by smatch:

drivers/block/ublk_drv.c:445 ublk_setup_iod_zoned() warn:
	signedness bug returning '(-95)'
drivers/block/ublk_drv.c:963 ublk_setup_iod() warn:
	signedness bug returning '(-5)'

The type of "blk_status_t" is either be a u32 or u8, but this two
functions return a negative value when not supported or failed. Use
the error code of the blk module to fix these warnings.

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202308100201.TCRhgdvN-lkp@intel.com/
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 85a81ee556d5..ef1760b3d8b5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -442,7 +442,7 @@ static int ublk_revalidate_disk_zones(struct ublk_device *ub)
 static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 					 struct request *req)
 {
-	return -EOPNOTSUPP;
+	return BLK_STS_NOTSUPP;
 }
 
 #endif
@@ -960,7 +960,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 
 	if (!ublk_queue_is_zoned(ubq) &&
 	    (op_is_zone_mgmt(op) || op == REQ_OP_ZONE_APPEND))
-		return -EIO;
+		return BLK_STS_IOERR;
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
-- 
2.34.1

