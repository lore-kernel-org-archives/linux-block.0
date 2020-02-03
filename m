Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ADEC35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F5120661
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGk1szuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgBCKlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52691 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgBCKlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 05:41:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so15256823wmc.2
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9M/C89B+RPb3s/AEZzJiX5HrsMKA5pqQCZ+d/xtiimQ=;
        b=HGk1szuNHr8Rpi6K6AEB+UGzUz7mmYy5IVSIeYVQhByZzdXdbUVfmZOZXNPt+6FaDn
         9YBerNBayTRTP2fjJYfNbtSO6+LlPgjwjOIoPMubtwUGpgPGgQUiQYBBSfZRzhrcHCdO
         1JVKDUJ1QWcbscUWrS8iB06shr7HP+gyNZcHpdeRLm65/PTor0LwZ0YzW5KmgOMjfs/i
         scaIjBh4sXpXhScIiFB/DEGdD47H9x/n5w/s5dq6+znXOb7O1TVkhhehsjOkmbz1aIBR
         9crljBQOXioT5+DnOKMl5A2EdaWHjOrNys/mlU9TOGFuYovwWoVTCy5mkWfzsRSw7a2x
         80QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9M/C89B+RPb3s/AEZzJiX5HrsMKA5pqQCZ+d/xtiimQ=;
        b=cIe9NA/6XgrtgMTXeUHte2Kh6SC7ZD+c9u0XTUtMDR6ebm9cWUMAaWYosbioyQKHqE
         LcWgKWiQpqVytoNVkf3VFlWOdEq+Dnz0TvGjwTKARevXytOfdjPfftZtaYIH5mfvvED+
         aS6ddwrqQSumXzQLv1LyhCwxmphpf0enHhMgP8yRIaL5k/IdgwKPfqnimpqpuQMgb3xp
         sCYGzKEXfE++NEctV3o1b1dloap8CuhdlCmXtLLIC1Rxyfq9QQHZIsuvrooQwd+ZvooY
         Y2K1KLAun+bRdwKAXu2yqVF7moLreFTE2jstLgkdsqdb2lhPKQdLol0NthYinr7iY0w+
         +y9g==
X-Gm-Message-State: APjAAAUHMzys1GLt4xKf05VnInGNMbwRGEmkAbDyM3KIHMwMfzQmJYAC
        M1rHq7Kl8bOAZ79r9pWjkYUwBA==
X-Google-Smtp-Source: APXvYqzbBaAEE1ZuOQv8l5wyfJ6burueShpn1fgakonYTcdxiPDi2XpkDNjDG+Jz74vpXyUSnQ8E/g==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr29184394wmm.145.1580726484032;
        Mon, 03 Feb 2020 02:41:24 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:23 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 7/7] block, bfq: clarify the goal of bfq_split_bfqq()
Date:   Mon,  3 Feb 2020 11:41:00 +0100
Message-Id: <20200203104100.16965-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The exact, general goal of the function bfq_split_bfqq() is not that
apparent. Add a comment to make it clear.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fff76c920968..8c436abfaf14 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5979,6 +5979,8 @@ static void bfq_finish_requeue_request(struct request *rq)
 }
 
 /*
+ * Removes the association between the current task and bfqq, assuming
+ * that bic points to the bfq iocontext of the task.
  * Returns NULL if a new bfqq should be allocated, or the old bfqq if this
  * was the last process referring to that bfqq.
  */
-- 
2.20.1

