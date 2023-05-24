Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F2C77B73
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 06:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjEXGcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 02:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbjEXGcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 02:32:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2A3186
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 23:32:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96fb1642b09so74818266b.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684909950; x=1687501950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjpbzJTpyImprSHdMScJEaKA5Tx5t2Zyeyk1hd449FY=;
        b=Xs6/nw7wRJQNuGrFRWzYsEyAHydIL9w1yLtZGQp2zre16BhgHI03JYVG8Asr8PRfQj
         DKAI0c7RSVvb0kVNJKa2eX03y/voIYc+dN347qOP2FvCL8+bj2t15O54p9qBVcx4je0W
         eWp3k2UdsLCYHaR/wCgD8RyhutklhJGHXmfuqI81OMejs3WyIQbn3yGaL8GTsEdPafXZ
         uRpC6OquyNjc1Ow9NT4pYVtTfnhTniOUbKsWx2/xQHQxE2i5mkD8JGRC43UufiCN7vhD
         8vPPx0FcHWanzG4XpKdw5tL8jMaphDH9q/Ci92h7TCdrLBTWX0qBHdBZhWXc51QS+fXu
         n4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684909950; x=1687501950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjpbzJTpyImprSHdMScJEaKA5Tx5t2Zyeyk1hd449FY=;
        b=XMMlv7K4HESR4oOQlnoGTYdZfWAfuntJijdvPpCUqAL1L+NnygpOriXw37pH59V4ul
         i8685uKHkQdbP/rEgOvKepzRj/+R9y3YFLLpwLbz8oovk+o9OuUPxfAtyoDKcw8BR5Bu
         J/hQ+YE2tkAJAVTmfQhSSekJMp13RYv1OW+hMhppGZz1cqs1kAQRDUra0X9E/HPRgNoH
         whUXbkAtmLvtvEVw0+4db9kChFL1NmyZlAvn/Ky3fXJMQUDheIVIdpAvEw709uWtT6t2
         EBhrVBlbnxnfFqNQmYwG0MP9RURj6xJS3h5XxQX6k7rEnwhiTo0GXkSZ7XHOEKdMScnY
         0omg==
X-Gm-Message-State: AC+VfDyQkW9ONUcrmaQDw3SVgO5vs6U/2TghFvcM8Sb7lH6ftMdI3NeJ
        WGAbGdZJ29jHGxq1LKwzliC4fr+UC8nvHSitCuTDG9Gzg9/Z8Ygt
X-Google-Smtp-Source: ACHHUZ4FSUNZkjD2HAWT8a3FfSRFc5RMMjq2iC/z4ntKo5XUFHeVDvMtx6LQhxqpt4rkJzRD/ZwsSsDU2pePs+5RXrE=
X-Received: by 2002:a17:906:9743:b0:96a:bdb0:5744 with SMTP id
 o3-20020a170906974300b0096abdb05744mr18420420ejy.26.1684909950605; Tue, 23
 May 2023 23:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
 <20230523075331.32250-5-guoqing.jiang@linux.dev> <CAMGffEkw=A=WSSgW4ReCMV9h0TCOSWYLEqSUZPf3bfNgTXTp3g@mail.gmail.com>
 <fd208b16-c191-4d2d-34a9-74e97bb16a33@linux.dev>
In-Reply-To: <fd208b16-c191-4d2d-34a9-74e97bb16a33@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 May 2023 08:32:19 +0200
Message-ID: <CAMGffE=fmOPBpPogMRv4TOgM8m_21KuAqkpdjBHqKt5Vt_Mbjw@mail.gmail.com>
Subject: Re: [PATCH 04/10] block/rnbd-srv: no need to check sess_dev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 3:35=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
>
>
> On 5/23/23 17:27, Jinpu Wang wrote:
> > On Tue, May 23, 2023 at 9:53=E2=80=AFAM Guoqing Jiang <guoqing.jiang@li=
nux.dev> wrote:
> >> Check ret is enough since if sess_dev is NULL which also
> >> implies ret should be 0.
> >>
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> >> ---
> >>   drivers/block/rnbd/rnbd-srv.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-s=
rv.c
> >> index e9ef6bd4b50c..c4122e65b36a 100644
> >> --- a/drivers/block/rnbd/rnbd-srv.c
> >> +++ b/drivers/block/rnbd/rnbd-srv.c
> >> @@ -96,7 +96,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_sessio=
n *srv_sess)
> >>                  ret =3D kref_get_unless_zero(&sess_dev->kref);
> >>          rcu_read_unlock();
> >>
> >> -       if (!sess_dev || !ret)
> >> +       if (!ret)
> >>                  return ERR_PTR(-ENXIO);
> >>
> >>          return sess_dev;
> >> --
> >> 2.35.3
> > This looks wrong, if you drop the check for !sess_dev, you have to
> > check it later with IS_ERR_OR_NULL when call rnbd_get_sess_dev
>
> How can it return NULL? Pls correct me if I am wrong.
>
> 1. If sess_dev is NULL then ret is 0, so it just returns ERR_PTR(-ENXIO).
> 2. If sess_dev is not NULL, we still rely on the checking of ret.
Ah, you are right.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
thx!
