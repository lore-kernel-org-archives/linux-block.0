Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5745C61DB3
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 17:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjAIRwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbjAIRvi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 12:51:38 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7D271B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 09:47:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i1so1727569ilu.8
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7LcyydZFhGrE/n8mOpMLasvDg3mRxcl0EglIxC2lYc=;
        b=OIrc91n5OS9Q+wJn8ye+ZBD4251Lm2dGGEC6vqK4HstGQJfdPxjtBoromNFHFwud1f
         oGA6XHmHL/uu6uD4WsBd35OeelsDe/VWWMyPw3dl2h6OwZECQZfu634/BYTDxefnbj/0
         SeTzSYbo72sxzEJ7CukS0nXprIHEcfwDvW4oqRKR7U6jD804QdLnF7xRC5FQ6bZyPd+H
         xeQdHJ+upyEvTg65K/KTxl1WtKIRbvw4VoKm5C3uLjPrYKfsTeA30+MgannAoDZYLFV+
         4H7iZo8CQJB82Au4SPKco4UVIGyxDCzFDDIksJHcRCljWX2vuCO1IeAs22/15bZAHkjg
         Rurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7LcyydZFhGrE/n8mOpMLasvDg3mRxcl0EglIxC2lYc=;
        b=jpAdeDe9idmg5SilVKJArQQyN4QgJjd48FVApRKIUEdJ57N2cSANycS4u1SJ5cujf9
         w5bFPn79M2r6bgUDs/n7i+7jIsXC+DHw7fbkmmX3DC9W+S4shLVje/m47MzHm93I4ou6
         dTQioQA7VPrBihqz77VMxqlh0oZ3wLpv8YTCGtuUzrH5rik7kUuSz/EJc/RtlFPAbxwn
         74dze5cYz3Vt+FhURDNW/xhx8Q5c9hb+RzL6Wh1Z2hpXydTtz7rQ5G8sjZ8sI/cMvQvC
         cYprKdpI0pM+n4DFhLm+EY2wrCqY8UUjtrWp2QiLQEk4/aF+yBPSy5sWF1deuJaf3HSL
         TUcQ==
X-Gm-Message-State: AFqh2kpS5u/+XXsQpfRDhJecUilKvUVCBobLN1oXM+/+uXX9yPwo0o1b
        PYTP6gt3jrmrOFCNKQ7AQ2TrHyu8S6v3LCvV
X-Google-Smtp-Source: AMrXdXsGChJB94TPu2kUhyIR5q2a0Bbwec4Xdi+exwxuAPplf2MJjclHQpx9syS/7iH0a1JaZGGRjg==
X-Received: by 2002:a92:c151:0:b0:303:9c30:7eff with SMTP id b17-20020a92c151000000b003039c307effmr9960918ilh.2.1673286472361;
        Mon, 09 Jan 2023 09:47:52 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w17-20020a92ad11000000b0030c44ed932asm2833213ilh.29.2023.01.09.09.47.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 09:47:52 -0800 (PST)
Message-ID: <da48fbb7-ec78-f382-919e-cdf23fa200db@kernel.dk>
Date:   Mon, 9 Jan 2023 10:47:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: add a BUILD_BUG_ON() for adding more bio flags than we
 have space
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have BIO_FLAG_LAST in the enum for bio specific flags, but it's
not used to check that we're not exceeding the size of them. Add
such a check.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/bio.c b/block/bio.c
index 5f96fcae3f75..633d1a2af785 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1785,6 +1785,8 @@ static int __init init_bio(void)
 {
 	int i;
 
+	BUILD_BUG_ON(BIO_FLAG_LAST > 8 * sizeof_field(struct bio, bi_flags));
+
 	bio_integrity_init();
 
 	for (i = 0; i < ARRAY_SIZE(bvec_slabs); i++) {

-- 
Jens Axboe

