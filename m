Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43425E828
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834350; cv=none; b=VJ+n4QRNxRIr7jdzrB8wPYq2rGRsOpa1N3W5TSwiywWvvhwwFlbWkuV1RLSLI/xGdgEL3fFgMYst1FHesfO4bBaiTh72KDvL0QbRb0BaQ3UbautWxIT8aZuKB0KOxHygUZHXn/fLGYcGWt1HWKFmUpT/cTy6zvjSeOj/dzJTlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834350; c=relaxed/simple;
	bh=J3q7+ERLGGMYNzcLUoAdfmlz8C/A9OhMRW6zKx/4oqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTkfDHinMT8gpL0q7+KFFsp84KFgpJd2N+hY+SWxiKOum5IrIubPr6VsYrydhiPegVDM2Fc8MZ4Zc7w6gnVmPPyvhc7Xaf8VDvx8/r6ImJSdmTfKNHPswxhc8QIvs+hKta6QxOI93DhMqJyyTPAwP6J6Gm4qXQEeQuYGiCPAmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gyx3AxP1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gyx3AxP1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e78378051aso577022a12.3
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745834346; x=1746439146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rINvUOH68ih2WYNJ2sZFwzY5douH3ogOju4in3oWC7g=;
        b=gyx3AxP1LbAFzwF1G67ZZIxLvOdeieULCRh/p20zfKIl8cG638HuNQnZDD0MO5nZwA
         S5gnQ9C7u+GBk6jK9xCEJ5rsAe1Povnp1AdqgBL5KlbHk27IDKluZXthYbX62I8T82Gh
         f7pv6gxiAdG/lEQ7lsYKT43EHtWgjPFYNw9jkjn5d7guqwKEzgWPPwps/PFhCGjUJET9
         T7Z9GPsMFSS37t2/MJ7+eShvmo81EdwMZ6xsJAI6sq5e1lXvze0dQkmSztoSv4kBMjEQ
         JeQ8BJ/mtOv7DU5aJJAfwBeCq508AxGTg9Kd0arwJZ97zcTMNHW/zG/Hig4dMOYzDPKS
         I2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745834346; x=1746439146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rINvUOH68ih2WYNJ2sZFwzY5douH3ogOju4in3oWC7g=;
        b=rkrol2uobvyJq/c7O30c0+rDXFaFFZNmt+rBDnoVWRK28lTXzRErSp3HuIiUZkL/aV
         0QPzDTI5lc4GYwC68th4gHGGZZX8dcFDJ3L52zEB+1jL9XD3T+XZqoRPrHvtmh9VY2FJ
         BNu2JwLBbzZu7Ozd9FxThGauqC514enSH3e+rQxWVVU18aQwn5RdBbomWcL76z+osZn7
         eA74W4mKf/67AxyDXnAlERWCdQqzKP6Rm379iPZ6xJXVON70Uq+ta1kQspColy84SS6y
         JZCLEb9VSAn2ew2CdcaXCdJOcGXYi5NViKh8YFpqv9ldKjPzbeKuiCkc/5VurX7p0py6
         50QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFCXSJVaDYe/KrQIp1F2ji6wuyu/eqnzfdI4h560VIZbzwOiBcFwytu3Ro2/tFHwKDtQ4cRbUiW+rMDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Mga/XsxvLR42ygH51vqkk3JUTpUVvUyQV+mIG5qZILQm6Q5b
	1/MEbJ+AXmwwDdFXxmkVWRB0x6bpVmGQpbLXmYxXnG1v03e9KyN6crwBw0G7wKtSgbRcJUz2P5l
	7VB1nVckdNhrQ+w9QFYkgfn0NopwcATKmj3pg0w==
X-Gm-Gg: ASbGncsboxkvr2Kf7IP0vc9s/e+CHxv/sLObB3olz1DERZY7+sICWUVps0U0LPdy1q4
	lsPBzza74JN9eyi/Y/6npmZBz1Hd5d0CI1eEjodXMwiqqnUm12B4zzTEwqJl0q2sOYOKeBhVRjp
	DR1+JotGAHWnZxa+RzyByhUg==
X-Google-Smtp-Source: AGHT+IHHy6cjJLCZOHoKD0Vir+Tlj+84pXwRNtT9CfC5vOM1rZhJdWTi3FlcQ1xaGBYFZ0wYE7qauMRO4rQ0F79VUm0=
X-Received: by 2002:a05:6402:1d4a:b0:5f4:d131:dbef with SMTP id
 4fb4d7f45d1cf-5f723a137cbmr3068606a12.8.1745834345736; Mon, 28 Apr 2025
 02:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aA5Rzse_xM5JWjgg@pc>
In-Reply-To: <aA5Rzse_xM5JWjgg@pc>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 28 Apr 2025 11:58:55 +0200
X-Gm-Features: ATxdqUG1FpHJ7ywPwQYIG1Fv3071Xq963wpMBqS0BrlJJM0d8JjCStD9cCOICTU
Message-ID: <CAMGffEnT+C2xSNXuEFzGm9Yh_f=sRVrPsFO=tSasLMWciqKPhw@mail.gmail.com>
Subject: Re: [PATCH] block: rnbd: add .release to rnbd_dev_ktype
To: Salah Triki <salah.triki@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 27, 2025 at 5:48=E2=80=AFPM Salah Triki <salah.triki@gmail.com>=
 wrote:
>
> Every ktype must provides a .release function that will be called after
> the last kobject_put.
>
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
This change cause crashing during unmap device.
We already have rnbd_client_release from rnbd_client_ops, so no memleak.

Nacked.

Thx!
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnb=
d-clt-sysfs.c
> index 6ea7c12e3a87..144aea1466a4 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -475,9 +475,17 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev=
 *dev)
>         }
>  }
>
> +static void rnbd_dev_release(struct kobject *kobj)
> +{
> +       struct rnbd_clt_dev *dev =3D container_of(kobj, struct rnbd_clt_d=
ev, kobj);
> +
> +       kfree(dev);
> +}
> +
>  static const struct kobj_type rnbd_dev_ktype =3D {
>         .sysfs_ops      =3D &kobj_sysfs_ops,
>         .default_groups =3D rnbd_dev_groups,
> +       .release        =3D rnbd_dev_release,
>  };
>
>  static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
> --
> 2.43.0
>
