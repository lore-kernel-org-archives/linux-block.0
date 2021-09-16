Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88434C4332F
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EDD60F8F
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 09:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhIPJZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 05:25:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16265 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhIPJZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 05:25:26 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H9BTV3jQFz8tC3;
        Thu, 16 Sep 2021 17:23:26 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 17:24:04 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 16
 Sep 2021 17:24:04 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [patch v8 5/7] nbd: clean up return value checking of sock_xmit()
Date:   Thu, 16 Sep 2021 17:33:48 +0800
Message-ID: <20210916093350.1410403-6-yukuai3@huawei.com>
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

Check if sock_xmit() return 0 is useless because it'll never return
0, comment it and remove such checkings.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 22c91d8901f6..7f9e030e41ce 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -490,7 +490,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 }
 
 /*
- *  Send or receive packet.
+ *  Send or receive packet. Return a positive value on success and
+ *  negtive value on failue, and never return 0.
  */
 static int sock_xmit(struct nbd_device *nbd, int index, int send,
 		     struct iov_iter *iter, int msg_flags, int *sent)
@@ -616,7 +617,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	result = sock_xmit(nbd, index, 1, &from,
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
 	trace_nbd_header_sent(req, handle);
-	if (result <= 0) {
+	if (result < 0) {
 		if (was_interrupted(result)) {
 			/* If we havne't sent anything we can just return BUSY,
 			 * however if we have sent something we need to make
@@ -660,7 +661,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				skip = 0;
 			}
 			result = sock_xmit(nbd, index, 1, &from, flags, &sent);
-			if (result <= 0) {
+			if (result < 0) {
 				if (was_interrupted(result)) {
 					/* We've already sent the header, we
 					 * have no choice but to set pending and
@@ -712,7 +713,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	reply.magic = 0;
 	iov_iter_kvec(&to, READ, &iov, 1, sizeof(reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
-	if (result <= 0) {
+	if (result < 0) {
 		if (!nbd_disconnected(config))
 			dev_err(disk_to_dev(nbd->disk),
 				"Receive control failed (result %d)\n", result);
@@ -783,7 +784,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 		rq_for_each_segment(bvec, req, iter) {
 			iov_iter_bvec(&to, READ, &bvec, 1, bvec.bv_len);
 			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
-			if (result <= 0) {
+			if (result < 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
 				/*
@@ -1229,7 +1230,7 @@ static void send_disconnects(struct nbd_device *nbd)
 		iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
 		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
-		if (ret <= 0)
+		if (ret < 0)
 			dev_err(disk_to_dev(nbd->disk),
 				"Send disconnect failed %d\n", ret);
 		mutex_unlock(&nsock->tx_lock);
-- 
2.31.1

