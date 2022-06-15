Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F4CCA47D
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiFOVBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbiFOVBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 17:01:46 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5B255349
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:45 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id c196so12518304pfb.1
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlBOBs75qJg+H6i2ao8I084W2KaBPhQg34zhEA9I3cM=;
        b=qP8fG0Xnavwu8ZPyWl4chjK8k4qL8GXEJ9LB0QYBZFgdya9FnHq5MJl/g+vt+jJXE6
         eDr7rHPZ1wmF1J3nvqPc5Bay5I/PrNEQvDAGWGRnnIW4kQpdkqTQpkLuODvCtwpRPs16
         65NHpjhk0zzFDLdHdtyxNLrU9tz++nAeIadjWtJ49isZkh4zFfP7K8knea0s7pToNbXu
         HkbjV1y5qpHEJHnSBn8yERKj3qX2pX+cy0V2ks68TrR7OTmmEO7dKR+w2s2x60NgZ6Hn
         9qpopEQcPvaYAflQ6Ns25D/lmVB5p8QwpMaXRWY+rt4v+Sds7jweuJUGRAW9ipwynl16
         ghJg==
X-Gm-Message-State: AJIora+k1gM00kh0T8T46jDbOIoRpn/Afvvs04gvODP5dWcMgFYTFMug
        7z3Ez/zrpBTkvXXPQZS8oGQ=
X-Google-Smtp-Source: AGRyM1sTSegSu9qK6huaL3AokkaKlmpsAqXc3No45ae5FZvTcZVl3bkm8p9/PlkN1Yrc6VYqhkSxTQ==
X-Received: by 2002:a63:8543:0:b0:401:a213:a5df with SMTP id u64-20020a638543000000b00401a213a5dfmr1504568pgd.44.1655326905337;
        Wed, 15 Jun 2022 14:01:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b0015e8da1fb07sm68986plj.127.2022.06.15.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:01:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 1/3] blk-iocost: Simplify ioc_rqos_done()
Date:   Wed, 15 Jun 2022 14:01:34 -0700
Message-Id: <20220615210136.1032199-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615210136.1032199-1-bvanassche@acm.org>
References: <20220615210136.1032199-1-bvanassche@acm.org>
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
