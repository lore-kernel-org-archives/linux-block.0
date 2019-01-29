Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3780C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9594A2084C
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlNrCME0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfA2LH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41229 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfA2LHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so21518088wrs.8
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDzJdQaJUVbOMOgsobVLGeLVo1CynjuO1LWZuQEuQ0s=;
        b=YlNrCME02AvhfJTfFzDA7cXLW6GkN4P602kH9FqZdMo8dfqIjrdqLc0SZVieJXCoRk
         EjdcaZrCdjJRqKoBG9NcdFH+dOguGYF0kGl4fWzV9VPBr3jVZNgBhaVc8Z87DiCt5APe
         jwOLIrtW+c8AGnIapiBil70XxXFnbCiHytrkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDzJdQaJUVbOMOgsobVLGeLVo1CynjuO1LWZuQEuQ0s=;
        b=WPBxQi2sT9KROdH2pTT5vwMG3Unt/4FNUj7uQcXVOnvpvoPFdtdXBi5TYS88cTK+tP
         MT9mcXL9MZ2+aPO1MlKq+HrT339A4OgpujXX9W+u/bdIzB6mw9TTFSiy+JfiucUObEOf
         xsspztPBun5DXqXx+b4e9QCaEltVbCpbo086Lzz3qqvpoIWfpBtNqF6J+UBw/xeTfak5
         Scnx/0DTDyKJiTZapy0JWms6ArWwRe23jDDMoAPadjUKL1BKJBO2dRF8tftfthqBtZB6
         VstD8bNvhw6OMVYMMg9b/4p7cA1d32HJEcyggbvLv384eZcByBZ2Wy27ULiPoBOE4kfE
         aRmw==
X-Gm-Message-State: AJcUukeRPINHYj/MdlL62CMAvf+mY73nWh3kDt7+C0JkahbDTlulwsiz
        7d09OYkszf2aOKZLrpxNVY4/Ng==
X-Google-Smtp-Source: ALg8bN4i2QB/ggjoyUvCO+iRRW6VcZ2yv+tDBmGHgCCBvaPAOEFc754Zt/AEpp3mU/3ngl4Pq/tjNw==
X-Received: by 2002:adf:c711:: with SMTP id k17mr24732765wrg.197.1548760032900;
        Tue, 29 Jan 2019 03:07:12 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:12 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 12/14] block, bfq: port commit "cfq-iosched: improve hw_tag detection"
Date:   Tue, 29 Jan 2019 12:06:36 +0100
Message-Id: <20190129110638.12652-13-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The original commit is
commit 1a1238a7dd48 ("cfq-iosched: improve hw_tag detection")
and has the following commit message.

If active queue hasn't enough requests and idle window opens, cfq will not
dispatch sufficient requests to hardware. In such situation, current code
will zero hw_tag. But this is because cfq doesn't dispatch enough requests
instead of hardware queue doesn't work. Don't zero hw_tag in such case.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 48b579032d14..2ab53d93ba12 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4786,6 +4786,8 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 static void bfq_update_hw_tag(struct bfq_data *bfqd)
 {
+	struct bfq_queue *bfqq = bfqd->in_service_queue;
+
 	bfqd->max_rq_in_driver = max_t(int, bfqd->max_rq_in_driver,
 				       bfqd->rq_in_driver);
 
@@ -4801,6 +4803,17 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	if (bfqd->rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
+	/*
+	 * If active queue hasn't enough requests and can idle, bfq might not
+	 * dispatch sufficient requests to hardware. Don't zero hw_tag in this
+	 * case
+	 */
+	if (bfqq && bfq_bfqq_has_short_ttime(bfqq) &&
+	    bfqq->dispatched + bfqq->queued[0] + bfqq->queued[1] <
+	    BFQ_HW_QUEUE_THRESHOLD &&
+	    bfqd->rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
+		return;
+
 	if (bfqd->hw_tag_samples++ < BFQ_HW_QUEUE_SAMPLES)
 		return;
 
-- 
2.20.1

