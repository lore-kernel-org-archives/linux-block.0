Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBF7C3F2CD
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3662086A
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgCCNCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:02:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbgCCNCB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 08:02:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C1AF3BA7D2722142F272;
        Tue,  3 Mar 2020 21:01:49 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 21:01:44 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>
Subject: [PATCH] nbd: make starting request more reasonable
Date:   Tue, 3 Mar 2020 21:08:43 +0800
Message-ID: <20200303130843.12065-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Our test robot reported a warning for refcount_dec trying to decrease
value '0'. The reason is that blk_mq_dispatch_rq_list() try to complete
the failed request from nbd driver, while the request have finished in
nbd timeout handle function. The race as following:

CPU1                             CPU2

//req->ref = 1
blk_mq_dispatch_rq_list
nbd_queue_rq
  nbd_handle_cmd
    blk_mq_start_request
                                 blk_mq_check_expired
                                   //req->ref = 2
                                   blk_mq_rq_timed_out
                                     nbd_xmit_timeout
                                       blk_mq_complete_request
                                         //req->ref = 1
                                         refcount_dec_and_test(&req->ref)

                                   refcount_dec_and_test(&req->ref)
                                   //req->ref = 0
                                     __blk_mq_free_request(req)
  ret = BLK_STS_IOERR
blk_mq_end_request
// req->ref = 0, req have been free
refcount_dec_and_test(&rq->ref)

In fact, the bug also have been reported by syzbot:
  https://lkml.org/lkml/2018/12/5/1308

Since the request have been freed by timeout handle, it can be reused
by others. Then, blk_mq_end_request() may get the re-initialized request
and free it, which is unexpected.

To fix the problem, we move blk_mq_start_request() down until the driver
will handle the request actully. If .queue_rq return something error in
preparation phase, timeout handle may don't need. Thus, moving start
request down may be more reasonable. Then, nbd_queue_rq() will not return
BLK_STS_IOERR after starting request.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/block/nbd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 78181908f0df..5256e9d02a03 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -541,6 +541,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		return -EIO;
 	}
 
+	blk_mq_start_request(req);
+
 	if (req->cmd_flags & REQ_FUA)
 		nbd_cmd_flags |= NBD_CMD_FLAG_FUA;
 
@@ -879,7 +881,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	config = nbd->config;
@@ -888,7 +889,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		nbd_config_put(nbd);
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	cmd->status = BLK_STS_OK;
@@ -912,7 +912,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
-			blk_mq_start_request(req);
 			return -EIO;
 		}
 		goto again;
@@ -923,7 +922,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	 * here so that it gets put _after_ the request that is already on the
 	 * dispatch list.
 	 */
-	blk_mq_start_request(req);
 	if (unlikely(nsock->pending && nsock->pending != req)) {
 		nbd_requeue_cmd(cmd);
 		ret = 0;
-- 
2.16.2.dirty

