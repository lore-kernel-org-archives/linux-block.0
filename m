Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEAC433E0
	for <linux-block@archiver.kernel.org>; Sun, 17 Jan 2021 08:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FD4206D6
	for <linux-block@archiver.kernel.org>; Sun, 17 Jan 2021 08:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhAQI50 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Jan 2021 03:57:26 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:13910 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbhAQIyu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Jan 2021 03:54:50 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app2 (Coremail) with SMTP id by_KCgA3Hoka+wNgLCeUAA--.34965S4;
        Sun, 17 Jan 2021 16:53:51 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] block: Fix an error handling in add_partition
Date:   Sun, 17 Jan 2021 16:53:42 +0800
Message-Id: <20210117085346.25095-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgA3Hoka+wNgLCeUAA--.34965S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy7AFyfGr13Zr17Jr1DKFg_yoW3trc_J3
        Wvvr109r18AryI9rn0kF4rtr1rtw1FqF40kF4xtFnrXayavayDur92gryIkr9xWayUury3
        XF45Xw45AFs7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
        64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgYIBlZdtSBAWAABsN
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once we have called device_initialize(), we should use put_device() to
give up the reference on error, just like what we have done on failure
of device_add().

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Refine commit message.

v3: - Add '[v3]' to the title.
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e7d776db803b..23460cee9de5 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -384,7 +384,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 
 	err = blk_alloc_devt(bdev, &devt);
 	if (err)
-		goto out_bdput;
+		goto out_put;
 	pdev->devt = devt;
 
 	/* delay uevent until 'holders' subdir is created */
-- 
2.17.1

