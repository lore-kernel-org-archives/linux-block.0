Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B24C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 18:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiKHSKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiKHSKv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 13:10:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D250F2C
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 10:10:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c2so14858103plz.11
        for <linux-block@vger.kernel.org>; Tue, 08 Nov 2022 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doefm16lSnPXsJmoD4HfwCSvjxjKuEr5Qsn95UJjEvs=;
        b=iWqJN2aTT85XOWY8kqWAzz6nDxz79xyLSl9V9Go+paQEpkuEzdzQQJ0UrLhmGmD/IB
         mZtuMuH1CGWHSYGAThg7Xm282vcRJlk45sKx07CmtvpsiXsV3YHnrkTXuiu1C4HRwuyR
         Lz0jPfUPhf0DogtOkredrzdlTfzSCGY7HuqBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doefm16lSnPXsJmoD4HfwCSvjxjKuEr5Qsn95UJjEvs=;
        b=T/GmmcrMpunCzF1lvrZhxFneHe+vtNPILzJI/b/phl3prHN7AOlLcfz1V0vtdx4ogF
         J6ZI9u+Q35sCezW7eurad7871JRNFVdeOgAdETHXJEt/KGDUvx4hJADjQsGCTIhCtXYL
         3d1TAhP9n97JNDRxrgoxohL5pCP/GTY4RQgGPiTZcBqV+lRsrKgGjTLMXjYVsu5dsPuH
         LwkUi3po7bK0p64GuKn9sGmjODxOz+eJZxMV0i8c1hfIuPuXxjO9WFKbsJicAVHIM3vB
         lGmxNMloR91aDERRFxxDluVQRbXkAo1BRXgFSJ+4IfnL7BeWxcz4ec+VhLCxeuB2Ajjd
         Nijw==
X-Gm-Message-State: ACrzQf1fEf7b78u6x496aHxAHGEsSz/PVqPclMdJA0rgwVfC2pMuWTnS
        jzxeBXbyZJSVnCjKlaTTgVZK1g==
X-Google-Smtp-Source: AMsMyM68HhKupkJBpyvCvguW+US1Mfr9RRdIRyS8SygEK6NABnZyhxXZkaKBENdkw6H30lJ+neDBGA==
X-Received: by 2002:a17:90a:c592:b0:213:9c65:b78f with SMTP id l18-20020a17090ac59200b002139c65b78fmr57515431pjt.14.1667931048089;
        Tue, 08 Nov 2022 10:10:48 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:21f:525:beef:f928])
        by smtp.gmail.com with ESMTPSA id h3-20020a63df43000000b0046fd180640asm6048754pgj.24.2022.11.08.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:10:47 -0800 (PST)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH 2/2] bfq: ignore oom_bfqq in bfq_check_waker
Date:   Tue,  8 Nov 2022 10:10:30 -0800
Message-Id: <20221108181030.1611703-2-khazhy@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221108181030.1611703-1-khazhy@google.com>
References: <20221103013937.603626-1-khazhy@google.com>
 <20221108181030.1611703-1-khazhy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

oom_bfqq is just a fallback bfqq, so shouldn't be used with waker
detection.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ca04ec868c40..267baf84870f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2135,7 +2135,9 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (!bfqd->last_completed_rq_bfqq ||
 	    bfqd->last_completed_rq_bfqq == bfqq ||
 	    bfq_bfqq_has_short_ttime(bfqq) ||
-	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC)
+	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
+	    bfqd->last_completed_rq_bfqq == &bfqd->oom_bfqq ||
+	    bfqq == &bfqd->oom_bfqq)
 		return;
 
 	/*
-- 
2.38.1.431.g37b22c650d-goog

