Return-Path: <SRS0=4SCO=RN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B418FC4360F
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE42087C
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtdmQx2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCJSMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:12:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45153 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfCJSMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 14:12:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id o7so2622444wrp.12
        for <linux-block@vger.kernel.org>; Sun, 10 Mar 2019 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUHw4uD/6PdjAyafvFS/vFaSGIdhMTKmdDdLyjrgLw8=;
        b=gtdmQx2Zk6ww/kOS2ogjkJUpLQtwK3crXM1AJgeofygnkUT9nw5qv9MWszMcLDTTSP
         StOKhxeSNxBCEBcshrFDwNaO6mALCJqcW761baZGdJKTvJWE7vU4n1QYsPY0+MwPDgUu
         9JnnWzfKHLu4V0NpzpirdIO4vYfwx4dObLII9rGtWnJpw6cHBgdgDxx4pf363mXXQizX
         lxGG5cvUbIyDnayRqgBml8xHhJAU62O7YsDv2IoqeZcn/zDOzfsfX8PMXm524exgiwvN
         jZg+tcLcHZd7W+Mpxf+z8LoeZ4H1z9WHmNaJfY5ON16KIo6CoQP0fZ4KMafXsyCU5EVD
         VF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUHw4uD/6PdjAyafvFS/vFaSGIdhMTKmdDdLyjrgLw8=;
        b=eZ84so57DU3Xk1Y2NJSxyBEXsR74gxIjgd09p4xE2zBmCmspjG+xYWNgVAALFb4g4B
         doC2nfvPODmD7wU5LPkuZ9+gteKfCPS9XxLWZdFOwtjORtHE9sMVDO04oPusl12xB83r
         8CFlmsmDwNVWch+Z05KZlqBYfYESeca9B10RMgvFsahzVGOjrwGuTHPNzB5kq0ETh55a
         u0kyOnUfx0aJON3eTQQ1R61S8lj+8mxBOQfE741x05SBBGaPSTTBcEjbTMW/95D/sMTO
         ZlC2bux8Q2YH1qjnZyKW58JSPvhCUhRK8oUDlNSoFePow1mg8GL32nZ+jtkzefPAGtKI
         GkYA==
X-Gm-Message-State: APjAAAXrmofh86kuXwcMKzLBVLnKCSG/HfW2L8H6pIDgoL95XVMq5pRW
        FaRT9XmfCZHRKV8iVQ8S1Ij+GA==
X-Google-Smtp-Source: APXvYqzSxTuup2NH4SewBU3+oJJ493aBHU+xX085HMGEbSFqhRLyaGxvX6DDv5mavid1ldmgePvhNQ==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr16495341wrm.4.1552241540362;
        Sun, 10 Mar 2019 11:12:20 -0700 (PDT)
Received: from localhost.localdomain (146-241-67-113.dyn.eolo.it. [146.241.67.113])
        by smtp.gmail.com with ESMTPSA id d206sm24906368wmc.11.2019.03.10.11.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:12:19 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 5/9] block, bfq: do not tag totally seeky queues as soft rt
Date:   Sun, 10 Mar 2019 19:11:33 +0100
Message-Id: <20190310181137.2604-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310181137.2604-1-paolo.valente@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sync random I/O is likely to be confused with soft real-time I/O,
because it is characterized by limited throughput and apparently
isochronous arrival pattern. To avoid false positives, this commits
prevents bfq_queues containing only random (seeky) I/O from being
tagged as soft real-time.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b96be3764b8a..d34b80e5c47d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -242,6 +242,14 @@ static struct kmem_cache *bfq_pool;
 	  blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT))
 #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
 #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 19)
+/*
+ * Sync random I/O is likely to be confused with soft real-time I/O,
+ * because it is characterized by limited throughput and apparently
+ * isochronous arrival pattern. To avoid false positives, queues
+ * containing only random (seeky) I/O are prevented from being tagged
+ * as soft real-time.
+ */
+#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history & -1)
 
 /* Min number of samples required to perform peak-rate update */
 #define BFQ_RATE_MIN_SAMPLES	32
@@ -1622,6 +1630,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 */
 	in_burst = bfq_bfqq_in_large_burst(bfqq);
 	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
+		!BFQQ_TOTALLY_SEEKY(bfqq) &&
 		!in_burst &&
 		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
 		bfqq->dispatched == 0;
@@ -4816,6 +4825,11 @@ bfq_update_io_seektime(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	bfqq->seek_history <<= 1;
 	bfqq->seek_history |= BFQ_RQ_SEEKY(bfqd, bfqq->last_request_pos, rq);
+
+	if (bfqq->wr_coeff > 1 &&
+	    bfqq->wr_cur_max_time == bfqd->bfq_wr_rt_max_time &&
+	    BFQQ_TOTALLY_SEEKY(bfqq))
+		bfq_bfqq_end_wr(bfqq);
 }
 
 static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
-- 
2.20.1

