Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:1444 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbcIWExl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2016 00:53:41 -0400
From: Yunlong Song <yunlong.song@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <sylinux@163.com>, <yunlong.song@huawei.com>
CC: <bintian.wang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] block: Change BIO_RESET_BITS to current proper value
Date: Fri, 23 Sep 2016 13:03:44 +0800
Message-ID: <1474607024-21240-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 436f43f..b7221b3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -117,7 +117,7 @@ struct bio {
  * Flags starting here get preserved by bio_reset() - this includes
  * BVEC_POOL_IDX()
  */
-#define BIO_RESET_BITS	10
+#define BIO_RESET_BITS	9
 
 /*
  * We support 6 different bvec pools, the last one is magic in that it
-- 
1.8.5.2

