Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44463C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 06:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BA461186
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 06:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhIJGpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 02:45:46 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:38372 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231223AbhIJGpq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 02:45:46 -0400
Received: from localhost.localdomain (unknown [124.16.141.243])
        by APP-05 (Coremail) with SMTP id zQCowAA3GKG__jphrh4RAA--.18302S2;
        Fri, 10 Sep 2021 14:44:15 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] blk-zoned: Remove needless request_queue NULL pointer checks
Date:   Fri, 10 Sep 2021 06:44:12 +0000
Message-Id: <20210910064412.80446-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAA3GKG__jphrh4RAA--.18302S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrGFy7GFy8WFW8GryDWrg_yoW8XryDpF
        y5Ga4SkrW0grWIgFy8t3WUJrnFgw42kw4xJayxJ34Sy3y3try2vFn5Zr1jvrWFkrWkGF4U
        uryjqF90qr1UCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F
        4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r47MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxqXdUUUUU
X-Originating-IP: [124.16.141.243]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQoAA102ag5bSAABsd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The request_queue pointer returned from bdev_get_queue() shall
never be NULL, so the NULL checks are unnecessary, just remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Changes since v2:
- Make the q variable assignment together with declaration.
---
 block/blk-zoned.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1d0c76c18fc5..a406ead05ab7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -346,17 +346,13 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	void __user *argp = (void __user *)arg;
 	struct zone_report_args args;
-	struct request_queue *q;
+	struct request_queue *q = dev_get_queue(bdev);
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

