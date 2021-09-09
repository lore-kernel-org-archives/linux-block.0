Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351BCC4332F
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16411610FF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 14:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbhIIOFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:05:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9411 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbhIIOEK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 10:04:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H50wB2dkdz8xQZ;
        Thu,  9 Sep 2021 21:58:34 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 22:02:55 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 9 Sep
 2021 22:02:55 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v5 1/6] nbd: don't handle response without a corresponding request message
Date:   Thu, 9 Sep 2021 22:12:51 +0800
Message-ID: <20210909141256.2606682-2-yukuai3@huawei.com>
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
  blk_mq_tag_to_rq
 blk_mq_complete_request
                          nbd_send_cmd

Thus add a new cmd flag 'NBD_CMD_INFLIGHT', it will be set in
nbd_send_cmd() and checked in nbd_read_stat().

Noted that this patch can't fix that blk_mq_tag_to_rq() might
return a freed request, and this will be fixed in following
patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5170a630778d..04861b585b62 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -126,6 +126,12 @@ struct nbd_device {
 };
 
 #define NBD_CMD_REQUEUED	1
+/*
+ * This flag will be set if nbd_queue_rq() succeed, and will be checked and
+ * cleared in completion. Both setting and clearing of the flag are protected
+ * by cmd->lock.
+ */
+#define NBD_CMD_INFLIGHT	2
 
 struct nbd_cmd {
 	struct nbd_device *nbd;
@@ -400,6 +406,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	if (!mutex_trylock(&cmd->lock))
 		return BLK_EH_RESET_TIMER;
 
+	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
 		mutex_unlock(&cmd->lock);
@@ -729,6 +736,12 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	cmd = blk_mq_rq_to_pdu(req);
 
 	mutex_lock(&cmd->lock);
+	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+		dev_err(disk_to_dev(nbd->disk), "Suspicious reply %d (status %u flags %lu)",
+			tag, cmd->status, cmd->flags);
+		ret = -ENOENT;
+		goto out;
+	}
 	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
 		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
 			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
@@ -829,6 +842,7 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 
 	mutex_lock(&cmd->lock);
 	cmd->status = BLK_STS_IOERR;
+	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 	mutex_unlock(&cmd->lock);
 
 	blk_mq_complete_request(req);
@@ -964,7 +978,13 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	 * returns EAGAIN can be retried on a different socket.
 	 */
 	ret = nbd_send_cmd(nbd, cmd, index);
-	if (ret == -EAGAIN) {
+	/*
+	 * Access to this flag is protected by cmd->lock, thus it's safe to set
+	 * the flag after nbd_send_cmd() succeed to send request to server.
+	 */
+	if (!ret)
+		__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+	else if (ret == -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Request send failed, requeueing\n");
 		nbd_mark_nsock_dead(nbd, nsock, 1);
-- 
2.31.1

