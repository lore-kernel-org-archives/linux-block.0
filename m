Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB529C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52A161D1A
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhF3Jtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbhF3Jti (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 05:49:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23AC061767
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 02:47:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so3979095wms.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
        b=zLTi5aCbnypPB5E3aUA0ZTW2QZ9ElWO1rUMChAnrYkbnv5R1HppvSR83sz83GmhmUA
         UMxwvrtyn70Zd9AoLodBjAgPxIMvZ1UB4cERbwNt9h4ezFzozjlRXTJceovl8itCNtkO
         ZHpCXotz6yp1b1LU/oBZfpMMbHJ9z37zfQLOhI93YEXu77Z1hvbdB1hXccB0ErO3BuRM
         2v2H3xdjL56voJXkKEkXOJouofN6tE6pWAPsziIGqT+x1uxsqXS8aHT7JlV4vp9xlNdX
         RRmNLJxKm6216ZAGJ10+La1loxmhKlUG8r/gC+MQIkg6soAQE9aR2vguk2YO28brVd4+
         UeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
        b=IUJsX2d5d7SwveP2drdxcESNAW2vajq8hRxbVQaHyOS7vvQ31rtXLjUcGbj5oTjAvV
         dvxBdeiMiimqsfwVYCM/cUyPGh9zxnu7VQM/Mui7FEJm+Z4tqZl9vS0LYkxdHwFhfUAr
         veHdQ+y44MIQln++5OK04bo3JHwLKpS5Uqv3uj9HYgkvpqLgC7z7dFZItNcLzbEEQaVj
         hzrKUhHvJCMDOprqgY4n8Lm9tgToWULvpLnekg7E7lefJgZLPx0u0mh4CBIVMeEQzX53
         f0KkUJ1ze4fMR8QGWrguoDU9/OfgWTrRV8aYZ2gAGgITfBKw0e3Uw4L/l1IHhQ5GElmn
         posA==
X-Gm-Message-State: AOAM532Cy0x+Mcb8SQcs/ZayDS6SpTAB5FdXOC9xzWgUqAMK0XVvkhlF
        iMRzk3QGjr/UAfhRlnD2pSSt6w==
X-Google-Smtp-Source: ABdhPJysgaWNsxoQ1Ekn5yIfyUpjV6tLOTWrZta/4RIlCjFmHAXWqbWe870FTEuNbqmWvtd9IqJeZQ==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr3558850wmd.33.1625046428092;
        Wed, 30 Jun 2021 02:47:08 -0700 (PDT)
Received: from dell ([95.144.13.171])
        by smtp.gmail.com with ESMTPSA id p7sm8990839wrr.68.2021.06.30.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:47:07 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:47:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     Satya Tangirala <satyat@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 0/8] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YNw9me1Fd6Siy18A@dell>
References: <20210121230336.1373726-1-satyat@google.com>
 <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
 <YK09eG0xm9dphL/1@google.com>
 <20210526080224.GI4005783@dell>
 <20210609024556.GA11153@fractal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609024556.GA11153@fractal>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 08 Jun 2021, Satya Tangirala wrote:

> On Wed, May 26, 2021 at 09:02:24AM +0100, Lee Jones wrote:
> > On Tue, 25 May 2021, Satya Tangirala wrote:
> > 65;6200;1c
> > > On Tue, May 25, 2021 at 01:57:28PM +0100, Lee Jones wrote:
> > > > On Thu, 21 Jan 2021 at 23:06, Satya Tangirala <satyat@google.com> wrote:
> > > > 
> > > > > This patch series adds support for direct I/O with fscrypt using
> > > > > blk-crypto.
> > > > >
> > > > 
> > > > Is there an update on this set please?
> > > > 
> > > > I can't seem to find any reviews or follow-up since v8 was posted back in
> > > > January.
> > > > 
> > > This patchset relies on the block layer fixes patchset here
> > > https://lore.kernel.org/linux-block/20210325212609.492188-1-satyat@google.com/
> > > That said, I haven't been able to actively work on both the patchsets
> > > for a while, but I'll send out updates for both patchsets over the
> > > next week or so.
> > 
> > Thanks Satya, I'd appreciate that.
> FYI I sent out an updated patch series last week at
> https://lore.kernel.org/linux-fscrypt/20210604210908.2105870-1-satyat@google.com/

If you end up [RESEND]ing this or submitting another version, would
you mind adding me on Cc please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
