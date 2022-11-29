Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B8C4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 03:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiK2DBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiK2DBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 22:01:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA80C3D92C;
        Mon, 28 Nov 2022 19:01:52 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLnCn4JGkzCqj2;
        Tue, 29 Nov 2022 11:01:09 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:50 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 01/10] blk-throttle: correct stale comment in throtl_pd_init
Date:   Tue, 29 Nov 2022 11:01:38 +0800
Message-ID: <20221129030147.27400-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221129030147.27400-1-shikemeng@huawei.com>
References: <20221129030147.27400-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On the default hierarchy (cgroup2), the throttle interface files don't
exist in the root cgroup, so the ablity to limit the whole system
by configuring root group is not existing anymore. In general, cgroup
doesn't wanna be in the business of restricting resources at the
system level, so correct the stale comment that we can limit whole
system to we can only limit subtree.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 847721dc2b2b..59acfac87764 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -395,8 +395,9 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 	 * If on the default hierarchy, we switch to properly hierarchical
 	 * behavior where limits on a given throtl_grp are applied to the
 	 * whole subtree rather than just the group itself.  e.g. If 16M
-	 * read_bps limit is set on the root group, the whole system can't
-	 * exceed 16M for the device.
+	 * read_bps limit is set on a "parent" group, summary bps of
+	 * "parent" group and its subtree groups can't exceed 16M for the
+	 * device.
 	 *
 	 * If not on the default hierarchy, the broken flat hierarchy
 	 * behavior is retained where all throtl_grps are treated as if
-- 
2.30.0

