Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C40C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiF2XcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiF2XcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:12 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671730B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:10 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id x4so16521633pfq.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZza/KzXDhVgRsOKYL7+Amk0YEqqP3BHm75zMaB/H74=;
        b=viWnMx9dK1YOhNH+3oRTMSKq/ggwIlkMur7eMJvujR4jT9ZWGCJ0qvQs8surlyifyu
         db/semFTzjUSlyczAbx0FQyi1e6bDpe+RgCyetk+IKPRW8ePeZFlhF0UDWyGWX25afcz
         bG9dbaV9V3gzgRHx5+YVOQTFKQs/bKBghArOL6BreuUzh0XK2Yd/wsHvyQ1XBnXMD+4s
         jaApupYRmPOFBum8aqus+GEHgn3CYQGIBiS21xviRbCvWDz0RYpQFTaZHCHU5Sn4j5nB
         YkbGGRs0Bd+M7GGqZbGsbDSCDMLgdzC59TtPfDB0+Hfkb4uLqs8KUmk+D64w5kVg7quH
         kHOA==
X-Gm-Message-State: AJIora95QKmjT4bzfEZ5zFIZ2bH94+dBkVhmw5ElJ2r9ZLWkffkqyjNh
        UrECr+GiVBMBvAB5fM/Ac9c=
X-Google-Smtp-Source: AGRyM1vUKutqIjhd9k50BneWjquyJ9nm8Cs1YjkVXTZL2F/ffp88VXaVo/rOABbOpQ9E4xkW6Vh+ag==
X-Received: by 2002:a63:1943:0:b0:411:5e12:4e4f with SMTP id 3-20020a631943000000b004115e124e4fmr4982932pgz.400.1656545530058;
        Wed, 29 Jun 2022 16:32:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Jun'ichi Nomura <junichi.nomura@nec.com>
Subject: [PATCH v2 10/63] blktrace: Trace remapped requests correctly
Date:   Wed, 29 Jun 2022 16:30:52 -0700
Message-Id: <20220629233145.2779494-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Trace the remapped operation and its flags instead of only the data
direction of remapped operations. This issue was detected by analyzing
the warnings reported by sparse related to the new blk_opf_t type.

Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Jun'ichi Nomura <junichi.nomura@nec.com>
Fixes: b0da3f0dada7 ("Add a tracepoint for block request remapping")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c584effe5fe9..cee788817fb3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1058,7 +1058,7 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+			req_op(rq), rq->cmd_flags, BLK_TA_REMAP, 0,
 			sizeof(r), &r, blk_trace_request_get_cgid(rq));
 	rcu_read_unlock();
 }
