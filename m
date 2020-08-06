Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545CAC43461
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A96F221E2
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ArwYzW2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHFHpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHFHpU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 03:45:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2670C061574
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 00:45:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so40976755ljd.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmOfIhD7pMcaWHY+0xHQeIpwIq2AsQ5CzuRIyGHtlGw=;
        b=ArwYzW2akB4SfUoNGdF55uLqSVWax0Vt6YpckHqsqDIMeaWWEHZVcGcIcOC1DQb8oW
         fZDvVwdbKnG+Uow1whCydPtp5HUIEHRCxmbR6YgsThjOF16HjZS3YnZBRNARKaivtP6A
         p552D8aa+ry/87XnqcuM5noo8tHIfRgmKHj+GM23IURzS6GDjB7rIl35fcTvWEXPwzs/
         s2sXw5POYFGxDM9fcZ9nrFfVBXu1zyJq6eZVkRguJjangGf1/uGDgUnrnX+4+qMdDaaB
         eVMiXis9xLUQAaWOz9Xa25yd2rAzlYG0QXoTWjXFCQwaW9hkV+lvG4Kh3uKyQy/yhOdo
         3EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmOfIhD7pMcaWHY+0xHQeIpwIq2AsQ5CzuRIyGHtlGw=;
        b=arPKPISnds5ULZjW2NOR1oNOZnlwvfo1FmkdF9CzXYkRx7p+CdOQ2YTYbi82LSqTIM
         7WSSh9uHEDUAK4UnLFSAR1OrEplM/3JxOFo646zP8sEMZgkA5qQTbOM/PMkbvFJcxMv5
         FSTRSgFZyQntoKjhgBAdTaZWjCCHoZ1OFW1VoIZoUAM/xeF5fQCMn1FNZfiAFHeqcz5C
         b9/RDfqjvkgVnw4jC+ozpgqJ3zAxyyYDPvMzzkzimpO1BLopHkO9WFUEdCGQZ7smI3OM
         9f36kraRRq6zfEeDxETeG/7kqdxKvQhyhR7Jx+hMeuJbfiN4kbut9VXME/iAQmj1f2sV
         Vx+g==
X-Gm-Message-State: AOAM533FL2C/xW0/RfgSNN3tbbHwPC7Mw+AcaXMxu7bG5yd50imDHeoT
        Bo3H1mrk27Jz/CqfS4NOPrY3bVxhSFZM3RMhqf6Y+V6M
X-Google-Smtp-Source: ABdhPJxiNTyDusCrZ90U66dkipos8QykQVGe5cpgKsAbDaOzNKTd4MV0t2mt8om6onviF6GW/VRXxxUB2E9h3ZfiL+A=
X-Received: by 2002:a2e:9913:: with SMTP id v19mr3019001lji.292.1596699916133;
 Thu, 06 Aug 2020 00:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <1591929831-2397-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <d2a8b662-a99a-104c-b749-c10293f71211@cn.fujitsu.com>
In-Reply-To: <d2a8b662-a99a-104c-b749-c10293f71211@cn.fujitsu.com>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 6 Aug 2020 09:45:05 +0200
Message-ID: <CAB0TPYEvfCSCNyBZTB5hMF2AfcV5jLMr0jyxmpjfeyvSwYcwUA@mail.gmail.com>
Subject: Re: [PATCH] loop: Remove redundant status flag operation
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yang,

Thanks for the patch! I think it's correct, but I wonder whether it's
confusing to read, especially since the comment says "For flags that
can't be cleared, use previous values too" - it might not be obvious
to the reader that ~SETTABLE is a subset of ~CLEARABLE, and they might
think "well what about the settable flags we just cleared?"

To be honest I wouldn't mind leaving the code as-is, since it more
clearly describes what happens, and presumably the compiler will be
smart enough to optimize this anyway. But if you have other ideas on
how to remove this line and make things easier to understand, let me
know.

Best,
Martijn

On Sat, Aug 1, 2020 at 5:04 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> Hi
> Ping.
>
> > Since ~LOOP_SET_STATUS_SETTABLE_FLAG is always a subset of ~LOOP_SET_STATUS_CLEARABLE_FLAGS
> > ,remove this redundant flags operation.
> >
> > Cc: Martijn Coenen <maco@android.com>
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > ---
> >   drivers/block/loop.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index c33bbbf..2a61079 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1391,8 +1391,6 @@ static int loop_clr_fd(struct loop_device *lo)
> >
> >       /* Mask out flags that can't be set using LOOP_SET_STATUS. */
> >       lo->lo_flags &= LOOP_SET_STATUS_SETTABLE_FLAGS;
> > -     /* For those flags, use the previous values instead */
> > -     lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
> >       /* For flags that can't be cleared, use previous values too */
> >       lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
> >
> >
>
>
