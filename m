Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4076FC433E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 11:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1086461A27
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 11:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCYLpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:45:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14534 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhCYLpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 07:45:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5jrr38VmzPkKf;
        Thu, 25 Mar 2021 19:42:36 +0800 (CST)
Received: from [10.174.178.35] (10.174.178.35) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 19:45:02 +0800
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     linfeilong <linfeilong@huawei.com>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>
From:   lixiaokeng <lixiaokeng@huawei.com>
Subject: [PATCH] brd: fix integer overflow in brd_check_and_reset_par
Message-ID: <99e9da32-9372-ada2-8197-26602fe242c8@huawei.com>
Date:   Thu, 25 Mar 2021 19:45:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.35]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The max_part may overflow. For example,

modprobe brd rd_nr=3 rd_size=102400 max_part=1073741824(2^30)

Expected result
NAME             MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
ram0               1:0    0   100M  0 disk
ram1               1:256  0   100M  0 disk
ram2               1:512  0   100M  0 disk

Actual result
NAME             MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
ram0             259:0    0   100M  0 disk
ram1             259:1    0   100M  0 disk
ram2             259:2    0   100M  0 disk

Fix it.

Signed-off-by: Lixiaokeng <lixiaokeng@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 drivers/block/brd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c43a6ab4b1f3..c91831cd5d2a 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -457,21 +457,19 @@ static void brd_del_one(struct brd_device *brd)

 static inline void brd_check_and_reset_par(void)
 {
-	if (unlikely(!max_part))
+	if (unlikely(max_part <= 0))
 		max_part = 1;

 	/*
 	 * make sure 'max_part' can be divided exactly by (1U << MINORBITS),
 	 * otherwise, it is possiable to get same dev_t when adding partitions.
 	 */
-	if ((1U << MINORBITS) % max_part != 0)
-		max_part = 1UL << fls(max_part);
-
 	if (max_part > DISK_MAX_PARTS) {
 		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
 			DISK_MAX_PARTS, DISK_MAX_PARTS);
 		max_part = DISK_MAX_PARTS;
-	}
+	} else if ((1U << MINORBITS) % max_part != 0)
+		max_part = 1UL << fls(max_part);
 }

 static int __init brd_init(void)
-- 
