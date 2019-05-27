Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA512C07542
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 12:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C399020883
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 12:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfE0MG7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 08:06:59 -0400
Received: from app1.whu.edu.cn ([202.114.64.88]:42472 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfE0MGy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 08:06:54 -0400
Received: from localhost (unknown [111.202.192.3])
        by email1 (Coremail) with SMTP id AQBjCgAniKXW0utcGsnjAA--.59650S2;
        Mon, 27 May 2019 20:06:50 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] block: use KMEM_CACHE macro
Date:   Mon, 27 May 2019 20:05:18 +0800
Message-Id: <20190527120518.3703-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgAniKXW0utcGsnjAA--.59650S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWfGFy7Cw4rKFWrWr4kZwb_yoW8JF4kpF
        Z3GFn8Cr1jga1xuFWkAayxZry3Cw4vgF1xWa1Yv34Ykr9rCws2vF1vyr1UZrWxurWfCrW5
        Xr48tryrXr1jkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryU
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU0CJPDUUUU
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the preferred KMEM_CACHE helper for brevity.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 block/blk-core.c | 3 +--
 block/blk-ioc.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1bf83a0df0f6..841bf0b12755 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1789,8 +1789,7 @@ int __init blk_dev_init(void)
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
-	blk_requestq_cachep = kmem_cache_create("request_queue",
-			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
+	blk_requestq_cachep = KMEM_CACHE(request_queue, SLAB_PANIC);
 
 #ifdef CONFIG_DEBUG_FS
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 5ed59ac6ae58..58c79aeca955 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -408,8 +408,7 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 
 static int __init blk_ioc_init(void)
 {
-	iocontext_cachep = kmem_cache_create("blkdev_ioc",
-			sizeof(struct io_context), 0, SLAB_PANIC, NULL);
+	iocontext_cachep = KMEM_CACHE(io_context, SLAB_PANIC);
 	return 0;
 }
 subsys_initcall(blk_ioc_init);
-- 
2.19.1

