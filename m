Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294AC3E4C65
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281656; cv=pass; b=RLGbeaJbZqVDveep0KtW00Iz1IvFdyDsoIgUFfMCvIlx233/6qwd7JaqJT2hxoL3zV8cbYCk5Fi+a5rBJ3oZ52Erpbmanfn6zaGFw36dhsPiJ6CFr4Rn5IxVR2xsekLH+SC/jhcF7xV0W0e1y3sribS79GxPgqudna6fyMQYnEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281656; c=relaxed/simple;
	bh=UjTpkiOcq8brRffnQ7vEvC4+cTuo7MTwov4DeVg/Yvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADMD3bUkZ8yZf87ftg2dod0sqBJ2OtgBz05y3o2s8vDrtGGDE97EDuVKu+8oAw/TcrvM/86VF68JvwCuAvzIm78L4qavk5evfuykpn3uls+dtpv43MxkkovSob42qZE+SiRFUf2TXN5x+MYcV1fULiirH60iiodD5rIRej9+uQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=RGrEYI3y; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RGrEYI3y"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c166ec26696so47231566b.0
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 02:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784281652; cv=none;
        d=google.com; s=arc-20260327;
        b=lyIKYeB3D8nqwADGLIiEHguj3m4i1UzYZ6wVhNnVcBmzjEe9jrMoKJJVgcIKJCVUTi
         cJBKgfs37MU0Xhn6WD+lDWB6SrcmhzPOqr8KEJD+ygf3+/5M0b7XGM4YOJYl1rTI4xTg
         CwECyQcT85y6tqUo+7KOGIPy/vLwjP9ZSNfz2WLNd7zvfjyfAV0pcmrkz5KzWs1en9Xq
         7BKrb6aWO+a0lePoO8kkVP2g7PIG3dwMGW1eFpUYO01RkCnEp5qp/eRTfDycgztai22n
         9+J9XDsPy1MaFXPiShFSbbrOVSrwRw1Yk3zSnVCUo7Z2KNmrptNTol2Th2FRZ8jns4j1
         CyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qvUe7qgak+4VWoHWMbfHFceGcLZldsmBmrDHucACarE=;
        fh=kA/jpmXQVZRe+2dznKQYZkZ1H7dYdSzqYwpbEBCipM0=;
        b=prDLQq7T9lQUGZbLoVqwlJ4ZuKOHbNScAgB50TmLlvywiIcMwhRY3/KUuelCoQYSrI
         poIEhhHahO2MjZMyEjkXdflOhsDf8ry93MtvO2M0Iwy9oaLyTuhdS1bGrGzVs56cq7Jt
         zKdqS0y3E3M60NmnD4l4Gvlld4MnuHDnyYHIGUxQUXHVeY5uBW8YY/WvWGcSWlW2OAH3
         l311/9w2HJCBgphCJzCL7ndGEBJV/6VsEsmEyC7FxGIg6rCaAl1hETiEIsEoGjtEKKSe
         4vn1txzAQuLiXziGznmuFuUsXzw4M9hF+XRTAgHRa7U6GhqxDDitivC4RsCOaC3+76tn
         8Osw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1784281652; x=1784886452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qvUe7qgak+4VWoHWMbfHFceGcLZldsmBmrDHucACarE=;
        b=RGrEYI3ytnGd/PiR8RzgxKMEaelbhQxFI1zwyQvsT437hUttqrKUWmNxEADPu62P5x
         WE4PuuTk6q3dSub+nZVwS5it64AMgV9q6cQ6158mpiFZmH8WT0JDQzx1KzSU7kGXK1p0
         hjoTXPl4nG3DWi4fQNzHvzP1dmOye1gs5Rmwv6hSpzydwMPSKUAD10cqxSlf3Kc53wTF
         Nc/xbbNoyKA9KurrLNwdyOc2ywWqaP39dXrvKismJpAWfnynPoPowoqhrAyKMgeGAuvf
         PL/exdPd3aiAk4gXyAmofEDknIYjTtyxLuG1eX8nytxb71CLOtRuKw5C+Ug1LyIdx9o2
         UTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281652; x=1784886452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvUe7qgak+4VWoHWMbfHFceGcLZldsmBmrDHucACarE=;
        b=Ezfi01szBsx6HQf/sOQ9UoydzrrL/6eLK2Kx4y5Vn8Fapg6CGi3vA4b/a4TmBo6X9+
         vIHAG/ELIOZOF9MK4I/hMJMuCyDdHi/tIlNp0QrVJdJ34TkBM/2mfHPwQLs0AG9OaLnW
         G70RAmJWp0anmzUh82Ls172c/LEbXu81MS37ogMfiNVeJzn4cZFMty8oKCOqLNP90oLY
         MgoD/3EqAC2EOgtOUbpE7EW9X7PvjgfimTTnRqoWIYADSfHU9OQoL3hOYL8mDnFD/pi/
         d2p809uhtVgHhoxUzyZQGjkBAbI1giDONOH5apDo/CyRdAd4hceNxgfd1pKulnUXvtCw
         i07Q==
X-Forwarded-Encrypted: i=1; AHgh+Rojnjj45Mvx5etB6Ay1tJG0RiVKxio24CSQPLBLWEXqszBDh0XzfgItadzrHgTHwn+cWrET2dnBWtjmQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3gA1e4xrhcIKccMztkRTG87DvBdVgU245joIq7sZd42hEQQr
	zqUlnWsi5oST+cSr6iEz/vIjwguBdLAZqJol06rVo4neK5ZFibMapRJil/cJSbjDQytAIfcYqXx
	zyoHAcvXLvO8ieW7zJRR1Raw20bvMCHtgHneRrlhCVQ==
X-Gm-Gg: AfdE7cmVm2My6rrpoNzpYY45olLPrmX4JjEkHuDsfwfWxRl9OLZZB4E54xIwUrM0DL+
	lbYGwGASbBU8GbesO5d5URbh4MkzSV8vlZ31bDjWVdrMzBDA1IjhXcQeBeGF4IOYl6OTvHIYIaP
	FpHUf/aQQtrprNhG0T9b/H+4aPkKetYw9e6U+qcCisZjM0V4oMMuPNE0+Yf19Lyhiah7qLPZ3bH
	O7zDWy4nmrnnnTIwM117jBfhFtq53DwLZw0d2NkLkwDypU5Nc8toIp+csaCLqjKFWosAfwJFeks
	WXanFUUgoAjsOUB/SQ==
X-Received: by 2002:a17:907:1ca2:b0:c12:e4f7:9a0 with SMTP id
 a640c23a62f3a-c16b46b2758mr43790166b.2.1784281652282; Fri, 17 Jul 2026
 02:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714115051.1401174-1-lgs201920130244@gmail.com>
In-Reply-To: <20260714115051.1401174-1-lgs201920130244@gmail.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Fri, 17 Jul 2026 11:47:21 +0200
X-Gm-Features: AUfX_mwbPUzFF6hJCWj4_ebzZ4F7Bs345-sg-n39cyrfh8893KslX5SbYtue0uA
Message-ID: <CAMGffEm+SAvqHt7qORVrzmKnOo8hKazCcscXfdWjbHZiyg1bqQ@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Fix double free in process_msg_open
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jens Axboe <axboe@kernel.dk>, 
	Danil Kipnis <danil.kipnis@cloud.ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:53=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> process_msg_open() allocates srv_sess_dev with
> rnbd_srv_create_set_sess_dev() and then initializes its embedded kobject
> through rnbd_srv_create_dev_session_sysfs().
>
> If sysfs creation fails, the helper calls kobject_put(). The final put
> invokes rnbd_srv_sess_dev_release(), which reaches
> rnbd_destroy_sess_dev() and frees srv_sess_dev. process_msg_open() then
> jumps to free_srv_sess_dev and calls kfree() on the same object again,
> resulting in a double free.
>
> Add the session device to the list and release srv_dev->lock before
> creating the sysfs entries. On failure, rely on the kobject release
> callback as the sole owner of the cleanup instead of freeing the object
> again.
>
> This issue was found by a static analysis tool I am developing.
>
> Fixes: 8cee532f469b ("block/rnbd: server: sysfs interface functions")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
lgtm.
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 10e8c438bb43..5a991bfbf3ad 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -778,18 +778,22 @@ static int process_msg_open(struct rnbd_srv_session=
 *srv_sess,
>                 }
>         }
>
> +       /*
> +        * Add the session device to the list before initializing its
> +        * kobject. If sysfs creation fails, kobject_put() invokes the
> +        * release callback, which removes the object from this list and
> +        * releases all resources associated with the session device.
> +        */
> +       list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
> +       mutex_unlock(&srv_dev->lock);
> +
>         ret =3D rnbd_srv_create_dev_session_sysfs(srv_sess_dev);
>         if (ret) {
> -               mutex_unlock(&srv_dev->lock);
> -               rnbd_srv_err(srv_sess_dev,
> -                             "Opening device failed, failed to create de=
v client sysfs files, err: %d\n",
> -                             ret);
> -               goto free_srv_sess_dev;
> +               pr_err("Opening device '%s' on session %s failed, failed =
to create dev client sysfs files, err: %d\n",
> +                      full_path, srv_sess->sessname, ret);
> +               goto free_path;
>         }
>
> -       list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
> -       mutex_unlock(&srv_dev->lock);
> -
>         rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->name=
);
>
>         kfree(full_path);
> --
> 2.43.0
>
