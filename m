Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B07C4743C
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518BE613F8
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhFDUCV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:02:21 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:51885 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhFDUCV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:02:21 -0400
Received: by mail-yb1-f201.google.com with SMTP id d6-20020a2568060000b0290535b52251cfso13146594ybc.18
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pgZaEyBtBsTzFRJDI8Jnnog0gKADt58CJnoqBCP+in8=;
        b=uUV7BqO4f+Zte/lFb383yyVYOK3VdXuD3Okwqz87OPd2B5NgUxxaz3ZxJyVyMfYOgY
         9ZE5AgKFLwNVu2wqFDTPs77c+t9PbozjYepuv1BD8/amxLlelOC4N762wZRM75mO3lVR
         +zfxCnxGAMJfSJ+A4aHfeATlTMM2VyItnu3Pr7UzFN7nJKdf26X8LdHY/maLK/99t0zt
         s4kaQhIr6a1YQEvCT11A5fhX0e19eKkFow3v7vcMQe0ZzksnSRmGjvJfxgn55pbpOshX
         84Qx/HB6cA9Sgnjpc1iG4+8J+p/foxRGtsH8ebHDgiauvDmr3kFmyDKFIgNT+WaUMdE9
         BzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pgZaEyBtBsTzFRJDI8Jnnog0gKADt58CJnoqBCP+in8=;
        b=PbbriIjT1iqNTyc/9sDD23VEbsVsO9GEUpFkO6yZGSbU5X90bPCwBU6yix8sHRmJE6
         iOq9z+Ok8XV034T5yeeTdd1kS17gpFy+7ETJtJiM+yVZ4KzZv7fbAhZpEzZIMzTyWjJj
         VkHSRRhzhF4z3Xmxg8B1FCUI2U0UT+ht4IgdQ+EgKfKnZ9AAoZFFuGKi72SQULs7+8gy
         SCXhuxd/H6qdDPh3taKlXrx/vVukFZHJRPi9hVLEDxdoKpCKr6ZJqKz2cLiwLVIYEavF
         ETP+pwreKOPU9ZEUxSKJ96BzRumAjEfWyPu205RVyw3n39b6q1Wn7fjgNh5HZqwDV294
         B2Hw==
X-Gm-Message-State: AOAM530yKGs0ykuGGbzCGZfkNRzQWx9AUDqPj1bA3QZ2gyG+E9DPTt6K
        2NXpC6JswUF8PQpTfxg8hfxYVgfDBoOmT7CB6kkvLD97mdFzV681nolxx0Sv7tmX8u6ZfMASzoJ
        eG76Ue7wsuwJRNMQdJC99N9n1x3hnUWGmiu4u8wx6RtOCOLCkBgFn2kGAe8IkvlHgB3Sk
X-Google-Smtp-Source: ABdhPJy3hxJvjiN/TAAfv2M9Py0zD+C14+X3vu2qbb0PQB99gWO5CrTeHtdS1YqnXjKPQIXY/tSGHL83z8c=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:4d04:: with SMTP id a4mr7276497ybb.311.1622836774525;
 Fri, 04 Jun 2021 12:59:34 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:57 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-8-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 07/10] mmc: handle error from blk_ksm_register()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Handle any error from blk_ksm_register() in the callers. Previously,
the callers ignored the return value because blk_ksm_register() wouldn't
fail as long as the request_queue didn't have integrity support too, but
as this is no longer the case, it's safer for the callers to just handle
the return value appropriately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/mmc/core/crypto.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
index 419a368f8402..cccd8c7d7e7a 100644
--- a/drivers/mmc/core/crypto.c
+++ b/drivers/mmc/core/crypto.c
@@ -21,8 +21,17 @@ void mmc_crypto_set_initial_state(struct mmc_host *host)
 
 void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
 {
-	if (host->caps2 & MMC_CAP2_CRYPTO)
-		blk_ksm_register(&host->ksm, q);
+	if (host->caps2 & MMC_CAP2_CRYPTO) {
+		/*
+		 * This WARN_ON should never trigger since &host->ksm won't be
+		 * "empty" (i.e. will support at least 1 crypto capability), an
+		 * MMC device's request queue doesn't support integrity, and
+		 * it also satisfies all the block layer constraints (i.e.
+		 * supports SG gaps, doesn't have chunk sectors, has a
+		 * sufficiently large supported max_segments per bio)
+		 */
+		WARN_ON(!blk_ksm_register(&host->ksm, q));
+	}
 }
 EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

