Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F7C433DB
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F5664E46
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCMQzP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhCMQzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Mar 2021 11:55:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316BC061574;
        Sat, 13 Mar 2021 08:55:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n9so16899993pgi.7;
        Sat, 13 Mar 2021 08:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=inlPIT9YAU/L7BKjPTjnpiP35IjHmvlJFgvsurh3w4E=;
        b=YoSzK1SGjHXARDw2jmew25yOw/D4k8OS0TAnwFKLAaWkyyYszg83VBWbsxMh5rpoiS
         bV8DROmQOIOotXRSmee+UKJHbzP1PqeSZC3/eZLczy6xeUjO60K0JlY2zP9QRiMjoPZy
         F1mzfvdPZeGaBALNYNcs2CJUQrswJpNwi7yMjwqjmey3mBU49qa29NlsaU8asBs5rrdX
         Q0qKxWksvlmOfFxU3il92O+RGmlJfdxZsuwXEOl6N5ueB0r5U5HXYapPjKEaYCtJaxrm
         OYYzr8PI2SZfDye9HssdK7kc+BXMJJygC/Q4s2LorlQiK8fAPQa5PvJnCbvl1YGPjD3G
         RJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=inlPIT9YAU/L7BKjPTjnpiP35IjHmvlJFgvsurh3w4E=;
        b=RuvrVHpHJOXznvmSnHolvRz0S2D9klOI9mjO2Zy6vFbgoeIXcKxQIh8gji22fY2+GO
         9fjsDz1PX5KVvuc8fHHRbqCFwccOL3YU7DrZjlPgsn8+iw5Eq6V85Nb4unt5Zf6wQK02
         ftiXp70seqjjbqSaAEIXlMbvUU0QPqzVaFVhhlHrgQ/u6tIm1n2Z8w/gSE0NDI4iaa8A
         Jagm9GB88tzUy3rO4tfHXVjnZosNBtFgbEU2ROOzaBkYk2Ce225HX/Ql3FEE/1I7jOAV
         tEq8agRuqVZd8u6cBw0w9GRAuDV3wCgkTVcFEFOczjAA2CGQlyApehH3W+2VMlPo6XwD
         dHwQ==
X-Gm-Message-State: AOAM533ksXjEqN2bt4dznsT+0A6c5HYtFaRI6gANqiXm81aXlWjJuNE+
        wQ5H365Uf+6ToS1zXMtcbZI=
X-Google-Smtp-Source: ABdhPJwCdPGpeEKu1Nbu81x3B3xRWGi2V116vJB8RmDToIm0/6vBcwhLPWoDoeq2VrZEbh67BWpOfg==
X-Received: by 2002:a63:9dc2:: with SMTP id i185mr16381314pgd.329.1615654509826;
        Sat, 13 Mar 2021 08:55:09 -0800 (PST)
Received: from client-VirtualBox ([223.186.9.86])
        by smtp.gmail.com with ESMTPSA id 6sm9336872pfv.179.2021.03.13.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 08:55:09 -0800 (PST)
Date:   Sat, 13 Mar 2021 22:25:01 +0530
From:   Chinmayi Shetty <chinmayishetty359@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bkkathik@pesu.pes.edu
Subject: [PATCH] Bio: Fixed the code indentation using tabs
Message-ID: <20210313165501.grdrrhi5l6ezv7ze@client-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bio: Fixed code indentation using tabs

Fixed coding style issue

Signed-off-by: Chinmayi Shetty <chinmayishetty359@gmail.com>
---
 block/bio.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a1c4d2900c7a..7c1354f7065c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -501,6 +501,7 @@ void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
 
 	__bio_for_each_segment(bv, bio, iter, start) {
 		char *data = bvec_kmap_irq(&bv, &flags);
+
 		memset(data, 0, bv.bv_len);
 		flush_dcache_page(bv.bv_page);
 		bvec_kunmap_irq(data, &flags);
@@ -616,15 +617,15 @@ void bio_put(struct bio *bio)
 EXPORT_SYMBOL(bio_put);
 
 /**
- * 	__bio_clone_fast - clone a bio that shares the original bio's biovec
- * 	@bio: destination bio
- * 	@bio_src: bio to clone
+ *	__bio_clone_fast - clone a bio that shares the original bio's biovec
+ *	@bio: destination bio
+ *	@bio_src: bio to clone
  *
  *	Clone a &bio. Caller will own the returned bio, but not
  *	the actual data it points to. Reference count of returned
- * 	bio will be one.
+ *	bio will be one.
  *
- * 	Caller must ensure that @bio_src is not freed before @bio.
+ *	Caller must ensure that @bio_src is not freed before @bio.
  */
 void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 {
@@ -657,7 +658,7 @@ EXPORT_SYMBOL(__bio_clone_fast);
  *	@gfp_mask: allocation priority
  *	@bs: bio_set to allocate from
  *
- * 	Like __bio_clone_fast, only also allocates the returned bio
+ *	Like __bio_clone_fast, only also allocates the returned bio
  */
 struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 {
@@ -1009,7 +1010,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 				put_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
-                                return -EINVAL;
+				return -EINVAL;
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
-- 
2.25.1

