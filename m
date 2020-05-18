Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5036C433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFDD20758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgERBsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 21:48:20 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52136 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgERBsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 21:48:19 -0400
Received: by mail-pj1-f65.google.com with SMTP id cx22so950822pjb.1
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 18:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcfnQojx/doFhHpkvlqZHsi2lSxiHoLu3RvZ54XPUTs=;
        b=W0iajg7ivIJY4ZekTABYx9Q0NJ6Ki+FJXnFqaBZk1aol3DmH+6pEoilYmTLsKP/iUH
         IFg8qbNpLzntGg+NEugua0FY1dcOlryp5Kk8XX+hjpG5xl5SbGLCrHjIJmChKDcuRleq
         bWbazTFVimJIjBUcbzxsVlY4VIT5MZzjJG3khqcYhGQKjSnREfwEUMVLNkUK/TSCOtcU
         7uw/gSf+qRpTNq5j+WbY57HueAiU9SC9epy8u2Y1zpHqpgzf95mKxPCB7uWZ8qhNI1AI
         IczrAQvu2/iGOzl8djBUXmxK2QXUt5OIJA32Zw6HsnlphWn7DZLgNpTOVzPvSwOg5ezU
         grlg==
X-Gm-Message-State: AOAM5308VvW7pCS1O51mxOmKrZy6963BBAOx6BW1Sb4VWZXf9iF9Ey8W
        gfpHXd3baq0in7TpJl30tes=
X-Google-Smtp-Source: ABdhPJwx8g2XlTEBHoyFHIrcA2sBU6xrMG4ek7A68sWyw8Jc/VOadA3HjD57sszF2jpvkjz4GcFk+w==
X-Received: by 2002:a17:90b:693:: with SMTP id m19mr16960050pjz.125.1589766499116;
        Sun, 17 May 2020 18:48:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:1c3f:56a2:fad2:fca1])
        by smtp.gmail.com with ESMTPSA id m2sm3778353pjl.45.2020.05.17.18.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 18:48:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 2/4] bio.h: Declare the arguments of the bio iteration functions const
Date:   Sun, 17 May 2020 18:48:05 -0700
Message-Id: <20200518014807.7749-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518014807.7749-1-bvanassche@acm.org>
References: <20200518014807.7749-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This change makes it possible to pass 'const struct bio *' arguments to
these functions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/bio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0ee494a6329..950c9dc44c4f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -70,7 +70,7 @@ static inline bool bio_has_data(struct bio *bio)
 	return false;
 }
 
-static inline bool bio_no_advance_iter(struct bio *bio)
+static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
@@ -138,8 +138,8 @@ static inline bool bio_next_segment(const struct bio *bio,
 #define bio_for_each_segment_all(bvl, bio, iter) \
 	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
 
-static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
-				    unsigned bytes)
+static inline void bio_advance_iter(const struct bio *bio,
+				    struct bvec_iter *iter, unsigned int bytes)
 {
 	iter->bi_sector += bytes >> 9;
 
