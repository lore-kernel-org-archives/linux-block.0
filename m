Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAF6C678D5
	for <linux-block@archiver.kernel.org>; Sun, 19 Feb 2023 02:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBSClb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Feb 2023 21:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBSCl2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:28 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9EB12849;
        Sat, 18 Feb 2023 18:41:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PK8v65Q1jz4f3pFW;
        Sun, 19 Feb 2023 10:41:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S10;
        Sun, 19 Feb 2023 10:41:24 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 08/17] block, bfq: start service_from_wr accumulating of async queues correctly
Date:   Sun, 19 Feb 2023 18:43:00 +0800
Message-Id: <20230219104309.1511562-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S10
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1fXw13uF17Ar43Xw47Arb_yoWftFX_Gw
        s5Gr1DCFWkGr4rCrsayFW5XFZ5KayrZF1qyFnxKr1UXF1Sq3ZakFyqqFWDtFZrAa17GFnx
        twnYv345tr40gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Start accumulating service_from_wr when async queues are weight raised.
The service_from_wr for async queues is accumulated and checked to finish
weight-raise as sync queues. We need charge service_from_wr for async
queues or service_from_wr will keep accumulating and async queues will
finish weight-raise soon after weight-raise starts.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5610a7dcacdf..7a0283f08aed 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2323,6 +2323,7 @@ static void bfq_add_request(struct request *rq)
 		    time_is_before_jiffies(
 				bfqq->last_wr_start_finish +
 				bfqd->bfq_wr_min_inter_arr_async)) {
+			bfqq->service_from_wr = 0;
 			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
 			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
 
-- 
2.30.0

