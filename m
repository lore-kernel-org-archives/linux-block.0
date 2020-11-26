Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61E8C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4221821534
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbgKZDPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 22:15:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8592 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733273AbgKZDPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 22:15:24 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ChNCy41p1zLthD;
        Thu, 26 Nov 2020 11:14:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 11:15:12 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] blk-throttle: don't check whether or not lower limit is valid if CONFIG_BLK_DEV_THROTTLING_LOW is off
Date:   Thu, 26 Nov 2020 11:18:34 +0800
Message-ID: <20201126031834.40807-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_throtl_update_limit_valid() will search for descendants to see if
'LIMIT_LOW' of bps/iops and READ/WRITE is nonzero. However, they're always
zero if CONFIG_BLK_DEV_THROTTLING_LOW is not set, furthermore, a lot of
time will be wasted to iterate descendants.

Thus do nothing in blk_throtl_update_limit_valid() in such situation.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b771c4299982..d52cac9f3a7c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -587,6 +587,7 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	tg_update_has_rules(tg);
 }
 
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 static void blk_throtl_update_limit_valid(struct throtl_data *td)
 {
 	struct cgroup_subsys_state *pos_css;
@@ -607,6 +608,11 @@ static void blk_throtl_update_limit_valid(struct throtl_data *td)
 
 	td->limit_valid[LIMIT_LOW] = low_valid;
 }
+#else
+static inline void blk_throtl_update_limit_valid(struct throtl_data *td)
+{
+}
+#endif
 
 static void throtl_upgrade_state(struct throtl_data *td);
 static void throtl_pd_offline(struct blkg_policy_data *pd)
-- 
2.25.4

