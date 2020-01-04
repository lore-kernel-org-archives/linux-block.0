Return-Path: <SRS0=MEbK=2Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EEAC2D0C2
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 17:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E2822B48
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 17:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="op/7M5rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgADRnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jan 2020 12:43:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35906 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgADRnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Jan 2020 12:43:11 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so5997378pjb.1
        for <linux-block@vger.kernel.org>; Sat, 04 Jan 2020 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jZIYqat9Vk8RmyHO0YqI0lp82fLcvzGDD4xWJ1k/iR4=;
        b=op/7M5rI392GPcNGx3WX48R4F8QEXUY5NxJ+yJtrXKpHIjOF4noV5etYr9rQ95gIFg
         D6yGKnnNeZJYZAcEQZ8h1nW5jzjmsiwtPJHcyaNwK546FtCX4XUWw9F2oLo62K3wyDQl
         o41dWdigBrnFNu3H7XeYQcoxAAgb/p/tTPYGZnXhunXFjObcjXjYeNBkDbqp1PluxzkM
         D2UeP2l3O4G4mwA1XasHLuPQ8hZ0ARKYKLfDNkI1s66RUBaDKXDOlLaK7lBBqFLdsCiX
         6wq71svNnrPPEBF0i/T/NInId6d3Mz7n8fU7yRRoztuf8GDmDd77FXxLqIUlTs9W+t5K
         npPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jZIYqat9Vk8RmyHO0YqI0lp82fLcvzGDD4xWJ1k/iR4=;
        b=GusItCjxV1EGYcbyK+xx3QPl8riglNiXJJP895k5bDImqRoEvWZ//QxzK7zxjIrAXZ
         IkVplUtWXQ+7BRHuRzW2z79IThhHE7TjDEcNaYBMapD9wk4ROBe8jAl1ivEdbCtk+git
         fREKCtrfqqYRe3khIrrDma/ZTsiWhwI1KjHVly9JELdMcPzn4yW5AEemkMnrjbBWvqGI
         49QGUFer2Y1+nHMDq8zwMTjRMCexIkdU+YjTIdGI3sVAHYiHUcwDYgndPDUuhy/B2GkQ
         OLDTvLsgjqdXS1G+7FYmj8ORyuxR/NMbvg/KaZzBWPrQkA3h/C3/l5WCMDakWSXM6Vr7
         4ExA==
X-Gm-Message-State: APjAAAWIG7W5Rx3stbPntMay3+dsWM5R+xlcnNsMsY0JhrNkAOgCW3fk
        +kiPnaxYltSJGuEZw2os6iDmLr/AItBDgQ==
X-Google-Smtp-Source: APXvYqyXEBFQgvyv97mN9RAUHG3TkNqCyih9TNUuoDHkyzGwbM/K2Gr5Aw43qmyM59zXqGGRTRXrJQ==
X-Received: by 2002:a17:90b:309:: with SMTP id ay9mr32756941pjb.22.1578159791128;
        Sat, 04 Jan 2020 09:43:11 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:c432:634e:2cbb:b7c? ([2605:e000:100e:8c61:c432:634e:2cbb:b7c])
        by smtp.gmail.com with ESMTPSA id e6sm71828165pfh.32.2020.01.04.09.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 09:43:10 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: remove unused mp_bvec_last_segment
Message-ID: <d8642060-8984-f584-6d93-6fcf032d6b6e@kernel.dk>
Date:   Sat, 4 Jan 2020 10:43:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After commit 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod")
this function is unused, remove it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 679a42253170..a81c13ac1972 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -153,26 +153,4 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
-/*
- * Get the last single-page segment from the multi-page bvec and store it
- * in @seg
- */
-static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
-					struct bio_vec *seg)
-{
-	unsigned total = bvec->bv_offset + bvec->bv_len;
-	unsigned last_page = (total - 1) / PAGE_SIZE;
-
-	seg->bv_page = bvec->bv_page + last_page;
-
-	/* the whole segment is inside the last page */
-	if (bvec->bv_offset >= last_page * PAGE_SIZE) {
-		seg->bv_offset = bvec->bv_offset % PAGE_SIZE;
-		seg->bv_len = bvec->bv_len;
-	} else {
-		seg->bv_offset = 0;
-		seg->bv_len = total - last_page * PAGE_SIZE;
-	}
-}
-
 #endif /* __LINUX_BVEC_ITER_H */

-- 
Jens Axboe

