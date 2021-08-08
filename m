Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F063C4320A
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 03:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C5360EE8
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 03:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhHHDHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Aug 2021 23:07:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7808 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHHDHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Aug 2021 23:07:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gj3z645vvzYlWZ;
        Sun,  8 Aug 2021 11:06:58 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 8 Aug 2021 11:07:09 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 8 Aug
 2021 11:07:08 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 1/2] blk-mq: add two interfaces to lock/unlock blk_mq_tags->lock
Date:   Sun, 8 Aug 2021 11:17:51 +0800
Message-ID: <20210808031752.579882-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210808031752.579882-1-yukuai3@huawei.com>
References: <20210808031752.579882-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei had fixed the request UAF while iterating tags, however
some drivers is calling blk_mq_tag_to_rq() directly to get request
through tag. So the problem might still exist since that
blk_mq_tags->lock should be held.

Thus add blk_mq_tags_lock() and blk_mq_tags_unlock() so that drivers
can lock and unlock blk_mq_tags->lock if they are not sure that the
request is valid.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 12 ++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 86f87346232a..388d447c993a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -652,3 +652,15 @@ u32 blk_mq_unique_tag(struct request *rq)
 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
 }
 EXPORT_SYMBOL(blk_mq_unique_tag);
+
+void blk_mq_tags_lock(struct blk_mq_tags *tags, unsigned long *flags)
+{
+	spin_lock_irqsave(&tags->lock, *flags);
+}
+EXPORT_SYMBOL(blk_mq_tags_lock);
+
+void blk_mq_tags_unlock(struct blk_mq_tags *tags, unsigned long *flags)
+{
+	spin_unlock_irqrestore(&tags->lock, *flags);
+}
+EXPORT_SYMBOL(blk_mq_tags_unlock);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1d18447ebebc..b4bad4d6a3a8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -635,4 +635,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
+void blk_mq_tags_lock(struct blk_mq_tags *tags, unsigned long *flags);
+void blk_mq_tags_unlock(struct blk_mq_tags *tags, unsigned long *flags);
 #endif
-- 
2.31.1

