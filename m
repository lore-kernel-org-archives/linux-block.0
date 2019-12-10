Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11C4C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8538206D5
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwjhEEqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLJGU1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:20:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45880 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfLJGU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 01:20:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so12665507lfa.12;
        Mon, 09 Dec 2019 22:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jv//fc1VPzyc+MNAsiN7TquFe8yzj3we6ZRj3X1mR00=;
        b=nwjhEEqFWHgdt7GcskJDmpuj3JQ6GgLRuMmIWw6ew5Pe1AlHuPb/kNgkY6UbbWf/nV
         0Nxxbp7JtxbIWFD+mwB12W1o13HMGfeRyDupDkdAlMtQQTKb50geCspTGO6+cse+klui
         V3wsKUraWC6uWYeKN1y0zYqwOufAElbN3bP5lGSx9DTdBYeYcQ+G7hmkN7p2sah5vwAr
         XcClaUU/W3cAGDsogtO2Oi+IiZoCCa+orrJTucBey2OVgNPweO8lbw+l1vK0q5VM6yY1
         FTfuN5knCSTU95Ifmd7gxdrn5t6iCv91xSDHzI5iNFpaedvjFXTHKLGwm+Q8FPfCTExF
         OWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jv//fc1VPzyc+MNAsiN7TquFe8yzj3we6ZRj3X1mR00=;
        b=nbxImwX4MWwVMGsGLNK3dG6WglerT72NSmjtAYC695YFDiYFkCI2kHipOLQL9kc89z
         fnhz3T3Y7qq35u/xPO3ERGBCxaJgLIi2s7xVaRqx9kL548c/GpMJbEopk43ABeuIR/RO
         qxsfOBHGmsup/FL4gaAgAYrbWIV1yR/QZIi7nJHO5rD0SEWx83FNl2lIPxAOwDE4OK6H
         3zWu1P9vXKIxc0WHzQPonk5orENJ/vTFGo1pBiNqwNMMj15Ijq8SkSsvUS5JReJDxZz7
         /jrCSEhEJxXTsXctDRxuFqYBVnDKEjZvL34DKgtICW72rgvPgHUTrqZ84ArN1Dnb4iPH
         vpzA==
X-Gm-Message-State: APjAAAXxj8ydYRhB5ULFEotU3xzwckPs6952dXdBI1qchtRXd1mJ2UZk
        qIA0lJ+/uLHFXCluySEf3esURRtruZLa9yrMKRs=
X-Google-Smtp-Source: APXvYqyS0TFkIrszmllm1gFo+1Pqhy+E7YQmUTRI7t9cOOtybqrCk6UxIdDQrEHQ6tJeW5fDrNFEyZx+GuLyWPaGlbM=
X-Received: by 2002:a19:6a06:: with SMTP id u6mr13880006lfu.187.1575958823690;
 Mon, 09 Dec 2019 22:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20191209194305.20828-1-sjpark@amazon.com> <20191209194305.20828-2-sjpark@amazon.com>
 <2aca11d5-38ba-e924-c38e-e48c52c915c6@suse.com>
In-Reply-To: <2aca11d5-38ba-e924-c38e-e48c52c915c6@suse.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 10 Dec 2019 07:19:57 +0100
Message-ID: <CAEjAshpqjByUcJpmkTU4ukm3pPn0hDfRfB=Rh_vh81ajr9z1Tw@mail.gmail.com>
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

On Tue, Dec 10, 2019 at 7:11 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wro=
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
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Returns 0 always because we are using shrinker to only detect memor=
y
> > + * pressure.
> > + */
> > +static unsigned long xenbus_backend_shrink_count(struct shrinker *shri=
nker,
> > +                             struct shrink_control *sc)
> > +{
> > +     bus_for_each_dev(&xenbus_backend.bus, NULL, NULL,
> > +                     xenbus_backend_reclaim);
> > +     return 0;
> > +}
> > +
> > +static struct shrinker xenbus_backend_shrinker =3D {
> > +     .count_objects =3D xenbus_backend_shrink_count,
> > +     .seeks =3D DEFAULT_SEEKS,
> > +};
> > +
> >   static int __init xenbus_probe_backend_init(void)
> >   {
> >       static struct notifier_block xenstore_notifier =3D {
> > @@ -264,6 +292,9 @@ static int __init xenbus_probe_backend_init(void)
> >
> >       register_xenstore_notifier(&xenstore_notifier);
> >
> > +     if (register_shrinker(&xenbus_backend_shrinker))
> > +             pr_warn("shrinker registration failed\n");
> > +
> >       return 0;
> >   }
> >   subsys_initcall(xenbus_probe_backend_init);
> > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > index 869c816d5f8c..52aaf4f78400 100644
> > --- a/include/xen/xenbus.h
> > +++ b/include/xen/xenbus.h
> > @@ -104,6 +104,7 @@ struct xenbus_driver {
> >       struct device_driver driver;
> >       int (*read_otherend_details)(struct xenbus_device *dev);
> >       int (*is_ready)(struct xenbus_device *dev);
> > +     unsigned (*reclaim)(struct xenbus_device *dev, domid_t domid);
>
> Can you please add a comment here regarding semantics of specifying
> DOMID_INVALID as domid?

Yes, of course.  Will do with the next version.


Thanks,
SeongJae Park

>
> Block maintainers, would you be fine with me carrying this series
> through the Xen tree?
>
>
> Juergen
