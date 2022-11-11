Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB30C4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 23:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiKKXl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiKKXlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 18:41:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A22C65877
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 15:41:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so5926838pjk.1
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 15:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQhDM+RPGT3h0ZStdNTell0VImm+UlnhHeN2vcaUii8=;
        b=klz3JVtfcvTRwuDP+4+oxgOyHSg2TYq+jTPR514iHObdH7rzSlm/lCzKajMkEhygo+
         goVood1ozNl500eJtvbqvMT6TXroWuEE2D8rSRD7PO9w+ofoi0Uup61y4SBdfWM5QwrX
         D3k0d7NulGLWNvfvc47sYAc6o8LIpvk5siwAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQhDM+RPGT3h0ZStdNTell0VImm+UlnhHeN2vcaUii8=;
        b=VokBjTTbOO/QrSaTABD39XzxBDEnFy/pjL0c/3uoFf7ppexGHEi6RfjVjoeHgA51MP
         0dkjqjUz6/Zzd7oatpHBeoRCpSjCEo/YC0z3EDIbIHa1FvGobSYiMHGQ2hxuvmxU1oSk
         tDaIVBgwqJxgCCiDEmReY6U2OimIvW/0R/QBOTK+NaKQH2UEqcXGnGJC50UaJA6WTjZi
         yF880dHJPfmZwmlKNG+OuaN8owAaFy3MSDr87/PgCoC+RjOwwzU2+FTQ/iOmLWagVMo+
         WQzsLGCSrEsKCyICefhwVz6oKsRWJyANvFCq2W5VuZYN89zN94GSYRsR90Q/z7HDTZT8
         BWxA==
X-Gm-Message-State: ANoB5pkVoyGenNct3QECupSHHRAnpiuhvjRYpaW72R4pEgUfg4Np/RHY
        l6mhAZXirYNXjyzWZrEZmroKaQ==
X-Google-Smtp-Source: AA0mqf5uH4H6XdCUZsV/+8pU6vprIQO8EHckXG3RMlHRGoJuFzZxeejG6iwWk67HuWEuXO+aQubIVg==
X-Received: by 2002:a17:903:3308:b0:186:d89d:f0bc with SMTP id jk8-20020a170903330800b00186d89df0bcmr4696841plb.19.1668210114051;
        Fri, 11 Nov 2022 15:41:54 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:a816:a4bd:3250:5678])
        by smtp.gmail.com with ESMTPSA id q101-20020a17090a1b6e00b002130ad34d24sm5421826pjq.4.2022.11.11.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:41:53 -0800 (PST)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] bfq: use configured slice_idle in bfq_bfqq_is_slow
Date:   Fri, 11 Nov 2022 15:41:48 -0800
Message-Id: <20221111234148.2608273-1-khazhy@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Missing a bfqd->, so we'd only ever use the default value here.

Fixes: ab0e43e9cea0 ("block, bfq: modify the peak-rate estimator")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 267baf84870f..827b878a0266 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4160,7 +4160,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  */
 			*delta_ms = BFQ_MIN_TT / NSEC_PER_MSEC;
 		else /* charge at least one seek */
-			*delta_ms = bfq_slice_idle / NSEC_PER_MSEC;
+			*delta_ms = bfqd->bfq_slice_idle / NSEC_PER_MSEC;
 
 		return slow;
 	}
-- 
2.38.1.431.g37b22c650d-goog

