Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5AEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 09:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6EC611CA
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 09:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhIPJZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 05:25:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15428 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbhIPJZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 05:25:27 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H9BPV4YW0zRGBR;
        Thu, 16 Sep 2021 17:19:58 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 17:24:05 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 16
 Sep 2021 17:24:05 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [patch v8 7/7] nbd: fix uaf in nbd_handle_reply()
Date:   Thu, 16 Sep 2021 17:33:50 +0800
Message-ID: <20210916093350.1410403-8-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916093350.1410403-1-yukuai3@huawei.com>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a problem that nbd_handle_reply() might access freed request:

1) At first, a normal io is submitted and completed with scheduler:

internel_tag = blk_mq_get_tag -> get tag from sched_tags
 blk_mq_rq_ctx_init
  sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
...
blk_mq_get_driver_tag
 __blk_mq_get_driver_tag -> get tag from tags
 tags->rq[tag] = sched_tag->static_rq[internel_tag]

So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
to the request: sched_tags->static_rq[internal_tag]. Even if the
io is finished.

2) nbd server send a reply with random tag directly:

recv_work
 nbd_handle_reply
  blk_mq_tag_to_rq(tags, tag)
   rq = tags->rq[tag]

3) if the sched_tags->static_rq is freed:

blk_mq_sched_free_requests
 blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
  -> step 2) access rq before clearing rq mapping
  blk_mq_clear_rq_mapping(set, tags, hctx_idx);
  __free_pages() -> rq is freed here

4) Then, nbd continue to use the freed request in nbd_handle_reply

Fix the problem by get 'q_usage_counter' before blk_mq_tag_to_rq(),
thus request is ensured not to be freed because 'q_usage_counter' is
not zero.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 69dc5eac9ad3..b3a47fc6237f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -825,6 +825,7 @@ static void recv_work(struct work_struct *work)
 						     work);
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
+	struct request_queue *q = nbd->disk->queue;
 	struct nbd_sock *nsock;
 	struct nbd_cmd *cmd;
 	struct request *rq;
@@ -835,7 +836,20 @@ static void recv_work(struct work_struct *work)
 		if (nbd_read_reply(nbd, args->index, &reply))
 			break;
 
+		/*
+		 * Grab .q_usage_counter so request pool won't go away, then no
+		 * request use-after-free is possible during nbd_handle_reply().
+		 * If queue is frozen, there won't be any inflight requests, we
+		 * needn't to handle the incoming garbage message.
+		 */
+		if (!percpu_ref_tryget(&q->q_usage_counter)) {
+			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
+				__func__);
+			break;
+		}
+
 		cmd = nbd_handle_reply(nbd, args->index, &reply);
+		percpu_ref_put(&q->q_usage_counter);
 		if (IS_ERR(cmd))
 			break;
 
-- 
2.31.1

