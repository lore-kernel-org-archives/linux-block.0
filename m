Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E759C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D7860F70
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 13:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhIGNxK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:53:10 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15303 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhIGNxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 09:53:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H3ms05rp7z8sss;
        Tue,  7 Sep 2021 21:51:32 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 21:52:01 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 7 Sep
 2021 21:52:01 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v4 2/6] nbd: convert to use blk_mq_find_and_get_req()
Date:   Tue, 7 Sep 2021 22:01:50 +0800
Message-ID: <20210907140154.2134091-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210907140154.2134091-1-yukuai3@huawei.com>
References: <20210907140154.2134091-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tag_to_rq() can only ensure to return valid request in
following situation:

1) client send request message to server first
submit_bio
...
 blk_mq_get_tag
 ...
 blk_mq_get_driver_tag
 ...
 nbd_queue_rq
  nbd_handle_cmd
   nbd_send_cmd

2) client receive respond message from server
recv_work
 nbd_read_stat
  blk_mq_tag_to_rq

If step 1) is missing, blk_mq_tag_to_rq() will return a stale
request, which might be freed. Thus convert to use
blk_mq_find_and_get_req() to make sure the returned request is not
freed. However, there are still some problems if the request is
started, and this will be fixed in next patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5170a630778d..920da390635c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -718,12 +718,13 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
 	if (hwq < nbd->tag_set.nr_hw_queues)
-		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
-				       blk_mq_unique_tag_to_tag(tag));
+		req = blk_mq_find_and_get_req(nbd->tag_set.tags[hwq],
+					      blk_mq_unique_tag_to_tag(tag));
 	if (!req || !blk_mq_request_started(req)) {
 		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
 			tag, req);
-		return ERR_PTR(-ENOENT);
+		ret = -ENOENT;
+		goto put_req;
 	}
 	trace_nbd_header_received(req, handle);
 	cmd = blk_mq_rq_to_pdu(req);
@@ -785,6 +786,9 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 out:
 	trace_nbd_payload_received(req, handle);
 	mutex_unlock(&cmd->lock);
+put_req:
+	if (req)
+		blk_mq_put_rq_ref(req);
 	return ret ? ERR_PTR(ret) : cmd;
 }
 
-- 
2.31.1

