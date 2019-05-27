Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F4C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 11:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6082146F
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfE0Lu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 07:50:27 -0400
Received: from app2.whu.edu.cn ([202.114.64.89]:56568 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfE0Lu1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 07:50:27 -0400
Received: from localhost (unknown [111.202.192.3])
        by email2 (Coremail) with SMTP id AgBjCgBntW3xzutcUsrjAA--.16709S2;
        Mon, 27 May 2019 19:50:18 +0800 (CST)
From:   Peng Wang <wangpeng15@xiaomi.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] block: use KMEM_CACHE macro
Date:   Mon, 27 May 2019 19:48:35 +0800
Message-Id: <20190527114835.2071-1-wangpeng15@xiaomi.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AgBjCgBntW3xzutcUsrjAA--.16709S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWfGFy7Cw4rKFWrWr4kZwb_yoW8Jw45pF
        Z5GFn8Cr1jgF4xuFWkAayxZry3Cw4vgF1xXa1Yvw1Yyr9rCwn2vF1vyr1UZrWxurWfCrW5
        Xr48tryUXr1j9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
        82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
        Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
        M4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI4
        8JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jw
        o7NUUUUU=
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Peng Wang <rocking@whu.edu.cn>

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

