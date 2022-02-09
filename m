Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BBAC433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 09:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiBIJnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:43:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiBIJnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 04:43:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C776E067855
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 01:43:43 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtvWC4WVKzbkLM;
        Wed,  9 Feb 2022 17:20:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 17:21:56 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <dm-devel@redhat.com>
CC:     <linux-block@vger.kernel.org>, <agk@redhat.com>,
        <snitzer@redhat.com>, <axboe@kernel.dk>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] dm: make sure dm_table is binded before queue request
Date:   Wed, 9 Feb 2022 17:37:51 +0800
Message-ID: <20220209093751.2986716-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We found a NULL pointer dereference problem when using dm-mpath target.
The problem is if we submit IO between loading and binding the table,
we could neither get a valid dm_target nor a valid dm table when
submitting request in dm_mq_queue_rq(). BIO based dm target could
handle this case in dm_submit_bio(). This patch fix this by checking
the mapping table before submitting request.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/md/dm-rq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 579ab6183d4d..af2cf71519e9 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -499,8 +499,15 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (unlikely(!ti)) {
 		int srcu_idx;
-		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
-
+		struct dm_table *map;
+
+		map = dm_get_live_table(md, &srcu_idx);
+		if (!map) {
+			DMERR_LIMIT("%s: mapping table unavailable, erroring io",
+				    dm_device_name(md));
+			dm_put_live_table(md, srcu_idx);
+			return BLK_STS_IOERR;
+		}
 		ti = dm_table_find_target(map, 0);
 		dm_put_live_table(md, srcu_idx);
 	}
-- 
2.31.1

