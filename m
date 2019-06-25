Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC07AC48BD4
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A882085A
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQYzQbNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfFYFNK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:13:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37098 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfFYFNI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so16233818wrr.4
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 22:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ut8pJenbbfhanl2aOoK0pt6xWf0qOGuFx8Wspm0t8o=;
        b=MQYzQbNYvxusF57C18gXvM1eka5gQuEJ/R8ufmNqYIO+mmMce5I25JzdSIWDOIqTVT
         Vo4e6VYb8JsTA5twrek74WolVnQN6cPzfzssZpOrbGi0tKIShxyS2TWbrH1MKOxTtVd/
         WL4n7tViZgPeip+DT4tsa67+W6eS2unJA/4dSiq9nKd7F+3rXGWzIa0BbnYhGqC79g9Z
         djoqYLPqJSSOKT8waUiK6BTGcp3HccM9aVhimjv9A/rT6gg2ZzKmJf5h7d2t/8jeUpNL
         CdG71P4tuL/yFhnUKJmoS4TafUoWR71HRUlC1pU/W7X3kvUPNalBJZO5sd46xa86HVLX
         cmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ut8pJenbbfhanl2aOoK0pt6xWf0qOGuFx8Wspm0t8o=;
        b=NKk/8UZxNmUlIU+MlhqDYnN6PE/m3C1UoarPZC41+/NRDZJK5qorC5vzNw+dK4A1wO
         lp7YjxUN78ryqamOYHPu8skKYTG5KWcGVcGTiueCaEBpxx4c6aFpEeS/EqV6CDmVsvSS
         qPMaxjXLRjuGPDShGWbxqERdZBp7NH5BVs83UznQSvFlueMH1sf/L5mDqHwqwScCYvfH
         V3nMmHLbf72GlhmNdA8iWRXfew29dn57D+k0C1Ld3xVXOA+QGnm8dd82yIbAGVmIWCcV
         WMQg6tu1msZjMQq+rYUNehVUUL2vSnV47W7VZfZM8AT9E6pQufvU8ShVsqta01DDW1La
         bxRA==
X-Gm-Message-State: APjAAAV7jEEdZWC1QfscaRMBwClYB1mNQaTheoghdl1mLZEiBYGwVpj8
        etePTbXFjiyDPFPXxE2tfgI8Jbz6vrU=
X-Google-Smtp-Source: APXvYqzo/rbjLONVjtwNHQnvN0AjTFJgXyl/qUR8zcODpPqucbQgztmwmBULcQ59rMBkRPzibe8emQ==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr21587242wrw.279.1561439586531;
        Mon, 24 Jun 2019 22:13:06 -0700 (PDT)
Received: from localhost.localdomain (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id q20sm28543149wra.36.2019.06.24.22.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:13:06 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 2/7] block, bfq: fix rq_in_driver check in bfq_update_inject_limit
Date:   Tue, 25 Jun 2019 07:12:44 +0200
Message-Id: <20190625051249.39265-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625051249.39265-1-paolo.valente@linaro.org>
References: <20190625051249.39265-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One of the cases where the parameters for injection may be updated is
when there are no more in-flight I/O requests. The number of in-flight
requests is stored in the field bfqd->rq_in_driver of the descriptor
bfqd of the device. So, the controlled condition is
bfqd->rq_in_driver == 0.

Unfortunately, this is wrong because, the instruction that checks this
condition is in the code path that handles the completion of a
request, and, in particular, the instruction is executed before
bfqd->rq_in_driver is decremented in such a code path.

This commit fixes this issue by just replacing 0 with 1 in the
comparison.

Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9bc10198ddff..05041f84b8da 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5481,8 +5481,14 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 	 * total service time, and there seem to be the right
 	 * conditions to do it, or we can lower the last base value
 	 * computed.
+	 *
+	 * NOTE: (bfqd->rq_in_driver == 1) means that there is no I/O
+	 * request in flight, because this function is in the code
+	 * path that handles the completion of a request of bfqq, and,
+	 * in particular, this function is executed before
+	 * bfqd->rq_in_driver is decremented in such a code path.
 	 */
-	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 0) ||
+	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 1) ||
 	    tot_time_ns < bfqq->last_serv_time_ns) {
 		bfqq->last_serv_time_ns = tot_time_ns;
 		/*
-- 
2.20.1

