Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E5AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 22:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbiFOWz6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347483AbiFOWz5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 18:55:57 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB16E9C
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:55:57 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so4159352pjb.1
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlBOBs75qJg+H6i2ao8I084W2KaBPhQg34zhEA9I3cM=;
        b=qj+KAY0imlNoHzuR8/dE1yzpwywJJsGrpVDHhlqR1ca2t74yS9GRIBcky3wwo3zYLD
         n1cncu6e7dTJMje5pHU4hjoeYm5kpTtczSn9cdQbyafoEqgeHzOlbYnNaDScOqkTrTv/
         ZUvDRD3C2i9sl1XadAAtSMSHNscIaCgi0pCl8MV96rycNxrpUJv0sVKX+J7XYG3/U2Iw
         rHdSlyO9bNNxdBSrMAkQ16uqmrShYMJSfGmYnlF9J6SO1e+eGOBv+WJpdkkzR929Rh/N
         yLcaAVWOsX7H5CWxwXDZSEn8eYC1aVXqKcbAs7JJvVTXopsZqMOVELXZAAN0cihbWa2Z
         WKfQ==
X-Gm-Message-State: AJIora/NOLydASe6Y97xk1w6hWmE96+XBS557+3aulBB+vzPgr/dGWeb
        FjgjWmRSlEDZO0k+6lbBqGk=
X-Google-Smtp-Source: AGRyM1sFEd+HxWWEO7ryRder+Tqky1IWu6TfCZakTnAYUeOkLUHkjau2rEbNSfnL8KXm5kUEB/i1oA==
X-Received: by 2002:a17:902:6bc7:b0:168:e0b6:c740 with SMTP id m7-20020a1709026bc700b00168e0b6c740mr1834408plt.156.1655333756471;
        Wed, 15 Jun 2022 15:55:56 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id f62-20020a17090a704400b001eae95c381fsm158611pjk.10.2022.06.15.15.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:55:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 1/3] blk-iocost: Simplify ioc_rqos_done()
Date:   Wed, 15 Jun 2022 15:55:47 -0700
Message-Id: <20220615225549.1054905-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615225549.1054905-1-bvanassche@acm.org>
References: <20220615225549.1054905-1-bvanassche@acm.org>
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
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
