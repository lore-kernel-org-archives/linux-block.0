Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F3C433E1
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643E620B80
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BtXhurLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGMVsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMVsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 17:48:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7EC061755
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:48:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q74so15203861iod.1
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1SM9CxZIwoG7q3bQpCY4Q6lVy8hcZgrKgbqX4bnB+F0=;
        b=BtXhurLNG+tWq7kyFdZltfqvEVRZUXlMj9vuoZUOnaCDVn19VtnMVmODlXP5BMOzTl
         kgHwWgmpM2G5gC7q6LT3wO5lrFb+rwIGiZOkelFXF0EMzwIkOaN81zXSmishgXQPtJYs
         tKiTN1UROZapidP5uweeEGUsMbvXImqLMRweOhWlNSAlbGNGMnMUCysmQjEvD3O6hmyT
         5zt5IpAQ7DrnkwjXENRh/VSCZYMgE1C8LiDFED43HkLJBBxHuz8sLWjR8PWvR3XTwGq2
         gmHZazA97ubQK50J1lyJkWGIr59H4q23iA5yOW7sYYlVoTGrKt5G18Bp69UTlQkbEv0O
         ISxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1SM9CxZIwoG7q3bQpCY4Q6lVy8hcZgrKgbqX4bnB+F0=;
        b=IiqxZC0emp/UJE9m81T15H+gMKivIMPYkSiyQuyN2Qfdjw8N2lc4VlXaw1lkBfNKwN
         78fKjCKe4bcMxTLhUbf0GaOdBUpXBSAB/ZmeiV2OhY75ELe+bRd/JS2ubTo18Vv1SBvz
         905RPbE0fG/Fe7vrZqm+59guhM2YvQ85nrcFpdb98qtMfhDgUpx0BkjDEBLaRFS2Z4NK
         FTt8IiEYVg96+2e3JoOcIMsbtFfdtp2BKo4NppFLMwcZMjwCADMMcFkJVlTmbVci2dph
         CEFTzgRc6NbrWi/1WOIv0BA2b+pKMxZaVPLxNZenNDq6FlXOxI554WmjTQgNh+vHt1Hf
         1QCg==
X-Gm-Message-State: AOAM5304A/zFmT64tGFmT1sJkI+9Dyal56xpMgEYTPQtlUzSMSHHhI3j
        rI6LgSsRUVEY6/4nGdCRGq8HWcCaxCqRSQ==
X-Google-Smtp-Source: ABdhPJw1f0f2aaaTLu6p5E5I1TXch3VL2En1Z9hwEsKm1ZnfI8kqhX1W7aiumG5jeDiFUwIp4HchZQ==
X-Received: by 2002:a05:6638:12d2:: with SMTP id v18mr2482870jas.4.1594676898268;
        Mon, 13 Jul 2020 14:48:18 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r6sm8972852iln.77.2020.07.13.14.48.17
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 14:48:17 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: relax jiffies rounding for timeouts
Message-ID: <b4193146-c246-c2f9-21f5-f185979c5b26@kernel.dk>
Date:   Mon, 13 Jul 2020 15:48:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In doing high IOPS testing, blk-mq is generally pretty well optimized.
There are a few things that stuck out as using more CPU than what is
really warranted, and one thing is the round_jiffies_up() that we do
twice for each request. That accounts for about 0.8% of the CPU in
my testing.

We can make this cheaper by avoiding an integer division, by just adding
a rough HZ mask that we can AND with instead. The timeouts are only on a
second granularity already, we don't have to be that accurate here and
this patch barely changes that. All we care about is nice grouping.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 3a1ac6434758..34c4d50d1858 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -88,11 +88,19 @@ void blk_abort_request(struct request *req)
 }
 EXPORT_SYMBOL_GPL(blk_abort_request);
 
+/*
+ * Just a rough estimate, we don't care about specific values for timeouts.
+ */
+static inline unsigned long blk_round_jiffies(unsigned long j)
+{
+	return (j + CONFIG_HZ_ROUGH_MASK) + 1;
+}
+
 unsigned long blk_rq_timeout(unsigned long timeout)
 {
 	unsigned long maxt;
 
-	maxt = round_jiffies_up(jiffies + BLK_MAX_TIMEOUT);
+	maxt = blk_round_jiffies(jiffies + BLK_MAX_TIMEOUT);
 	if (time_after(timeout, maxt))
 		timeout = maxt;
 
@@ -129,7 +137,7 @@ void blk_add_timer(struct request *req)
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(expiry));
+	expiry = blk_rq_timeout(blk_round_jiffies(expiry));
 
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
index 38ef6d06888e..919f3029f5ee 100644
--- a/kernel/Kconfig.hz
+++ b/kernel/Kconfig.hz
@@ -55,5 +55,11 @@ config HZ
 	default 300 if HZ_300
 	default 1000 if HZ_1000
 
+config HZ_ROUGH_MASK
+	int
+	default 127 if HZ_100
+	default 255 if HZ_250 || HZ_300
+	default 1023 if HZ_1000
+
 config SCHED_HRTICK
 	def_bool HIGH_RES_TIMERS

-- 
Jens Axboe

