Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33FC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D32A206B7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRs1AqsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D32A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeLEO7r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:59:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50373 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLEO7r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 09:59:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so11158598wmd.0
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 06:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ppoYVHrvXIn5sQwam+kKuQckR/dRRpKbtLMrTcFlzL4=;
        b=fRs1AqsNSb0jEtDZNSkSQCOg7Sfr/3CbIsITtY0rOIt64yk7zTECnDMZwszchR6NYO
         J1ARpJPV3eE8apcKgD+HtpA/7SVs7UflkaKmbZ3I0zzs0RuU660j6Cv6lEMy//AXuqgV
         Zw3To4njs8C1O8ORiwtIwOHJN2ibrRhynoRj3CUaqjlXm6r/9T+yXY4dFc2IJdlXgJO3
         Vilth7w9Y8ENuKlp6iQxViw7/TiAxIpuKIHQZ2f3/vKCg0EIrwVFGLuGVyjlzdjD937S
         fjbgZcOP7lZQntMea/b6p+YIeZ/4V6GOVP/12Mn8xc+nhfWC89P7lNbRBRSxjCP05jzw
         c7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ppoYVHrvXIn5sQwam+kKuQckR/dRRpKbtLMrTcFlzL4=;
        b=UcvdlixhRbBZwKrh4+8pSLspAlGzIqBWzY5D9ViRFqf9FSRgbgn/6j66iZxkrEZ4Ut
         PBl/yfbyMDNk4ZnApzop2rhiHlDn2bPsiRsTjlgC8D4cnAS2pyoTqrY/kBwB5Rsp3Eo6
         /ENFopprR6/SjPWX9Nai3uu5vGqRjCmpMknnh6QZR8EZmkaeT5XzpC6ULSVRLZqj3b9s
         huq8NMKXqntTtP9sbPblquYOX84CD83ca31iF1JpZSQhaBuel1SHceopspUdMuvK3pIo
         0wny2yWU7tv89khWUNqvyXipH9wdCL7OuHmXY9JrTuDELs00ct9YoKdcRyKDwZk70iUT
         RIYg==
X-Gm-Message-State: AA+aEWbD19LQwFs9JXIKSoVuUTGuA6YvOsKH6RcX27gipy07jVBVf/Px
        22qdET/QWb/TV5xdvWVodXxNp9gF43YgnEkUT4M=
X-Google-Smtp-Source: AFSGD/WhZUgH60gBRfC6Rq+Tjtdw2UQqloMwnEYjVjhdHAK5G0Efsq+vNA5ygQqxOsoUpJAXix6uot/P+6rbpZBN7a0=
X-Received: by 2002:a1c:48c1:: with SMTP id v184-v6mr16635705wma.26.1544021984527;
 Wed, 05 Dec 2018 06:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20181205141701.GA33910@192.168.3.9> <20181205144006.GA18123@infradead.org>
 <CAA70yB5WQPYzptck=miwiBrV7=uixvLKpJrzGEOP9zBU5Y2CwQ@mail.gmail.com>
In-Reply-To: <CAA70yB5WQPYzptck=miwiBrV7=uixvLKpJrzGEOP9zBU5Y2CwQ@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 5 Dec 2018 22:59:31 +0800
Message-ID: <CAA70yB7rD_vqMXUvHrQ8SwH-jAyDZeL58TkqABqJ0Y=-p_pjyg@mail.gmail.com>
Subject: Re: [PATCH v3] block: add documentation for io_timeout
To:     hch@infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, bvanassche@acm.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Weiping Zhang <zwp10758@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Christoph Hellwig <hch@infradead.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:40=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > Can you please also send a patch to not show this attribute for
> > drivers without a timeout handler?  Thanks!
> >
Is there a simple way do that ?

Shall we return -ENOTSUPP when user read/write this attribute when
driver has no timeout handler ?
> Do you means checking q->mq_ops->timeout is NULL or not ?
>
> static void blk_mq_rq_timed_out(struct request *req, bool reserved)
> {
>         req->rq_flags |=3D RQF_TIMED_OUT;
> If it's NULL, only re-start a timer for this request in blk_add_timer.
> Is there some defect ? if show this attribute and the driver doesn't
> support timeout handler =EF=BC=9F
>
>         if (req->q->mq_ops->timeout) {
>                 enum blk_eh_timer_return ret;
>
>                 ret =3D req->q->mq_ops->timeout(req, reserved);
>                 if (ret =3D=3D BLK_EH_DONE)
>                         return;
>                 WARN_ON_ONCE(ret !=3D BLK_EH_RESET_TIMER);
>         }
>
>         blk_add_timer(req);
> }
>
>
> > On Wed, Dec 05, 2018 at 10:17:06PM +0800, Weiping Zhang wrote:
> > > Add documentation for /sys/block/<disk>/queue/io_timeout.
> > >
> > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
> > >  Documentation/block/queue-sysfs.txt   |  7 +++++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/AB=
I/testing/sysfs-block
> > > index dea212db9df3..f254a374710a 100644
> > > --- a/Documentation/ABI/testing/sysfs-block
> > > +++ b/Documentation/ABI/testing/sysfs-block
> > > @@ -271,3 +271,13 @@ Description:
> > >               size of 512B sectors of the zones of the device, with
> > >               the eventual exception of the last zone of the device
> > >               which may be smaller.
> > > +
> > > +What:                /sys/block/<disk>/queue/io_timeout
> > > +Date:                November 2018
> > > +Contact:     Weiping Zhang <zhangweiping@didiglobal.com>
> > > +Description:
> > > +             io_timeout is a request=E2=80=99s timeouts at block lay=
er in
> > > +             milliseconds. When the underlying driver starts process=
ing
> > > +             a request, the generic block layer will start a timer, =
if
> > > +             this request cannot be completed in io_timeout millisec=
onds,
> > > +             a timeout event will occur.
> > > diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/bloc=
k/queue-sysfs.txt
> > > index 2c1e67058fd3..f0c9bbce73fd 100644
> > > --- a/Documentation/block/queue-sysfs.txt
> > > +++ b/Documentation/block/queue-sysfs.txt
> > > @@ -67,6 +67,13 @@ If set to a value larger than 0, the kernel will p=
ut the process issuing
> > >  IO to sleep for this amont of microseconds before entering classic
> > >  polling.
> > >
> > > +io_timeout (RW)
> > > +---------------
> > > +This is a request=E2=80=99s timeouts at block layer in milliseconds.=
 When the
> > > +underlying driver starts processing a request, the generic block lay=
er
> > > +will start a timer, if this request cannot be completed in io_timeou=
t
> > > +milliseconds, a timeout event will occur.
> > > +
> > >  iostats (RW)
> > >  -------------
> > >  This file is used to control (on/off) the iostats accounting of the
> > > --
> > > 2.14.1
> > >
> > ---end quoted text---
