Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C79C282C2
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0A8218D0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="nNEWwniE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAYJPo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:15:44 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36814 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfAYJPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:15:43 -0500
Received: by mail-vk1-f194.google.com with SMTP id 185so1980449vkc.3
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 01:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CfqQ1Z6m4s/zG4lB3JwG+9674COrG8YbS4ffn1hDPmk=;
        b=nNEWwniErbNNgIa865BF0Yrkl9DFvmu1mOh0GnkwcjQ+wV/qh7d4+yW3fpoP2dPbtF
         SL/x8vk6xN+pHsAgs5/76i93Sz/TZLox41Z5k9mz73MEM5yGTFlg4rm3/CjicVyftcoI
         kSXKIzggWxheK1gsaVKCx0Sg9PGl0n/xPz9dwLWfMDWiqzg4zNZSbI89JUWCXU2b7SfR
         UC1tX6p8/9w33GnwwovQExm01aeqhbbYOX+iNx2X4EuFo8GXfzMul5L75axpsPUesbg/
         dpuaxWQOFBhIm7Bohpq31wKUxduXUwePDWuooUU5StkJyk9IzyttitePcqiNP5MIj184
         LdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CfqQ1Z6m4s/zG4lB3JwG+9674COrG8YbS4ffn1hDPmk=;
        b=gI3caMdiUG7mMcPs8nLBPIeqM68ybW1U4XRSD1yygkT7+Nz5cDf36HkAfoTATEnPuf
         GHKvDTx8+XFw8KyJe0qSI6dsR9MKTcDVAVMyZJQICNrEnNrYi65xdBnmkEnbqUSgyaUW
         cnT0CjFpF4on1xKOqwFAvwhYjCvl5u/Xy2UOoH35XfoUMqXLS2YzJncjn/0J8FvEEvl7
         xuEDUZWr5YgW1zizrBUH6j3mUWiqRUHP40Ki/mBt/1Ib3jwVixNlnpCgUCEOXkx+ZEke
         xsOdy8YE1U17fN8lO3bs24P+Jzl+acJzdSE4csFneX94ydiJxwfIjV4C+FlMvgOaDpQE
         LrFQ==
X-Gm-Message-State: AJcUukdbqf9zmGgRy3WXKENUjmfdXZVnfIrIeQrxq4PH32p2wul3gjg4
        lLEQK8giNZDVnvj+jWWcRVIBxuMbzY4XAzj3PLUT5w==
X-Google-Smtp-Source: ALg8bN7Wp0Ve+fZmpw4S/5aJh6N5Cv6gSxxeB9WHoIwt7i7f11Lc+pLzSb6l2V2p5yvIaWPERoSylXE9krqax1i+xe8=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr4057468vkb.34.1548407742311;
 Fri, 25 Jan 2019 01:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20190122101531.30893-1-hans@owltronix.com> <251D7CB9-A9B0-4474-85A0-B0C23DB31272@javigon.com>
In-Reply-To: <251D7CB9-A9B0-4474-85A0-B0C23DB31272@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 25 Jan 2019 10:15:31 +0100
Message-ID: <CANr-nt04b06LAXm0LUV4wtGM18Qb2UZ2+Kq+D7XC79nyiptUug@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: stop taking the free lock in in pblk_lines_free
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 2:19 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 22 Jan 2019, at 11.15, hans@owltronix.com wrote:
> >
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > pblk_line_meta_free might sleep (it can end up calling vfree, depending
> > on how we allocate lba lists), and this can lead to a BUG()
> > if we wake up on a different cpu and release the lock.
> >
> > As there is no point of grabbing the free lock when pblk has shut down,
> > remove the lock.
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> > drivers/lightnvm/pblk-init.c | 2 --
> > 1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.=
c
> > index f9a3e47b6a93..eb0135c77805 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -584,14 +584,12 @@ static void pblk_lines_free(struct pblk *pblk)
> >       struct pblk_line *line;
> >       int i;
> >
> > -     spin_lock(&l_mg->free_lock);
> >       for (i =3D 0; i < l_mg->nr_lines; i++) {
> >               line =3D &pblk->lines[i];
> >
> >               pblk_line_free(line);
> >               pblk_line_meta_free(l_mg, line);
> >       }
> > -     spin_unlock(&l_mg->free_lock);
> >
> >       pblk_line_mg_free(pblk);
> >
> > --
> > 2.17.1
>
> Can you add a comment too indicating that this is only safe on a single
> threaded shutdown?

To be able to free the lines, we need have stopped anything accessing
the lines first. That seems obvious to me.

It would be nice to make a pass over the code and document pblk's
locking(and other concurrency handling, like the line krefs) though.

Thanks,
Hans

>
> Otherwise the patch looks good.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>
