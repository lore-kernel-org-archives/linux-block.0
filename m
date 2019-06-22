Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173CC43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C7520862
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 19:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZ8MnRj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfFVTix (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:38:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43246 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFVTiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jun 2019 15:38:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so9698982wru.10
        for <linux-block@vger.kernel.org>; Sat, 22 Jun 2019 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZi5qI5fs3eqak0rmlJ8FUpmcCJ8LSmdIGuMVhAVLqc=;
        b=ZZ8MnRj80C5Q8PPZEVB/DMWrWxScaqai5TQs8N4UM/ee4a0VRO85OJ8qch/iHEneIO
         OGykyug4pKFid/ukR8HKjNV28Q8eePS6f/x5WZ87KJto3UqxHxD2WRhLZA6c8cWQiRsq
         zTLhFLMb7xBRSaQVFboiwGqa8WLB8MLY5XqdTe10uQlEoh/pvSVIvwT2Mdb/zhmvcjpB
         5Aencgy+KkYeJALqPtP6lUM07CqDW0PrB7Q95VKTC2FLmjn3gavu76HAoMbGIaddD0B0
         I5SszlFfpcly97CD9pQXH12ZclYXvVmN7ALS4v+v3UrJZU8HodJ5cnJWKrnVlJfhKk4N
         lXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZi5qI5fs3eqak0rmlJ8FUpmcCJ8LSmdIGuMVhAVLqc=;
        b=r53VCA6WgaqV8W7W4kvFUF2YxtoGxSxwrZAI+Xmjj0nG9YBkklwGUtVJvtAZ5P8qKf
         i8HY9O+6b3JFZmFy93O5E5ss0D8SGRsb9Wy6kK1r1fXdy/SwcL0Pak06e3T33EcJ3gLk
         QxK3FQGymEYVlXXoONVo8Owt/Cq3mxhftb/hWyifsBZ0+KymuT86ZxvAigby0kjoRdp5
         dbdqTRC1A/aErUJkZGZucEuj9U4u+Lh7jpbd82wS5JIYzD7y2ifKONptNHQKanZQdZqo
         qif2IELF83Y776bo/qt9siSc4n7rnOW3/sPqBUz8zpVQmMRnujk96JYvrTgLCgaF7Clf
         DeDg==
X-Gm-Message-State: APjAAAU9y+H9N/jHyakhtHiSfzlc8GN60Nud03GbnJxeyqD+/QDlfE9p
        jnTU+4OrupwpT3JS1/LwhTHiag==
X-Google-Smtp-Source: APXvYqzzdbeQofH+YY1cf2Nis6ROebk4vQk9p+s7zvbPwWyNYlXYSG2Eeh9DxVrfWb1agwXoYdRsXg==
X-Received: by 2002:a05:6000:110:: with SMTP id o16mr23049894wrx.200.1561232330085;
        Sat, 22 Jun 2019 12:38:50 -0700 (PDT)
Received: from localhost.localdomain (88-147-39-13.dyn.eolo.it. [88.147.39.13])
        by smtp.gmail.com with ESMTPSA id h90sm7506441wrh.15.2019.06.22.12.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 12:38:49 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 1/1] block, bfq: fix operator in BFQQ_TOTALLY_SEEKY
Date:   Sat, 22 Jun 2019 21:38:03 +0200
Message-Id: <20190622193803.33044-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622193803.33044-1-paolo.valente@linaro.org>
References: <20190622193803.33044-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By mistake, there is a '&' instead of a '==' in the definition of the
macro BFQQ_TOTALLY_SEEKY. This commit replaces the wrong operator with
the correct one.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f8d430f88d25..f9269ae6da9c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -240,7 +240,7 @@ static struct kmem_cache *bfq_pool;
  * containing only random (seeky) I/O are prevented from being tagged
  * as soft real-time.
  */
-#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history & -1)
+#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history == -1)
 
 /* Min number of samples required to perform peak-rate update */
 #define BFQ_RATE_MIN_SAMPLES	32
-- 
2.20.1

