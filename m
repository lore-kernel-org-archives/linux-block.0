Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 17:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbiDKRSV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348807AbiDKRSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 13:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD8B414020
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649697364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DrLtcPmwGcrIqCcNfbaH7A6AhGFi5Av5dx06PW0cZzY=;
        b=bBP6PO98Ljw9Zemhnf+3dqU1qVcmaoibXGVk6aaxxsRwVf4cdtVT4sqUF/dyF5/Z465GbI
        /nTOZiHFEojB5xqJwKvCzrAei+NL51UZTG/KoXkkbr681+XI+SBSisO1E2L4lGyCYvE4So
        RHsQ822VoLpnqZ/owRMlNlKKXvHyi3s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-uUt06PGfOamvUaYC9S3TZQ-1; Mon, 11 Apr 2022 13:16:03 -0400
X-MC-Unique: uUt06PGfOamvUaYC9S3TZQ-1
Received: by mail-qk1-f199.google.com with SMTP id br18-20020a05620a461200b0069bfc9fdb0dso3221131qkb.21
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 10:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrLtcPmwGcrIqCcNfbaH7A6AhGFi5Av5dx06PW0cZzY=;
        b=yoSgdldubgC+jACBRHaq0qG3m2LC+TZPZHg0voW1+0c+uh2TA/E1A8mwpHK/rcrDJR
         G+Jvbjr3/2YYK9SeN7uEp9wAvD/fPHxSiagwjmDzOIZedhC1B5eq/DfOCO7jlXksc5S4
         US5gDX1BMk4iI69O/bP3M0Z1eNvX2AkGg3udgkJ5Y82eN6IpfZSgR4NyrpxYQXQprAfB
         HozPfO9fbq6HujN3KYxAwUEQil5OCJjqrrhrhiFUrTaXWb2I7yJmnUQH7SSBBpl7uenT
         VZywAHUap2nKNNo3EzAjTqdPHpCk9sPeg0avUSOAD5CgzFzR6n8XbYMhp96adWMNfO7j
         yUhQ==
X-Gm-Message-State: AOAM530zF62I3PqKoF5pxTVqbgPNBioHLSq9BGTrdh2+H1veWOx5uQJZ
        UFxvpsEp37mGD4ojb4/X8LdzBnSfiQs7GJF3+nGRg/nrYTcJ3oNo0/ZIpK2pZaKv1ThicGx0c+6
        pECckqU8oHCyEQ/nuYT17Lg==
X-Received: by 2002:ac8:7d88:0:b0:2e1:cd8d:3dda with SMTP id c8-20020ac87d88000000b002e1cd8d3ddamr276896qtd.351.1649697362657;
        Mon, 11 Apr 2022 10:16:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx9YRN19sGQAWmu6437r4Zhh/5vkMYh+H+zxQ4tgPbWv84LGnK+bGBDSJIkc/rmX2AFrWkHw==
X-Received: by 2002:ac8:7d88:0:b0:2e1:cd8d:3dda with SMTP id c8-20020ac87d88000000b002e1cd8d3ddamr276879qtd.351.1649697362384;
        Mon, 11 Apr 2022 10:16:02 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id br35-20020a05620a462300b0067e890073cbsm21822458qkb.6.2022.04.11.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:16:02 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:16:01 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, tj@kernel.org,
        axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YlRiUVFK+a0DwQhu@redhat.com>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
 <YlEWfc39+H+esrQm@infradead.org>
 <YlReKjjWhvTZjfg/@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlReKjjWhvTZjfg/@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 11 2022 at 12:58P -0400,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Sat, Apr 09 2022 at  1:15P -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Fri, Apr 08, 2022 at 11:42:51AM -0400, Mike Snitzer wrote:
> > > I think we can achieve the goal of efficient cloning/remapping for
> > > both usecases simply by splitting out the bio_set_dev() and leaving it
> > > to the caller to pick which interface to use (e.g. clone vs
> > > clone_and_remap).
> > 
> > You can just pass a NULL bdev to bio_alloc_clone/bio_init_clone.
> > I've been hoping to get rid of that, but if we have a clear use case
> > it will have to stay.
> 
> DM core is just using bio_alloc_clone. And bio_alloc_bioset() allows
> bdev to be NULL -- so you're likely referring to that (which will skip
> bio_init's bio_associate_blkg).
...

> diff --git a/block/bio.c b/block/bio.c
> index 7892f1108ca6..0340acc283a0 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -772,14 +772,16 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
> 	bio_set_flag(bio, BIO_CLONED);
> 	if (bio_flagged(bio_src, BIO_THROTTLED))
> 		bio_set_flag(bio, BIO_THROTTLED);
> -	if (bio->bi_bdev == bio_src->bi_bdev &&
> -	    bio_flagged(bio_src, BIO_REMAPPED))
> -		bio_set_flag(bio, BIO_REMAPPED);
> 	bio->bi_ioprio = bio_src->bi_ioprio;
> 	bio->bi_iter = bio_src->bi_iter;
> 
> -	bio_clone_blkg_association(bio, bio_src);
> -	blkcg_bio_issue_init(bio);
> +	if (bio->bi_bdev == bio_src->bi_bdev) {
> +		if (bio_flagged(bio_src, BIO_REMAPPED))
> +			bio_set_flag(bio, BIO_REMAPPED);
> +
> +		bio_clone_blkg_association(bio, bio_src);
> +		blkcg_bio_issue_init(bio);
> +	}
> 
> 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
> 		return -ENOMEM;
> 
> Think this will fix some of the performance penalty of redundant blkcg
> initialization that I reported (though like was also discussed: more
> work likely needed to further optimize bio_associate_blkg).

Looking closer at the case where bio_{alloc,init}_clone are passed a
bdev, bio_init() will call bio_associate_blkg() so the __bio_clone()
work to do anything with blkbg isn't needed at all. So this patch is
best:

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

