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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FB2C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 04:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81C924BB1
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 04:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JVqJMNXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfFDEFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:05:20 -0400
Received: from m12-12.163.com ([220.181.12.12]:59240 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFDEFT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 00:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=YUBZD
        ynJLMXXGVegIZqIC35/ur/rTnXatkDZueWxJpM=; b=JVqJMNXN37g+ZKH/0uDSh
        pqPsj/aj5cOKMgRfwGvbeFyhQAraT5CbUZCjuYM0ty3z/hNgP+7+3qBt5IMCrudq
        XcP9nbbmzYi1QRnD0t9YB5RlqvPmY9r3S6sGvTXEhGglxfXEYCsrxUXUm3++1JeS
        gImMfiAxwoTsUv6gD2McDk=
Received: from tero-machine (unknown [124.16.85.241])
        by smtp8 (Coremail) with SMTP id DMCowAA35cn07fVccX0RAA--.4692S3;
        Tue, 04 Jun 2019 12:05:09 +0800 (CST)
Date:   Tue, 4 Jun 2019 12:05:08 +0800
From:   Lin Yi <teroincn@163.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liujian6@iie.ac.cn, csong@cs.ucr.edu,
        zhiyunq@cs.ucr.edu, yiqiuping@gmail.com, teroincn@163.com
Subject: [PATCH 2/2] block :blk-mq-sysfs :fix kobj refcount imbalance on err
 return path
Message-ID: <249f0ba61c63520ef1608503c3be16daebf5a30f.1559620437.git.teroincn@163.com>
References: <cover.1559620437.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559620437.git.teroincn@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: DMCowAA35cn07fVccX0RAA--.4692S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3WF1xur4xuFW5CF17Jrb_yoWfAFg_GF
        ykCFW8urn8Cr1akw1jkayIvF1rtw4xJFWxCFW3tr9rJr1kJFn8ArW3Xr1UZrs8WF4xua15
        Cr1DJ3s5Ar109jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU838n5UUUUU==
X-Originating-IP: [124.16.85.241]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiwATJElXllSPh5gABsf
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
 block/blk-mq-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index d6e1a9b..7499a47 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -323,8 +323,10 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	lockdep_assert_held(&q->sysfs_lock);
 
 	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
-	if (ret < 0)
+	if (ret < 0) {
+		kobject_put(&dev->kobj);
 		goto out;
+	}
 
 	kobject_uevent(q->mq_kobj, KOBJ_ADD);
 
-- 
1.9.1


