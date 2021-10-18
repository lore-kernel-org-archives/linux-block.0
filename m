Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CDFC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9101E6103C
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhJRJsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:48:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3998 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhJRJsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:48:30 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HXsNM258yz6889v;
        Mon, 18 Oct 2021 17:42:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 18 Oct 2021 11:46:18 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 10:46:15 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Date:   Mon, 18 Oct 2021 17:41:23 +0800
Message-ID: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
Diff to v1:
- Add Ming's RB tag

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

