Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD9DC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 19:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiF2T0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiF2T0u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 15:26:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB61393F4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:26:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b133so12821046qkc.6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afkV4rBN6nn1zph/9YW9XobgOkkRmSqKCQvR6HQFXHE=;
        b=A1wzFStzlV6MNXwMz81uHzB775+UoF2Per9X1G8H8qfrm6y2IwhjxAVkRJWUETN7jN
         BZ6s9Rl4CQp/dbNIzsYiV0QQAaoqvlHLsligOboea4Lc68JPQTemhzke7hu4L3IazXu5
         iz0AzD8aHID1LheTFtUvYNP171YlFNlKYA+L0kk+empWqocnk2hfiUnmAn+GYXcuSLy9
         0Kjf3ZC0QjYRZBLawiJ+zILGVrSqdZyVALxrqCCNQha3GGGC7nWmFBbCWSkoO+HplTZi
         J69gQhlMmZhwqPdIpAZ2Amo69yr1Y4cVhoHkI3ruZebwTS/4AepE6sU7Kh4TEDsYPI54
         e/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afkV4rBN6nn1zph/9YW9XobgOkkRmSqKCQvR6HQFXHE=;
        b=mFUGDhun2q06sebVabR43Tt9NUDdybMy946KdEyqRJJ5YmsTU7dpPPRjJS6HRQIQEP
         yc3xbMnzl/ZqYJtNHsNv07T7s0LjQJ5wIBhMlchqi0aZW/UcIF3/RfH1RUFvNPIaMima
         tChpvjtP9cCtHBOhBIBL2l15QsHqO2Z+yBZk4fry3GGyuGB66kOqN9yX+u0CTIvmOSMt
         nhOBQgFznV2MeRhWwcriI7BKTgexvZUidwU8T5NrmE9+4yx2b1B5gPZoQSkCFpT/fxry
         DukLTleQikRWSsRAQsz/EGoK6I2rNfVMy5Nl7Gty9mIz5hKX/rRbLT326dEoiPoZWlje
         7yJA==
X-Gm-Message-State: AJIora8OEyb3clNFwmato1T4GzNbsoMRGm3b/dJPVF8raUCzmB1qju8o
        +XL1BHun7Xzh2F/PxGitNA==
X-Google-Smtp-Source: AGRyM1ubTa/2lTc8XS7wB4e3sKdA8mE1xOYnCVBR33J2Ga2S95V+hyWd5+9QdFDdDCsWGpF3v7llEQ==
X-Received: by 2002:a37:c50:0:b0:6af:46d:c373 with SMTP id 77-20020a370c50000000b006af046dc373mr3461406qkm.659.1656530809118;
        Wed, 29 Jun 2022 12:26:49 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id r8-20020a05620a298800b006a99088cd99sm15411713qkp.6.2022.06.29.12.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:26:47 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:26:46 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220629192646.aoj5c7xdqkifwjdg@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
 <20220629184001.b66bt4jnppjquzia@moria.home.lan>
 <3e15e116-ea64-501d-1292-7b2936b19681@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e15e116-ea64-501d-1292-7b2936b19681@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 01:00:52PM -0600, Jens Axboe wrote:
> On 6/29/22 12:40 PM, Kent Overstreet wrote:
> > On Wed, Jun 29, 2022 at 11:16:10AM -0600, Jens Axboe wrote:
> >> Not sure what Christoph change you are referring to, but all the ones
> >> that I did to improve the init side were all backed by numbers I ran at
> >> that time (and most/all of the commit messages will have that data). So
> >> yes, it is indeed still very noticeable. Maybe not at 100K IOPS, but at
> >> 10M on a core it most certainly is.
> > 
> > I was referring to 609be1066731fea86436f5f91022f82e592ab456. You
> > signed off on it, you must remember it...?
> 
> I'm sure we all remember each and every commit that gets applied,
> particularly with such a precise description of the change.
> 
> >> I'm all for having solid and maintainable code, obviously, but frivolous
> >> bloating of structures and more expensive setup cannot be hand waved
> >> away with "it doesn't matter if we touch 3 or 6 cachelines" because we
> >> obviously have a disagreement on that.
> > 
> > I wouldn't propose inflating struct _bio_ like that. But Jens, to be
> > blunt - I know we have different priorities in the way we write code.
> > Your writeback throttling code was buggy for _ages_ and I had users
> > hitting deadlocks there that I pinged you about, and I could not make
> > heads or tails of how that code was supposed to work and not for lack
> > of time spent trying!
> 
> OK Kent, you just wasted your 2nd chance here. Plonk. There are many
> rebuttals that could be made here, but I won't waste my time on it, nor
> would it be appropriate.
> 
> Come back when you know how to act professionally. Or don't come back
> at all.

Jens, you're just acting like your code is immune to criticism, and I don't have
an eyeroll big enough for that. We all know how you care about chasing every
last of those 10 million iops - and not much else.
