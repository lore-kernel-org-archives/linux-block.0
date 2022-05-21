Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA4AC43217
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 07:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354736AbiEUHYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354726AbiEUHYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 03:24:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C325166475;
        Sat, 21 May 2022 00:24:14 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L4w6t5tfwzjWwt;
        Sat, 21 May 2022 15:23:18 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 15:24:12 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 15:24:11 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <yukuai3@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH -next v3 3/6] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
Date:   Sat, 21 May 2022 15:37:46 +0800
Message-ID: <20220521073749.3146892-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521073749.3146892-1-yukuai3@huawei.com>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Otherwise io will hung because request will only be completed if the
cmd has the flag 'NBD_CMD_INFLIGHT'.

Fixes: 07175cb1baf4 ("nbd: make sure request completion won't concurrent")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2ee1e376d5c4..a0d0910dae2a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -403,13 +403,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	if (!mutex_trylock(&cmd->lock))
 		return BLK_EH_RESET_TIMER;
 
-	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
 		mutex_unlock(&cmd->lock);
 		return BLK_EH_DONE;
 	}
 
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
+		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 		mutex_unlock(&cmd->lock);
 		goto done;
 	}
@@ -478,6 +479,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
 	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
 	cmd->status = BLK_STS_IOERR;
+	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 	mutex_unlock(&cmd->lock);
 	sock_shutdown(nbd);
 	nbd_config_put(nbd);
@@ -745,7 +747,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	cmd = blk_mq_rq_to_pdu(req);
 
 	mutex_lock(&cmd->lock);
-	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
 		dev_err(disk_to_dev(nbd->disk), "Suspicious reply %d (status %u flags %lu)",
 			tag, cmd->status, cmd->flags);
 		ret = -ENOENT;
@@ -854,8 +856,16 @@ static void recv_work(struct work_struct *work)
 		}
 
 		rq = blk_mq_rq_from_pdu(cmd);
-		if (likely(!blk_should_fake_timeout(rq->q)))
-			blk_mq_complete_request(rq);
+		if (likely(!blk_should_fake_timeout(rq->q))) {
+			bool complete;
+
+			mutex_lock(&cmd->lock);
+			complete = __test_and_clear_bit(NBD_CMD_INFLIGHT,
+							&cmd->flags);
+			mutex_unlock(&cmd->lock);
+			if (complete)
+				blk_mq_complete_request(rq);
+		}
 		percpu_ref_put(&q->q_usage_counter);
 	}
 
-- 
2.31.1

