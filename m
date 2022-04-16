Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A88C433FE
	for <linux-block@archiver.kernel.org>; Sat, 16 Apr 2022 09:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiDPJ0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Apr 2022 05:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiDPJ0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Apr 2022 05:26:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8031C1171;
        Sat, 16 Apr 2022 02:23:31 -0700 (PDT)
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KgSLh57KQzCr6c;
        Sat, 16 Apr 2022 17:19:08 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 17:23:29 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 17:23:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 5/5] block, bfq: do not idle if only one cgroup is activated
Date:   Sat, 16 Apr 2022 17:37:53 +0800
Message-ID: <20220416093753.3054696-6-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220416093753.3054696-1-yukuai3@huawei.com>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that root group is counted into 'num_groups_with_pending_reqs',
'num_groups_with_pending_reqs > 0' is always true in
bfq_asymmetric_scenario().

Thus change the condition to 'num_groups_with_pending_reqs > 1'.

On the other hand, now that 'num_groups_with_pending_reqs' represents
how many groups have pending requests, this change can enable concurrent
sync io is only on cgroup is activated.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 39abcd95df8e..7d9f94882f8e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -846,7 +846,7 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 
 	return varied_queue_weights || multiple_classes_busy
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       || bfqd->num_groups_with_pending_reqs > 0
+	       || bfqd->num_groups_with_pending_reqs > 1
 #endif
 		;
 }
-- 
2.31.1

