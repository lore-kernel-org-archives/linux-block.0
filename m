Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8823C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 09:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A62147A
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 09:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKpoqBtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCJ5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:57:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCJ5j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 05:57:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so7392520wmc.3;
        Wed, 03 Apr 2019 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5z9tj9vwQxdmP4C9pPg3smpBfu8NuyBtrZ++1CzJ1TE=;
        b=OKpoqBtU2Els+WuT69zZbGU5qTzrWAY3x3auWGWkfqYOcuk1BKesoqxnxEAx9GVvQv
         gA6Jfqron/6GhuO+w381HPVv0PCFMmdKgrJrzJlhhW/jMUzRBn5AQv1Glgsl9yPklceK
         00sxV05xk68aKrg6/X5n9psTATFQKEg76Cw9iKU/LypU1Qi1v8Pqxd5fv+CTQrK/rtVk
         KGwrwszQE2eFOC2jimgW5hzQt4b81gxptWrqv44l2MdlrknxHcGY2RRLUP1YPmuV6Roa
         lknHVP1hqxindrUVkDo6RO1ya0PTkjGG66N3H9oN7B73lpejZBQ50Adc31YatB7eBkiX
         CVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5z9tj9vwQxdmP4C9pPg3smpBfu8NuyBtrZ++1CzJ1TE=;
        b=dp8uXvZ9JM8yztIikR8qRI5zLF9buCSO16OUrmZpKBklFYPejVW+mT6/dpRB2jpjku
         qfdwG+ArlbAqzEsZ3p5fQHgIcTCjW6XnrsKrA72ReUX7T9BbFtpstytjnVfqm8dPgUJO
         VsceAu62V2WSFTM2vjkuwqVtY9uy5OJOM61w7R/HdzT7NtMDq6oqMXt2/sTVzTDaZbzM
         DJbKZFPZH+ETqlj3Z9q53PRr03cSIfZMYhYZ1Ecl/YqR56+bdwChQecVSRLTCBpPV7wR
         0Qrm860UwCP94VYqjc2dhese8MH+AJ0otrTF6jZxAx6garf0yth7+Uqo20KQQrdSM97Q
         C/XA==
X-Gm-Message-State: APjAAAV/SWZB6RVPQ6HlWPQTpKLdeKNB3aFLqs/9oakVphWWWjJphQWf
        ba8x4DBse//5A68KiwXOuJzEH1goFfKLoXmPbbQCRew1
X-Google-Smtp-Source: APXvYqzWC3k1fko4fxPIIUGY2nzswiTVMYEhUWsE33RfkLGOMY+v6JXenvr2Ed/BJ22g4xifjviQB9TSgRE+a2VrTe8=
X-Received: by 2002:a1c:f312:: with SMTP id q18mr1372207wmq.96.1554285457973;
 Wed, 03 Apr 2019 02:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190403091519.13376-1-jthumshirn@suse.de>
In-Reply-To: <20190403091519.13376-1-jthumshirn@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 3 Apr 2019 17:57:25 +0800
Message-ID: <CACVXFVNfNH_OLnmEsZGyvFo_YE9pRvOc=k2rbFRSaf_kpquDKw@mail.gmail.com>
Subject: Re: [PATCH] block: bio: ensure newly added bio flags don't override BVEC_POOL_IDX
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 3, 2019 at 5:16 PM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> With the introduction of BIO_NO_PAGE_REF we've used up all available bits
> in bio::bi_flags.
>
> Convert the defines of the flags to an enum and add a BUILD_BUG_ON() call
> to make sure no-one adds a new one and thus overrides the BVEC_POOL_IDX
> causing crashes.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>
> ---
> This used to be part of my bio patchset but as it's a) not clear why we
> end up calling bio_put() on the on-stack bio and b) the needed prep patch
> for the fix introduces a regression, I've decided to sent this patch out
> as it's valid on it's own.
>
> I dropped Hannes' and Christoph's R-b though, as the context changed.
> ---
>  block/bio.c               |  3 +++
>  include/linux/blk_types.h | 29 ++++++++++++++++-------------
>  2 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 8d516d508ae3..c2592c5d70b9 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -2218,6 +2218,9 @@ static int __init init_bio(void)
>         bio_slab_nr = 0;
>         bio_slabs = kcalloc(bio_slab_max, sizeof(struct bio_slab),
>                             GFP_KERNEL);
> +
> +       BUILD_BUG_ON(BIO_FLAG_LAST > BVEC_POOL_OFFSET);
> +
>         if (!bio_slabs)
>                 panic("bio: can't allocate bios\n");
>
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 791fee35df88..be418275763c 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -215,21 +215,24 @@ struct bio {
>  /*
>   * bio flags
>   */
> -#define BIO_NO_PAGE_REF        0       /* don't put release vec pages */
> -#define BIO_SEG_VALID  1       /* bi_phys_segments valid */
> -#define BIO_CLONED     2       /* doesn't own data */
> -#define BIO_BOUNCED    3       /* bio is a bounce bio */
> -#define BIO_USER_MAPPED 4      /* contains user pages */
> -#define BIO_NULL_MAPPED 5      /* contains invalid user pages */
> -#define BIO_QUIET      6       /* Make BIO Quiet */
> -#define BIO_CHAIN      7       /* chained bio, ->bi_remaining in effect */
> -#define BIO_REFFED     8       /* bio has elevated ->bi_cnt */
> -#define BIO_THROTTLED  9       /* This bio has already been subjected to
> +enum {
> +       BIO_NO_PAGE_REF,        /* don't put release vec pages */
> +       BIO_SEG_VALID,          /* bi_phys_segments valid */
> +       BIO_CLONED,             /* doesn't own data */
> +       BIO_BOUNCED,            /* bio is a bounce bio */
> +       BIO_USER_MAPPED,        /* contains user pages */
> +       BIO_NULL_MAPPED,        /* contains invalid user pages */
> +       BIO_QUIET,              /* Make BIO Quiet */
> +       BIO_CHAIN,              /* chained bio, ->bi_remaining in effect */
> +       BIO_REFFED,             /* bio has elevated ->bi_cnt */
> +       BIO_THROTTLED,          /* This bio has already been subjected to
>                                  * throttling rules. Don't do it again. */
> -#define BIO_TRACE_COMPLETION 10        /* bio_endio() should trace the final completion
> +       BIO_TRACE_COMPLETION,   /* bio_endio() should trace the final completion
>                                  * of this bio. */
> -#define BIO_QUEUE_ENTERED 11   /* can use blk_queue_enter_live() */
> -#define BIO_TRACKED 12         /* set if bio goes through the rq_qos path */
> +       BIO_QUEUE_ENTERED,      /* can use blk_queue_enter_live() */
> +       BIO_TRACKED,            /* set if bio goes through the rq_qos path */
> +       BIO_FLAG_LAST
> +};
>
>  /* See BVEC_POOL_OFFSET below before adding new flags */

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
