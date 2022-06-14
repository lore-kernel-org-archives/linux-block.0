Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3EBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245621AbiFNR5i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbiFNR5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:57:37 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061D23151
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:33 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id u2so9242439pfc.2
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9tnBOai4DmZhA38KFvvakDUH45VuiQA8jpuK+GovrI=;
        b=i4IRlXfZ6r3+n8EkoEfUZmBVuAXpSKtTwRVR3bsd6EcdONzsHh/0jgxMtJGAA8oms9
         jpRwTkA2xII5nWoKYZ/Es+dlkUMoi2dmGirpBvUfZTYQq/vVi7D+yJOQW5lYwCv+c27R
         hAXr3Ru8BY+qMD02N6M4kY+ehCyAEzvhiCWib7q/2S0BDE4OgI68IOXFeN5jOU+ENQm+
         vBGk+Yli9Rb7XcrhQPTz6bREmp6DD1/GxZG8EOCaEGWrXlMXlLvgCr0i8k2E1Lcd124u
         AhwRarg1OQehIVf8r/0uIjD8TZutHr1oG8PMhfhDhj3MYSXB5vbG5F/kTuvbw5U0Y/BY
         pWig==
X-Gm-Message-State: AOAM532qn9uMD+4nhrZ3nI7VYOZbLIdHU4weUOqKJCJE94XQjejvqJti
        jeGf88TrR40VRGpPGI5+r9OOaW9WsNI=
X-Google-Smtp-Source: ABdhPJx5zYPUFzsyxsG2oMLAvCxQh8wa65aLWAkslRsbcgpL9ZIkpU0V/SuK2eHz23CsfpGo+fCXeQ==
X-Received: by 2002:a63:604:0:b0:3fc:8830:a67c with SMTP id 4-20020a630604000000b003fc8830a67cmr5453336pgg.402.1655229452854;
        Tue, 14 Jun 2022 10:57:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b0015e8d4eb1f7sm7519666plb.65.2022.06.14.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:57:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] blk-iocost: Simplify ioc_rqos_done()
Date:   Tue, 14 Jun 2022 10:57:23 -0700
Message-Id: <20220614175725.612878-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614175725.612878-1-bvanassche@acm.org>
References: <20220614175725.612878-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Leave out the superfluous "& REQ_OP_MASK" code. The definition of req_op()
shows that that code is superfluous:

 #define req_op(req) ((req)->cmd_flags & REQ_OP_MASK)

Compile-tested only.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..b7082f2aed9c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2769,7 +2769,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 	if (!ioc->enabled || !rq->alloc_time_ns || !rq->start_time_ns)
 		return;
 
-	switch (req_op(rq) & REQ_OP_MASK) {
+	switch (req_op(rq)) {
 	case REQ_OP_READ:
 		pidx = QOS_RLAT;
 		rw = READ;
