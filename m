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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B60C433E0
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE51264F19
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhCMQgf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMQgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Mar 2021 11:36:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49DC061574
        for <linux-block@vger.kernel.org>; Sat, 13 Mar 2021 08:36:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ha17so5906471pjb.2
        for <linux-block@vger.kernel.org>; Sat, 13 Mar 2021 08:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=f/ATcZDgkpa69P3OCF6HCVINJhil+2RUrXNv8f9zA+k=;
        b=ixq5AqjNJQnE6MLgsqrJZyh0ohcY0MZdhd/MmTB7FIjPBJbB0TwvkH6MoI/05wZH38
         wkEeVBm/8kCenDtYr+QrUYDxEgN7WHJtyygklq8il0kngX5mIXHYDHEdlPOfR48QEdcu
         eWo6ys31IStxrVCe+W0Y4nvJiCh45UCMxsA3RoRoI29t5Z5i5wtCBgNuZKlpsT0furUg
         sEsvYkPJzm/WxjEWA0q9KKoHWfBFHdwjyMpv6nneIvK7sYXuGoF7cEo5Lui8RD76z1i6
         VZyfNEjqFTGkQ+6nXUG9CJcMNle0ALGruGHFGgHADU7AdyM8r8G+0D0cq69vy0UNh7Q9
         erJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=f/ATcZDgkpa69P3OCF6HCVINJhil+2RUrXNv8f9zA+k=;
        b=cYCid9/3wno4a87HJymfnDGy6u5fN6XIrSZcSC9SJJyrmxIaKJDTUQvRvA0eCP1b9N
         IG7rV63/cBxHfqN5L0qvdHJyuBlrPRu11KosvLM/urK46cpRarHlh3Zi4FQDHECBgWVF
         8qxSAesUrvJ/yaOzwzg58sYS/lg2+GaY4oy4WVXRydujxlaa3bVmkf/9lridKwtkDt+O
         vv317JPsi5zz8+or/Yigfw6Q37nK1k7FQPY7ou55+eMGdmM99G6epmBT1b8reez38LI1
         KGCgko6KtSOZkFsmy9tOIoLW1kZqPVAoH3LlW/nAGUmPo4hsrTfFSX33Lr8vMHN5zg1z
         VrIQ==
X-Gm-Message-State: AOAM533ZThY6jJb7zAv1jia3WwDRahmxOEdetRQRtcztLTEQf9m/BQIy
        Giy/eR+y0CAqLLwXZ6hWH3IMZRNcWYwBHesa
X-Google-Smtp-Source: ABdhPJyrUicAl9UwbVYa+tzLtY6c7OL5uQf3r+WiNab8Gx7Mn9Ry96S041sirKcU7iGv3Kjmn7p+iA==
X-Received: by 2002:a17:902:8c97:b029:e2:8c58:153f with SMTP id t23-20020a1709028c97b02900e28c58153fmr4342363plo.79.1615653360704;
        Sat, 13 Mar 2021 08:36:00 -0800 (PST)
Received: from client-VirtualBox ([223.186.9.86])
        by smtp.gmail.com with ESMTPSA id e20sm8521750pgm.1.2021.03.13.08.35.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 08:36:00 -0800 (PST)
Date:   Sat, 13 Mar 2021 22:05:52 +0530
From:   Chinmayi Shetty <chinmayishetty359@gmail.com>
To:     linux-block@vger.kernel.org
Subject: [PATCH] Bio: Fixed the code indentation by using tabs
Message-ID: <20210313163552.hcor6mdqw66om5r7@client-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

