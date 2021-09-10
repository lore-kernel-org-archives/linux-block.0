Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB4C433FE
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 02:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782B96113E
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 02:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhIJCcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 22:32:47 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:43664 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229741AbhIJCcp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 22:32:45 -0400
Received: from localhost.localdomain (unknown [124.16.141.243])
        by APP-03 (Coremail) with SMTP id rQCowADHz3v7wTphEPUJAA--.10149S2;
        Fri, 10 Sep 2021 10:25:00 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        xen-devel@lists.xenproject.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen-blkback: Remove needless request_queue NULL pointer check
Date:   Fri, 10 Sep 2021 02:24:57 +0000
Message-Id: <20210910022457.22963-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowADHz3v7wTphEPUJAA--.10149S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw43Kry8uw1rGFy7WryrtFb_yoWfJwb_Wr
        1UZrsrXr1kurn0934DCFsay340ya48ZF1SkFn2q3ySq34UAF1av39Fvrn5Gw47X3yUKr90
        kFyUGF17tr48AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8Jr
        0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7M5lUUUUU
X-Originating-IP: [124.16.141.243]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwgAA1z4kZv+wwAAsT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The request_queue pointer returned from bdev_get_queue() shall
never be NULL, so the null check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/block/xen-blkback/xenbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 33eba3df4dd9..f05132b9ddbf 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -516,7 +516,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		vbd->type |= VDISK_REMOVABLE;
 
 	q = bdev_get_queue(bdev);
-	if (q && test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+	if test_bit(QUEUE_FLAG_WC, &q->queue_flags)
 		vbd->flush_support = true;
 
 	if (q && blk_queue_secure_erase(q))
-- 
2.17.1

