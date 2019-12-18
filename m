Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67797C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 08:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318D224691
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 08:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLRIRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:17:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfLRIRI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 03:17:08 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 420504A90767678B9FA2;
        Wed, 18 Dec 2019 16:17:06 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 16:16:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH] block: fix memleak when __blk_rq_map_user_iov() is failed
Date:   Wed, 18 Dec 2019 16:44:04 +0800
Message-ID: <1576658644-88101-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When I doing fuzzy test, get the memleak report:

BUG: memory leak
unreferenced object 0xffff88837af80000 (size 4096):
  comm "memleak", pid 3557, jiffies 4294817681 (age 112.499s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    20 00 00 00 10 01 00 00 00 00 00 00 01 00 00 00   ...............
  backtrace:
    [<000000001c894df8>] bio_alloc_bioset+0x393/0x590
    [<000000008b139a3c>] bio_copy_user_iov+0x300/0xcd0
    [<00000000a998bd8c>] blk_rq_map_user_iov+0x2f1/0x5f0
    [<000000005ceb7f05>] blk_rq_map_user+0xf2/0x160
    [<000000006454da92>] sg_common_write.isra.21+0x1094/0x1870
    [<00000000064bb208>] sg_write.part.25+0x5d9/0x950
    [<000000004fc670f6>] sg_write+0x5f/0x8c
    [<00000000b0d05c7b>] __vfs_write+0x7c/0x100
    [<000000008e177714>] vfs_write+0x1c3/0x500
    [<0000000087d23f34>] ksys_write+0xf9/0x200
    [<000000002c8dbc9d>] do_syscall_64+0x9f/0x4f0
    [<00000000678d8e9a>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

If __blk_rq_map_user_iov() is failed in blk_rq_map_user_iov(),
the bio(s) which is allocated before this failing will leak. The
refcount of the bio(s) is init to 1 and increased to 2 by calling
bio_get(), but __blk_rq_unmap_user() only decrease it to 1, so
the bio cannot be freed. Fix it by calling blk_rq_unmap_user().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 3a62e471d81b..b0790268ed9d 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -151,7 +151,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	return 0;
 
 unmap_rq:
-	__blk_rq_unmap_user(bio);
+	blk_rq_unmap_user(bio);
 fail:
 	rq->bio = NULL;
 	return ret;
-- 
2.17.1

