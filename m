Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A71C433F5
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiDKRAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiDKRAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 13:00:35 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE102A7
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 09:58:21 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id 75so8321402qkk.8
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9NaM/bqnDmwmZW9IjiKDhdbhCbXASVz0XNirNdhkOw=;
        b=sZEBTmva1j2hHU2Gdmw3s7cNKvtIRhIxaZBluEc7kq5g7s/r0hoXCWr4Ekd+9K5F7C
         9nIRppF2rBcBkBRbh2FTfMpVgeye0jypPWwOFI8Nsgs0b/TUCGfC8awMEgTDJcvffXGT
         xY6Q7AX/WcZzr0MfurcmQY7gVeqEuyRkurq00ngZ5FLEROu18g8Wx68brlc7DgaZHIgA
         WRhaExLgEAUM1IHGYkDC/U3Io5C4HSkSqTSTlF+bQVTjt31zToyEk6vrQHQmOdAA2HfC
         8XZSAUK1VTAwqDSxe6THkembFlwformXGcjBwWyqqThdfUhTvmmYKiFS6S0cH6uqmnRC
         rmnQ==
X-Gm-Message-State: AOAM532FArRysBsnddT786b9GEV9Ae4C/GmDMeyCutCeUbl1pf7Ctwa/
        nh85rwsZH3ukLs2cl0Bk4Ts5
X-Google-Smtp-Source: ABdhPJzneUy68CPhWIxGkvWUcDlTbElnOZi5WfODKQ97gn0Po+Vl0ctS1z0DBoq/zxAjz93pxGyBcQ==
X-Received: by 2002:a05:620a:404f:b0:69a:5ca1:32fc with SMTP id i15-20020a05620a404f00b0069a5ca132fcmr230560qko.676.1649696300198;
        Mon, 11 Apr 2022 09:58:20 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h186-20020a376cc3000000b00699c789a757sm14602815qkc.132.2022.04.11.09.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 09:58:19 -0700 (PDT)
Date:   Mon, 11 Apr 2022 12:58:18 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dennis Zhou <dennis@kernel.org>, tj@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YlReKjjWhvTZjfg/@redhat.com>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
 <YlEWfc39+H+esrQm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlEWfc39+H+esrQm@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 09 2022 at  1:15P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Apr 08, 2022 at 11:42:51AM -0400, Mike Snitzer wrote:
> > I think we can achieve the goal of efficient cloning/remapping for
> > both usecases simply by splitting out the bio_set_dev() and leaving it
> > to the caller to pick which interface to use (e.g. clone vs
> > clone_and_remap).
> 
> You can just pass a NULL bdev to bio_alloc_clone/bio_init_clone.
> I've been hoping to get rid of that, but if we have a clear use case
> it will have to stay.

DM core is just using bio_alloc_clone. And bio_alloc_bioset() allows
bdev to be NULL -- so you're likely referring to that (which will skip
bio_init's bio_associate_blkg).

Circling back to earlier in this thread, Dennis and you agreed that it
doesn't make sense to have __bio_clone() do blkcg work if the clone
bio will be remapped (via bio_set_dev).  Given that, and the fact that
bio_clone_blkg_association() assumes both bios are from same bdev,
this change makes sense:

diff --git a/block/bio.c b/block/bio.c
index 7892f1108ca6..0340acc283a0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -772,14 +772,16 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
	bio_set_flag(bio, BIO_CLONED);
	if (bio_flagged(bio_src, BIO_THROTTLED))
		bio_set_flag(bio, BIO_THROTTLED);
-	if (bio->bi_bdev == bio_src->bi_bdev &&
-	    bio_flagged(bio_src, BIO_REMAPPED))
-		bio_set_flag(bio, BIO_REMAPPED);
	bio->bi_ioprio = bio_src->bi_ioprio;
	bio->bi_iter = bio_src->bi_iter;

-	bio_clone_blkg_association(bio, bio_src);
-	blkcg_bio_issue_init(bio);
+	if (bio->bi_bdev == bio_src->bi_bdev) {
+		if (bio_flagged(bio_src, BIO_REMAPPED))
+			bio_set_flag(bio, BIO_REMAPPED);
+
+		bio_clone_blkg_association(bio, bio_src);
+		blkcg_bio_issue_init(bio);
+	}

	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
		return -ENOMEM;

Think this will fix some of the performance penalty of redundant blkcg
initialization that I reported (though like was also discussed: more
work likely needed to further optimize bio_associate_blkg).

I'll audit DM targets and test to verify my changes and will post
proper patch(es) once done.

Mike
