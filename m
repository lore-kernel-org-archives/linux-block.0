Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7CFC48BE9
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7CC20679
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUz3pIK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfFXTlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:41:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38224 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfFXTlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 15:41:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so510914wmj.3
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFdPqD3TBf44a7c2W86e+D5nf2bSFpU6DQYW7s1Xtyc=;
        b=jUz3pIK7GFLYzyZZC1NLM+qmBubKD0cR/ksXweLYxKtD6meQ2jRbJtvdVHenpdSe5h
         SxEErNwcmnsz62OBV3TPzqQd+x0zxqhF1UFlCDFLJPFXmVMshLuI7zYRWEPue7bSyXGg
         CC2Zl+gZjmxDeP3gVJMd/Xfc22sMsFvft1DcMuJluj3TVPmmq/EN3xDeN8ZbW8i7gUZz
         IkcWUe82yllfLovacQzbIin5axowhDCoF5fyMhSfXUVg+88PQsEnavEGi92WVc/Y4kaD
         5SlZSuExJuMXfFqLR+xYOqqUB/wcKjUdsoAoHU0pYRkqmXUgXg1ZCggRbyTgTmGKrri4
         5f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFdPqD3TBf44a7c2W86e+D5nf2bSFpU6DQYW7s1Xtyc=;
        b=SkBe612aQpXNVm21aaS/c4kgRgz35GlUX5/iWub9P1ppaBRV7oZcFk7xG+fZpQfYvn
         Jj8IY7pUaKLRV6N0hA5oUzjoumegZqPcyfJdJSNM3Jla8oC5rZKfJ2l+shMzCydHe4AQ
         5D4KtPoGlbtdcRKmjSXXdt+qBhvbvDF3KRPurmFafONevqAS8fnsFiJwQ5xps3TcPGeo
         yJpA77/PnLJG6yN4nQmjmQRa4meSZdCoy/j6fSZXbwAxNKAQRkqlPn1PDleeGv7NhR5o
         Jyvdfc9oOhG5S9qB+JWbpwMP1xj0NCSBzUhOpigzC08sxG4nwv2alvar+d+o8Gnki8zR
         DGCQ==
X-Gm-Message-State: APjAAAWsxv1MqMpvGhttqwpmc6r94Kv3049uEM0/bsw5V2//qRmrJw/8
        b8ecxbwjh+QE1ZygygfiUa3t6w==
X-Google-Smtp-Source: APXvYqw5BDG/KxnETCwgHcWNNFORB2nJcwBnAbM0CYqBtkprJrxohc9+YIkIZCm2UUlrcx7NuoUwbw==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr18108832wmi.50.1561405269151;
        Mon, 24 Jun 2019 12:41:09 -0700 (PDT)
Received: from localhost.localdomain (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id q25sm17615395wrc.68.2019.06.24.12.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:41:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 3/7] block, bfq: update base request service times when possible
Date:   Mon, 24 Jun 2019 21:40:38 +0200
Message-Id: <20190624194042.38747-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624194042.38747-1-paolo.valente@linaro.org>
References: <20190624194042.38747-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I/O injection gets reduced if it increases the request service times
of the victim queue beyond a certain threshold.  The threshold, in its
turn, is computed as a function of the base service time enjoyed by
the queue when it undergoes no injection.

As a consequence, for injection to work properly, the above base value
has to be accurate. In this respect, such a value may vary over
time. For example, it varies if the size or the spatial locality of
the I/O requests in the queue change. It is then important to update
this value whenever possible. This commit performs this update.

Tested-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 05041f84b8da..62442083b147 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5496,7 +5496,18 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 		 * start trying injection.
 		 */
 		bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
-	}
+	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
+		/*
+		 * No I/O injected and no request still in service in
+		 * the drive: these are the exact conditions for
+		 * computing the base value of the total service time
+		 * for bfqq. So let's update this value, because it is
+		 * rather variable. For example, it varies if the size
+		 * or the spatial locality of the I/O requests in bfqq
+		 * change.
+		 */
+		bfqq->last_serv_time_ns = tot_time_ns;
+
 
 	/* update complete, not waiting for any request completion any longer */
 	bfqd->waited_rq = NULL;
-- 
2.20.1

