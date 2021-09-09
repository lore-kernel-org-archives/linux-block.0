Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC5C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2B9610CE
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 14:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhIIOE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:04:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15314 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347029AbhIIOEK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 10:04:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H510f4JLbz8srZ;
        Thu,  9 Sep 2021 22:02:26 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 22:02:57 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 9 Sep
 2021 22:02:56 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v5 4/6] blk-mq: export two symbols to get request by tag
Date:   Thu, 9 Sep 2021 22:12:54 +0800
Message-ID: <20210909141256.2606682-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909141256.2606682-1-yukuai3@huawei.com>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nbd has a defect that blk_mq_tag_to_rq() might return a freed
request in nbd_read_stat(). We need a new mechanism if we want to
fix this in nbd driver, which is rather complicated.

Thus use blk_mq_find_and_get_req() to replace blk_mq_tag_to_rq(),
which can make sure the returned request is not freed, and then we
can do more checking while 'cmd->lock' is hold.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 5 +++--
 block/blk-mq.c         | 1 +
 include/linux/blk-mq.h | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 86f87346232a..b4f66b75b4d1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -200,8 +200,8 @@ struct bt_iter_data {
 	bool reserved;
 };
 
-static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
-		unsigned int bitnr)
+struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
+					unsigned int bitnr)
 {
 	struct request *rq;
 	unsigned long flags;
@@ -213,6 +213,7 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 	spin_unlock_irqrestore(&tags->lock, flags);
 	return rq;
 }
+EXPORT_SYMBOL(blk_mq_find_and_get_req);
 
 static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 08626cb0534c..5113aa3788a2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -916,6 +916,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 	else if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
+EXPORT_SYMBOL(blk_mq_put_rq_ref);
 
 static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 13ba1861e688..03e02990609d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -637,4 +637,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
+void blk_mq_put_rq_ref(struct request *rq);
+struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
+					unsigned int bitnr);
 #endif
-- 
2.31.1

