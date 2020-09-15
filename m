Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA8C43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24786206E6
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6GMQaA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgIOSv7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgIORZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 13:25:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46EC061788
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so5061727qka.5
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kx5MVQ6xbvL7SHYiOkls0hYmmDYxo6c0riPFgM+lrnY=;
        b=p6GMQaA8hmceMnb+5kwya+bzED6xKn8OGXbLxSIfMluBX06j6KehloBobDOAp+/9Ya
         Lx1mw9+l42SVWztlPyHzrXxAgiRD5QwHvmxrsV0bgZj0i9b9M4BCz5Xt2+DhfJiqDAdt
         egxzt5B84faJQQ9g5UciXDyFBGScsuekTfkSAOQT+H+HDpRqHCXt7g54ztyW0CoxYwP0
         QFow0Sr4rSLFm44giwNBSEkEOVEHjw9hAXXkw25j3VxS/YMYtInfSQ06PDXeJdX9s2Tf
         Az/LnwWbRxaglE1+gocO2IjuLBpyx8zD6h4rS9u36q7Nj16Q6Carae9Wbg1CuTLItPLL
         446w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Kx5MVQ6xbvL7SHYiOkls0hYmmDYxo6c0riPFgM+lrnY=;
        b=FdWSQCfLKYxQnpKiZMC5vewe7akWp+H6F/cyMeL4qojOg7IU10XUlGzqQMIHFrBi87
         dEtsL2EG3H7JLKPYdvXOIMNS2xh2x1/Nw0HXNEFgS2NdzXfi2rMI+U/SFjLIMt4vbS5p
         lg5RYx8zmYnQd//dIOQxJ1KHdgO1y8jeYa/Fkgr1fg5aM7EF+RdC4SSOgli6vHCLCMPM
         xSQVrhlFIAZ8abudBDPNOZ80yzr4LgfNykE2gS5DNskRU7WPcdzDGXObkj1V5Dv6kO+9
         M6XCdBRvtx1Tl5Evrud7gpbKQ62OPmgNpiYZSoaFCUV6MMP3JNfBYNZn2jBx+IJhQKsI
         3LTg==
X-Gm-Message-State: AOAM530HiSSJ/St4mP7hMFSjKdrcA/vyvcANpSG2BJWBd3JX2j96fz+X
        SOOpVrL0niFF89cLKQ4xIyI=
X-Google-Smtp-Source: ABdhPJzKaUpJoi0KDI4Qkd/096qDGqB8xHMUklj32DH+7MIkhoQilpcZPSpn/qOUshcAtyBcNDuOPw==
X-Received: by 2002:a05:620a:13f6:: with SMTP id h22mr19848092qkl.9.1600190640218;
        Tue, 15 Sep 2020 10:24:00 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g18sm16371219qtu.69.2020.09.15.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:23:59 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 1/4] block: use lcm_not_zero() when stacking chunk_sectors
Date:   Tue, 15 Sep 2020 13:23:54 -0400
Message-Id: <20200915172357.83215-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200915172357.83215-1-snitzer@redhat.com>
References: <20200915172357.83215-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Like 'io_opt', blk_stack_limits() should stack 'chunk_sectors' using
lcm_not_zero() rather than min_not_zero() -- otherwise the final
'chunk_sectors' could result in sub-optimal alignment of IO to
component devices in the IO stack.

Also, if 'chunk_sectors' isn't a multiple of 'physical_block_size'
then it is a bug in the driver and the device should be flagged as
'misaligned'.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 76a7e03bcd6c..b2e1a929a6db 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -534,6 +534,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->io_min = max(t->io_min, b->io_min);
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
 
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
@@ -556,6 +557,13 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		ret = -1;
 	}
 
+	/* chunk_sectors a multiple of the physical block size? */
+	if ((t->chunk_sectors << 9) & (t->physical_block_size - 1)) {
+		t->chunk_sectors = 0;
+		t->misaligned = 1;
+		ret = -1;
+	}
+
 	t->raid_partial_stripes_expensive =
 		max(t->raid_partial_stripes_expensive,
 		    b->raid_partial_stripes_expensive);
@@ -594,10 +602,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
-	if (b->chunk_sectors)
-		t->chunk_sectors = min_not_zero(t->chunk_sectors,
-						b->chunk_sectors);
-
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
-- 
2.15.0

