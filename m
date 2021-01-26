Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C35C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F842064C
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAZV4t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:56:49 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:43100 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbhAZEqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 23:46:08 -0500
Received: by mail-pg1-f175.google.com with SMTP id n10so10752995pgl.10
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 20:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQNfmGEjRYMzkKRmvMlftFyPH0UTLINJY80X188BtSQ=;
        b=nNUPo2iIOuzNwbMr1dO0xlgQ11n8GoVc0UeOYPrw/BIpvkoL1mhtpSmlntQ1LvWiar
         QeXbUIGuGwN6qkc8ewn5Qo3v7Zwuql8unV7dm9Qbbe+Ks/Flu5kUVvmGXKBDI1HFdCKD
         G9n5k0GyoIAU5359TjjLkh0DvyEyb2p9xFUAFj7gK4NTKHYgI+gYq5r3jknPHVEwb/cF
         izP2il21cq3hdWPvYG9MiXCVPZiydMu1L75yHGPYcTngLgq/uc9MLsySlZEXbz4JIEU4
         0Gsbxey1S1/mEGoylorS8YDUNxeGdMW6DitZkZ+7UjFpFqKlVE9swSYde9SEB54HBRqO
         qiFA==
X-Gm-Message-State: AOAM533OmzC1nC1moByj3u9IZss9Omtqgwl2E2oL3FVSjj5sQrNXk9o5
        dpaZa/2vosdw4jsUTfDron2BnLYUxYg=
X-Google-Smtp-Source: ABdhPJyZ2Hu20S9zbJJMfelg0zkgmrXpgWMMQztcdapGEtehSOchYt291V0aYEiAB3RaT9RH/wKSCQ==
X-Received: by 2002:a63:5705:: with SMTP id l5mr3973559pgb.415.1611636328180;
        Mon, 25 Jan 2021 20:45:28 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:f18a:1f6a:44e7:7404])
        by smtp.gmail.com with ESMTPSA id m1sm866857pjz.16.2021.01.25.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:45:27 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 1/3] tests/block/030: Make this test less noisy
Date:   Mon, 25 Jan 2021 20:45:17 -0800
Message-Id: <20210126044519.6366-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126044519.6366-1-bvanassche@acm.org>
References: <20210126044519.6366-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since test block/030 injects blk_mq_realloc_hw_ctxs() failures, it is
expected that writes into the 'submit_queues' attribute can fail. Send
the 'nproc: write error: Cannot allocate memory' failures to $FULL instead
of stderr. See also commit a668c61064f2 ("Add a test that triggers the
blk_mq_realloc_hw_ctxs() error path").

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/block/030 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/030 b/tests/block/030
index 84302c109c0c..d2e528697873 100755
--- a/tests/block/030
+++ b/tests/block/030
@@ -42,7 +42,7 @@ test() {
 	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
 		for ((i = 0; i < 100; i++)); do
 			echo 1 > $sq
-			nproc > $sq
+			{ nproc > $sq; } >>"$FULL" 2>&1
 		done
 	else
 		SKIP_REASON="Skipping test because $sq cannot be modified"
