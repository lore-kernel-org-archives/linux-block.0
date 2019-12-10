Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89EC2D0B1
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E9620663
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+GxJASG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfLJGaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:30:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46960 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfLJGaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 01:30:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id f15so11907782lfl.13;
        Mon, 09 Dec 2019 22:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L6jPrprQadsFkjVs7M2+ie2lIeuZ6l3uv7h9nAdlHbw=;
        b=s+GxJASGfcqo4Y05xsFfbX4tcLxCj+iwnRJiBr/iHHhb4uRsZapDn7+vEYTR3vh+Jz
         3VxGVR7HU/AydAY8pCCPb4nMT4/Cwoe1pkQKODR9ItMVv7R4yOKU0gJItqdy4xlzAjUK
         iJuBl+dBsbo8s0UPvioaE3qlSErwLOAV0ykhSyCcK2pytQcJWXESDqVEvPwbRNrYphWD
         7f+uhTogTx/+uCG3RxUjCk8DdfpHTBbUG28dRBUKWHkmTljXNDWDNHSoHuZR2Tx9Lmhp
         R9vSjzJ/kVpZzDp+SnfbaKjfwp64xn8jeQRggrjO656ysnNZEgkhXgWdmj2CfRSZT2yq
         7R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L6jPrprQadsFkjVs7M2+ie2lIeuZ6l3uv7h9nAdlHbw=;
        b=gLy3DUPI/Ks7w16T1B6DnkSaBsEsqTkR7piiDzK6pU+y3lFpbFxvt2dQTvu2nI17Jr
         tw2Gef3qJe7E7uUyowZSnoZWd9d3+BZX597ZtfSh5pnSTrGPaJe3JP06hsnBkdRU0u72
         k7ZWchscIgZOgC41BPA6H9PRVAQF9+WPYmZQ59Ou7tFCyDtMyU05TJmCMQJ7Lk4S7lFF
         MDwOBAOqkWbi4JayDBz7QUSJoBwW6LVWFHqu6iyUj6sSaFCPlZYOenyyndqHtwh5ToC8
         mjk5iJrqmmNco1+zxQVa4wlHChM6a8hjEPtJwNmpB3x67muktlE0i1WBWdEIhjOxh1Vb
         WCag==
X-Gm-Message-State: APjAAAWZ/ztHfE4/vm4NnCBnQp5t3MyHYFPZwKmcVoIV2eRCUu6r0+Pr
        F0/rlW0VCofzGzSG5xfeXBkoy+3wUj5UPSi4XhQ=
X-Google-Smtp-Source: APXvYqzS4WEz7RM60ft05c4AwdsFFB4/bWr5skRRN3mawetMj/dt4wZA9rJUWPkadh3DzPQSOuvRKTAMgCaPCGRCvfk=
X-Received: by 2002:ac2:531b:: with SMTP id c27mr17324318lfh.91.1575959419127;
 Mon, 09 Dec 2019 22:30:19 -0800 (PST)
MIME-Version: 1.0
References: <20191209194305.20828-1-sjpark@amazon.com> <20191209194305.20828-2-sjpark@amazon.com>
 <4be85067-a1cc-224e-6629-06034df2b7e6@suse.com>
In-Reply-To: <4be85067-a1cc-224e-6629-06034df2b7e6@suse.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 10 Dec 2019 07:29:52 +0100
Message-ID: <CAEjAshrUp-uZL4fWTMEWQ3T=kB=vsUCKOdUE2rRFDMNjuCfdQw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] xenbus/backend: Add memory pressure handler callback
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     SeongJae Park <sjpark@amazon.com>, Jens Axboe <axboe@kernel.dk>,
        konrad.wilk@oracle.com, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, pdurrant@amazon.com,
        roger.pau@citrix.com, xen-devel@lists.xenproject.org,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 7:23 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wro=
te:
>
> On 09.12.19 20:43, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Granting pages consumes backend system memory.  In systems configured
> > with insufficient spare memory for those pages, it can cause a memory
> > pressure situation.  However, finding the optimal amount of the spare
> > memory is challenging for large systems having dynamic resource
> > utilization patterns.  Also, such a static configuration might lacks a
> > flexibility.
> >
> > To mitigate such problems, this commit adds a memory reclaim callback t=
o
> > 'xenbus_driver'.  Using this facility, 'xenbus' would be able to monito=
r
> > a memory pressure and request specific domains of specific backend
> > drivers which causing the given pressure to voluntarily release its
> > memory.
> >
> > That said, this commit simply requests every callback registered driver
> > to release its memory for every domain, rather than issueing the
> > requests to the drivers and domain in charge.  Such things would be a
> > future work.  Also, this commit focuses on memory only.  However, it
> > would be ablt to be extended for general resources.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >   drivers/xen/xenbus/xenbus_probe_backend.c | 31 ++++++++++++++++++++++=
+
> >   include/xen/xenbus.h                      |  1 +
> >   2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xe=
nbus/xenbus_probe_backend.c
> > index b0bed4faf44c..cd5fd1cd8de3 100644
> > --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> > +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> > @@ -248,6 +248,34 @@ static int backend_probe_and_watch(struct notifier=
_block *notifier,
> >       return NOTIFY_DONE;
> >   }
> >
> > +static int xenbus_backend_reclaim(struct device *dev, void *data)
> > +{
> > +     struct xenbus_driver *drv;
> > +     if (!dev->driver)
> > +             return -ENOENT;
> > +     drv =3D to_xenbus_driver(dev->driver);
> > +     if (drv && drv->reclaim)
> > +             drv->reclaim(to_xenbus_device(dev), DOMID_INVALID);
>
> Oh, sorry for first requesting you to add the domid as a parameter,
> but now I realize this could be handled in the xenbus driver, as
> struct xenbus_device already contains the otherend_id.
>
> Would you mind dropping the parameter again, please?

Oh, I also missed it!  Will do!


Thanks,
SeongJae Park

>
>
> Juergen
