Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29898C282CE
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 02:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B344721871
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 02:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PkBr/FfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfDFCDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 22:03:07 -0400
Received: from [103.7.29.155] ([103.7.29.155]:56391 "EHLO smtpbg64.qq.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfDFCDH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 22:03:07 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2019 22:03:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1554516161;
        bh=j92zCe2a4Akoo/3jGg5ofdVBAz44WXJqbnAohA5iNEo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        b=PkBr/FfCg2Nnyx79m60kNEBZbpQgCZtA0d1Cg9SfgcDh2eClm04wjgZPMkFOfWStj
         /fnrkmruprkmXlFRRRC/fOsaafznSXVLFBZXJdkGjJnrsY99JeO7uXpviMhGr+0TDn
         tic26wx8OFu5c96jg09cTzWb9DUaEUdxHsXd8rwQ=
X-QQ-mid: esmtp7t1554515689t2khz8qxm
Received: from localhost.localdomain (unknown [114.243.219.120])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 06 Apr 2019 09:54:40 +0800 (CST)
X-QQ-SSF: 01000000000000F0FH3000000000000
X-QQ-FEAT: 9NFkmNiL4hcagxEGXxMG/VrKGbwWMfnp6v0Hz8sO8j7vS0MHKd+pLHpwH2UmJ
        b5XWKBsRDp0io2xTQ47NQ9QlHZ7wp719h7ib4smrlD39+marQOenXx0/CDabObDFM7hesXm
        /iZ2xHqholXajEbw2Z+Fv1AG8ayoAGwkb2jVvQIbdPoAgJm5ioJ2yfC9bwa0UNb8VA4zAKC
        F7PT5tY+5+dZrFWQlNp2kpYFvzSt8lAR1/rLtwdNTxgmvqfn7Odj1Uw6tIambyhmp+PN+Es
        VnNN1PQ8QV1yr8KUrFM4WpU30Nf++6ipOwfA==
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: set plug->rq_count 0 after sort in blk_mq_flush_plug_list
Date:   Sat,  6 Apr 2019 09:54:40 +0800
Message-Id: <20190406015440.30233-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb115
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set plug->rq_count 0 earlier can skip possible sort.
Move the 0-value set after sort.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3b0d33bdf88..e5d32f186e81 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1711,10 +1711,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	unsigned int depth;
 
 	list_splice_init(&plug->mq_list, &list);
-	plug->rq_count = 0;
 
 	if (plug->rq_count > 2 && plug->multiple_queues)
 		list_sort(NULL, &list, plug_rq_cmp);
+	plug->rq_count = 0;
 
 	this_q = NULL;
 	this_hctx = NULL;
-- 
2.20.1

