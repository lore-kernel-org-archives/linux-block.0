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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF1DC433E3
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9473761A45
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCYV1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCYV1Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:24 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42080C061761
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id r18so5023809pfc.17
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VeqQSH4BAMfamuR0TIVDu2q/mURjw8ysmtF95aAYc5g=;
        b=iIB/QotjWVxSDIpkUJeHf+48IT7EqDCP7QaLJh6PM3Hv3F8UcFt/7c1mQhoByWDg5w
         B2UHGD+Tl9Jx/foLXk869SWCL5TI84wfOoQSFaRrWF8nQOV3EMqGDt+FmZ/tEnUhSPDn
         dgB6JKaUs1NSogJqeqWeQkD6m8ftwSRvlxURDFlo1NDdyLDvyE5DXiI5J53iDrAptWQS
         OV/7OVzexzU9nL3RGuwfSIuKvdbmnYl+8c2s29BlAUm6jjERXmfoRskDwEwnjldkUvM1
         2w/0N6UamJghZiBZyvA5CCsmECbqiSwczQZsiXPOHg+gUaSDmxCwJsP2uznjv7L2nkS5
         UwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VeqQSH4BAMfamuR0TIVDu2q/mURjw8ysmtF95aAYc5g=;
        b=T1qnHzPuKM1TsMcbJsrPp6zr/Q0rUJowXC/25+5xPMHx2tmNIuHA1GgtBz47wYaG/u
         7fZoj4FLMO6P5f/LS7KDUBmq38p3XAZIv4UhQbw2k//RcKX/SDt/lMra9WoBxROuNHVF
         AR5FMsFkR9T9OAvnE1YJXIZ0kQkNLHt2SSAwPZFb2Ua4/lsexmBQ0le2a24z+43XEEDs
         PeVvam9t4wEwlA5lbOflwbOLRSBV/rPwJdEKSz9JKGYWphclFgxWyd4mMjyz7vqyl5aj
         7LDNtJpI6sz1F36wmswXh8RVuVhXybzy7zJbEQbWZXkOBqpEYGnL/jmvTxvMxbQo+Qp4
         sgHg==
X-Gm-Message-State: AOAM531VfSz7bhD74KrYj9DVLU06YVllzDTKTGXJiut4GGFGoMQmIioQ
        tNQ3PF1gj5cv3xJ4LdXKcufZhDMFVGGPyftk+FG2qAzEuqWM0uUPHCyLMcALnjQhZAMj+R+xN2u
        VhuXCZsZQfhw9V8l/yodRUrr4kozcy1xmoB0exYS/AIoKQoz8V4gyksdUJiFMxKWyXwmi
X-Google-Smtp-Source: ABdhPJx8aHEdvXlb3UgvsOScmw6EfBXxYY/yM5TkRR0f5jYmkvclrzvTBWVREz+Lt00OU3rQNPW32DXzrfk=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a63:c84a:: with SMTP id l10mr9146122pgi.159.1616707642540;
 Thu, 25 Mar 2021 14:27:22 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:09 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-9-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 8/8] block: add WARN() in bio_split() for sector alignment
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The number of sectors passed to bio_split() should be aligned to
bio_required_sector_alignment(). All callers (other than bounce.c) have
been updated to ensure this, so add a WARN() if the number of sectors is
not aligned. (bounce.c was not updated since it's legacy code that
won't interact with inline encryption).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 26b7f721cda8..cb348f134a15 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1458,6 +1458,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
+	WARN_ON(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));
 
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-- 
2.31.0.291.g576ba9dcdaf-goog

