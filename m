Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26288C432BE
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40D460E53
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 13:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhGWM21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhGWM21 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 08:28:27 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6CAC061575;
        Fri, 23 Jul 2021 06:08:59 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id d16so375436vkp.4;
        Fri, 23 Jul 2021 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kVBfC6co2VsHDzY9tpVsgW1qF6lGCAzJxuznl8I/9GE=;
        b=S7yHpcB0mbS1di7E5oWpwhpxwwZ2/SiAg+gx57RoBO0r4PvBN81gZFYvQSTBVXpkri
         YUOnreKPJdPh9H7ClkUAZtgq0HexnNabAP1nftaQovyy214cqPbsC6xU4xPi1+6HF1aQ
         0/j1uTvscTLhK0PE1Z7bgekrYAnESQqxHVEzA9/3FtLOiv9IYrictiJcIOD9tYL/8BhY
         j6G4P7zHrG+t5k0sGGAWuPMDn1svydRZ908pPwvtPqK6FntCVHG2lDxUUv55YIWuRAgq
         egB46wg9CNEMt/9XXbGl7Q0krzeJRHgSKKZUd3NZO93FEIN9Sb3pTNA48ud83njIAzza
         XADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kVBfC6co2VsHDzY9tpVsgW1qF6lGCAzJxuznl8I/9GE=;
        b=eywsFOmv784Gw5Yckw01Gz/2Na5yfO5kYtO5UbfvYX5tSxjAAubPYw+vZz4WPQUmnb
         yGKqmhaXRHIPRbc9RV8nHfuZj93wJ11/dAZXMDa2RE/tnY65qS2g8FpPfbtk1SD24qoz
         T5j3QtsTx/mZz1wbkVcN4qAnygd7jVRIvZSXME4zFNvohBLEwY+FRJzZI9TYk4SMhIAF
         3bXHcBz2wP4exALn/nw9MKDAlbrNe0ajnJLH3OGIGpwLTggdTFIxmU9D9Jklu6XYRLtR
         RNateaKpUrnACuYfsuhVyaG6WcC1CkPrwotHCoPAlDN20L33QKxQE3hJSiym0s+Ql6dL
         59Rw==
X-Gm-Message-State: AOAM5328ZzETKEnGqgoivO3GeVzjy+qFpcxDn4v9FFb8aXu2q0jk2ely
        rzLJYreWVNga3Ppj+gb7Z2dCHdZSQCa/K5QTBTU=
X-Google-Smtp-Source: ABdhPJzm4WOjliZN4J/jn8+c1kgtEDm9FOG1JP5fQJzmTsotnWi265Upc6UbXRPTWQZb1IP+PBk1yHG5isNcMSmo9bU=
X-Received: by 2002:ac5:c888:: with SMTP id n8mr3669958vkl.22.1627045738539;
 Fri, 23 Jul 2021 06:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxxVEVwj=hGa+FoQUV6i7BtoUbiJwGunnRq26Fp=Ax2ziQ@mail.gmail.com>
 <8057650.rSI8SBESIY@natalenko.name> <98103103-c517-59d2-a4d6-9b0758cbdfc1@kernel.dk>
In-Reply-To: <98103103-c517-59d2-a4d6-9b0758cbdfc1@kernel.dk>
From:   jim.cromie@gmail.com
Date:   Fri, 23 Jul 2021 09:08:32 -0400
Message-ID: <CAJfuBxwJam5=s3Rr06RyLoO19s3HTBomnNi6P3dw59s_b7we+Q@mail.gmail.com>
Subject: Re: 5.14.0-rc1 KASAN use after free
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 18, 2021 at 5:58 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/18/21 3:08 PM, Oleksandr Natalenko wrote:
> > + Paolo, Jens et al.
> >
> > On =C4=8Dtvrtek 15. =C4=8Dervence 2021 16:32:29 CEST jim.cromie@gmail.c=
om wrote:
> >> hi all,
> >>
> >> I noticed this report this morning, from 3 days ago,
> >> about 10 minutes after boot.
> >> Its easiest to ignore it, and I dont want to make a fuss,
> >> but it looks useful to someone
> >>
> >>
> >> [   33.663464] Bluetooth: RFCOMM ver 1.11
> >> [  646.343628]
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [
> >> 646.343649] BUG: KASAN: use-after-free in bfq_get_queue+0x47d/0x900 [
> >> 646.343680] Read of size 8 at addr ffff88810d864a00 by task
> >> journal-offline/1639
>
> There are only a few commits between 5.13 and master in this area, see
> attached. I'd just start reverting from the top, one by one, and see
> which one is causing the issue. Jim, would that be feasible?
>

oops, didn't see this earlier.
It hasnt happened since, I can try to recreate mid-next-week


> --
> Jens Axboe
>
