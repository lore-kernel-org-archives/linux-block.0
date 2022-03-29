Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F6C433FE
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 09:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiC2J1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiC2J1l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 05:27:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AEF972EA;
        Tue, 29 Mar 2022 02:25:58 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KSPLY0rn9z1GD1H;
        Tue, 29 Mar 2022 17:25:41 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:25:57 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:25:56 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC 1/6] blk-mq: add a new flag 'BLK_MQ_F_NO_TAG_PREEMPTION'
Date:   Tue, 29 Mar 2022 17:40:43 +0800
Message-ID: <20220329094048.2107094-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329094048.2107094-1-yukuai3@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tag preemption is the default behaviour, specifically blk_mq_get_tag()
will try to get tag unconditionally, which means a new io can preempt tag
even if there are lots of ios that are waiting for tags.

This patch introduce a new flag, prepare to disable such behaviour, in
order to optimize io performance for large random io for HHD.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c | 1 +
 block/blk-mq.h         | 5 +++++
 include/linux/blk-mq.h | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index aa0349e9f083..f4228532ee3d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -226,6 +226,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
 	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
+	HCTX_FLAG_NAME(NO_TAG_PREEMPTION),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 2615bd58bad3..1a084b3b6097 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -168,6 +168,11 @@ static inline bool blk_mq_is_shared_tags(unsigned int flags)
 	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
 }
 
+static inline bool blk_mq_is_tag_preemptive(unsigned int flags)
+{
+	return !(flags & BLK_MQ_F_NO_TAG_PREEMPTION);
+}
+
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
 	if (!(data->rq_flags & RQF_ELV))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7aa5c54901a9..c9434162acc5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -656,7 +656,12 @@ enum {
 	 * or shared hwqs instead of 'mq-deadline'.
 	 */
 	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 7,
-	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
+	/*
+	 * If the disk is under high io pressure, new io will wait directly
+	 * without trying to preempt tag.
+	 */
+	BLK_MQ_F_NO_TAG_PREEMPTION	= 1 << 8,
+	BLK_MQ_F_ALLOC_POLICY_START_BIT = 9,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
 	BLK_MQ_S_STOPPED	= 0,
-- 
2.31.1

