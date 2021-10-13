Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94310C433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AB661027
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhJMIsP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 04:48:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3973 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhJMIsO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 04:48:14 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HTmHz6ymgz67Mml;
        Wed, 13 Oct 2021 16:42:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 10:46:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 09:46:07 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Date:   Wed, 13 Oct 2021 16:40:59 +0800
Message-ID: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since it is now possible for a tagset to share a single set of tags, the
iter function should not re-iter the tags for the count of #hw queues in
that case. Rather it should just iter once.

Fixes: e0fdf846c7bb ("blk-mq: Use shared tags for shared sbitmap support")
Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 72a2724a4eee..c943b6529619 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -378,9 +378,12 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
-	int i;
+	unsigned int flags = tagset->flags;
+	int i, nr_tags;
+
+	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
 
-	for (i = 0; i < tagset->nr_hw_queues; i++) {
+	for (i = 0; i < nr_tags; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
 					      BT_TAG_ITER_STARTED);
-- 
2.26.2

