Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75CCC64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8553D22247
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUA8GKj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbgLAQHx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 11:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgLAQHw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 11:07:52 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C91C0613CF
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 08:07:12 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g19so1050514qvy.2
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HDs+wOaN7N1oAjDOJXdaryAzxarmO9q6Cf3R5Ld01fE=;
        b=BUA8GKj6x8n3M0CCI7kYrxBTWsfcvKOSnb+N5FvYJ88U8X5bdjyKw6nSUXwmsESnri
         g1ccxEPNK471eqzJA6LT7HwxgcyaZs7k6FOYoeTwuZEjxE/hjgc206A4XjeP3t7jHqd8
         DfH7cPHLSaQt96rzpFiqADNLcAsfjipf5IddGIjhMa9RFpsDmRe2BVGomu1aX6xQnNuJ
         f6NDZ+kl9EBzadJrv4sIrAuAjQuYojYweY5X4hU50SlmUBpfJK85tVDLtEddrwSGmaPy
         iYCBO7nAHVWeR3orlGOzDB+VnOiuiPs5ToWj/RnOqY3NxZZWnRFM+/KQ3JclWof86Mvr
         09qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=HDs+wOaN7N1oAjDOJXdaryAzxarmO9q6Cf3R5Ld01fE=;
        b=DJOZOCKG0iht9f5fSoUTdiY/cyEo2IqgHCyG1+XhOwKu2F/UVdM1NN8NpBrJNU6rkF
         O2+G35AIMKdUIDIPyHh69Y6mKHL7ubIhbmpbVSzW/nlocx4uV5hE1mf51mcRCavlmYNh
         6dBIKMIGS84uxJjG7Twf3EivVYt17oMwhuO8Ed6hdnivsLA9fUJIwe1RG1R4x6rNUey6
         mocNLK2HPbjAjvP7GM43xVVgWwqYQx1bm+3mf3RTypnGnyzta5AzcMIutKPt0KxWkXjG
         msPn+LwprUC0t7Aedu5VEiN19ZxVbne5xXcBEwgb03KK6Ja2rnTWzoxwguSOy6SyFARt
         eKBA==
X-Gm-Message-State: AOAM530Q81WMYxSGHre3T07Q2dFTFQCg72xo2iZbb8aXnAjI/bame1ji
        ORiLJ7SEzpCX5ldsFDM1Ftg=
X-Google-Smtp-Source: ABdhPJwhC2uejtnz+5vT2sYN3igQEt6dMIe1e7vEZH7+ShhdQHDFCQvBWTHFB8LX9qWcDXHrU7i12w==
X-Received: by 2002:ad4:5441:: with SMTP id h1mr3605049qvt.4.1606838831033;
        Tue, 01 Dec 2020 08:07:11 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y3sm2061476qkl.110.2020.12.01.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:07:10 -0800 (PST)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     martin.petersen@oracle.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jdorminy@redhat.com, bjohnsto@redhat.com
Subject: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
Date:   Tue,  1 Dec 2020 11:07:09 -0500
Message-Id: <20201201160709.31748-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20201130171805.77712-1-snitzer@redhat.com>
References: <20201130171805.77712-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
reflect the most limited of all devices in the IO stack.

Otherwise malformed IO may result. E.g.: prior to this fix,
->chunk_sectors = lcm_not_zero(8, 128) would result in
blk_max_size_offset() splitting IO at 128 sectors rather than the
required more restrictive 8 sectors.

And since commit 07d098e6bbad ("block: allow 'chunk_sectors' to be
non-power-of-2") care must be taken to properly stack chunk_sectors to
be compatible with the possibility that a non-power-of-2 chunk_sectors
may be stacked. This is why gcd() is used instead of reverting back
to using min_not_zero().

Fixes: 22ada802ede8 ("block: use lcm_not_zero() when stacking chunk_sectors")
Fixes: 07d098e6bbad ("block: allow 'chunk_sectors' to be non-power-of-2")
Cc: stable@vger.kernel.org
Reported-by: John Dorminy <jdorminy@redhat.com>
Reported-by: Bruce Johnston <bjohnsto@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-settings.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

v2: use gcd(), instead of min_not_zero(), as suggested by John Dorminy

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9741d1d83e98..659cdb8a07fe 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->io_min = max(t->io_min, b->io_min);
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
-	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
+
+	/* Set non-power-of-2 compatible chunk_sectors boundary */
+	if (b->chunk_sectors)
+		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
 
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
-- 
2.15.0

