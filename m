Return-Path: <SRS0=tJY/=UH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE175C28CC5
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88172214C6
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 20:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOug2p1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfFHUQJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Jun 2019 16:16:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46915 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHUQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Jun 2019 16:16:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so1202955pgr.13;
        Sat, 08 Jun 2019 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLlwXriYXWRDWa6HLbM2ROrlGesibqzQ/9uF5Z67oTI=;
        b=uOug2p1q8b8ToqRGjDQGLomtv0cac2TObRAWxk6HBJ+4oJVfEu1muX75mCezZMdLXg
         Vle/ZUpPXzGHtdlKSXX3k3RgnQJUjFFCjfoJ33uCDI2XQDgePNy/jarK019y4htN7HkT
         vzvi/FFaDranTeHdGdmfnmTP52qzwjR/uzfmLOR5l1cvBnSNUphByrCzNIo+WHLXhdVa
         OnVxEkhlfTpYHHSw0EbVr6L86UobqFpQELoCsKmhAFqXDz0AWIgFzWPOlGcER60CxYTo
         i9m43LDICNLo3k/ejj04x+xV4RHeTUE4Va53kFNzP2ElRQijJYJVnK6Y/K+bil2eZWIa
         xAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLlwXriYXWRDWa6HLbM2ROrlGesibqzQ/9uF5Z67oTI=;
        b=cdyIHN25CCAYrTLfQx+tU54bZ3dePi0+vqgLMZgO4luZMf3ysrzIztgjifzks1LH31
         emQ3aipa4W37Fm0HIDNimZrvz31M1jdfNGJPiep/sEgk4dnP5UleJ2TBkVHyQOZNoa3K
         xOXV44Cj76bdrghd7zOgoCa0OpdcUpJkJDGIPVSg0VEcWdouZtOq6lutXhDe9VEg2MTe
         2qpq8HlwlXZxfScksCUKWoqeRaBDIERZvpLGjpp69cz6A0Mbf7V9DPV536XoJ23gyV1W
         rgOdcQKsJ2e61+L2Se81VXMhtZotwljHCK+mpoa6G+EUGRO1vTosoorSqA7IvudbyxkS
         AmOw==
X-Gm-Message-State: APjAAAW67AtiO9yCVdyMT+l8NpEm1A30dyFRwvqzJb74n/7m/BTlRAly
        5TUgnf/cYpKmFGeYVA7GgWtK/worLoU=
X-Google-Smtp-Source: APXvYqzfUZt9gGBQUWLKaBWxLP7Ho4KXquSPkx5l20Qr1x1iBYrQbXydAmPIedpOOZ7aGu8+x45yaQ==
X-Received: by 2002:a17:90a:c303:: with SMTP id g3mr13064434pjt.58.1560024968206;
        Sat, 08 Jun 2019 13:16:08 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id s64sm5196863pfb.160.2019.06.08.13.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 13:16:07 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RESEND PATCH] block: move tag field position in struct request
Date:   Sun,  9 Jun 2019 05:15:51 +0900
Message-Id: <20190608201551.4531-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__data_len and __sector are internal fields which should not be accessed
directly in driver-level like the comment above it. But, tag field can
be accessed by driver level directly so that we need to make the comment
right by moving it to some other place.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..90e6914bea0c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -137,11 +137,11 @@ struct request {
 	unsigned int cmd_flags;		/* op and common flags */
 	req_flags_t rq_flags;
 
+	int tag;
 	int internal_tag;
 
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
-	int tag;
 	sector_t __sector;		/* sector cursor */
 
 	struct bio *bio;
-- 
2.21.0

