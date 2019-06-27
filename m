Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6682C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 10:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3CB20828
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 10:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvwhDRjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0KYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:24:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33601 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0KY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 06:24:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so1016992pfq.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fYF54IvA4gU4yHe1fPxhOf/iWEqU6Urg8Sv5WY0nD9s=;
        b=JvwhDRjBtOeBX+y8cyJeJxF+hnvpfaf2RaQO5xnU3dCiTxfvQluFojIBgnt88PJ/Sg
         YJtN45L2SP1u1t55vxuPuLmuu5ytoQtvnIJE0sDPrkR6HKGTHxldBhvfaLBegKZogepq
         LtJszO3Inym/LlgHupS89F1p7HpNtCtegwPDbzGmfntl9BV/G0Xj+xRcLl3xdfw4yWNs
         No3aybn7Bfv5VCjAzOYitd8bQW+ljx28osZ5rLlR7D4oRreDFSTWj9liLnrYC/VN+mu5
         ILOJDjGkD7hYsH7BGfRFqapP3hhxXBlCOcupqmePn0n7s82xKBP490NYo1j95JtV9c6J
         zM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fYF54IvA4gU4yHe1fPxhOf/iWEqU6Urg8Sv5WY0nD9s=;
        b=OAprOgPZ/dj5cowzGQdO/LOm1wjxwQo3WC2UoY7FpiFXyx5i4s6+2MSkz/rZVsdrME
         4I+0kUyAbVAMeWhtQmqO38mqwnGPnfV77uJ5OFgYPdniQo3GGPIuSsdcLicuZxbG+m4G
         XUmwue3n2Y71VSos9wTx8M6i+RL5BsHsqLJR1He3r9CgDiD+7tTTcnBkWf//GVcX/Ufu
         PcOY9amGCpAXGCr7LCW4YtTDtUwE18OgVPP6dA+c2BQ6TPd/cU+eNUFywz9dTn+ad3ac
         1ogTcTJpfYINw0b/c90yb1uFeJr1Z3m49OxmfZNLO5+kcBOPM/pWrYO1dsPn7f1ajL/n
         +0FA==
X-Gm-Message-State: APjAAAUlLSU6o5usTsSUS5WfVjP1ZabmJAXP++F7a0JW59eDCL+7goNG
        2uf1VQ5njJ0OlVEayv2wpAg=
X-Google-Smtp-Source: APXvYqwUtDzFGTNjgaytGMd9GzsA8xJcmhG3JYevgVNfybmcuL3Tn/+OU7eBhdkUzmCv33jtUIJkcQ==
X-Received: by 2002:a65:5304:: with SMTP id m4mr3087564pgq.126.1561631068781;
        Thu, 27 Jun 2019 03:24:28 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id j14sm2180013pfe.10.2019.06.27.03.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 03:24:28 -0700 (PDT)
Date:   Thu, 27 Jun 2019 19:24:26 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 2/9] block: optionally mark pages dirty in
 bio_release_pages
Message-ID: <20190627102426.GB4421@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-3-hch@lst.de>
 <20190626205247.GH4934@minwooim-desktop>
 <108F1585-0711-4D2C-9E99-0E404D4E173B@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <108F1585-0711-4D2C-9E99-0E404D4E173B@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-27 00:21:27, Chaitanya Kulkarni wrote:
> 
> 
> ﻿On 6/26/19, 1:52 PM, "linux-block-owner@vger.kernel.org on behalf of Minwoo Im" <linux-block-owner@vger.kernel.org on behalf of minwoo.im.dev@gmail.com> wrote:
> 
>     On 19-06-26 15:49:21, Christoph Hellwig wrote:
>     > A lot of callers of bio_release_pages also want to mark the released
>     > pages as dirty.  Add a mark_dirty parameter to avoid a second
>     > relatively expensive bio_for_each_segment_all loop.
>     > 
>     > Signed-off-by: Christoph Hellwig <hch@lst.de>
>     > ---
>     >  block/bio.c         | 12 +++++++-----
>     >  include/linux/bio.h |  2 +-
>     >  2 files changed, 8 insertions(+), 6 deletions(-)
>     > 
>     > diff --git a/block/bio.c b/block/bio.c
>     > index 9bc7d28ae997..7f3920b6baca 100644
>     > --- a/block/bio.c
>     > +++ b/block/bio.c
>     > @@ -845,7 +845,7 @@ static void bio_get_pages(struct bio *bio)
>     >  		get_page(bvec->bv_page);
>     >  }
>     >  
>     > -void bio_release_pages(struct bio *bio)
>     > +void bio_release_pages(struct bio *bio, bool mark_dirty)
>     >  {
>     >  	struct bvec_iter_all iter_all;
>     >  	struct bio_vec *bvec;
>     > @@ -853,8 +853,11 @@ void bio_release_pages(struct bio *bio)
>     >  	if (bio_flagged(bio, BIO_NO_PAGE_REF))
>     >  		return;
>     >  
>     > -	bio_for_each_segment_all(bvec, bio, iter_all)
>     > +	bio_for_each_segment_all(bvec, bio, iter_all) {
>     > +		if (mark_dirty && !PageCompound(bvec->bv_page))
>     > +			set_page_dirty_lock(bvec->bv_page);
>     
>     Christoph,
>     
>     Could you please explain a bit why we should not make it dirty in case
>     of compound page?
> 
> Maybe because of [PATCH 7/9] block_dev: use bio_release_pages in bio_unmap_user :-
> 
> @@ -259,13 +258,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> 	}
> 	__set_current_state(TASK_RUNNING);
> -	bio_for_each_segment_all(bvec, &bio, iter_all) {
> -		if (should_dirty && !PageCompound(bvec->bv_page))
> -			set_page_dirty_lock(bvec->bv_page);
> -		if (!bio_flagged(&bio, BIO_NO_PAGE_REF))
> -			put_page(bvec->bv_page);
> -	}
> -
> +	bio_release_pages(&bio, should_dirty);
> 
> I'll let Christoph confirm that.

Chaitanya,

Thanks for sharing this.  Actually I have seen that commit log but
didn't catch up why the compound pages are so.  Now I understood what
Christoph has mentioned.

Thanks for your help, again.
