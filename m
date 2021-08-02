Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4625CC4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297E360EBC
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 18:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhHBSXM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhHBSXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 14:23:10 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59AC061760;
        Mon,  2 Aug 2021 11:23:01 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id t25so5436222uar.13;
        Mon, 02 Aug 2021 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6ApN7kLqibhyq1qI7/ZsZatouw7YTs2JP48UHp8aQ/A=;
        b=lsUKFilECheVKjSF1JXecXfsKOXJnDixp3QcQmPbn5tKCVnyKquYeKSCqr9duESTs1
         eQKJveOEWYkZ2y42vAPA3JWEFqGchWZCl6XIv0ixEyewqTy7BKCWtqqODu5T9cwyLEZa
         +cZKYYgeQwvBYkB3DTM9w9Uy+QOrrSLjlrqiwkZCYHiq5/YniokYTzaRXXfA+WQj/HvI
         5wEEct/cFVaQHmdVxPLkrXsGnOQwkxcH7fBoAE2TRomWXFF6i3xKFOcKMkerwzTG9a6Z
         dm3qOSrsFhGvIWhB+qgz428NcKQLvI2QxTn8Pl0bTbraBd2B3lj5vboE+g2HQOq/iCh6
         3oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6ApN7kLqibhyq1qI7/ZsZatouw7YTs2JP48UHp8aQ/A=;
        b=fe0NvzOUPQKKya1S0dc4ZdQRbeeU6lNXQCx0jpw/Pw4mQPTaDUJYkZJ3FJy/wRjljL
         /SrxXLQs8hEE6KHrkxJ6xz4nH46Lg01TPyWlrTjv1cDQR4Rh2KjAt1wj9BakR73aW1v8
         MgvDTzFCNehl8iz1O2cfr3ARm6cu34jGRW80H86CzRWZ8LAKZXgYm8kpg/e2/4RdzJei
         gW7+O+YXPzboQhVyOckSWt2Ay1zNFhjkiwJddCNG2yFAZlk0JcSCo+B6JP+2HFsNNcR1
         Zw9saTjzI/neF0WT3Bt7dmGCn4eIhI5kLKf0u4sp1EnMP+I0j5N5exsPP03ScNQYxCWO
         m4LQ==
X-Gm-Message-State: AOAM531dXqsNKeSN6P+PWMZR2szNSi2ESKTMaw3OeBS5ji/J7OgEGBt3
        wT4qponuHw/zGjYHijGgFIeDA23c4vGMwVmUN6E=
X-Google-Smtp-Source: ABdhPJxOGW9lt2I4UeiOBWzfIUEg64BUWAC2wuJshjV0PXtCqkZkrJ/D3hYer3ZuXL4h9KAqQ9EEcAaYjSF9+V0eGOQ=
X-Received: by 2002:ab0:7187:: with SMTP id l7mr11832750uao.13.1627928580293;
 Mon, 02 Aug 2021 11:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxxVEVwj=hGa+FoQUV6i7BtoUbiJwGunnRq26Fp=Ax2ziQ@mail.gmail.com>
 <8057650.rSI8SBESIY@natalenko.name> <98103103-c517-59d2-a4d6-9b0758cbdfc1@kernel.dk>
 <CAJfuBxwJam5=s3Rr06RyLoO19s3HTBomnNi6P3dw59s_b7we+Q@mail.gmail.com> <FE6B2429-5846-4EE8-896A-691BD11C76D0@linaro.org>
In-Reply-To: <FE6B2429-5846-4EE8-896A-691BD11C76D0@linaro.org>
From:   jim.cromie@gmail.com
Date:   Mon, 2 Aug 2021 12:22:34 -0600
Message-ID: <CAJfuBxxVD-A0uSB6gOAUj_FDi=kKNSRvavBCPxAGu_b=f3QrnQ@mail.gmail.com>
Subject: Re: 5.14.0-rc1 KASAN use after free
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 2, 2021 at 8:21 AM Paolo Valente <paolo.valente@linaro.org> wro=
te:
>
>
>
> > Il giorno 23 lug 2021, alle ore 15:08, jim.cromie@gmail.com ha scritto:
> >
> > On Sun, Jul 18, 2021 at 5:58 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 7/18/21 3:08 PM, Oleksandr Natalenko wrote:
> >>> + Paolo, Jens et al.
> >>>
> >>> On =C4=8Dtvrtek 15. =C4=8Dervence 2021 16:32:29 CEST jim.cromie@gmail=
.com wrote:
> >>>> hi all,
> >>>>
> >>>> I noticed this report this morning, from 3 days ago,
> >>>> about 10 minutes after boot.
> >>>> Its easiest to ignore it, and I dont want to make a fuss,
> >>>> but it looks useful to someone
> >>>>
> >>>>
> >>>> [   33.663464] Bluetooth: RFCOMM ver 1.11
> >>>> [  646.343628]
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [
> >>>> 646.343649] BUG: KASAN: use-after-free in bfq_get_queue+0x47d/0x900 =
[
> >>>> 646.343680] Read of size 8 at addr ffff88810d864a00 by task
> >>>> journal-offline/1639
> >>
> >> There are only a few commits between 5.13 and master in this area, see
> >> attached. I'd just start reverting from the top, one by one, and see
> >> which one is causing the issue. Jim, would that be feasible?
> >>
> >
> > oops, didn't see this earlier.
> > It hasnt happened since, I can try to recreate mid-next-week
> >
>
> Still nothing?
>

Nada.

up to an hour ago, I was still running that installed kernel.
I just rebooted to it and ran a virtme session on it
(because of a possible 9p related trigger)
no sign of kasan err.

Im gonna boot rc4 built in the same build-dir,
I dont think Ive messed with the config,
but its a long-shot anyway to reproduce,
since same kernel image didnt do it 2nd time.


> Thanks,
> Paolo
>
> >
> >> --
> >> Jens Axboe
>
