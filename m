Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C16C433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 08:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE80F6115B
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 08:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhJ2IsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 04:48:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4038 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhJ2Irz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 04:47:55 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HgbVD6Hn0z67n1D;
        Fri, 29 Oct 2021 16:40:36 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 10:45:18 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 09:45:16 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq-debugfs: Show active requests per queue for shared tags
Date:   Fri, 29 Oct 2021 16:40:23 +0800
Message-ID: <1635496823-33515-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we show the hctx.active value for the per-hctx "active" file.

However this is not maintained for shared tags, and we instead keep a
record of the number active requests per request queue - see commit
f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for
when using shared sbitmap).

Change for the case of shared tags to show the active requests per request
queue by using __blk_mq_active_requests() helper.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 68ca5d21cda7..0f8c60e9c719 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -550,7 +550,7 @@ static int hctx_active_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
-	seq_printf(m, "%d\n", atomic_read(&hctx->nr_active));
+	seq_printf(m, "%d\n", __blk_mq_active_requests(hctx));
 	return 0;
 }
 
-- 
2.17.1

