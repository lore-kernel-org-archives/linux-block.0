Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E173C4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AAE6112D
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhJMQ40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbhJMQ40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:26 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79E1C061749
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:22 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h10so426257ilq.3
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWWbxxl1nqVuRPyRl4TrQ64PvIRN1ySCGLzomh2MwOY=;
        b=CflgU2lNxFISUs7Wvc/XFgDqwIo5d6uA52jlkovsmf2d3JZ4uAkoCdFnq8suCN0ic/
         Oh0lXdUwWq0YKA/gQES0XUq3P81BmEdIDQpxFiRGjkKitiUtafjm8ksVrehZby7DWjY0
         GW1hrVL+KIuyhCiKIcso7Drlp/6KtYHYEKCbvVaI+EEFs74aO3ihzw9fXzXMhosEJ8wH
         rLu3xh9661EdHfkcy+hcH0GoPhIzUUSWT2+kjwxCmSFqk7DRjX3s4WBXSkNJoy0h8ZIW
         iEsKCx/9EGVZ7rSWjS/IjGPIMp8L0ih1aMF6iR1gN87fVQbd6ts7AZWTn06ZWodaj/5c
         8Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWWbxxl1nqVuRPyRl4TrQ64PvIRN1ySCGLzomh2MwOY=;
        b=pi7fbkf2Sm/BJXrCuiIlggDwl1KuTImIlYoSdshnw0AxXljIsstjV9jXIZzaPZ2IqP
         hemOX5j8PphXfzbCtB85c2fDLpRf5dKxsjp6VzMsvZzYs0gH0fnuEEjC/mGXn2awsXVU
         vsLRnPR/dJVov9fRiNM02B4uamucrE/AJTnARiTtqTKF2fudPKCxh5dR9ffT9dOCCSUM
         FHrCcozs84dMX4wXuRrZyFaA4nepJebKMJUoG6hRZXgFw96zUxQeVAuAzh3rhg1DyXkA
         1v/rqt6MOeVimlXm5qKN+Tdd1Yoqc3X99LfSIbc/GelzXDcTohZ+M1gKJR1YzLemZNoI
         zilw==
X-Gm-Message-State: AOAM533RMka8m5eg1hQuYo+hYjFxEHr2my/cVuTcqfFX+BCENIYcY8Ou
        LFYKpuk8JKzHZIEYWOU6cJN2rY+xsltaKg==
X-Google-Smtp-Source: ABdhPJz0XpqF3ukDwj/1tNTioMwvr6SBUJaon891lNXBWnGTFI6QRM5p1x/cay79NvB7a/TEdCoywA==
X-Received: by 2002:a05:6e02:1569:: with SMTP id k9mr89672ilu.317.1634144062169;
        Wed, 13 Oct 2021 09:54:22 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/9] sbitmap: test bit before calling test_and_set_bit()
Date:   Wed, 13 Oct 2021 10:54:11 -0600
Message-Id: <20211013165416.985696-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we come across bits that are already set, then it's quicker to test
that first and gate the test_and_set_bit() operation on the result of
the bit test.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/sbitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index c6e2f1f2c4d2..11b244a8d00f 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -166,7 +166,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			return -1;
 		}
 
-		if (!test_and_set_bit_lock(nr, word))
+		if (!test_bit(nr, word) && !test_and_set_bit_lock(nr, word))
 			break;
 
 		hint = nr + 1;
-- 
2.33.0

