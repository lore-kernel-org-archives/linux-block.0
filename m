Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B301CCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiFWTAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiFWTAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:18 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5710CD20
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:46 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so3412525pjr.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB1xiHV0NGk+yjyEhzG5/AEKBrtijo9o4tlzumPY0/0=;
        b=2nljDR3D1AFa6/4Et825dvofiHJQrOaFPMx5nzRXvR7kB0HmWOSMTIEXPv5Oqodw/Q
         nqnY2Yp6LDONvKMMnxzDT+w5WatbIK/5xJ5+4QJtglkTwCeQK90wOCuESCDPtE4jKSGp
         OJwhZACYP1nhCbRQjp3G6NT0cOTypkIADs+DMqdF7YcPmARxKaIGE9k0yBSgocGlcaIp
         VMpJOHDGr/Esd1pAyRGpZMbvxNcxNNhLFJBhWwNODYYmKchDfTau1dh4x1MTWn2TuDZl
         Fq5LDYx4I+Is4fyv5HL3HQi2OePShdU5GG+9KRvNIwcv7YVFn06bQlSxu4fDHr3/5nov
         KLjQ==
X-Gm-Message-State: AJIora8DxLAkGkmKdeKXWhT9bEsgV0zm7n+wrxliAb8898pkh0svZfvv
        JACU42IjRgwl7znmo9cVLWw=
X-Google-Smtp-Source: AGRyM1vqIkBzc5KiTUa59m1N7Ox6JzaMxg+Jr1G4JSiZfvsWiDPpUZbCjSz6xJ41/v4r/b3BqdsDGA==
X-Received: by 2002:a17:902:d2d1:b0:16a:1dd9:4d3d with SMTP id n17-20020a170902d2d100b0016a1dd94d3dmr23746961plc.18.1656007546261;
        Thu, 23 Jun 2022 11:05:46 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Subject: [PATCH 08/51] blktrace: Trace remap operations correctly
Date:   Thu, 23 Jun 2022 11:04:45 -0700
Message-Id: <20220623180528.3595304-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Trace the remapped operation instead of only the data direction of
remapped operations. This issue was detected by analyzing the warnings
reported by sparse related to the new blk_opf_t type.

Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Fixes: b0da3f0dada7 ("Add a tracepoint for block request remapping")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f24c7351071c..d9e0530080e2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1061,7 +1061,7 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+			req_op(rq), 0, BLK_TA_REMAP, 0,
 			sizeof(r), &r, blk_trace_request_get_cgid(rq));
 	rcu_read_unlock();
 }
