Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E119C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D094A2084C
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbEl1Xzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfA2LHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50921 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfA2LHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so17363878wmd.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfh0pAFFntluWsfkKiHNCWmGd04mxXjXMAOMMF2nCLo=;
        b=bbEl1Xzgyv62vtDcTw804jba5WzfBOVjKpHPxC3U5g2tcPH4HKqtB+uTCqHcWc7xfx
         WgdKQhwnUJws1yCsxGdrqh5MOEpOUBRGDkjY7U14LxizTJ5yiae2dwFGTATB4rNJdjbr
         bf7Ph+MwLgcCr8DcYkS2jIlYcoixT+wlG6DFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfh0pAFFntluWsfkKiHNCWmGd04mxXjXMAOMMF2nCLo=;
        b=TOvlcJiylQnEdr18Y7vkBWZeRgvttm1bi1e709HvWtCswb0zfNO8WrTTWhP/tvzcM0
         MIB52VfZ5cWukBbsPvIAAruCrqkIVKBe/stf3jk41q72+bVFvLs6AloUe/rJAzOPIh6i
         hd+FcgnqwCe/GtwyhybpRx7HzVcL02tlLol/DCO6/FryWypmV1+LI0avOypQxe6gqPQh
         dX5vm00tbaWT3QZXoWoZJyEZam/Zw9g/fh26Wz23Ra26Un0It19fbAxAucztLfGBU+vK
         1zIXhyn/M4oiz3Qy/UZztSojawQ2MsA1AcnZdiOI32JqSQ95udgWJauMR2gjXRhBrAGT
         2ZvA==
X-Gm-Message-State: AJcUuke2M2HKa/BABuvuKQ4wCgHo34eX61lavgx6K8CaLhwH0QVQzC+b
        V/OzR1pRllEO+1v6KE2m+EPO5g==
X-Google-Smtp-Source: ALg8bN6fqF+RgUuq/0rqhbPXf1ZmTs5ioSHxjm84uvoeXP1aKMG7HS0sWrkM0S7RuGoVGc5WY3pyjA==
X-Received: by 2002:a1c:8b09:: with SMTP id n9mr20820350wmd.38.1548760020924;
        Tue, 29 Jan 2019 03:07:00 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:00 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 03/14] block, bfq: make sure queue budgets are not below service received
Date:   Tue, 29 Jan 2019 12:06:27 +0100
Message-Id: <20190129110638.12652-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With some unlucky sequences of events, the function
bfq_updated_next_req updates the current budget of a bfq_queue to a
lower value than the service received by the queue using such a
budget. Unfortunately, if this happens, then the return value of the
function bfq_bfqq_budget_left becomes inconsistent.  This commit
solves this problem by lower-bounding the budget computed in
bfq_updated_next_req to the service currently charged to the queue.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9ea2c4f42501..b0e8006475be 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -907,8 +907,10 @@ static void bfq_updated_next_req(struct bfq_data *bfqd,
 		 */
 		return;
 
-	new_budget = max_t(unsigned long, bfqq->max_budget,
-			   bfq_serv_to_charge(next_rq, bfqq));
+	new_budget = max_t(unsigned long,
+			   max_t(unsigned long, bfqq->max_budget,
+				 bfq_serv_to_charge(next_rq, bfqq)),
+			   entity->service);
 	if (entity->budget != new_budget) {
 		entity->budget = new_budget;
 		bfq_log_bfqq(bfqd, bfqq, "updated next rq: new budget %lu",
-- 
2.20.1

