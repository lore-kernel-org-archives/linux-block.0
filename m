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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B161CC433E4
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D1961A50
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhCYV1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhCYV1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:16 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939FBC06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f8so4052110qtv.22
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jcwCmvL2zf0lF3Ank04XNaFIuqNE6u2MJVhR/WWQGZc=;
        b=fUGJmbUcJs9LLuwYxYrtUvHLhM1TcSpAOUXmXU9i7ZnDvC+dagbI2nRWiKwSzhKIn6
         J2TpCtBOE35vXBCihxWEoeINPTXBVETVHLvpHO2733KVglleDWVzIJryyi32kWjj+nP6
         YWdKtTHMviMBZFfEpcz7H+m/aZzW2qRD0u6jIUMv9IZAR8iixPQJaqco0CUSkUewAmHs
         X9UEZpJes0lwNIZdwASUbOtV7WpZVWPE2WLSwgNbEhr97VbdgNEr/YGq6BOOoDSZHi7e
         GeRiDIF/hZPeQo4HSjSsd7RD21QbbVFei8tLUMSo4UI6bfEa9gryrW23GJeBK4/nos4P
         yC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jcwCmvL2zf0lF3Ank04XNaFIuqNE6u2MJVhR/WWQGZc=;
        b=r9FuUFWa36aPEsNYISEZTtTDpGU4r/zf8QefUZ5PNMrrAFtCGBzmtqJt0S6HZA9JWZ
         ASkLeYe7/ugzkWqOlRInH5uyAuUqXjhWcXjqh8iAPQBt4FzUf37arCcLw5I/6AH3Anxf
         qmhEDNcGONsabcBBCqniox8opgz97kr66lbnpj1rhdtKIZpo8uzhF+6xGKydFCRbLhn9
         fDqU+43uF35oZ4Ri88V6N32aiovY9MrtksdIsW1A6uT5oJkSi0OVY/84m8MqdjzPjhHZ
         fddphwhs3uqw2diUI0wheJ0gdC64oMiKhLDpeZhepak9WZq1whIMY2Fh8cU/Iu/DQGOh
         MeoQ==
X-Gm-Message-State: AOAM530648Sfni40M/oRDeJunq3Oa2XzScs02IFpnxpVhTwp2aAClUyb
        cWpSQogfqs3cOi11aVihBism4KDBpsUom7BAVqaRRhvnGpvmrZtOBY4nGOVZ9Aq0NmXA4iYoCHt
        GgXsW9xCD9zBUnPSge0fqouZFOHRdwmRYhgukyYQOta0PJ88TwR3VLNiVOSzhOKji+62s
X-Google-Smtp-Source: ABdhPJxIQ06W5lmnWE4BuGBz9AJvw51tzkMUBqKwdv/PcZO7ZgbD/Nw38wjPFr6N5rLFbrNgkw8F4v3Hn4I=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:c345:: with SMTP id j5mr10335420qvi.52.1616707635674;
 Thu, 25 Mar 2021 14:27:15 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:05 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-5-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 4/8] block: introduce bio_required_sector_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function returns the required alignment for the number of sectors in
a bio. In particular, the number of sectors passed to bio_split() must be
aligned to this value.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..5ef207a6d34c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -261,6 +261,18 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 }
 
+/*
+ * The required sector alignment for a bio. The number of sectors in any bio
+ * that's constructed/split must be aligned to this value.
+ */
+static inline unsigned int bio_required_sector_alignment(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+
+	return max(queue_logical_block_size(q) >> SECTOR_SHIFT,
+		   blk_crypto_bio_sectors_alignment(bio));
+}
+
 /*
  * The max bio size which is aligned to q->limits.discard_granularity. This
  * is a hint to split large discard bio in generic block layer, then if device
-- 
2.31.0.291.g576ba9dcdaf-goog

