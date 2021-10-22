Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73032C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 08:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4775060E8B
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 08:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhJVITp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:19:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4019 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhJVITo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 04:19:44 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HbHDB1BSMz67Cp1;
        Fri, 22 Oct 2021 16:13:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 10:17:25 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 09:17:22 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <naresh.kamboju@linaro.org>,
        <anders.roxell@linaro.org>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()
Date:   Fri, 22 Oct 2021 16:12:20 +0800
Message-ID: <1634890340-15432-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We should not reference the queue tagset in blk_mq_sched_tags_teardown()
(see function comment) for the blk-mq flags, so use the passed flags
instead.

This solves a use-after-free, similarly fixed earlier (and since broken
again) in commit f0c1c4d2864e ("blk-mq: fix use-after-free in
blk_mq_exit_sched").

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Fixes: e155b0c238b2 ("blk-mq: Use shared tags for shared sbitmap support")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e85b7556b096..6a9444848e3a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -541,7 +541,7 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int fla
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags) {
-			if (!blk_mq_is_shared_tags(q->tag_set->flags))
+			if (!blk_mq_is_shared_tags(flags))
 				blk_mq_free_rq_map(hctx->sched_tags);
 			hctx->sched_tags = NULL;
 		}
-- 
2.17.1

