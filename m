Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B4FC43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AB1222C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 15:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Qp0ogsu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKMPVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:21:31 -0500
Received: from m15-114.126.com ([220.181.15.114]:57577 "EHLO m15-114.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfKMPVb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 10:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=g4zBKukrfs1sRRf/F1
        7Sb3CGg6la5ZQam/XLkpNLqTU=; b=Qp0ogsu8Eiy2NXapegO9v6o+4LhRpfzhud
        6R2XpMvt+s4wYwKexm+qPG9KtBlVksd7Mkr0kbZcUbJf+1JLBmJZgGHGTMq1OGNJ
        Bk1s7I2559gwXSNfmOMNTGQv+dwtrioYOiQx0x7EoEK2WjhFzAi4j18g4mPGR3KS
        ZgLo7s81s=
Received: from 192.168.137.243 (unknown [112.10.84.216])
        by smtp7 (Coremail) with SMTP id DsmowAAnhxNxH8xdNK9AAg--.63081S3;
        Wed, 13 Nov 2019 23:21:22 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix the typo in comment of function deadline_latter_request
Date:   Wed, 13 Nov 2019 10:21:19 -0500
Message-Id: <1573658479-13094-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowAAnhxNxH8xdNK9AAg--.63081S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4zuWDUUUU
X-Originating-IP: [112.10.84.216]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi9ApspFpD9HDm1QAAsY
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the typo "`" to "'"

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b490f47..6047192 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -71,7 +71,7 @@ struct deadline_data {
 }
 
 /*
- * get the request after `rq' in sector-sorted order
+ * get the request after 'rq' in sector-sorted order
  */
 static inline struct request *
 deadline_latter_request(struct request *rq)
-- 
1.8.3.1

