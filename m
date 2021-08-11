Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E56EC4320E
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772BC6105A
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhHKTgG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHKTgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:36:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20196C0613D5
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w14so5169981pjh.5
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7nEJ4dK4R1jH+/WHvia5muthOy9g65ru5z/3wVHRoE=;
        b=tv9oqAVejrrGokNmOqO0Ms1rxAVj+vm5DTRXkCXDIf4klCeIBkEvJ4v9RTKTYG01WA
         iaLLB7o99dK5AjUtzEsxBZkzttLdIAjjtSIW+uyTyiwdB41IxGMfkoU4PCSOIHTNA2EK
         NhbodCJYjx9KFeGQLxfaaPnsGyLRVMVk+hFukuEpiTdpV87HWiUWWzfP/CxKJBCjdiwf
         IXQFAPHwzhu0JvR12tb3pNmvAhVSq20IdOALpL8AhfCR2ISSGR1Ay5lxUmnwHR83cyec
         2Reh+xVaziPbWMdEyAskXuFvzgHUUKcOloNiYL1YRE64KKOtZ22KNrazLzaLn9EElkm/
         Qj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7nEJ4dK4R1jH+/WHvia5muthOy9g65ru5z/3wVHRoE=;
        b=JHgzqpvAhCNJ+RKhXFgkhpkSm1C5JQYuruVrVM3tl7mM6xzjwms6WonR9mjaHlszp7
         W7m/A5emtPdWI+djpI4yYinWUAyhQIBBSNPj0LFV+0xO+yvZxar9JUUL+41KFB/9K9NV
         99/EEoy1jlM2vOP/82CQdrtlKzjzXAGbpBBvvSiLKAD7/Rcj63PXY/2q5s8evfqmcPEW
         qF0U6bWZ17ezXya1wywC9pmZQkIYUfiM/zp84k8UC7JcKzoaJiLQPT4qiogYsNnfR2dF
         K4Dlq4HN4e502jekTsXgD8sdu6ceZCrAX9INP3wtPkiVNq7XBUaacvUQ214C7J9RLNQ3
         j+JQ==
X-Gm-Message-State: AOAM533EEh4YsvKHVn+7j3NuS4NlsiFu4TbOcouX4z/f5i1gfjhsVu77
        u01rNwnw055i/Z4rzdfI34wP0R+WmGEAEcrV
X-Google-Smtp-Source: ABdhPJx7HRsnH9aZkRlFR+my4k725bNl8KLhfQEjijU09X1B1Ld8cYqbDcQuwAYKhjXdKQUPm5m19Q==
X-Received: by 2002:a17:90a:2c0c:: with SMTP id m12mr153114pjd.107.1628710539670;
        Wed, 11 Aug 2021 12:35:39 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u20sm286487pgm.4.2021.08.11.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:35:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] bio: optimize initialization of a bio
Date:   Wed, 11 Aug 2021 13:35:28 -0600
Message-Id: <20210811193533.766613-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811193533.766613-1-axboe@kernel.dk>
References: <20210811193533.766613-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The memset() used is measurably slower in targeted benchmarks. Get rid
of it and fill in the bio manually, in a separate helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 1fab762e079b..0b1025899131 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -238,6 +238,35 @@ static void bio_free(struct bio *bio)
 	}
 }
 
+static inline void __bio_init(struct bio *bio)
+{
+	bio->bi_next = NULL;
+	bio->bi_bdev = NULL;
+	bio->bi_opf = 0;
+	bio->bi_flags = bio->bi_ioprio = bio->bi_write_hint = 0;
+	bio->bi_status = 0;
+	bio->bi_iter.bi_sector = 0;
+	bio->bi_iter.bi_size = 0;
+	bio->bi_iter.bi_idx = 0;
+	bio->bi_iter.bi_bvec_done = 0;
+	bio->bi_end_io = NULL;
+	bio->bi_private = NULL;
+#ifdef CONFIG_BLK_CGROUP
+	bio->bi_blkg = NULL;
+	bio->bi_issue.value = 0;
+#ifdef CONFIG_BLK_CGROUP_IOCOST
+	bio->bi_iocost_cost = 0;
+#endif
+#endif
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	bio->bi_crypt_context = NULL;
+#endif
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	bio->bi_integrity = NULL;
+#endif
+	bio->bi_vcnt = 0;
+}
+
 /*
  * Users of this function have their own bio allocation. Subsequently,
  * they must remember to pair any call to bio_init() with bio_uninit()
@@ -246,7 +275,7 @@ static void bio_free(struct bio *bio)
 void bio_init(struct bio *bio, struct bio_vec *table,
 	      unsigned short max_vecs)
 {
-	memset(bio, 0, sizeof(*bio));
+	__bio_init(bio);
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
 
-- 
2.32.0

