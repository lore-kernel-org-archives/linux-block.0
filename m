Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D316C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbiDKRgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbiDKRgP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 13:36:15 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1BA165A7
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 10:34:00 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id kl29so13802818qvb.2
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 10:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDwpjxnaXnMZ7L/oCeYRvVxrGJTCBqxpXVhzEXP2jxw=;
        b=RSxbr8wc1dSGrhQC8nmqxyaytvYTKzzUgbjMTlntOskzHQ0Ei1C0VnJ/O5oEkJlCvA
         AwQzJTuFa0NRyZQWBZJebyUbV/XzotbEQfV4uOJ7FajUZAECCTvrbF+MtSByK2ClRjb5
         RNUeKYbe6D0AcDTGX+kAQbp0LS6fXsHujTfioRfkadrsajypx9Pj3NeK/UNohz+pxS4S
         ZwnboesemBtayVVe6yfv/bU9T5/lwzDXIdkYoFn5v4c2IfEjTeEzikC14P29/c8pEyMU
         iOytHNFc9r/BIFvHGNXHC68/yaaYsGQXhuMyoNho+FEpC0HlyC7WNzea3aPHfeD7iXxA
         Yg9g==
X-Gm-Message-State: AOAM530WP0gFJISIETEtOtFXrwf2GnqlwfPy+XBPn+x88UeRQM/Ga2lH
        5AakHXsU4wxps8tYk7sAqXCcVqCjeeYTpdoBuj9OyTotAsQLS6Jnj7O56QPT8S6jQjJqC6JsfHK
        bGDQ8A/3R4o0z3oXXILSjU96IeM8Oh3QegxvGqpzwpNhWdSTyYhQ87z3di2okD7YTm2+yFbonjr
        8=
X-Google-Smtp-Source: ABdhPJzYSYJVHqSt6oh9OPhZ8i6wED3jCrcze23zl3ItN1H0Y8TdIYC5OdPbTvUi+Ft4gwKM5nxVyQ==
X-Received: by 2002:a05:6214:daa:b0:441:7161:de4b with SMTP id h10-20020a0562140daa00b004417161de4bmr27795121qvh.48.1649698439658;
        Mon, 11 Apr 2022 10:33:59 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z145-20020a376597000000b0069c0669327bsm4313551qkb.95.2022.04.11.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:33:59 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:33:58 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, tj@kernel.org,
        axboe@kernel.dk, dm-devel@redhat.com
Subject: [PATCH] block: remove redundant blk-cgroup init from __bio_clone
Message-ID: <YlRmhlL8TtQow0W0@redhat.com>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
 <YlEWfc39+H+esrQm@infradead.org>
 <YlReKjjWhvTZjfg/@redhat.com>
 <YlRiUVFK+a0DwQhu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlRiUVFK+a0DwQhu@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When bio_{alloc,init}_clone are passed a bdev, bio_init() will call
bio_associate_blkg() so the __bio_clone() work to initialize blkcg
isn't needed.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/bio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7892f1108ca6..6980f1b4b0f4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -778,9 +778,6 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_iter = bio_src->bi_iter;
 
-	bio_clone_blkg_association(bio, bio_src);
-	blkcg_bio_issue_init(bio);
-
 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
 		return -ENOMEM;
 	if (bio_integrity(bio_src) &&
-- 
2.30.0

