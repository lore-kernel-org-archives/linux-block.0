Return-Path: <SRS0=oKFV=PD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88636C43387
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 01:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D92421720
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 01:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCswx13F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeLZBvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:51:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43196 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeLZBvi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Dec 2018 20:51:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so14566062wrs.10
        for <linux-block@vger.kernel.org>; Tue, 25 Dec 2018 17:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8MYoYnN5oMnHvyMtSKxhwLSF1IRRW0NOrvfOfqy9gY=;
        b=dCswx13FoBY4tZvzqk1viZxlWau0UOiKR4KBlHxz1at6mQyv7/igBw3WZo/eVVybae
         AoECySx0KPYtqmlCMWBPACQLW+Po9zk5rkSofB8rq7rD1QnXbyu2U+tZmiHMrRr21LRt
         hhBk4CDSGia80IbW9VDk0q1+mdlouhZ47NCLlnrIwlx0/Fo0Gn7mmyCewY5lEcE71PBJ
         PCSj1hzyth1HAFHj7CCEjAjB7oue06WLoyKxiJcZuDkvDJ4GZ0jALLVqa+TfxROg1mw0
         kZStRqu+L54401OstLkBXDWz97k8eh+TZtg8WucthqMNFsHWgaEiNCz8UTTHC9XgnDCh
         OKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8MYoYnN5oMnHvyMtSKxhwLSF1IRRW0NOrvfOfqy9gY=;
        b=PW7TBIzU1IXtNgrfQY8AMJ2s5BhqEEfI7Otdaa1r2jTxUhYgseweth1lTmdxOEUDTy
         UTA6OJMryaIF6w90G64gDdAkx929YJZP+OZF6z2sxfjw+PGYP3XIMnI+tvHsU2uT9277
         9MwLjobIayL6z//rppAAoSox25gU0uTuJguFTWPFFEAO/NtRZB95Cdx7N+UDmaQe2nEL
         HUA+ZehFNRTQf2GXcLRs3aWRa4uMSJ4SauaAZx7g5znyqYQJ9oaCvVF+YUFffcMBCBae
         H5OyEH+v1mOdYO38s//z8lR5AnpJlzrJwoBAhxDSYCqbVJEBDAkGqY+oKvE0qhX0EP2d
         BLYQ==
X-Gm-Message-State: AJcUukcze1acLVHHHqkouvBvk9RW32AoKVVDV0/lh2mQifGNJ2QAhBxV
        yzy6pW26uIod/Vvqi5wnIF+fARoQXzeCGoTVe6Q=
X-Google-Smtp-Source: ALg8bN7iuvCJ3KkiCciDkIldp5MUpDOMn0fLeanO9WxD0T8q2Fdkaywf2Pr6X6i0dfVfjW0mnhiaYTh/OgR7c11a0p4=
X-Received: by 2002:adf:9361:: with SMTP id 88mr16070361wro.204.1545789096246;
 Tue, 25 Dec 2018 17:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20181205141701.GA33910@192.168.3.9> <1544113174.185366.240.camel@acm.org>
In-Reply-To: <1544113174.185366.240.camel@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 26 Dec 2018 09:51:25 +0800
Message-ID: <CAA70yB4LNi=ob31MhL4Pc+uWxvnehbq-CMJjtsNLMC_BM8a2CQ@mail.gmail.com>
Subject: Re: [PATCH v3] block: add documentation for io_timeout
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 2018-12-05 at 22:17 +0800, Weiping Zhang wrote:
> > +Description:
> > +             io_timeout is a request=E2=80=99s timeouts at block layer=
 in
> > +             milliseconds. When the underlying driver starts processin=
g
> > +             a request, the generic block layer will start a timer, if
> > +             this request cannot be completed in io_timeout millisecon=
ds,
> > +             a timeout event will occur.
>
> Sorry but I think this description is still somewhat confusing. How about
> changing that description into the following?
>
>         io_timeout is the request timeout in milliseconds. If a request d=
oes not
>         complete in this time then the block driver timeout handler is in=
voked.
>         That timeout handler can decide to retry the request, to fail it =
or to
>         start a device recovery strategy.
>
Sorry for late reply, thanks for your suggestion I'll post it in V4.
> Bart.

>> > Is there a simple way do that ?
>>
>> How about checking the timeout member of struct blk_mq_ops for blk-mq an=
d
>> checking the rq_timed_out_fn member in struct request_queue for the lega=
cy
>> block layer?
>
>Just the former given that the legacy code is gone in for-next.
>
>> > Shall we return -ENOTSUPP when user read/write this attribute when
> >> driver has no timeout handler ?
> >
> >A much more elegant solution is to introduce a sysfs attribute group for=
 the
> >io_timeout attribute and to make that group visible only if a timeout ha=
ndler
> >has been defined. See e.g. disk_attr_group in block/genhd.c for an examp=
le.
>
>Agreed, that is the way to go.

OK, I'll do that.

Thanks
Weiping
