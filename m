Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C2C4332F
	for <linux-block@archiver.kernel.org>; Fri, 16 Dec 2022 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiLPPWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiLPPWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2022 10:22:13 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE24532E9
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2022 07:22:12 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i25so1386188ila.8
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2022 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3YgMmmLB/EnAStLz/AVqhHL9YZF83ZcXULr2yxPrfA=;
        b=ahPEulgZax6VcxzriW5ZdYzTrQY+X7bQx2xpc/GHFdhUZDoQhYHtiTU+hL7HbZnt+l
         QZV0sEjtvT/zdhsPF+qo8dn3CdgktamXvcUYK4TXMZoX23jd0T+aySBzd+ek0BT5xpyG
         s+gm+7yNYoP8sOWSXzGC+AxpnNTO9Bv0DVFgBPL7cpb+VsaujyC8Rq7GMPk9M5UeqMRH
         tRSQ6dGMi6P1YtnHA+pOw1P0dMbZkz60cM+gA5tF3HR3G9p+wVh3jY3/zOHrGP5JgbcZ
         SaX6t3LjowrndEKYkt5fTUPrSbfjm/bpecz+LcjiwhQU5w+O3F6WCeTd1BK9GQqZVFsZ
         BEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3YgMmmLB/EnAStLz/AVqhHL9YZF83ZcXULr2yxPrfA=;
        b=pkzvDrDj1tYWNOymdiFCX3tqdWDN1RGfa9akZOQdVkdPoTgznULcDmFcsepS8rKXrG
         JQFppWHMyNoDnYJSRWw5WnZY6sRArd0tdJzdDJogoWSgftRbVKwgoFY4s/OmrfBVwrO1
         KrDw5Agb8i/p5W3LHsJRO/gg4NKIEvUHLz1n5Z3yT1eHgLDOsblRysGFl101Yrd9mKp0
         lF9Ud0qgkuWCGjdKQT3u4UTcmRSNzTcv4QorzX86hRBfHxrozG1UhXnPEIX7KbZP5j/r
         SqNY2E+liYb4RBkuEDu77s0cDjsDvi0T1ALGH8DsXUG00I5UUC44yid7zCJXP37paNy5
         eNtA==
X-Gm-Message-State: ANoB5plByeRLqSP7EorKeH5MAn7hKc+6BDvdl8f13qGmlkvdvhb9kAgk
        gYz2eLEaymeLTwSZ5Yzq3QkHMm6b6JC8VA57Rys=
X-Google-Smtp-Source: AA0mqf7vnWQIMX/grqSwdDpKhlrphxhkmX1U7VUwfMGG6tEXI/ea0dmA2C/odfHxH3JALJ3unEpVIA==
X-Received: by 2002:a05:6e02:1072:b0:303:66a5:c50 with SMTP id q18-20020a056e02107200b0030366a50c50mr4442278ilj.2.1671204131453;
        Fri, 16 Dec 2022 07:22:11 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z11-20020a92d6cb000000b00302a772730esm729784ilp.54.2022.12.16.07.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:22:10 -0800 (PST)
Message-ID: <ca1e0bf6-b7fa-5505-3682-2cd122b984be@kernel.dk>
Date:   Fri, 16 Dec 2022 08:22:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: don't clear REQ_ALLOC_CACHE for non-polled requests
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit:

b99182c501c3 ("bio: add pcpu caching for non-polling bio_put")

we support bio caching for IRQ based IO as well, hence there's no need
to manually clear REQ_ALLOC_CACHE if we disable polling on a request.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b231a665682a..22078a28d7cb 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -782,8 +782,7 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 
 static inline void bio_clear_polled(struct bio *bio)
 {
-	/* can't support alloc cache if we turn off polling */
-	bio->bi_opf &= ~(REQ_POLLED | REQ_ALLOC_CACHE);
+	bio->bi_opf &= ~REQ_POLLED;
 }
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,

-- 
Jens Axboe

