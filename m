Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A61C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EAB2084C
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="djoXGnsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfA2LIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:08:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41212 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfA2LHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so21517428wrs.8
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NergthX5oSNRCeJESFYVsMGHKG3cwu/m8eBx+7n5JOE=;
        b=djoXGnsK11deAS6J4IpmOiUJzQK9Kh7UxFQ1sIfWXNRnsCRYdWvW0iAmNOyyvH1U5l
         ORyYOSUQzOHLOCqOg8RLHcMw3X44QxZocHBXJf/enpRVP2QWwBZEQTd1ADwMLsAu7YOh
         D74Y4PF0RgKe7o69H7P4Au761wDwXZIkzxtm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NergthX5oSNRCeJESFYVsMGHKG3cwu/m8eBx+7n5JOE=;
        b=HiJ97AGG95IJHUL0AR5rY4GFQddw5ZNu14qeagSV2APmM4xwkWYFnBO0pB5/OUx/RA
         D+g8H0KLJywoq9E0oa1Rz1NKraUqnbCGua6+Uq+OEuad0rwmQ63rIyzxFb71WGEWF9jG
         UdIyiobiLl6B0Ftt55bbWe5leID2DbGv5I5ut8y877UK6H5Fm/FsTHLX79/4ScAxXfC7
         NFq01kO00YqSxsVY6vswhipdq5+1BxGHR5tomQQ2HDscUHao857ndeAmPvZUVGNEyRlw
         ShOT4cBq8dTTLAnIFYFxF/J6k8fB9rxLhnwiYP0+ghPNa2mW3aE6TY4HyvZeAhrYvzBs
         lbJw==
X-Gm-Message-State: AJcUukfFtHjVV8OjREk/zPPz7lJZ58r0ZuVdI3ceVK0LKYCDlCRPaokk
        UJfb6cv6p95WwZFgjbJYzVV61Q==
X-Google-Smtp-Source: ALg8bN7KyU4T2hntASzwapUm1qGbXPcwc372C+KpSmztKCfyCq9jXBrjLPKcmlxaBmqmGaTtpBWGHA==
X-Received: by 2002:adf:9361:: with SMTP id 88mr24827980wro.204.1548760022218;
        Tue, 29 Jan 2019 03:07:02 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:01 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 04/14] block, bfq: remove case of redirected bic from insert_request
Date:   Tue, 29 Jan 2019 12:06:28 +0100
Message-Id: <20190129110638.12652-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before commit 18e5a57d7987 ("block, bfq: postpone rq preparation to
insert or merge"), the destination queue for a request was chosen by a
different hook than the one that then inserted the request. So,
between the execution of the two hooks, the bic of the process
generating the request could happen to be redirected to a different
bfq_queue. As a consequence, the destination bfq_queue stored in the
request could be wrong. Such an event does not need to ba handled any
longer.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b0e8006475be..a9275ed57726 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4633,8 +4633,6 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bool waiting, idle_timer_disabled = false;
 
 	if (new_bfqq) {
-		if (bic_to_bfqq(RQ_BIC(rq), 1) != bfqq)
-			new_bfqq = bic_to_bfqq(RQ_BIC(rq), 1);
 		/*
 		 * Release the request's reference to the old bfqq
 		 * and make sure one is taken to the shared queue.
-- 
2.20.1

