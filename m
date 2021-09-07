Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5398DC43217
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E65F610FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 13:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhIGNxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:53:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9010 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhIGNxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 09:53:12 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H3mrd02mqzVsc4;
        Tue,  7 Sep 2021 21:51:13 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 21:52:03 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 7 Sep
 2021 21:52:02 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v4 6/6] nbd: don't start request if nbd_queue_rq() failed
Date:   Tue, 7 Sep 2021 22:01:54 +0800
Message-ID: <20210907140154.2134091-7-yukuai3@huawei.com>
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

Currently, blk_mq_end_request() will be called if nbd_queue_rq()
failed, thus start request in such situation is useless.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 807c8cbccaae..122e49ae86fb 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -938,7 +938,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	config = nbd->config;
@@ -947,7 +946,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		nbd_config_put(nbd);
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	cmd->status = BLK_STS_OK;
@@ -971,7 +969,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
-			blk_mq_start_request(req);
 			return -EIO;
 		}
 		goto again;
-- 
2.31.1

