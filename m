Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855DC433E1
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFD722D37
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 17:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgHERjf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:39:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728916AbgHERed (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Aug 2020 13:34:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4663146D141309B3CA39;
        Wed,  5 Aug 2020 21:37:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 5 Aug 2020
 21:37:08 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] block-throttle: set q->td to NULL if blkcg_activate_policy failed
Date:   Wed, 5 Aug 2020 21:37:20 +0800
Message-ID: <20200805133720.1008782-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Otherwise q->td will point to the released memory, although there is
no access to q->td in the following process, still recommend to do this.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 block/blk-throttle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fee3325edf27..05b87516eee9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2399,6 +2399,7 @@ int blk_throtl_init(struct request_queue *q)
 		free_percpu(td->latency_buckets[READ]);
 		free_percpu(td->latency_buckets[WRITE]);
 		kfree(td);
+		q->td = NULL;
 	}
 	return ret;
 }
--
2.25.4

