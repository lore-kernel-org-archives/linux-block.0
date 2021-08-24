Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7535BC4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF3D61212
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhHXODA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:03:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15209 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbhHXOC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 10:02:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gv9l529BRz1DD7t;
        Tue, 24 Aug 2021 22:01:37 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 22:02:09 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 22:02:08 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 3/5] nbd: don't handle response without a corresponding request message
Date:   Tue, 24 Aug 2021 22:12:25 +0800
Message-ID: <20210824141227.808340-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824141227.808340-1-yukuai3@huawei.com>
References: <20210824141227.808340-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While handling a response message from server, nbd_read_stat() will
try to get request by tag, and then complete the request. However,
this is problematic if nbd haven't sent a corresponding request
message:

t1                      t2
                        submit_bio
                         nbd_queue_rq
                          blk_mq_start_request
recv_work
 nbd_read_stat
  blk_mq_get_rq_by_tag
 blk_mq_complete_request
                          nbd_send_cmd

Thus add a new cmd flag 'NBD_CMD_INFLIGHT', it will be set in
nbd_send_cmd() and checked in nbd_read_stat().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ca54a0736090..7b9e19675224 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -127,6 +127,11 @@ struct nbd_device {
 };
 
 #define NBD_CMD_REQUEUED	1
+/*
+ * This flag will be set if nbd_send_cmd() succeed, and will be checked in
+ * normal completion.
+ */
+#define NBD_CMD_INFLIGHT	2
 
 struct nbd_cmd {
 	struct nbd_device *nbd;
@@ -743,6 +748,12 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	cmd = blk_mq_rq_to_pdu(req);
 
 	mutex_lock(&cmd->lock);
+	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+		dev_err(disk_to_dev(nbd->disk), "NBD_CMD_INFLIGHT is not set %d\n",
+			tag);
+		ret = -ENOENT;
+		goto out;
+	}
 	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
 		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
 			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
@@ -980,6 +991,8 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	 * returns EAGAIN can be retried on a different socket.
 	 */
 	ret = nbd_send_cmd(nbd, cmd, index);
+	if (!ret)
+		set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 	if (ret == -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Request send failed, requeueing\n");
-- 
2.31.1

