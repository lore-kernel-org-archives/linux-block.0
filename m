Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5ECCA479
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 07:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiGAHzM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 03:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiGAHzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 03:55:11 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD026D570;
        Fri,  1 Jul 2022 00:55:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LZ6Sh0w81zlBQL;
        Fri,  1 Jul 2022 15:36:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXFWgIpL5igL73AA--.48972S12;
        Fri, 01 Jul 2022 15:36:45 +0800 (CST)
From:   Yu Kuai <yukuai3@huawei.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v6 7/8] blk-throttle: cleanup tg_update_disptime()
Date:   Fri,  1 Jul 2022 15:49:22 +0800
Message-Id: <20220701074923.657426-9-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701074923.657426-1-yukuai3@huawei.com>
References: <20220701074923.657426-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXFWgIpL5igL73AA--.48972S12
X-Coremail-Antispam: 1UD129KBjvJXoW7ur47KFW5Gry5tw1rtw4Dtwb_yoW8Xw45pF
        yUCF4rJa18tr4q9ry5XFsFqFWfJan7JFWfA397GayfArW2qrnFgrn7ZryrZaykAF93XrW5
        ZFsrtw48Aa1UZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
        02YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28I
        cwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU166wJUUUUU==
Sender: yukuai1@huaweicloud.com
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

th_update_disptime() only need to adjust postion for 'tg' in
'parent_sq', there is no need to call throtl_enqueue/dequeue_tg().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ab30efedff4e..473f0b651ef0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -520,7 +520,6 @@ static void throtl_rb_erase(struct rb_node *n,
 {
 	rb_erase_cached(n, &parent_sq->pending_tree);
 	RB_CLEAR_NODE(n);
-	--parent_sq->nr_pending;
 }
 
 static void update_min_dispatch_time(struct throtl_service_queue *parent_sq)
@@ -572,7 +571,11 @@ static void throtl_enqueue_tg(struct throtl_grp *tg)
 static void throtl_dequeue_tg(struct throtl_grp *tg)
 {
 	if (tg->flags & THROTL_TG_PENDING) {
-		throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
+		struct throtl_service_queue *parent_sq =
+			tg->service_queue.parent_sq;
+
+		throtl_rb_erase(&tg->rb_node, parent_sq);
+		--parent_sq->nr_pending;
 		tg->flags &= ~THROTL_TG_PENDING;
 	}
 }
@@ -1040,9 +1043,9 @@ static void tg_update_disptime(struct throtl_grp *tg)
 	disptime = jiffies + min_wait;
 
 	/* Update dispatch time */
-	throtl_dequeue_tg(tg);
+	throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
 	tg->disptime = disptime;
-	throtl_enqueue_tg(tg);
+	tg_service_queue_add(tg);
 
 	/* see throtl_add_bio_tg() */
 	tg->flags &= ~THROTL_TG_WAS_EMPTY;
-- 
2.31.1

