Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173654;
	b=244YB5C5HseajKDQsGzclNcpBuybAKlVpsfPmSYKhKsC2ToCCuiLY33507xwU53DuAIf
	 59I7luETQPxs0nj3U/8qYSlGw8KscKV3lMnD1ho6bM6JPPhE0mvndlK4f0om+NRwMVWUx
	 OgfU0b7EDswbNhvtiSLcnqLIKSyMhdwkaL6BHwx5v+YeWr8uIUbhX0AybEGYAIHKnGnWj
	 CxF84jyK5oZmjnDTBT94Bge3JG0Dly9u6nQu6px7ukJbvsG4Mv3gf/0vI+aMx/j5opM0j
	 9NhsydxrmbaDVvNVV4TEro9X9fTq8/iGcdCTG7t1FpmcR5V1OKPYGKPPzO4QLRrKvQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
	b=C6VDH/jiapAPavvH+WK/KNj6lOu1oZGow2tPtb1/5IRcQSsplUxgzmg79CsUeKYnktII
	 Z85ncpULm3GbJtDnfbb7cNGrgAIEfeETtYuEMJQCK2PBOOTIMen8C0HU0CTYUI6AZVfT2
	 p0+mFxSzmonSrUhNwjkrtRCqBPVOL9tgaLmzalvHSHUz2/EJtK88tDbQnr4wGnXI4VPlR
	 cIGlfgzT7jg7/wwdKbGd/vEF3qCona27ZN8Hq72ieo+KWnVhMk4XGWqUrOoO5udsSYtgj
	 LJC/FdFdKJPMFBPhkk884aRMZbRm8/ZTYJf0jXaSQX4fh/OyrGFKrM+lghE5KsxRZ7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=HGhCt+cg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A3606A326
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 11:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F3A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=HGhCt+cg
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so852771a12.1
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 03:20:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173652; cv=none;
        d=google.com; s=arc-20260327;
        b=ZL+/45Is+1UM8diLLvCv9Itok4fIPcyFcR46BcdbIj9qCfA16ZnYACEq7sAIA2WXIz
         onykWH1bP9JbNwqfREB0K7tosIcX3u4LJMneIPcw5G6iLIgLsNfIw208IYaHG7Be1SC2
         AOhN329/lcCienn6nJsC2eT5kZbeAjx5Z+oz5F3OYcTOITJjVNyx+YqTqEF2OBo+ghtK
         wT/NI2Qbi78dMym4LvYLDf8wzSsPTvRQySwga3XNlQ0NXk4gkWDW5jMJ+bXoVzFYaP5+
         1U/SubPYsXvlr/YXxMkSMGLPycZ03okz9VqTujrISFBF+tvU+1eZmreZGCjyQ2ni4sIc
         LERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
        fh=OUWMppDiyV7CinN8Im7/CdcyLqGi5l/CshebMsSTyng=;
        b=RY66S4Og8Rf1SpDdjuafa4Uax1L0dmJJcrySG9GtivLdzTUh5HVP5jpSy8nT6sJZEL
         Ld5Zh8vWTyqtdMq4/jAMvIH47TrIWEUPzeiqetjnuXei0sNkmEFcI3PMNwKdEIPPU/6N
         okoBNf1AePZF0ziab4he1z+91phjnB8iJ5+E71bGPlVRHPxsvVN48y/DFagk7m4ae2/x
         hJ00g2MznaZzpGkJJ0GT6IU/63Pf1mK6ZWyQsPiRPY6UwA+0nCpTgW4btae3lqqI0jJG
         752sUFx+PWSXxnpIc8/1RH42bjj8FF10Cx1TrdKclfebPvXouY/1r2kyNc1vXKXDIgde
         VvdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1795173652; x=1795778452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
        b=HGhCt+cgkHkc+fYj57YSXT8KfrPye31SP3vljt5ItUBjXF3Fqo0UyNq75R9e+gAovQ
         IrtVWcmnUlJq+NKn2fDamVFR1PZ5acmH5nkWFsrEeIIFGWddYEWc0NgKW5BvnZYKqeU/
         gczdBt84+rPVxAm4+Za3dVZ5hRCbWYPyc7Ggwz1AvyO0r39Yyyd/QFFaepNZgLcnmByv
         DLzGQM/RUg8Z/1XarC7itZWKS8J+sTUHGy9774gP272p4W82Z+zyRTZltQ/hLx9T7j5a
         bB2drpitti9W1X7N8msti2nogmIiiKGBpk9y7qMSmFZ4y2xJTJYeYnUzApyI0kNYF4Kq
         +pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173652; x=1795778452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
        b=gyzogyuNjJMdU+IwLmCh5aOvddbkRaoZUN9n/0wZyzSQXKsHwWeVBZAD0nhCHwT7ch
         aA3LNAx24sbenUvBlW+KzOLK9DWhbxJZ9WAtgABjb84I8LZD86xYm/xATEQbFfN9sM3e
         mcArtfXtpRKL/jP/z+VWUfZnyN/T7e0unDsylcfpA1w84jcBIDmAUEHBbICPxKCTgc5x
         n3/gJWT/JI3Y/IdYPXRhUY9/CkUPTHpPuK6ODXqvYzDScBHdzhFVUkqxsFRZXYgREmDt
         Jl4PgcdmCbp1i2pYkPmPrDan0lSuDJDQgnp7gfhW+T/fJNJUgUrajg8f8jleI8DemPam
         +pJQ==
X-Forwarded-Encrypted: i=1; AL+hErF4LOC0GqDqAtll2t7njKNKKfxkAD4vPN3IXBcZjle2y8P8/qiaqYJWvt8QEALOL9vIe0sboGAWA2gk0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8O6BTYyBnep6WliAEfiepusQ2YAfSPPzoBI3CausLYhoxLhisi
	557DIJVCDL1Te+DfJ+LeXTAKez9Z/HShLyffv6R7MS0pMQIuuUgFvMnkNGlS0bkgdh1nXuWqUiO
	QclN6PkH1VepuZogiTXUsjBr4McwTv8CWJci4tH2eeg==
X-Gm-Gg: AZFdTZfPpo00zQG8oFDGaN8FU40EmuEZJdSj67I7hMsg8M7eWVWofDSGuZMux6hNrQv
	cVWZhWnUyj9VShr1YTP1jV4VPi4XDn6rUY8K/R297g1aRX7PRFB+O+8P5JS+Vu32WC+HcYB0WgB
	BfvvPZewMpc6czf8qmt2T0MRgiYWINRcGwbzqRRWv9YNh4Nl0ph+9+m3izd6y4JKKf0SBmTiqvJ
	DsjaFxBd94fYsCEaiAXyhlnAKX6OZeLP5Y24Bm2iJi+xjq30qMuFvLqwwgShcZmZHwLnU3rmaDj
	UkHzMBw8gb/NgSOZG0ucaSWiiPz+rDcmBYcY9h9LQiYbo+y1cWmqnaWlYNQ5hKJSlsYFipuAEYc
	F++Cm+koiee7KWID9wsJDSTeUhJSnyGLhz/MXTlAn91F+RObMTjC15BGd6p/ZAWDUrrCVSwbNdu
	CVjU/0iKl8hPOVmb7EW2tlaH1QVHTbW7O8VWIaUIOc8tiehr0+iuJbo169UlGZyPlOtC5S3fwSX
	MXi0lK7iKLBoa+zHPJwOWXpFUZg6Vs4XKnUqsHpKKVpZoTXDrvmnBlWywc=
X-Received: by 2002:aa7:d351:0:b0:6b4:86e1:cc67 with SMTP id
 4fb4d7f45d1cf-6ba37ea0b91mr1306429a12.27.1795173651526; Fri, 20 Nov 2026
 03:20:51 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260802031350.1468599-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260802031350.1468599-1-shuangpeng.kernel@gmail.com>
From: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date: Fri, 20 Nov 2026 12:20:39 +0100
X-Gm-Features: Aa3M54plvx9H83qo4LJ7Ae2TaDMpFtDwJLUnuLmm5c3StPpYcDm0-SgN5HSqv5Q
Message-ID: <CAJpMwyjS_sCanPxHJAP7d_j4x8m9FQ4a8zq_nCc13jBZdXmVRw@mail.gmail.com>
Subject: Re: [PATCH] rnbd-clt: fix use-after-free on device sysfs creation failure
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 5:15=E2=80=AFAM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> rnbd_clt_add_dev_kobj() initializes dev->kobj and adds it below the
> gendisk kobject after rnbd_clt_map_device() has returned a live
> rnbd_clt_dev to rnbd_clt_map_device_store().
>
> If kobject_init_and_add() fails, the helper currently calls
> kobject_put() on the embedded kobject. That put can drop the initial
> kobject reference and run rnbd_dev_release(), freeing dev. The caller
> then continues through the normal error path and calls
> rnbd_clt_unmap_device(dev, true, NULL), dereferencing the freed device.
>
> Leave the initialized kobject alive until the normal device teardown has
> completed and rnbd_clt_put_dev() drops the final device reference. Since
> kobject_init_and_add() failure can leave the kobject initialized but not
> present in sysfs, only call kobject_del() from rnbd_destroy_sysfs() when
> state_in_sysfs is set.
>
> Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

LGTM!
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
>  drivers/block/rnbd/rnbd-clt.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnb=
d-clt-sysfs.c
> index eb485e4c12e2..9f5d30659f3d 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -498,7 +498,7 @@ static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev =
*dev)
>         if (ret) {
>                 rnbd_clt_err(dev, "Failed to create device sysfs dir, err=
: %d\n",
>                               ret);
> -               kobject_put(&dev->kobj);
> +               return ret;
>         }
>         kobject_uevent(gd_kobj, KOBJ_ONLINE);
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index 4d6725a0035e..5fe5c7e259b7 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1658,7 +1658,7 @@ static void rnbd_destroy_sysfs(struct rnbd_clt_dev =
*dev,
>                           const struct attribute *sysfs_self)
>  {
>         rnbd_clt_remove_dev_symlink(dev);
> -       if (dev->kobj.state_initialized) {
> +       if (dev->kobj.state_in_sysfs) {
>                 if (sysfs_self)
>                         /* To avoid deadlock firstly remove itself */
>                         sysfs_remove_file_self(&dev->kobj, sysfs_self);
> --
> 2.43.0
>


--=20

Regards
-Haris
