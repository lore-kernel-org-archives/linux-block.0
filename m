Return-Path: <SRS0=t6Xx=AJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D337C433DF
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 13:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2804E2065D
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 13:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgF1NzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jun 2020 09:55:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgF1NzN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jun 2020 09:55:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7631398745810881A35E;
        Sun, 28 Jun 2020 21:55:11 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sun, 28 Jun 2020
 21:55:01 +0800
From:   Guo Xuenan <guoxuenan@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <guoxuenan@huawei.com>, <wangli74@huawei.com>,
        <fangwei1@huawei.com>
Subject: [PATCH v2] blk-rq-qos: remove redundant finish_wait to rq_qos_wait.
Date:   Sun, 28 Jun 2020 09:56:25 -0400
Message-ID: <20200628135625.3396636-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is no need do finish_wait twice after acquiring inflight.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 block/blk-rq-qos.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 656460636ad3..18f3eab9f768 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -273,8 +273,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		if (data.got_token)
 			break;
 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
-			finish_wait(&rqw->wait, &data.wq);
-
 			/*
 			 * We raced with wbt_wake_function() getting a token,
 			 * which means we now have two. Put our local token
-- 
2.25.4

