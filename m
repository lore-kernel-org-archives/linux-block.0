Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 01:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561B460FDA
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 01:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhIMBZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 21:25:41 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:53614 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233133AbhIMBZl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 21:25:41 -0400
Received: from localhost.localdomain (unknown [124.16.141.243])
        by APP-03 (Coremail) with SMTP id rQCowABnfQA2qD5hFzpHAA--.1992S2;
        Mon, 13 Sep 2021 09:24:06 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] blk-zoned: Remove needless request_queue NULL pointer
Date:   Mon, 13 Sep 2021 01:24:02 +0000
Message-Id: <20210913012402.554-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowABnfQA2qD5hFzpHAA--.1992S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr17Xr1ktFW8JFWkGF1fCrg_yoW8WrW5pF
        y5GasakrW0grWIga48t3WUJrnFganrKw47tFWft34ay3yUtrW2vFn5ZryjvrWF9rWkGF4U
        CryjqFs0yr1UCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr
        1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6w4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hNVDUUUUU==
X-Originating-IP: [124.16.141.243]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwkDA1z4kaLmjwAAs8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The request_queue pointer returned from bdev_get_queue() shall
never be NULL, so the NULL checks are unnecessary, just remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Reported-by: kernel test robot <lkp@intel.com>
Changes since v2:
- Make the q variable assignment together with declaration.
Changes since v3:
- Fix error function use reported by kernel test robot.
---
 block/blk-zoned.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1d0c76c18fc5..b797e24d4aa3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -346,17 +346,13 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	void __user *argp = (void __user *)arg;
 	struct zone_report_args args;
-	struct request_queue *q;
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct blk_zone_report rep;
 	int ret;
 
 	if (!argp)
 		return -EINVAL;
 
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
 	if (!blk_queue_is_zoned(q))
 		return -ENOTTY;
 
@@ -403,7 +399,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	struct request_queue *q;
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct blk_zone_range zrange;
 	enum req_opf op;
 	int ret;
@@ -411,10 +407,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!argp)
 		return -EINVAL;
 
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
 	if (!blk_queue_is_zoned(q))
 		return -ENOTTY;
 
-- 
2.17.1

