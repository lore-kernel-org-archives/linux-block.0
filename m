Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4737FC04AAD
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 08:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E70321019
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 08:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="L0ED9O/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfEGIDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 04:03:40 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:51592 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfEGIDk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 May 2019 04:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1557216206;
        bh=5P86jqYLNxP7dBuvAXYQSd5hJWVKbDW1Nl9wv7F3f5Y=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=L0ED9O/W4kRBcDWqnxuqlsFYefDV2+BqmAymu6r/OEIh6N3+s+QzjgfkQPDmrX2pw
         9S3UTFyKeT9utn5WVC2eUrPmqPNj41gS251LfpqjO8lKBZi5D7T2HqfuIelquO7jE+
         lyqQnCDjN6b18TGRx9Oy7NlXebX6HWyQscaBFgqw=
X-QQ-mid: esmtp3t1557216203thb6qlv8u
Received: from localhost.localdomain (unknown [61.48.57.6])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 07 May 2019 16:03:19 +0800 (CST)
X-QQ-SSF: 010000000000000000K000000000000
X-QQ-FEAT: Tubeh+4qKFQuhaM4CkrsCM2V17OW744SvA8N0shiMcH+du0k7nBl0vzn/znDH
        VND3SgV0WDAXPnh7PQyRfSDZrjTJQKFtTA6QG4zsTxVI39cYGSLd/mkz0v6scexO4uVPeON
        ODXsVekzfw4Ut01yQKA7J71BXNSFgAs25Pir2zqiGa0SIJCMxARFaUU6EikSfbBcx/JkoFA
        6r/Aq5juO01mVUeNRDnyRFKQnUiqE8SpeHCIbh5DCDnDlC7VdWRsYZuXTSrIZCvVbuMEF+a
        UsqjHEADS/Jcod8Jxwhac35M206hse8PSp7g==
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     jmoyer@redhat.com
Subject: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu instead of cpu_possible()
Date:   Tue,  7 May 2019 16:03:19 +0800
Message-Id: <20190507080319.2045-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This issue is found by running liburing/test/io_uring_setup test.

When test run, the testcase "attempt to bind to invalid cpu" would not
pass with messages like:
   io_uring_setup(1, 0xbfc2f7c8), \
flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
sq_thread_cpu: 2
   expected -1, got 3
   FAIL

On my system, there is:
   CPU(s) possible : 0-3
   CPU(s) online   : 0-1
   CPU(s) offline  : 2-3
   CPU(s) present  : 0-1

The sq_thread_cpu 2 is offline on my system, so the bind should fail.
But cpu_possible() will pass the check. We shouldn't be able to bind
to an offline cpu. Use cpu_online() to do the check.

After the change, the testcase run as expected: EINVAL will be returned
for cpu offlined.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d91cbd53d3ca..718d7b873f4a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2472,7 +2472,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 							nr_cpu_ids);
 
 			ret = -EINVAL;
-			if (!cpu_possible(cpu))
+			if (!cpu_online(cpu))
 				goto err;
 
 			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
-- 
2.20.1



