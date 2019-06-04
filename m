Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6522AC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 04:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0224BB1
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 04:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z5dLEXmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfFDED0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:03:26 -0400
Received: from m12-18.163.com ([220.181.12.18]:59875 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFDED0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 00:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=mB4nm
        g5kmztAi1+dk1jdG+pooPcbG7iE1GgYDOrPtR0=; b=Z5dLEXmyRFc9gwD8miJgy
        UwBTRNkN6KDs0+BYsMOk5dhuom596HQAU5ioqm24sNn+gQ4Er5xJV9WfrqkLIrlM
        iWO6KPcGSblOuKGfBJXwD8s0/VRy8tvHvwQ0DHZ88G0PBMOs8SrmWUOjKvlNx/lN
        cwSlPWO7N9eGcRXcPeWhzE=
Received: from tero-machine (unknown [124.16.85.241])
        by smtp14 (Coremail) with SMTP id EsCowABnyoxu7fVcTiYPAA--.4127S3;
        Tue, 04 Jun 2019 12:02:54 +0800 (CST)
Date:   Tue, 4 Jun 2019 12:02:54 +0800
From:   Lin Yi <teroincn@163.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liujian6@iie.ac.cn, csong@cs.ucr.edu,
        zhiyunq@cs.ucr.edu, yiqiuping@gmail.com, teroincn@163.com
Subject: [PATCH 1/2] block :blk-sysfs :fix kobj refcount imbalance on the err
 return path
Message-ID: <0c46d61da0fbe9d245ceabd8cb86cdf12008ebec.1559620437.git.teroincn@163.com>
References: <cover.1559620437.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559620437.git.teroincn@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: EsCowABnyoxu7fVcTiYPAA--.4127S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3WF1xur4xuFW5Cw15Arb_yoW3Wwb_WF
        1kGFy0grn8Cwn8KF1ayayIqr1Syw43GFWSkFZxtr97X3W7J3Z5CrW3XF18ArsrGa1xuFy3
        Zr17G3s5uw4S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8aQ6tUUUUU==
X-Originating-IP: [124.16.85.241]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiLw7JElUMNHzwcQAAsq
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kobject_add takes a refcount to the object dev->kobj, but forget to
release it before return, lead to a memory leak.

Signed-off-by: Lin Yi <teroincn@163.com>
Fixes: 7bd1d5edd016 ("Merge branch 'x86-urgent-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
Cc: stable@vger.kernel.org
---
 block/blk-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 75b5281..539b7cb 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -971,6 +971,7 @@ int blk_register_queue(struct gendisk *disk)
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
 	if (ret < 0) {
 		blk_trace_remove_sysfs(dev);
+		kobject_put(&dev->kobj);
 		goto unlock;
 	}
 
-- 
1.9.1


