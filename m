Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA01C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 06:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjCOGwY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 02:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCOGwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 02:52:20 -0400
X-Greylist: delayed 1824 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 23:51:56 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9A9A1F5D4
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 23:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8dgTN
        jdJYeossWa30oeBFPuBnkA41wXnQxIbcGg2hEM=; b=Nu/ND9Q4fIQHHNM53ckgV
        Ml/kA56Zq25tiRy7Paiee9tiiqhW8XWtdP1Pl0PF3u7JTH4LJrLPi0iuH607Y4pb
        NTUgbngPyZWDjx1NfbIWxJ5KmOoY0RqhXgr0sjTV77J0an+bebXUv4vQpTQGpdSh
        UiFnM5p1LMTehJ4sFn6CHY=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDHLv+xYxFkLDF1AA--.22886S2;
        Wed, 15 Mar 2023 14:20:34 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     axboe@kernel.dk, windhl@126.com, linux-block@vger.kernel.org
Subject: [PATCH] block: sunvdc: add check for mdesc_grab()
Date:   Wed, 15 Mar 2023 14:20:32 +0800
Message-Id: <20230315062032.1741692-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHLv+xYxFkLDF1AA--.22886S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW8XFyxJr43Gw43uw1fXrb_yoW3uFb_C3
        WUZryxJF1vkr1SvF1j9F45ZrWIvFn0vrs3WF9ag3s3Xa48XF13Wa4qvFn8Ar1UWayrua45
        Awn8tFWj9w1SqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRqg4PUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgwzF1-Hapf6rQAAsA
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In vdc_port_probe(), we should check the return value
of mdesc_grab() as it may return NULL, which can cause
potential NPD bug.

Fixes: 43fdf27470b2 ("[SPARC64]: Abstract out mdesc accesses for better MD update handling.")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/block/sunvdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index fb855da971ee..d24a78199cdb 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -973,6 +973,9 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 
 	hp = mdesc_grab();
 
+	if (!hp)
+		return -ENODEV;
+
 	err = -ENODEV;
 	if ((vdev->dev_no << PARTITION_SHIFT) & ~(u64)MINORMASK) {
 		printk(KERN_ERR PFX "Port id [%llu] too large.\n",
-- 
2.25.1

