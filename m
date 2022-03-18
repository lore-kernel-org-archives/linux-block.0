Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE48FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 10:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiCRKiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiCRKiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 06:38:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AEE2D8126
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 03:36:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p15so2692210lfk.8
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uezAxvrMiMWp05gtOXieDCRlPfIaBrEY9L+wFxAHD0I=;
        b=bNnyZSbzTBSvQFszb6I/F12rQ8T6cQ/10ECH/5aamuFpcWLXuGwqmi2qlA6OiaUIr+
         V8TqpsR+t0/DyCMoEh0CzqowEErBChoYXYtogqepO3/rN15qn5ixhtqXSUnXgP8ImKUd
         dquYpFAmazrx70ftgNlsqJnMu8VXtOfn5Fycx5s4naSptE35kQcC2TBiqr3KKFo+LcV1
         5c8WxdJ3UMCLZsIfegAevCopkngxCuOIeY3nBuQeeddmK2uDHM1mtQLI5y+HsBtwRACr
         XdDNr/3qHzJL/P06ND/wPSbT5RUHQjnOnE3omFv2FjybosKBFQxhzuagXroaERc3iONq
         RREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uezAxvrMiMWp05gtOXieDCRlPfIaBrEY9L+wFxAHD0I=;
        b=k6mFeT9ahZmTdArTpWo3nR0WJZ5iJZ1hjL4wLg7JRsbckDiQ0agB+fnZLsj3ic8zO9
         lL32d6VFWd+oswnWSh/oqwP34fmkF3wGg2I0iR7wi77wmvtbss4NeJRFhoRb1vfMOrt1
         wYwzxwlq9GKwla9MmnLcEnecelzKdWU16cGIBS2GLVx7Iy+xn2lhCfERotjgdH5oY1u+
         YjoqTs5mpeFz5tt1mJyOIXnZrXqnx1ljfr2vocF/05qc8O8GZrYijlgKOFQHDdgscKah
         A15a2/ooBpWEFKrfB6pNjPtAZcLW8QhZMs07i/yPqWWvN4XXxP5HMAhyQGPd6+5s8RVu
         TK9Q==
X-Gm-Message-State: AOAM531y4Zi0UA0MHVZmVt+UvazTMVKG4qhf3kq9IjALxOLroSqSvTE4
        33gILTWdawCDNlrvcR/DQP3dO3db0SKvCqKodqnFtw==
X-Google-Smtp-Source: ABdhPJzLDlZkIjkcjiJPHs6VSkUvvCx84qJ6fCSn3Un08tTkfHEJ5Nvoc5uZ9+oYemtT0HKnjD8/dVaewJpYQqnDfQA=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr5958247lfr.233.1647599801563; Fri, 18
 Mar 2022 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220316093740.GA7714@lst.de> <20220316093855.GC7714@lst.de>
 <CAPDyKFrH4L2Y2TOFyWPJ+_rrgvJPixR05XX_HWUU99h0MZhLuA@mail.gmail.com> <20220318091152.GB31758@lst.de>
In-Reply-To: <20220318091152.GB31758@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Mar 2022 11:36:04 +0100
Message-ID: <CAPDyKFohNVnrwcZSCGnv7X++FfQ0a3rdeMx3tvJ0eW-Afr9Tyg@mail.gmail.com>
Subject: Re: [PATCH alternative 2] block: fix the REQ_OP_SECURE_ERASE handling
 to not leak erased data
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, jaegeuk@kernel.org, chao@kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 18 Mar 2022 at 10:11, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Mar 17, 2022 at 10:44:01AM +0100, Ulf Hansson wrote:
> > Stating that it can't work is probably not a correct statement.
> > Certainly it can, but it depends on how "secure" (or clever) the
> > implementation of the FTL is in the flash media. I mean, nothing
> > prevents the FTL from doing a real erase on erase block level and
> > simply let the "secure erase" request wait on that operation to be
> > completed.
>
> Well, that assumes it can find all the previous copied of the data.
> Having worked with various higher end SSDs FTLs I know they can't,
> so if an eMMC device could that would very much surpise me given
> the overhead.

An eMMC is no different from an SSD in this regard, so you are most
definitely correct. BTW, I was one of those guys working with FTLs
myself, but it was a long time ago, when NAND/NOR flashes were less
complicated to manage.

Anyway, to really make things work, one would need some additional low
level partitioning  - or commands to tag the data for special
purposes. eMMCs do have some support for things like this, but whether
it actually works to serve this particular use case (secure erase), I
really can't tell.

Kind regards
Uffe
