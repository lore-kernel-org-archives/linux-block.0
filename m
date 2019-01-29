Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F7C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55E92084C
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzNNNTGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfA2LHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36352 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbfA2LHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so21555849wrp.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwIs+zonmjtiCZ1USOo/5sS6ODQShYjtQFUwoinOfyA=;
        b=dzNNNTGG5PdbsAoIUTXnKMvPIzXU2GiE2VkYxsWTf2UiyCY0wriVi0q9foVNjfoQol
         P/FaGtCg2bXNR6bff01uCTbsm3htu93+aSrkN86YiYT7JF4IpxTl1xTYqfozHHkmz1rD
         xO5QtpvJKdv15+MIghqrBcKbEoaxfmx0cjXzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwIs+zonmjtiCZ1USOo/5sS6ODQShYjtQFUwoinOfyA=;
        b=pRbfom/3gN+ngELBi/P9gj0uDqpt848HIK2t35mZyJOb2pmtVXpz/lxH5LSSvOexmZ
         xyNaOiT7dpjKYFted8EAdQtQcEh2tXLqfQ7Di0qNg5/pG296b0a3gVRBydJbi2+q3cQT
         Cbrl+qZUOmvs4gbi7FxON4zSMkU8O8Fax1x32dkJ/fsn/8x8qrTTdwn+rh0cqUz0PMuc
         Vdez+6PGcNI33HAi5Vwl7ymjyYBc15HERf5QicGxVzjqf7uFPI5ifd08BAfIwAQGqdmL
         nT0C/vdrMcgRlDyEnCtT7hj4+Zuu1VIW04eP/SgCCAbNJxNUPBTF96kz+72CWW7oVYau
         Cz/Q==
X-Gm-Message-State: AJcUukdSXNCBt9LpZmHMb3+qq4MdRbEsJPaGjuS4mUY84AEI+Cu9167+
        3REbvKPpFVsMQ4U/pqKNitv02g==
X-Google-Smtp-Source: AHgI3IaoYkVg1V+aaV+ipWtTYVvEmycMI3EljtyJaeHGv0fpAC5NBzizUMkuaLwJoNdy0BOxILKnMQ==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr21053279wrp.111.1548760028824;
        Tue, 29 Jan 2019 03:07:08 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:08 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 09/14] block, bfq: fix sequential rq detection in rate estimation
Date:   Tue, 29 Jan 2019 12:06:33 +0100
Message-Id: <20190129110638.12652-10-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In bfq_update_peak_rate, to check whether an I/O request rq is
sequential, only the seek distance of rq w.r.t. the last request
dispatched is controlled. This is not sufficient for non-rotational
storage, where the size of rq is at least as relevant. This commit
adds the missing control.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c1bb5e5fcdc4..12228af16198 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -235,6 +235,11 @@ static struct kmem_cache *bfq_pool;
 
 #define BFQQ_SEEK_THR		(sector_t)(8 * 100)
 #define BFQQ_SECT_THR_NONROT	(sector_t)(2 * 32)
+#define BFQ_RQ_SEEKY(bfqd, last_pos, rq) \
+	(get_sdist(last_pos, rq) >			\
+	 BFQQ_SEEK_THR &&				\
+	 (!blk_queue_nonrot(bfqd->queue) ||		\
+	  blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT))
 #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
 #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 19)
 
@@ -2754,7 +2759,7 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 
 	if ((bfqd->rq_in_driver > 0 ||
 		now_ns - bfqd->last_completion < BFQ_MIN_TT)
-	     && get_sdist(bfqd->last_position, rq) < BFQQ_SEEK_THR)
+	    && !BFQ_RQ_SEEKY(bfqd, bfqd->last_position, rq))
 		bfqd->sequential_samples++;
 
 	bfqd->tot_sectors_dispatched += blk_rq_sectors(rq);
@@ -4511,10 +4516,7 @@ bfq_update_io_seektime(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		       struct request *rq)
 {
 	bfqq->seek_history <<= 1;
-	bfqq->seek_history |=
-		get_sdist(bfqq->last_request_pos, rq) > BFQQ_SEEK_THR &&
-		(!blk_queue_nonrot(bfqd->queue) ||
-		 blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT);
+	bfqq->seek_history |= BFQ_RQ_SEEKY(bfqd, bfqq->last_request_pos, rq);
 }
 
 static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
-- 
2.20.1

