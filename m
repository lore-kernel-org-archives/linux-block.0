Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA1C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D675421774
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 21:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXtMTc7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfK1VMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:12:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42029 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1VMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 16:12:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so32647501wrf.9;
        Thu, 28 Nov 2019 13:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fIuQVSLMX/1X5Z+UmWPRtwbnLZp5pF/aLYF24EqxQ1U=;
        b=JXtMTc7ocPvqqjhWGwL4N5XfTDj8IvidBJQBGqSy8ay6tVNlfhLMbwLCktvdaCLDUj
         g2jup+T3ajILxGPZ5JSmGNH83XvXWl9GqSDsdG2Ww81oJyOhmWbFWH8LUZwJmsorW++T
         WfD8SUnBT2p9Mc05X0HTlWYzTN+YpltX/UNH3zVBmWfmjMEmbaB0chJJxQb3KhoN5icz
         7DJGUMHpKJLlqL/IfLWQ0YLKaElaF9gSOfTGPVUsVUKwMtMVlPdsZgtYd0FwS9M/wmNb
         Z5OOPpGvRYhfFgQvyVlmaDhNqGxNxSGw2MG2zA/8zdSuLZEo/K5nFPyBuMIl/ssCrNQS
         lGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fIuQVSLMX/1X5Z+UmWPRtwbnLZp5pF/aLYF24EqxQ1U=;
        b=rDQkJB5Vno0PiIJwwR8D5II81bx4VC7Itu0czFIaQs3ImAwi7ja9IfP304nFNPkKOl
         a0hNgWZA1RL/4BNV/71hpZBi+BC42jJFWJux9B1kS42NO0voCEBOXQlc7Oz4IOPHXuhi
         BF5NWL/Q1mtszU32OT0cXWsHZg0srm5rTDVMumA1uHQ+kFRfC9mHQQQCUaMV3ubQcAew
         b1pjDND1Jc2h4+v5LLhaQ09R8XhqEREulwSpKo5HDSFaLFp/p+1Znlla9p2ui7h9RfcG
         g81ZHAio+x0U2dvExbDRr8rqvFkTybh5MHD6rRiiaDB7lGaOaU+tP5f5AtCuSZnZ7gOU
         dsmw==
X-Gm-Message-State: APjAAAXGZawhaoAhvSUKfczkuYg7kTDLk3Iib2BegKARVKMpTwfXDgsa
        VeV7/ihlJi/pQNhcBeNr92c=
X-Google-Smtp-Source: APXvYqw9YPzhZ5G3E2CqjZguJrFN2rKInPTXGrl7fNNH7DDUc1clMMTdpDu41ANSrPWnVFCvDl5mKw==
X-Received: by 2002:adf:ec48:: with SMTP id w8mr2500286wrn.19.1574975539807;
        Thu, 28 Nov 2019 13:12:19 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l26sm11620809wmj.48.2019.11.28.13.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 13:12:19 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] blk-mq: optimise rq sort function
Date:   Fri, 29 Nov 2019 00:11:53 +0300
Message-Id: <a21e91fff1abe201ebbc010d596b034f7b5123de.1574974577.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574974577.git.asml.silence@gmail.com>
References: <cover.1574974577.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check "!=" in multi-layer comparisons. The same memory usage, fewer
instructions, and 2 from 4 jumps are replaced with SETcc.

Note, that list_sort() doesn't differ 0 and <0.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 323c9cb28066..f32a3cfdd34e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1668,14 +1668,10 @@ static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
 	struct request *rqa = container_of(a, struct request, queuelist);
 	struct request *rqb = container_of(b, struct request, queuelist);
 
-	if (rqa->mq_ctx < rqb->mq_ctx)
-		return -1;
-	else if (rqa->mq_ctx > rqb->mq_ctx)
-		return 1;
-	else if (rqa->mq_hctx < rqb->mq_hctx)
-		return -1;
-	else if (rqa->mq_hctx > rqb->mq_hctx)
-		return 1;
+	if (rqa->mq_ctx != rqb->mq_ctx)
+		return rqa->mq_ctx > rqb->mq_ctx;
+	if (rqa->mq_hctx != rqb->mq_hctx)
+		return rqa->mq_hctx > rqb->mq_hctx;
 
 	return blk_rq_pos(rqa) > blk_rq_pos(rqb);
 }
-- 
2.24.0

