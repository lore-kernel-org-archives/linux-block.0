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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35BC433E6
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB78A23B2F
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbhANPsZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbhANPsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:24 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A2C061798
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l22so4024052pgc.15
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=33jUdHhsrV2CapOFoRvS5dOYYlCXOaJVM4qnyxmNbLU=;
        b=apKtoFYknu3DIcXShFWPosdE+beqxNL3vnxUidGPnAu4PB+7WBe23CsevJNH8B3nzC
         YeS2VuQUPAqWD+CAbk1eZ91bQ79KccJuqim4mCQfmOlUOqnaeiYbOe7XzjaHBPE8VehE
         HcMYkND85iXYvGQdWN/rM6gAG9jW+Zn2gXwASSuE/bPBBgDSL0pEm9cH8za/aw0/IY3P
         pDo++HqA3k0shLmHIO8lFLb4Q4rfwMAchSbZjbksJe7/9mwTnMS5PG6XCZgeNvno1tKj
         zRvQSJJdOh/c341ec5fFf6wd4tAP50OKMskZzM6zhRQfeKD1jb9g3r/gZLNiedP2ynZ8
         Kk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=33jUdHhsrV2CapOFoRvS5dOYYlCXOaJVM4qnyxmNbLU=;
        b=elexyGfH7G+8rhjb1N9dStMpSQ68WW4I4gyrVkLJMYJ/Ebkk0/WRo9isu6MAaE7N12
         XIeaadGOP7/VO2Wl7c2QgNxw4MlY3pnr7h5bTEWIYCjSWYouM5lBOrihwnHbsEFzWdZ7
         Cc1IH4V9VcEmNMqsCnyf8+FZuLdfubf1fBoDhqqOLf0qDP6W77tGrftm5T1fYxQ6lJZI
         imyRdrkoU8yAKnMzQfHxU0gMLmHTH1tLaqu6ee53RMsYDW88vKgVcorOqsDlhOeF9x8C
         RYTAXfajsfyjwOvzlTYQCWiejS73CUNs0WtRTVaCucTcIrXqhDFafK02U9awdRETIg/v
         Psig==
X-Gm-Message-State: AOAM532NQ5Hlf4qW/QDAjNk7kwPH0Qcsgkj6+SC50o90+pXs7srlgUzU
        xryfb0AjvOcCpEw7DBWGqdb6x32+WRHmbEmpchGtvKQ1nxz01vme8k8zudAbjwmFCAJ/VSD/Ywt
        2ghlCpfYOh2HfGoWbZRU+NdHC1AP4c2nPplC3/nXi5deO/fRzIENyNTy/MkelEkqMiESE
X-Google-Smtp-Source: ABdhPJyg3FWwzuF2MutPmTEmq0PgduUD2kKumkbOPbt3K4Us/J6vOeb3DnbLSRWjxovCLHKsVQ7RE4hvH+A=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:903:2292:b029:de:45c0:7005 with SMTP id
 b18-20020a1709032292b02900de45c07005mr5349837plh.75.1610639255488; Thu, 14
 Jan 2021 07:47:35 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:19 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-4-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 3/7] block: respect blk_crypto_bio_sectors_alignment() in bounce.c
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make __blk_queue_bounce respect blk_crypto_bio_sectors_alignment()
when calling bio_split().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bounce.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bounce.c b/block/bounce.c
index d3f51acd6e3b..7800e2a5a0f8 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -305,6 +305,9 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	if (!bounce)
 		return;
 
+	sectors = round_down(sectors,
+			     blk_crypto_bio_sectors_alignment(*bio_orig));
+
 	if (!passthrough && sectors < bio_sectors(*bio_orig)) {
 		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
 		bio_chain(bio, *bio_orig);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

