Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC621C433DF
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0416423119
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="frS1DJFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgHFRGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:06:12 -0400
Received: from m15111.mail.126.com ([220.181.15.111]:50497 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgHFRFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 13:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=+kkkBx1bxSHF0cNmAc
        mdtGqYc15xx5yDg7pnYwZu2X0=; b=frS1DJFLGX4fnq8DPpkPzrzBNlUdQF0oAl
        OByLZL/oh0uRwQOqWrbf1nOSNUXkqdCAH3q5tAuTs/FpHF95mdaDf5Y2jRIDQgn/
        Yhnm4ye5dHSqkaNpPT7U5g3xKULcl3LE4qSzaHuBJf9t8RWQDJ1TLxUWh3YO+iAI
        h+F4QZKqE=
Received: from 192.168.137.131 (unknown [112.10.84.202])
        by smtp1 (Coremail) with SMTP id C8mowAB3NEaiCyxfR1tJIQ--.29658S3;
        Thu, 06 Aug 2020 21:54:44 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blkcg: add plugging support for punt bio
Date:   Thu,  6 Aug 2020 09:54:42 -0400
Message-Id: <1596722082-31817-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8mowAB3NEaiCyxfR1tJIQ--.29658S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1kKFy5Kr47JF4UZw4xZwb_yoWfZrg_Gr
        yqyFykGF1DCa1Fkws09F93ArZYkws5XF1qg34rK34fXF18Ja1qkr13Xw4qq34rCFyxuFy3
        WanrZry8Crs3KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0dMaUUUUUU==
X-Originating-IP: [112.10.84.202]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi7Ql4pFpD-JPV9AAAsv
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Try to merge continuous bio to current task's plug fisrt.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ecc897..fe5d361 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -122,6 +122,7 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 					     async_bio_work);
 	struct bio_list bios = BIO_EMPTY_LIST;
 	struct bio *bio;
+	struct blk_plug plug;
 
 	/* as long as there are pending bios, @blkg can't go away */
 	spin_lock_bh(&blkg->async_bio_lock);
@@ -129,8 +130,10 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 	bio_list_init(&blkg->async_bios);
 	spin_unlock_bh(&blkg->async_bio_lock);
 
+	blk_start_plug(&plug);
 	while ((bio = bio_list_pop(&bios)))
 		submit_bio(bio);
+	blk_finish_plug(&plug);
 }
 
 /**
-- 
1.8.3.1

