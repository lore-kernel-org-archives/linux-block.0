Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EE3C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DEA2086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLXKLfec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DEA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeK2Byt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:54:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35965 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbeK2Byt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 20:54:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so2226348wmj.1
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=K0WipYoAONmvaBZMopY9nAgruH8DNCGNWaqPJZ1rL8I=;
        b=cLXKLfecqeePM4nK/EVCFlgDEyf3tBroO0uCL8hhrWAj/psLCCVkrI4mT/CyxIZCE9
         te3COweFjakugBlJURzAcTTdx/MNfrRIOQvfpQFACzE1jjT2+M0s0VDy/NRcZ0OASD1R
         leZuHoUeW8ahwpo/e9go/YI2uqq4El7amkEcLm36QsORfT38nU1GG4zlB9GOupTTHAWy
         +pGmoSD9YxY465mMLTyVk4/P/gQ4zxd856RaLzHmU5pkydY4dMfOCBWI1g7Dugor8s/b
         q2Y8jQTiTfDC62fpaE3L0WZ/1DjbEvqL85CWRIOneYfUO/YRsDmh2qW6wXrHdYZwghey
         rJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=K0WipYoAONmvaBZMopY9nAgruH8DNCGNWaqPJZ1rL8I=;
        b=CDGKTJzNF9PZYPVvWKg9IoWJ8CptoMJiPpk57xVIIuqDrNiKzyFaQ37cazEF2ip6if
         0/kXy8RMuiOOIpVELNCrZaxhTfv79pE8GgMkOBmmnHAKs3Z57Xi48fH7Pum8RIo2YItD
         xBEKSl4YTi8WYqBaKhKbIlz0tVzx3x8DMPyYDMSCtl2ZoRSKjOXSIbNcFCvzqBXg9isx
         Vyr1X6MRyzCdyNNobCrrTFZi9iCWDidfFXz9Eqjrz0E0bb2FpSKP5v9UbKrglSGssois
         I4dZZwv//b7aVTKgoRMg0rN8C63Wse3OSM6ogN4s9H2It9Q6NmJhAsttVsz9Nip3poeC
         onKQ==
X-Gm-Message-State: AA+aEWbSP3tE/WJ3htlzzNVrWCC7XbLYrH+nh/lmvPZZ4x8DjFKu73mK
        eI1rLBKxWKTnxy33GiBh362ztXob0CDpCApMOLC8Dg==
X-Google-Smtp-Source: AFSGD/WFVrQEEt2nC12VLalvoKORVbzoQfYdKcsacY/t9rCZgoQtMAIqFo4HDygDV4Z6+zcpWHMosB0BHJBp999wJUA=
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr3024002wmd.2.1543416771650;
 Wed, 28 Nov 2018 06:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20181119141145.GA25638@192.168.3.9>
In-Reply-To: <20181119141145.GA25638@192.168.3.9>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 28 Nov 2018 22:52:38 +0800
Message-ID: <CAA70yB6DedBE=yrbQD5qUdPL2HBtRHg9TejcywGMqeuAcqGM6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] block: add io timeout to sysfs
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

It's useful if user want a short timeout when a disk doesn't work normally.
Would you give some comments for this patch,

Thanks a lot
Weiping Zhang <zhangweiping@didiglobal.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:30=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Give a interface to adjust io timeout by device.
>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>
> Changes since v1:
> * make sure timeout > 0
>
>  block/blk-sysfs.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 80eef48fddc8..90a927514d30 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -417,6 +417,26 @@ static ssize_t queue_poll_store(struct request_queue=
 *q, const char *page,
>         return ret;
>  }
>
> +static ssize_t queue_io_timeout_show(struct request_queue *q, char *page=
)
> +{
> +       return sprintf(page, "%u\n", q->rq_timeout);
> +}
> +
> +static ssize_t queue_io_timeout_store(struct request_queue *q, const cha=
r *page,
> +                                 size_t count)
> +{
> +       unsigned int val;
> +       int err;
> +
> +       err =3D kstrtou32(page, 10, &val);
> +       if (err || val =3D=3D 0)
> +               return -EINVAL;
> +
> +       blk_queue_rq_timeout(q, val);
> +
> +       return count;
> +}
> +
>  static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
>  {
>         if (!wbt_rq_qos(q))
> @@ -685,6 +705,12 @@ static struct queue_sysfs_entry queue_dax_entry =3D =
{
>         .show =3D queue_dax_show,
>  };
>
> +static struct queue_sysfs_entry queue_io_timeout_entry =3D {
> +       .attr =3D {.name =3D "io_timeout", .mode =3D 0644 },
> +       .show =3D queue_io_timeout_show,
> +       .store =3D queue_io_timeout_store,
> +};
> +
>  static struct queue_sysfs_entry queue_wb_lat_entry =3D {
>         .attr =3D {.name =3D "wbt_lat_usec", .mode =3D 0644 },
>         .show =3D queue_wb_lat_show,
> @@ -734,6 +760,7 @@ static struct attribute *default_attrs[] =3D {
>         &queue_dax_entry.attr,
>         &queue_wb_lat_entry.attr,
>         &queue_poll_delay_entry.attr,
> +       &queue_io_timeout_entry.attr,
>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>         &throtl_sample_time_entry.attr,
>  #endif
> --
> 2.14.1
>
