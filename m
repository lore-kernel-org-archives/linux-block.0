Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84894C432BE
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F11610FC
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhHKTgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHKTgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:36:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D10C06179E
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so11299291pjb.3
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzAcF0zizY0wVeW39ScMbIL+yu4HjhIlQYH8a7v47yo=;
        b=UP4vySG67B3mWmew1yhsxprWgt1py2v7fnkkpmlxAWoNyfd6VwiwQHfDuPyJBCAT9y
         CpW0eU4AV0iEKcg7DA7lLDWAlVS3hCZPLjRJx/hdBaiGn2KKYJ3jMGu5fBeSlT73oeDI
         4Uro6cMsRsvkQZeamniiMreRLD7wwy1ru1ytSfqrZOnxKmlFsrq+O+0TyHopycKoZOaL
         JCSihSz+y22bXA/DJ/kRXPF7qkAWYUHfwv9HY4gjILL+NY1Qy7FpKL9Uaa7GShm6n8+R
         ZzdAY3AMgCLXa3GT/y5g87RcUXs+Onz6aOnsLzBQqwuU/ld5FBkzvCd+V8aGkZGi/XJd
         1Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzAcF0zizY0wVeW39ScMbIL+yu4HjhIlQYH8a7v47yo=;
        b=osiTfpczs0WgLDh9JjhyGS/6uddArYigmJvrIvL68TT3JHRSjIYfT1gOE4Emm/paqL
         lHwm25dRIXsv4p61H7g/GQtsUV0GYBQAIIIX5W7QtkMf+hCTGtmWzv8i8EfO4ubn5F34
         PMxnTe3O1seznC6Wp+Pmbt1cASDkTms7vNoViUapWfC2CI+ilj04lM9m2I1D9Jac1myZ
         HydXyAUe2qHr+q10UCLes92iUVNlNORh+cS/8Shhf9bvA+6ByVxMZQr5YeFSqpGSBWqw
         0QI+rv04ZEFYjvsK+d/wsZn6WP61pmdakhoXqM6L6lMe7XVvc2kzga8IHDKTTZmqjskV
         XBUg==
X-Gm-Message-State: AOAM533e17D9kFR7t6dhwElIv5WIYeip2nMf0HLltTLk5SNN/IkM/+TJ
        YnPNii/onorb4eArCw8SkrHHDg==
X-Google-Smtp-Source: ABdhPJyLozS2daFM9HNJ9WFZc7F7zdNlB81nDYSLw4lvsHkDusDtRKe6nUWUP09eLh+8xl4WDH8wZg==
X-Received: by 2002:a05:6a00:18a3:b029:3dd:8ade:9b8c with SMTP id x35-20020a056a0018a3b02903dd8ade9b8cmr309666pfh.63.1628710542623;
        Wed, 11 Aug 2021 12:35:42 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u20sm286487pgm.4.2021.08.11.12.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:35:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] block: clear BIO_PERCPU_CACHE flag if polling isn't supported
Date:   Wed, 11 Aug 2021 13:35:31 -0600
Message-Id: <20210811193533.766613-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811193533.766613-1-axboe@kernel.dk>
References: <20210811193533.766613-1-axboe@kernel.dk>
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

