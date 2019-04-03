Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A8C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F5520700
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzyaksLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDCKsh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:48:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34013 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCKsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 06:48:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so4528183wmf.1
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NIssOlik7/RrJ4JExhfnQPKWvcX2lAovmPMYXtMgkz0=;
        b=ZzyaksLG6yO+XH7Xi39Q3xXZW3Md2cU8k/kQjVH08tmhaVLngVQYk1vIdLkdnfP0ho
         CmIT7g2jRXtT/AKyrRnZD9VV9RRL3fUP5FjsTyBb9BGZYlI4g1CnNBEhoHToM2qrg4CC
         co3ITPewF9H4cwQMHdYVs2pwj3QiMX0OTCox/zrggo3ygYkR88jpGV9ZaNAc0nc+K6Wh
         YI3incjp+nh30274IgJoPTmQQXQycwAnW1+9occkyUDZ45pA6u1QSDOT0Nm5Lbbv6QL1
         V9uu+jS79B5d/pDpdAk3n3uqfOuFzHYqI2mY9HlXpp+QHBC+mvHJjhwxfhiPn08X3rmk
         KBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NIssOlik7/RrJ4JExhfnQPKWvcX2lAovmPMYXtMgkz0=;
        b=RB4nS58vzfZnBxLcabK/IW4o4dMjo47Dgc+7HInztway/k90fdcg8Wf3AXZsPgH9IP
         jnwnXD+hnSBVNcrqVk6JeVgRZZmRb9XcMRlKsxSct1Vy5Rve7Lpxldqk03cXAvu10EI+
         iJbKU0II7g2khK4xuckt0t9HAIpG2NA8v0NhcuNDMMvoIiHmbtUkwUUkjYuD+NrnEffe
         8iAjcJ4O+ZIPe4vCcRWM9yNjrgvXY+tKXleyPXtRGb3fdHMTPO6TV00HEO7MaU4vh0Ul
         CASig0IMAKthTSsqNB0/WzE+cEgxhAASe4AC2MBVI6VidLByyCrvmRKkPhsShk+ClgH2
         LUow==
X-Gm-Message-State: APjAAAU27EFZ6M/y9zcATkzwZpqOMyKPU/l/ols61lzA7Jtbg/xpS/Lw
        1dyjho0bq7dG985DC7Zz9MmdxQhs7c04o1wQulRwfDyR
X-Google-Smtp-Source: APXvYqxIQTyiE6kBlXWcG9i1Y7vdebepWtHZqyEuYGK78vYPThAv10Hp6l9DwzmGFMuTukiOaO6WmnUu1h+eR96qnOU=
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr122927wmb.23.1554288515066;
 Wed, 03 Apr 2019 03:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190402131424.GA12935@192.168.3.9> <1554217543.118779.130.camel@acm.org>
In-Reply-To: <1554217543.118779.130.camel@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 3 Apr 2019 18:48:23 +0800
Message-ID: <CAA70yB65t+yCcysDUvYCdcpto1BUio0a1woXkzVL7=efJ5FtJw@mail.gmail.com>
Subject: Re: [PATCH v2] block: don't show io_timeout if driver has no timeout handler
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2019=E5=B9=B44=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2019-04-02 at 21:14 +0800, Weiping Zhang wrote:
> > [ ... ]
> > -static struct attribute *default_attrs[] =3D {
> > +static struct attribute *queue_attrs[] =3D {
> >       &queue_requests_entry.attr,
> >       &queue_ra_entry.attr,
> >       &queue_max_hw_sectors_entry.attr,
> > @@ -770,6 +770,25 @@ static struct attribute *default_attrs[] =3D {
> >       NULL,
> >  };
> >
> > [ ... ]
> >
> >  static ssize_t
> > @@ -890,7 +909,6 @@ static const struct sysfs_ops queue_sysfs_ops =3D {
> >
> >  struct kobj_type blk_queue_ktype =3D {
> >       .sysfs_ops      =3D &queue_sysfs_ops,
> > -     .default_attrs  =3D default_attrs,
> >       .release        =3D blk_release_queue,
> >  };
> >
> > @@ -939,6 +957,14 @@ int blk_register_queue(struct gendisk *disk)
> >               goto unlock;
> >       }
> >
> > +     ret =3D sysfs_create_group(&q->kobj, &queue_attr_group);
> > +     if (ret) {
> > +             blk_trace_remove_sysfs(dev);
> > +             kobject_del(&q->kobj);
> > +             kobject_put(&dev->kobj);
> > +             goto unlock;
> > +     }
> > +
> >       if (queue_is_mq(q)) {
> >               __blk_mq_register_dev(dev, q);
> >               blk_mq_debugfs_register(q);
>
> This kind of change introduces an unacceptable race against udev. I think=
 we
> should wait with making this change until the patch series "kobject: Add
> default group support to kobj_type and replace subsystem uses" is upstrea=
m.
>
It's good patch, I'll send new patch after it was merged.
Could you point out the race case for udev?
> Bart.
