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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365BC433DB
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7F123B7D
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbhANPs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbhANPs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:28 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30EC061799
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:38 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id w204so5081723qka.18
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T+AWygX7OH80QXvfOzs3n7xe/G6bC11ON9WcWWdoQ+8=;
        b=U4LFD2nsz8xQHgT0rhZ1G/AMQ+FWnUzAzA6avnsMxwvpUEx7V1inLTHZQPW/o8yTam
         aw46GWdNFUsm2oO00a4n4ZmI7vlVdSmBFGetcUXDRbc/Udqh/xgSCv552WA2uRnnQXdI
         B9T9yIsTX6ts6jNo5CxgjE0vidmRPd2x+ooyvuit2hN7D5/lYkONfYd/jISnYd8Ote2W
         8/hBCTJ3FEndjzU/0YlKBd32qdMUY0sFawi+o0QqDVhiCVy8rHWSaHFWA6WgRnd+4+j4
         fLqFb0kBmx5FANNwVGnto0X18SlLpCMkazzi262K7CAjO3YV36X3Pun3EMS+IJLJvORo
         L05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T+AWygX7OH80QXvfOzs3n7xe/G6bC11ON9WcWWdoQ+8=;
        b=GwxQdANIAn+m0iutthdz0UL9J9Ce9CAVUUhpXGoEgs9EMHANNfZ32Zl5JWlzthox5J
         WZ/0vj7b6rWiMW3QFQ5STvIXh+phPGmNAJoJV4Cma7sg3iKO1xzvAaOzwbD3Ry4GDiEP
         K9U9tyNM0ttEgigwcN6pTOAnqPVIV81pENI8M6x9giW39DWrJYmgddW6ddnHDT5S+ZoE
         hosRtcU9oynFlRugxcsfmVXPw9fuuwrMxHskeGja0iQ6Uyp/4OLzjmcgYpFH31h4420M
         Gnj6tiLa+uFd6WhqIqVba3IvV2DBed32sfAprGq8J7LbcQY1ImREmOyluHGysMFuDpO/
         kLgA==
X-Gm-Message-State: AOAM533+Je2kUkME679/0UMtE1VP4faUvU5o6M/ZaYiXOfjbbrmCssz0
        TAO6XPr2cnsjHBbjcHPUBm6ySpXlbX5q6moVOjWjnl2PazXiZWm0PtQ1ywr7sUCW++Kqv0TFzKR
        17Nx/2sztwNlsvtsxI64h0fve57T5N8dubVxEDH6lRIjp4wBYaqy0uPehHSr+DTuKTSM2
X-Google-Smtp-Source: ABdhPJzTX4rjIJNaqVFSCnwwKO5HfCbqTP33xZ/K20KnPSIjDpsOY8CWYUyJncST7orNHt+rk2kmGBrif0Q=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:ad4:4a70:: with SMTP id cn16mr7421032qvb.38.1610639257345;
 Thu, 14 Jan 2021 07:47:37 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:20 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-5-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 4/7] block: respect blk_crypto_bio_sectors_alignment() in blk-crypto-fallback
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make blk_crypto_split_bio_if_needed() respect
blk_crypto_bio_sectors_alignment() when calling bio_split().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-fallback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c162b754efbd..77e20175df40 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -222,6 +222,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
+		num_sectors = round_down(len,
+					 blk_crypto_bio_sectors_alignment(bio));
 		split_bio = bio_split(bio, num_sectors, GFP_NOIO, NULL);
 		if (!split_bio) {
 			bio->bi_status = BLK_STS_RESOURCE;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

