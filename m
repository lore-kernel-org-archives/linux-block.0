Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC3C47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 12:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBE220722
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 12:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GN28oAOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEKM6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728000AbgEKM6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 08:58:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D98C061A0C
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 05:58:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j5so10847840wrq.2
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xgo/W1NTLOik3Gx/GLdLFPd2eOnb6jseacsx6/zbNYQ=;
        b=GN28oAOFyMLC3eH61pR/o4vAqZFpnTDzqczW9ZsELEz22P5qN0clea3CxZ1Z/+PUxR
         xfU8edWHtSawVOs9ss2ygpCTBMJ2+9U3vMmQs1RGmIUnguWs0L2hz/3m9IehLJoh9/cq
         NddR53RE7ACKIONdyBnzBeyNldZh3DtDbNlv2gtjdEX1IhgcY2e6Dobvf/RphcQZQgwt
         LFSSepULaOF6ASe4LtqlEZlw4b9QYkQJK4SvL/p1H8WKVk9lFolJh9M4moAHuEe4Gbd9
         hKVB3cLpkDST3dMQZpSpkaXbFf08vIq/MpzksSjL6nWnaaRulG3GCc/YZo1EdnAn8oIr
         2Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xgo/W1NTLOik3Gx/GLdLFPd2eOnb6jseacsx6/zbNYQ=;
        b=IJ/LnihePNBwf0ccUHncm3FeAh4ZadPtf2XaBsnv+5FJkC9GDPCKYS1tI5B6SEK0QH
         QC1v7bHKwtji78XUrMUtha7assrX2WQRuHJQvy56gk3l5+zrwpEKvBk1mGGWGwatNM+V
         JZG4YVogGfbm3oLTpCJPgXvCn62omLtR8xuRRED9+7k4KndkZy9vPOF+EEgKC3bcnbXz
         6svI6J6CNfclt7GlppHDVgYlVfjMzcSMB8Xa+x9F02rK4dMOwuepobCDXpx8GTmwzFJg
         Hbo+95H6RJ6hejx0s0DfVtEdrXR1cVKi660XiF0HoCb+foBWxg+y2rzQaYTmLWkICxMd
         QsUQ==
X-Gm-Message-State: AGi0PuZBzJVGue5DURlKTbhNJALgnZW8H5Ykjrpr0FsfCc8/cqK8iDec
        Mi+e74IUFSySuBCw7R/+Cr5xOZ5v2uhArOf4Zr4+Lw==
X-Google-Smtp-Source: APiQypI2ntEi+1N5Y3AwLECWfi+aJ7i/YLH5yAXPeoFEYswSY4x8mWRCz1Ev+N61nXRTwiPQdIA31YEr1wGi3ESlmXc=
X-Received: by 2002:a5d:5682:: with SMTP id f2mr18339836wrv.382.1589201893419;
 Mon, 11 May 2020 05:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk> <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com> <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
In-Reply-To: <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 May 2020 14:58:02 +0200
Message-ID: <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 10, 2020 at 6:20 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-05-10 03:03, Alexander Potapenko wrote:
> > Thanks for the explanation!
> > The code has changed recently, and my patch does not apply anymore,
> > yet the problem still persists.
> > I ended up just calling null_handle_rq() at the end of
> > null_process_cmd(), but we probably need a cleaner fix.
>
> Does this (totally untested) patch help? copy_to_nullb() guarantees that
> it will write some data to the pages that it allocates but does not
> guarantee yet that all data of the pages it allocates is initialized.

No, this does not help. Apparently null_insert_page() is never called
in this scenario.
If I modify __page_cache_alloc() to allocate zero-initialized pages,
the reports go away.
This means there's no other uninitialized buffer that's copied to the
page cache, the nullb driver just forgets to write anything to the
page cache.

> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c
> index 8efd8778e209..06f5761fccb6 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -848,7 +848,7 @@ static struct nullb_page *null_insert_page(struct
> nullb *nullb,
>
>         spin_unlock_irq(&nullb->lock);
>
> -       t_page =3D null_alloc_page(GFP_NOIO);
> +       t_page =3D null_alloc_page(GFP_NOIO | __GFP_ZERO);
>         if (!t_page)
>                 goto out_lock;
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
