Return-Path: <SRS0=ZTaq=6Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63013C54E49
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 10:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FA7208E4
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 10:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coKUnaOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgEJKDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 06:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgEJKDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 06:03:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA948C061A0C
        for <linux-block@vger.kernel.org>; Sun, 10 May 2020 03:03:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so14604998wmb.4
        for <linux-block@vger.kernel.org>; Sun, 10 May 2020 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OKNbPh/QzejDHThCyzcFtoYUPKfdh8W/M9uU0GmcYMs=;
        b=coKUnaOMw5oNatbcZt3ASi51Tk+ER/IbpzDqPhGwNt5TZX7y3Jvu3p46OVo7aevcT1
         lK1W6H7EbdN7SY4QMTkqYhflYf7fhXvJNCDxhy3ts/J+82Z03WcTxtbOeeyQwl3Wsp2o
         6+CfinS+p1PHi+LmMy/yGmUjq1pQAglqZr/RGMPXcOsfY8pymfV+8tsBBy37fm3QdOac
         eXg9XT1kn8RLdZPZZd7REIsdwjYITSYSOPBc+/ffU/zRqdhmKkkLkijQS1BX/yzP9eCf
         7RE1tt4tp66uH91COYCc4bGu/0r9+Bl7ut+qujAy3ht9VcTWKIvINJlCEnEjLXOhN6IV
         AU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OKNbPh/QzejDHThCyzcFtoYUPKfdh8W/M9uU0GmcYMs=;
        b=haMUybfE2vQshf69k4MAHfTC6vjG9646xcLA+Onh6BauDM27qoJTzTp66zIsq17E/D
         Ct9f2xP0qm2Q+GAxmcVO4sBO5cdf6VJJHSLA+K4DkSVV8jByuR4NevxNzKKViKPtkVbJ
         s+w2JcL9ZodudVnFIo/abhFX1xn8WfciL8iUyMIie3ClPgluCum1dO1dgE5rBNI7h1hM
         8VnXBQhU16/oVFSf/SAcBbOFQHZN1qc8++qOfJMEG3iNnOYtDz59bBHSb3nypaCRwYof
         hbBDYs/RFukXbyGUgYDjg9lb+fn3pqTq/RNafe4+2vc6X41nbV4Gd/FfrUECvZdlCSn6
         MuSg==
X-Gm-Message-State: AGi0PuYGa5OwFVyGGb4tsK6tX46MbMr++gOCorCximVlfuz1PL+XWjIR
        0JoQb4qvBUmN3XS29/5gTMvEd4DtDW+kLCAw3gDyDAQTL0M=
X-Google-Smtp-Source: APiQypKfN7OC61BiQ+gHqgOLXR3z82Ofu9IH3jE8nX+pj9laRd+KEzFsEvAsALOzUXczZFfvKjM+e8jQ06iLTNmiYJw=
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr26657792wmj.21.1589105016058;
 Sun, 10 May 2020 03:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk> <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Sun, 10 May 2020 12:03:24 +0200
Message-ID: <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(+Damien Le Moal)
(more context at
https://lore.kernel.org/linux-block/CAG_fn=3DVBHmBgqLi35tD27NRLH2tEZLH=3DY+=
rTfZ3rKNz9ipG+jQ@mail.gmail.com/)

On Mon, Nov 25, 2019 at 5:01 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 11/22/2019 03:58 AM, Alexander Potapenko wrote:
> > I'm using the following patch in KMSAN tree to suppress these bugs:
> >
> > diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_mai=
n.c
> > index 0e7da5015ccd5..9e8e99bdc0db3 100644
> > --- a/drivers/block/null_blk_main.c
> > +++ b/drivers/block/null_blk_main.c
> > @@ -1235,8 +1235,16 @@ static blk_status_t null_handle_cmd(struct
> > nullb_cmd *cmd, sector_t sector,
> >          if (dev->memory_backed)
> >                  cmd->error =3D null_handle_memory_backed(cmd, op);
> >
> > -       if (!cmd->error && dev->zoned)
> > +       if (!cmd->error && dev->zoned) {
> >                  cmd->error =3D null_handle_zoned(cmd, op, sector, nr_s=
ectors);
> > +       } else if (dev->queue_mode !=3D NULL_Q_BIO) {
> > +               /*
> > +                * TODO(glider): this is a hack to suppress bugs in nul=
lb
> > +                * driver. I have no idea what I'm doing, better wait f=
or a
> > +                * proper fix from Jens Axboe.
> > +                */
> > +               cmd->error =3D null_handle_rq(cmd);
> > +       }
>
> This is just based on what I read in the code, I don't have
> the kmsan support.
>
> null_handle_rq() should not be called without checking the
> dev->memory_backed value since it handles memory backed operation,
> (it may be working because of the correct error handling done
> in the copy_from_nullb() when t_page =3D=3D NULL).

Thanks for the explanation!
The code has changed recently, and my patch does not apply anymore,
yet the problem still persists.
I ended up just calling null_handle_rq() at the end of
null_process_cmd(), but we probably need a cleaner fix.

> Possible explanation could be for the above code fixing the problem
> is:-
>
> null_handle_cmd()
>         None of the ifs are handled (since it is default behavior)
>         calls null_handle_rq()
>                 Processes each bvec in this request :-
>                 rq_for_each_segment()
>                         calls null_transfer()
>                                 calls copy_from_null()
>
> Now here in copy_from_null(), null_lookup_page() returns
> NULL since it is not present in the radix tree(dev and cache
> since its !membacked && !cache_size I assume since I don't have
> the command line of modprobe null_blk),
>
> and then does the dest memset():-
>
> (from linux-block for-next)
> 1009                 if (!t_page) {
> 1010                         memset(dst + off + count, 0, temp);
> 1011                         goto next;
> 1012                 }
>
> which initializes the destination page to 0. This is what Jens
> is referring to I guess that we need to memset() it for the
> read when !membacked.
>
> It will be great if you can verify the above code path on your
> setup with above memset().
>
> The above patch does fix the problem but it is very confusing.
>
> What we need is to traverse the rq bvec and actually initialize
> the bvec.page and repeat the pattern present in the copy_from_null()
> in such a way this common code is shared between membacked and
> non-membacked mode for REQ_OP_READ.
>
> Jens can correct me if I'm wrong.
>
> I'll be happy to look into this if Jens is okay.
>
> >
> > It appears to fix the problem, but I'm not really sure this is the
> > right thing to do (e.g. whether it covers all invocations of
> > null_handle_cmd(), probably not)
> > I don't see an easy way to memset() the pages being read, as there're
> > no pages at this point.
> >
>
>
> >> >--
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
