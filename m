Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D9BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 04:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiF1EUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiF1EUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 00:20:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F429837
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 21:20:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c137so8820411qkg.5
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 21:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOuetpAXYSYI+dzBjT/ncBTsh7x4YoeNdtNMml9Z8Vg=;
        b=GJ2YmWwAhOYzYydCNlT+r8vR64TzK5QXRM+qPq+WbQdZNTaFz9dJ8zmyNy+mKAoXvk
         JTSUfoJBlVSwqUlXHcHLcQUH7NhZfiKumrfhPC3639TJ0lzWA3SXRFnhoqMgsRtqhLR+
         DJEewMlTwOTLpaOcbSr3DOaWDKmzOaAWTvJb8zNnj2VXwGSLCiwMdjTSWBumWo41AzGW
         c/mGkqYkvKNlQi5WNdyUeJdF/9KMqJ8Tmx/6DbpVxP8ctbuyylb5C4aQc7fzfU70+p2J
         IOrVKhwcEsNuk1lBQY2QYZX+NUgC5ILY81Y1hMq610hv3hr2I7VFP2T0P3IjaYC8FKll
         +hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOuetpAXYSYI+dzBjT/ncBTsh7x4YoeNdtNMml9Z8Vg=;
        b=Eb9z3fTHHOvHjBFPP1HBytauDpnfKuzZX07VJBHPmNpqgg3QNLHInClY1vFB9ww4tX
         R5qNODLQ91MMrByMrufIbFiAMmh1TO9bTchmEZ6oMkR1xuBE8x9yps4YX3V9HOVaD2qC
         84kh049RlfoCXLG02KrhnHKqbZ/aK1TG2BbszYB8la1uc8xWUvQRav39X/V+MABgZm4l
         WqG2Uc/udq5zjpA4N8oItDIR2jOPRDQ3YL4xBwn3g//Me3oHu5irbaDSe0bLJl6V7GWQ
         hNtNUYp0UY0MrRjFPGkD22edH53ykAACj3JP9OTtuf0UAlHCQZMmJqVhJNhlk2+qxK0S
         qRug==
X-Gm-Message-State: AJIora9yUCa1ud+rp6mw2QJ/BHulCkhCpJykSQ28UTXm8OlxDlak3xj8
        A2Ugxm4UNphIMH+V8ZMIGQ==
X-Google-Smtp-Source: AGRyM1seI9Ly0gshnChuPHs+Ql1zrzPSXLVpiTv/8F70O4T0r7+GLobK6iMGePdGlK7xTkzAQvRojQ==
X-Received: by 2002:a05:620a:3183:b0:6af:40c:284d with SMTP id bi3-20020a05620a318300b006af040c284dmr10154393qkb.433.1656390017553;
        Mon, 27 Jun 2022 21:20:17 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m5-20020ac84445000000b00307beda5c6esm8132383qtn.26.2022.06.27.21.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:20:16 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:20:16 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220628042016.wd65amvhbjuduqou@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrld9rLPY6L3MhlZ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
> On Sun, Jun 26, 2022 at 04:14:58PM -0400, Kent Overstreet wrote:
> > On Fri, Jun 24, 2022 at 10:12:52PM +0800, Ming Lei wrote:
> > > Commit 7759eb23fd98 ("block: remove bio_rewind_iter()") removes
> > > the similar API because the following reasons:
> > > 
> > >     ```
> > >     It is pointed that bio_rewind_iter() is one very bad API[1]:
> > > 
> > >     1) bio size may not be restored after rewinding
> > > 
> > >     2) it causes some bogus change, such as 5151842b9d8732 (block: reset
> > >     bi_iter.bi_done after splitting bio)
> > > 
> > >     3) rewinding really makes things complicated wrt. bio splitting
> > > 
> > >     4) unnecessary updating of .bi_done in fast path
> > > 
> > >     [1] https://marc.info/?t=153549924200005&r=1&w=2
> > > 
> > >     So this patch takes Kent's suggestion to restore one bio into its original
> > >     state via saving bio iterator(struct bvec_iter) in bio_integrity_prep(),
> > >     given now bio_rewind_iter() is only used by bio integrity code.
> > >     ```
> > > 
> > > However, it isn't easy to restore bio by saving 32 bytes bio->bi_iter, and saving
> > > it only can't restore crypto and integrity info.
> > > 
> > > Add bio_rewind() back for some use cases which may not be same with
> > > previous generic case:
> > > 
> > > 1) most of bio has fixed end sector since bio split is done from front of the bio,
> > > if driver just records how many sectors between current bio's start sector and
> > > the bio's end sector, the original position can be restored
> > > 
> > > 2) if one bio's end sector won't change, usually bio_trim() isn't called, user can
> > > restore original position by storing sectors from current ->bi_iter.bi_sector to
> > > bio's end sector; together by saving bio size, 8 bytes can restore to
> > > original bio.
> > > 
> > > 3) dm's requeue use case: when BLK_STS_DM_REQUEUE happens, dm core needs to
> > > restore to the original bio which represents current dm io to be requeued.
> > > By storing sectors to the bio's end sector and dm io's size,
> > > bio_rewind() can restore such original bio, then dm core code needn't to
> > > allocate one bio beforehand just for handling BLK_STS_DM_REQUEUE which
> > > is actually one unusual event.
> > > 
> > > 4) Not like original rewind API, this one needn't to add .bi_done, and no any
> > > effect on fast path
> > 
> > It seems like perhaps the real issue here is that we need a real bio_iter,
> > separate from bvec_iter, that also encapsulates iterating over integrity &
> > fscrypt. 
> 
> Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
> hold in per-io data structure. With this patch, 8bytes is enough
> to rewind one bio if the end sector is fixed.

Hold on though, does that check out? Why is that too big for per IO data
structures?

By definition these structures are only for IOs in flight, and we don't _want_
there to ever be very many of these or we're going to run into latency issues
due to queue depth.
