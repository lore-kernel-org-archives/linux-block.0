Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54245C433FE
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F4460C4B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhJLSTz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJLSTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:52 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53321C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y17so11947ilb.9
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWWbxxl1nqVuRPyRl4TrQ64PvIRN1ySCGLzomh2MwOY=;
        b=1toiFYGSPZD5+BDx2LJqqAoDP/et5H3GL7u3PweHmxR9NWV75Cjnbmt+o2mlNbL3z+
         LOxLbnaFcNQolgt+c2tBw6Bbv2mSgVI/36lUGwUWIW+G/md3R6awGbv53d3XGxApP0O0
         ASHPPp674rSEk5nmD/WfJw6seHbKHj5e4Y1o2o/AHccUtKQpMEhw7XX7fXu4s4IUaQTe
         4uHNr43L0qAxUZLn18wf03B+PHXMLfYvYS9YIaVdpzfEn56jkaZnieWWVWpMmDIHqUmM
         HYo/fA71gkHF8Gp1JmFDy9Ir11ds7Q2eTo4BnDCk/MHx+tiAD0eec/MK/y23LO1I3baE
         ebVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWWbxxl1nqVuRPyRl4TrQ64PvIRN1ySCGLzomh2MwOY=;
        b=bOfZZ60F0mqNVT5396ZPW0m+ozI8h/2MxGlkgp7Wydiu+zphOVEVPPcZ2ox3YyfqTX
         wuQW7Q6/o+SPjvkAYWZn5pmeiqR7FkJTzbSr5vkUicuIFHfvjoNujkWO0rv/MT6ssBWR
         EgKhR3ffVed98LLqljiZRLPP6mu0Jmabf1x9J9BX/3xwlUHbD8F1gaEyyeNWQ015Qpxo
         bCQa7rFwjYFQtse70w0v4YeXGtM8QcDKdM4OX+MR73YkVW2VsP5JxW5uWHcoTZH36HMz
         tCcxcK59UE50fB3z/afaWcJY2UvpPUvy7h47KFUmEdiMOgckkTxyckHqJBuaI7szacm1
         KaaA==
X-Gm-Message-State: AOAM531WB5q4q3430bGqrMuZTvWPoYNeyga7+QVlLtI+b9+yp+9ua3EI
        +ENp4Pas7nS8NWrx1B2e5wWcQyiayPfZrQ==
X-Google-Smtp-Source: ABdhPJwRdb84J3XEqgxDMhSMFfN/MTKY/wPDxsOOOi0DpS+oyqOqxvcz/ZbTvy2MsI63zB+UkV0Rng==
X-Received: by 2002:a05:6e02:1486:: with SMTP id n6mr25703510ilk.195.1634062667111;
        Tue, 12 Oct 2021 11:17:47 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/9] sbitmap: test bit before calling test_and_set_bit()
Date:   Tue, 12 Oct 2021 12:17:36 -0600
Message-Id: <20211012181742.672391-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
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

