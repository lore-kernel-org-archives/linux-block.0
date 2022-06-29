Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87CBC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiF2Tu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiF2Tu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 15:50:28 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE841DA41
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:50:27 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id z1so9178371qvp.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NcdUTjmMiq15qzZoGka90GPHW1G+61I7lzpRQwsVmx8=;
        b=hs1LOskTFwnLn0DAjOAqpUE7KB1BujxULdd76MShzM5XgkOBGOK2BFTs8Ccb0GJBqm
         b3IaYTROCIXounRyAf+rCeQeavlmHjDJSN9lYxdRCcEdYNkKzWzj8MSJebcrs3tuD7xG
         DvTvQaIR5WjxHvNjY02RS4J0maIbDFI9KhuY1ql1u5DdogSuEvnRNU+JEhrbkBr65kGo
         YwRLQZMZUAInVZ+bXC3WzQeNeaUy3csOUGn2TMYMTbdBH+whmspNovTeaS2/euMfU3LI
         4/UhFDA+hK+8iVwWZ6JmrXO0ReerXziX8/xinCkB+h3nXOyq12q8Qz8ScUbMLp0ITO3s
         3JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NcdUTjmMiq15qzZoGka90GPHW1G+61I7lzpRQwsVmx8=;
        b=2Y/3x0tArlhPPtrvJuLHnsqCcmDNudYnujhxM1aUVileQCu5cR1nWzUSAfNYgWLljl
         u19sAQFFr6T542sgdawEpxZ7SSJVWkjzWvslBBfjriCghtLJUsVbzBJ1Wi5Fx1YoiYtp
         JYnC0LUs1DGZ8+PNhV5HzdUCfDO1lHhcdcW/TLF1Yqx7hur1Nw+Ldmymhi5Xo2PdNyTZ
         tTl2RPasYcVu7Gr8QpxDJflBk4reahZvq4RC7seu10Q/ORwsmTvRZIubpD3sDCssHSUK
         04wVfOJ5F+X8/jcgWlBfG6VBhlBvHJWz3ah14EcKgZIWJeVRqq53cMv4AsnM2upBl/fu
         tOCg==
X-Gm-Message-State: AJIora+DSwGnFxiedECNWDcJyYI/N02NzmXERlzteujwll0lraPEvx48
        vwC5k0RVAUd2HYmqH0ra5A==
X-Google-Smtp-Source: AGRyM1v/EeCDMtPB2OY0rjuSz2sM6wW1C1DrePeXrTyAVsNXCHoOEl9CLBSNhd/wgxef86eeQ0iz6w==
X-Received: by 2002:ac8:7d52:0:b0:319:51f0:e418 with SMTP id h18-20020ac87d52000000b0031951f0e418mr4149475qtb.481.1656532226717;
        Wed, 29 Jun 2022 12:50:26 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bm9-20020a05620a198900b006a73ad95d40sm13568984qkb.55.2022.06.29.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:50:26 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:50:25 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220629195025.zqggtojkgt7bqvky@moria.home.lan>
References: <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
 <20220629184001.b66bt4jnppjquzia@moria.home.lan>
 <486ec9e2-d34d-abd5-8667-f58a07f5efad@acm.org>
 <20220629190540.fwspv66a4byzqxmg@moria.home.lan>
 <75aa2055-0f50-47ce-b9cc-8f79eba77807@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aa2055-0f50-47ce-b9cc-8f79eba77807@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 12:37:59PM -0700, Bart Van Assche wrote:
> On 6/29/22 12:05, Kent Overstreet wrote:
> > On Wed, Jun 29, 2022 at 11:51:27AM -0700, Bart Van Assche wrote:
> > > On 6/29/22 11:40, Kent Overstreet wrote:
> > > > But Jens, to be blunt - I know we have different priorities in the way we write code.
> > > 
> > > Please stay professional in your communication and focus on the technical
> > > issues instead of on the people involved.
> > > 
> > > BTW, I remember that some time ago I bisected a kernel bug to one of your
> > > commits and that you refused to fix the bug introduced by that commit. I had
> > > to spend my time on root-causing it and sending a fix upstream.
> > 
> > I'd be genuinely appreciative if you'd refresh my memory on what it was. Because
> > yeah, if I did that that was my fuckup and I want to learn from my mistakes.
> 
> I was referring to the following two conversations from May 2018:
> * [PATCH] Revert "block: Add warning for bi_next not NULL in bio_endio()" (https://lore.kernel.org/linux-block/20180522235505.20937-1-bart.vanassche@wdc.com/)
> * [PATCH v2] Revert "block: Add warning for bi_next not NULL in bio_endio()" (https://lore.kernel.org/linux-block/20180619172640.15246-1-bart.vanassche@wdc.com/)

Oh yeah, that.

So, we had - still have - a situation where we have a struct bio field, bi_next,
that's used in different ways by different chunks of code, and where that field
being left in an indeterminate state when bios are being handed off across
module boundaries was likely to be a source of bugs. And having debugged one of
those I decided to introduce a check, and then when that broke device mapper (an
unfortunate sitation I agree) you decided to just... revert the check I added.

Like I said, I would have been happy to fix the device mapper code if I'd been
able to get your tests working (did we ever get this added to blk-tests?) - but
I wasn't MIA on the list and I would've been happy to work with you on this.

Was there something you thought I should've done differently?
