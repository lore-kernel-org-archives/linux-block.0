Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C133B94A
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066107; cv=pass; b=fqcfxhCV1CJ2IjU3cOd9xgDLt6lYgymoPOmmb4BT+Lxtt0vvQLl/vYd9lrkx4z54mW/GSqizXdBpqTO9Ll8Xda3HPP0MhyQDoVSbSmFD+wKnzrCrzMhPGcnz84VS3Ypv5W0PQuxEMrXMXQC89pv561EL4FmIkiYqx2Yf9bIB2Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066107; c=relaxed/simple;
	bh=eXbCglQsMXFSphJbxAf4iKsmpcpHiz05YKeMX4ISn6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdLZ0znA3PEf02HBDczanM4YmAAeb7+M/P3UQs1Hf3DyU25OnHrt1PXMS6Bs80L7fMntL06evEytaa6mYZUdhJ1fV8MOHROpBoM7b91fsu9P6tD4RdM96E0PhDWJHhW8Uv8em13TJ6cRsarXV00TnnvhY+76BQEIBrqicfSk83Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VLVwCJWy; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VLVwCJWy"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b737d4cde73so7224566b.2
        for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 05:55:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766066101; cv=none;
        d=google.com; s=arc-20240605;
        b=EJAYOhCiFOfoWXxQRE5+yf7dT1WLRNbmZ3wEJT9yd+Rust4lS3dlz3KgoueVhcgvUw
         v8miNmVva7nJWJlLuLu9o2kaQD7GLt72/IruONzhTNFxvoYbjO4l9KEwksi7neVWL/TC
         5AJpymqaUva2RMktqtGWhDA0OjiSvuEzoxjuKm5ZTK4gmrNQRq7gLnQH38AFRZNoJj0p
         3zqZSi/e2EGr1P+CQXbU0+Flw23qgHzKAdcd7d4BrrPJrE3tSQ3gvMLV57lkLztFdTHW
         NnHmpIJdDCIn3SPDGhXOLTfWWq5qkPv6c03yunW3/ydScbUo/08kfxHJTRHuVAnqhTBa
         yPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TuggqT0F+KQhUId8ALwJVG7L0b+tt0jPF/ba4NHvZKc=;
        fh=MHGaqltLH2KN+suHDBU4wmG+p3+Ql5A4rxL1EGXSKuU=;
        b=Bn4JntReBKWsNVItAy+queJUmWgZsux2I3fJ6iWuXtq+Zi077dufZu44BF3w51bZvv
         nt90OoD5r5Bq5AQiN7APbHmXbdMUFeZhMb1qZLod6jDLztbHXi9HsUsbpDRVcKOelb4d
         2uNhDAagTzQyuFHX2HUa3lpa9For/ATugFFXKuQqDfXTSwhQwwlujeFnmAgJfiNi1SCu
         1ChuRM1sG99nwbk1PY90w5CcW8LIeU7JDyLW2J+BWtZMV+i/q/4iTbzWYZXICq76TK/n
         ygjKma3/CmAfu3m4oaApDbc0sjKYvW35YEDj74D12v17m3MxkZ54MV6hVwAAiDAZ5BoE
         Le9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1766066101; x=1766670901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuggqT0F+KQhUId8ALwJVG7L0b+tt0jPF/ba4NHvZKc=;
        b=VLVwCJWy8S/pPetvXClD6SHJd8EHR7ubRBLteQI9eY8DefQS9EfTVS+ZwrB1/3Rr+1
         5fQy23C7FwoeaEwJHGqH480DmS4YZse6a92y7f8JlttnS1NDsGlCkvuOU9EzTYOhiNxB
         vb0qCe/0GXqb8xT6EFlVd43ewGf/xvX0aZlmc7M5fys+8vegniyJtnn2CE5hwEw5eM0X
         5bbrPwXkLkTnQxiIVtFgAYouGQFAPZda733raoqqp6QaA5aNXDb1KAXFcDlWPFYkRxeo
         isQb6uhq9F6qrjBrvorpzDovLfUoYI9xNNgVzOMoX6kUbcbqRqntgWSWYz16PPMEpTdF
         t0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766066101; x=1766670901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuggqT0F+KQhUId8ALwJVG7L0b+tt0jPF/ba4NHvZKc=;
        b=pDlikDmRqbq4KmjB6TLjBdHEQjRjNxYW7Lb0tSf743OhCAxLaHa7+wnG1RqmOAvNF2
         GMg7WsxI+labotvLvuT9x3B3/aEgcTyf7xQKAs15RWPjUKlQenlpvC6esxsexBYq1Ob4
         PyrExqrpp55P/inXZx+JJCMtk51qPBBDsoHEWVApcObQGbe8Rgjjv0M35TifkCzroPrt
         fm7OS6o4ek9hM3bst4eNvkqB5Prp/VL6/mTf3PxkZ5gmfVnVeZny9kI0+dHEBxeTid3R
         +kvJgrVlauWhAkLYxHTKLxdyCfRrnciiZlaI+ppRoCXqtvz1K40c0MX8wGamDylWFhhT
         h7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbj0pPAC7vcAqE7I4DezvISYdpOkWJxiGVq6fHdxMu1JkD1MwdlJJKs2CzWNOJE5eLVwiGZoEi3+uvvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPFZiIpQ4SBc1g385/GVx2tv7/K1YagqdiuVFupeilNDXypQP
	NGlY86ykFQtXzEBkjVgM1brA6Z8UVI3z+W81uj8g2rDN9r5EoZ5M2NRXJ48BGevLQAzOJ7zacg6
	A0xOcIGvi8nrwJdHM7R9cRxO9+VUCdvIlb9B/wKPADg==
X-Gm-Gg: AY/fxX4+MfY71qYZ0Fh6Xj4iyHIv/JHPa3tirCcR1KfoO1qtwNeu4LBUsvSSeSkjxfq
	gfspRXhDe6k6uVftx5qE2OZT7SpNVXVZcfRzf0sUY7l5KQMORdfDslqbugWR/Wk/c2wyZp7vw4X
	LKfaXysCulvIyncwtRZXR2Ti7lVvLLMnjJlSLEqVfBEt2jDhAzz75Mw/FfFb8fsDAdQDn33a6Gl
	4uizr9Ux7vDNzXIBm7o2KwWjBlgwflA7hqTLN39G3Ovxs1Di7Ifvq2bYg0oSb1tMaOpfFg=
X-Google-Smtp-Source: AGHT+IHmrcaEZ/4xgJKyHbaxDw17pSVi915qQ/Af8AcipJ/aKEdizS2ujurbxKh2LNeNbayqAnWeh73SEUp04mm0pLo=
X-Received: by 2002:a17:907:948d:b0:b76:7e96:8b79 with SMTP id
 a640c23a62f3a-b8024fa5e0amr136869666b.2.1766066100620; Thu, 18 Dec 2025
 05:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217093648.15938-2-fourier.thomas@gmail.com>
In-Reply-To: <20251217093648.15938-2-fourier.thomas@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 18 Dec 2025 14:54:49 +0100
X-Gm-Features: AQt7F2rUAJe3eACQu6dyqFcKJODAJfKQsBhQaISdIzulKEe-oebCc5LtAkmCTaQ
Message-ID: <CAMGffE=D5Cj0UmzCGPLwW2WCOKU0NpKPeERfToMdt-trQWwZgw@mail.gmail.com>
Subject: Re: [PATCH v2] block: rnbd-clt: Fix leaked ID in init_dev()
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jens Axboe <axboe@kernel.dk>, 
	Md Haris Iqbal <haris.iqbal@cloud.ionos.com>, Lutz Pogrell <lutz.pogrell@cloud.ionos.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:37=E2=80=AFAM Thomas Fourier
<fourier.thomas@gmail.com> wrote:
>
> If kstrdup() fails in init_dev(), then the newly allocated ID is lost.
>
> Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathna=
me & blk_symlink_name")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> v1->v2:
>   - store id in dev directly
>
>  drivers/block/rnbd/rnbd-clt.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index f1409e54010a..d1c354636315 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1423,9 +1423,11 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_c=
lt_session *sess,
>                 goto out_alloc;
>         }
>
> -       ret =3D ida_alloc_max(&index_ida, (1 << (MINORBITS - RNBD_PART_BI=
TS)) - 1,
> -                           GFP_KERNEL);
> -       if (ret < 0) {
> +       dev->clt_device_id =3D ida_alloc_max(&index_ida,
> +                                          (1 << (MINORBITS - RNBD_PART_B=
ITS)) - 1,
> +                                          GFP_KERNEL);
> +       if (dev->clt_device_id < 0) {
> +               ret =3D dev->clt_device_id;
>                 pr_err("Failed to initialize device '%s' from session %s,=
 allocating idr failed, err: %d\n",
>                        pathname, sess->sessname, ret);
>                 goto out_queues;
> @@ -1434,10 +1436,9 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_c=
lt_session *sess,
>         dev->pathname =3D kstrdup(pathname, GFP_KERNEL);
>         if (!dev->pathname) {
>                 ret =3D -ENOMEM;
> -               goto out_queues;
> +               goto out_ida;
>         }
>
> -       dev->clt_device_id      =3D ret;
>         dev->sess               =3D sess;
>         dev->access_mode        =3D access_mode;
>         dev->nr_poll_queues     =3D nr_poll_queues;
> @@ -1453,6 +1454,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_cl=
t_session *sess,
>
>         return dev;
>
> +out_ida:
> +       ida_free(&index_ida, dev->clt_device_id);
>  out_queues:
>         kfree(dev->hw_queues);
>  out_alloc:
> --
> 2.43.0
>
