Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C2C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DD360FBF
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhHLPmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbhHLPmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 11:42:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58EBC0613D9
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 08:41:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so8257827oth.7
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzAcF0zizY0wVeW39ScMbIL+yu4HjhIlQYH8a7v47yo=;
        b=TihX5YMJv+Ds4lQ0p4PiRHGk8oWXtLun1JbOkDn9HgtJB+KVVPNtgcEJqWHN7MtssK
         zPaHp9eZvCzPqmb8Xn5Ht5kPNW67wAp/VeMnxecLfD70hI1QdMfxXKhI8NjgsXNppzR9
         IKM7yLkipYJauHpX6/tUBptEh+8XR+eNFblYE2oLiwofyHXRBZzdxNiUvcVxHPHrdLaw
         kPFZr2tLL4Eiid5AL4qWeha7+227TtjYSFfdvN4Me5ktN16iHpMsdhsI3zuT6ijwBnYy
         Ech6E+Xxu2DQ755Q3I78ma4wJ5dcrmDnmHPPQ4Zu07gGsrv0pHGJyi92gJlr/ZiDbViT
         gkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzAcF0zizY0wVeW39ScMbIL+yu4HjhIlQYH8a7v47yo=;
        b=eqiLr/qi+afG2kKu5I2FbXreo6Yth5GDJluujvDrf6sRQL6VXhxUIipdq50WtCk6l4
         /p3hmS9sB9UUKD1AqE57XttQRuHMwQ07glSIqBOPD+N9uS2CCgGanY+TNc5b7gTCIcz9
         g3ayQu6ssLMsFI1pf7tRsf3sEW5knAFnDO53rjmhj9IkgcBIL8jmoXya8V4moZyZqwfF
         dleSD8y4v5FgJShmyaeUzFBPjlLbXbCX1VAEIZljhb6tqpUMbwuJUbwDSwnmaI9CgbNB
         mv0KrUY6YCYQDh5gxrkhRIpTHKN5NmFXQHb97bs6w11Egl74jxNL/0QsUBGQpJoOIQ03
         Do+Q==
X-Gm-Message-State: AOAM531w80fS30sBl+71zwuuVjTHheAXs6QCDdmF19xATbiYH0o71YZz
        WQLlMDyG0RtpqvoWQC+mp0XN3w==
X-Google-Smtp-Source: ABdhPJw0Sl3w155IOnkFB5DmHVe92pvQEqfNjekV4IPmKjJ6R84Q/0+3dhjbz7vUG5w9NDS9EG6vBg==
X-Received: by 2002:a05:6830:4429:: with SMTP id q41mr4022053otv.284.1628782915057;
        Thu, 12 Aug 2021 08:41:55 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w16sm690973oih.19.2021.08.12.08.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 08:41:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] block: clear BIO_PERCPU_CACHE flag if polling isn't supported
Date:   Thu, 12 Aug 2021 09:41:47 -0600
Message-Id: <20210812154149.1061502-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812154149.1061502-1-axboe@kernel.dk>
References: <20210812154149.1061502-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio alloc cache relies on the fact that a polled bio will complete
in process context, clear the cacheable flag if we disable polling
for a given bio.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 04477697ee4b..c130206e9961 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -833,8 +833,11 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		}
 	}
 
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags)) {
+		/* can't support alloc cache if we turn off polling */
+		bio_clear_flag(bio, BIO_PERCPU_CACHE);
 		bio->bi_opf &= ~REQ_HIPRI;
+	}
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
-- 
2.32.0

