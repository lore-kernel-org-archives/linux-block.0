Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D661C432BE
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 19:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A8861074
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 19:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhG1TUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhG1TUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 15:20:41 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE6C061757
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 12:20:38 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b20so3369504qkj.3
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6qfKqRI6m4WTJASM6iTIDEeVp83gFU9fVe84XKYU6Y=;
        b=A3zB2BxrkshfLj1hul36dmsxR83ZwIIx8IATAiVAm18rAErkeotKTlhDn7xT5TnALE
         SsHLnr8y7ODufgkIr5xPzIWTu+TI10wW2RiIV6aLPlOn5SbgAL5YjwaDF1weKkx6biRQ
         VtPPWGqI2tJrPVDooy6TLnjaipm3AXs+KjeNLCj92QcUm4f/WFBnih3T6X8GzhRA7uD3
         vZaQPwDwSvfH9nVUhgfJf/w2pH/A8rjXZOSgOD/Kn37j4JPETTgm4YZc6egdcFFsIlZN
         FSD43Tci/OHWigGmrPz5HiJzhxtp44aHmXYXANlgGNmGipYYpFxcMAhjsc2IwmqHb9lQ
         nqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6qfKqRI6m4WTJASM6iTIDEeVp83gFU9fVe84XKYU6Y=;
        b=a9NIIFXFDPGjxswAsM4mQygCNw+Kc0Q9C6u9TCOrKNG/+kxKjx3AZQV7EkvsPDd7px
         8f6N495hDCLIR0TCAOG9Y7fvToDPyd8DiL6iXYkcUdYq+0W88TJ90K7F+s1Rwz/UI0sw
         GKEGPV1WGCPqcQv5+8UBmBUYct9MHgJ3DXJ0bI1DSMWxndkdShM71suv88UwJLsveD9C
         dcjdwgM6E3c7Zxdt5ecJMHZ3A2BsvGO1d4sWwLpvO/u9WMfhhK+V6Cl5o90kgUDSaeYR
         o5SGOH+xgWCI2uqFw+0wW+AbxVor6rd3xmv8MdEyVZqiIbEbk6+F7pRz9VBMJswB5ZDJ
         SWZA==
X-Gm-Message-State: AOAM531UViL7GBSdjUQB7hKiypKJV6uWTC15Sq8J57hq5YA032hVA7HQ
        nGOGz/TksVKE9OCKSPB8CJxTq1fJNu3MzdVuFXkQjbqbURo=
X-Google-Smtp-Source: ABdhPJxANaAhzZ3UvkSECqZTlZDB1UlnPJDdf7/FGnsQF5G3JjPaM70ed3s6veVwwGXMnJVtULZ62m95/1pevSBIiU4=
X-Received: by 2002:a05:620a:1319:: with SMTP id o25mr1256137qkj.396.1627500037010;
 Wed, 28 Jul 2021 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210715202341.2016612-1-mcgrof@kernel.org> <20210715202341.2016612-4-mcgrof@kernel.org>
In-Reply-To: <20210715202341.2016612-4-mcgrof@kernel.org>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Wed, 28 Jul 2021 16:20:01 -0300
Message-ID: <CALJn8nOWtFBnuzqPpuOH6nqikUzZGUYWEnvwCFvmrCrC5MWSmw@mail.gmail.com>
Subject: Re: [RFC 3/6] md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on is_mddev_broken()
To:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org
Cc:     axboe@kernel.dk, hare@suse.de,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 5:24 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/md/md.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 832547cf038f..80561bca1f51 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -766,7 +766,7 @@ static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
>  {
>         int flags = rdev->bdev->bd_disk->flags;
>
> -       if (!(flags & GENHD_FL_UP)) {
> +       if (!(flags & GENHD_FL_DISK_ADDED)) {

Thanks for the patch Luis! And thanks Christoph for looping me in on
the last iteration.
I think specifically for md, both flags are interchangeable - if
add_disk() is not completed, I'm pretty sure we cannot have the array
properly working hence we shouldn't ever reach this check for such
device. Nevertheless, technically speaking Christoph seems correct and
we are checking here in fact if the disk was del_gendisk'ed().
My opinion is that we don't need to change this usage, if possible,
but I'm not strongly against the change if you feel it fits better.

Just double-checking - after del_gendisk(), this flag is removed anyways right?
Oh, and if possible, loop me in CC for next revisions, using this email.
Cheers,


Guilherme
