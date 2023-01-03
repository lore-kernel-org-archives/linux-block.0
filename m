Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D54CC5479D
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 01:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjACBy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjACByY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jan 2023 20:54:24 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6097672;
        Mon,  2 Jan 2023 17:54:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NmG4T356pz4f3lJw;
        Tue,  3 Jan 2023 09:54:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBHr7LJirNj9wMDBA--.19481S4;
        Tue, 03 Jan 2023 09:54:20 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.com, paolo.valente@linaro.org, axboe@kernel.dk
Cc:     hch@lst.de, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
Date:   Tue,  3 Jan 2023 17:52:57 +0800
Message-Id: <20230103095303.2223546-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
References: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHr7LJirNj9wMDBA--.19481S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4UJr4kCFyfGw4rAF43ZFb_yoWkWrgEq3
        W8tws7AF1kAryfCFyakrWrXw1j9FWfJ3Wj9F90grZ8WF1UJ3Z8Z3srtrW5Crs3WFsF9a4a
        yr1Fvw4UJF409jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jy9aPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Parameter reason is never used, just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1220c41fc767..5a6d9e8c329d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4066,8 +4066,7 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
  * function to evaluate the I/O speed of a process.
  */
 static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				 bool compensate, enum bfqq_expiration reason,
-				 unsigned long *delta_ms)
+				 bool compensate, unsigned long *delta_ms)
 {
 	ktime_t delta_ktime;
 	u32 delta_usecs;
@@ -4263,7 +4262,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	/*
 	 * Check whether the process is slow (see bfq_bfqq_is_slow).
 	 */
-	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, reason, &delta);
+	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, &delta);
 
 	/*
 	 * As above explained, charge slow (typically seeky) and
-- 
2.30.0

