Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C953C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiF2TFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiF2TFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 15:05:44 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1823F1F638
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:05:43 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b133so12774990qkc.6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/ROI7j6XCNaDwyMGvVc2IaTPuaglS7jy5/jfdxPf9U=;
        b=pe1o7G+alGG0g7hsE0pPSPxx/h8OzxySzPJsJj0IHu7lgs3FeIB6vMoXtpkbv9bCAV
         CFOXdwEeIEWukUqJgYFmatkqAmzfCBuVArMemYdymaqRndCpco3+mtjn54yWoHKdXT/p
         t0zIy0Woe3stKaEQwXgVaSc8D8rSPsIJJE6xgAwayzmsR623eTgqdEMBFrVm3vnd/C6p
         GP2nt4ACUazF7laFA3Z/098GYqJzmi+xasAG4JmY6ykSKaMCrKXad2tABhIe6kxg0sqi
         QF40BasbZk6i1EF3/9MH8YZ+mAucalppAhbgpXlSidBU3kg8gWIYcNwQSaF3PowK/h5A
         5zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/ROI7j6XCNaDwyMGvVc2IaTPuaglS7jy5/jfdxPf9U=;
        b=lLDllKbzqCO73cdQtYK4Q0RUcSYLdom6Xq2xNh+PBNEipijrE4Pfi+B+cV9JsXU4j6
         vITgz/sHLHMtKYvjS4Zw3dD0ec6gqXBBSsb227ces61udkQY92Y5IIjOx9dtaOrGWIA0
         b1QFAA1seeskJGVb7fszNriyrNnXXlRY6JWSNghTTIFUSJNPVusMWXoM45ZEoXux6TkY
         XqaKou66MVoMxGdliCFKXLqHS8KBWuRMW2QEblqSuUN+UxVlzPYsWYAEHXS8pIqyjO24
         mu+dVr0AnTyPdOO/+gnue+llBee8Y5pSD6PKWCdfKOL3tbY2Fpyer1u0TNNViq+5DouH
         WTxQ==
X-Gm-Message-State: AJIora8fnQew0LCBBFmp+0enSf4OCB3ODJ7g6511wzHIu9XSfl/qx64t
        kADz4Lq/Ss5QLcJhRzQ2uQ==
X-Google-Smtp-Source: AGRyM1tVeCJUGS2aol+VvZfxynL1eHutTl8RCZi/SI3TvJoy/Vatp2e3ezxQ0Pclb5eXY/ZcZ+EfKw==
X-Received: by 2002:ae9:f718:0:b0:6af:5c0:6cdf with SMTP id s24-20020ae9f718000000b006af05c06cdfmr3381385qkg.426.1656529541996;
        Wed, 29 Jun 2022 12:05:41 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g19-20020ac87d13000000b00307aed25fc7sm11799668qtb.31.2022.06.29.12.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:05:41 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:05:40 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220629190540.fwspv66a4byzqxmg@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
 <20220629184001.b66bt4jnppjquzia@moria.home.lan>
 <486ec9e2-d34d-abd5-8667-f58a07f5efad@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486ec9e2-d34d-abd5-8667-f58a07f5efad@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 11:51:27AM -0700, Bart Van Assche wrote:
> On 6/29/22 11:40, Kent Overstreet wrote:
> > But Jens, to be blunt - I know we have different priorities in the way we write code.
> 
> Please stay professional in your communication and focus on the technical
> issues instead of on the people involved.
> 
> BTW, I remember that some time ago I bisected a kernel bug to one of your
> commits and that you refused to fix the bug introduced by that commit. I had
> to spend my time on root-causing it and sending a fix upstream.

I'd be genuinely appreciative if you'd refresh my memory on what it was. Because
yeah, if I did that that was my fuckup and I want to learn from my mistakes.
