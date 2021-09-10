Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F025C433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 03:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFA361100
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 03:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhIJEAz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 00:00:55 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:34346 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229462AbhIJEAz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 00:00:55 -0400
Received: from localhost.localdomain (unknown [124.16.141.243])
        by APP-01 (Coremail) with SMTP id qwCowABX2dgZ2Dpho9EOAA--.30793S2;
        Fri, 10 Sep 2021 11:59:22 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     Damien.LeMoal@wdc.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, axboe@kernel.dk,
        xen-devel@lists.xenproject.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] xen-blkback: Remove needless request_queue NULL pointer check
Date:   Fri, 10 Sep 2021 03:59:18 +0000
Message-Id: <20210910035918.24907-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowABX2dgZ2Dpho9EOAA--.30793S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw43Kry8uF4xXF47Wr1xXwb_yoWDKrc_Wr
        18ZrZaqr1v9rs09w1DCFnay340k3WkZFy09an2qFWaq347AFyaq3y7Zrn5Gw47uayUKrn5
        CFyUG3W2yr1xAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwAYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F
        4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1_M3UUUUU=
X-Originating-IP: [124.16.141.243]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQoAA102ag5bSAAAsc
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The request_queue pointer returned from bdev_get_queue() shall
never be NULL, so the null check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
Changes since v2:
- Add missing parenthesis.
- Remove another null pointer check.
---
 drivers/block/xen-blkback/xenbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 33eba3df4dd9..aac08b4369ac 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -516,10 +516,10 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		vbd->type |= VDISK_REMOVABLE;
 
 	q = bdev_get_queue(bdev);
-	if (q && test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
 		vbd->flush_support = true;
 
-	if (q && blk_queue_secure_erase(q))
+	if (blk_queue_secure_erase(q))
 		vbd->discard_secure = true;
 
 	vbd->feature_gnt_persistent = feature_persistent;
-- 
2.17.1

