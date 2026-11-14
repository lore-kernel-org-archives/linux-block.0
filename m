Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794680542;
	b=vUB04o+s2ex76+lAdlQP36LxJQ4DCB6HdIvGzQuUKNObDuJ+CiKRvF+MguWjuK2VYW+3
	 P7OT58vJtdF8OEaoJuIOio5uyQ66SyL+c+jfY/UEPDxiGk4N5EWxAlS4yiCQalnWQ1xXI
	 1WnRcghvbkzPjuCgtd9anxHBau7CyouhqPzdt34vbjQWaYXks3Xbkag5yWmhuhWsZh4gA
	 knUIr4Ue67w1azIRf6geSOMbu4uIi7hu7yBZEjCVGMI/1i3TeJEB75ADTL+SMkPun8xRp
	 XWZkcadQpjsjQ3h1T8YmfVqGok/Q2HbjXcJC19gfRZLxt+oxWITjYOwHzT7xYmzhSNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=brX2hSaZg8oetdJBa0p7mNVdZYGvvoMmLGZG2mMzrMk=;
	b=HVqzNtdnGYjaHIqJxC9L3LFtyCS4shI9c3vE/JVrQB2wrL9rIGqqci2mfYtfWfWUw8QR
	 KFZj6HtjVnQCo0nmgStlF0IvsRwQ58UDr6zyww/4uPpWUYYMe1bH4+35HQsGAPxIvv3A9
	 yeINkVsq3LjV98Z/cqi6TfwXcE8hnkdLlSMdCJdSQ7VC0+O0qgRKnJ82Uy7/+Rwvxw5u8
	 jdE6LHm/qNb3fTMYffHGylawHpthpn5VJaQFQg7a/c1N1hAUDBm1nWB+ERbjwaQ7KbH9z
	 RdPcO6yllTX8mZLk0uVbXeogty4MTA9vfF9UgEvGgdnrusnzv7ShqLS8/NWtgNEyShg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Bo17DvOi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428B606A327
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 18:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8428B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Bo17DvOi
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6f42722a10cso218829eaf.2
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 10:22:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794680540; cv=none;
        d=google.com; s=arc-20260327;
        b=sYy79XpujpbQhgQmst2ORm4wUzy+3I1hQJcHXqPtEe6+UU/3IsfxlRCbcg0TVOyrQp
         wmXLX+gCibct3YT3uGozfxcTexiF0TpMnfaC06/vU+tbcsZx/qNht7+AS57ljx5KuGon
         mSV80j8XVhdaGm+Za8VQQiYNLFL4hgv/tigrDMobE1gdJil5UsP0JMaY6FjIgpSdFuK5
         wB+n0PLH2VR3yUs7Qx3n3rWtB0MtFmLsIY4C10kJpJd77qijNK07Ns5fwlcpFAWVZgcP
         3wMkdwIwf4kV2jkW72f5LhCEoShWvUUpz1P5qaq+4IkbVppgAaMpxqz6ee/CNWXJb0YZ
         QPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brX2hSaZg8oetdJBa0p7mNVdZYGvvoMmLGZG2mMzrMk=;
        fh=KW7JXFoOur0ckIEtFHmhMKX3501g0+yqcy3bZKIg1d0=;
        b=drmuWT+CABCGRXzDSAB/lBNw/ARJSgNdnnSlMMtT8gBdd9b7VLwIHEwcReR6P08HYq
         +yRGzRx+MEGHe/kBnGk4Zt7XfEj2iCjEghzatv7ZOSOIdbArElGKhPdmDYZeozK3ix+E
         wJKOEKRWefjBV9xmvtZoevbVJEA8IW3wo0KJJfGkV8k6CHQtXGpOKIPOoNfgE3ueozpb
         K1WVoN1Wo+ZhzTmvgtIc0WJ1BpQJGAlh199ADdDQI66y8Ff9Kzi+pLhMaDacbxJbA60h
         qkSDKrRRE/R4JpYBm4orvvD4kRugNdGK5kKXY1JyKG2voSQuf6qA0kb9KvfKkHl1Tm0y
         hMKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794680540; x=1795285340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brX2hSaZg8oetdJBa0p7mNVdZYGvvoMmLGZG2mMzrMk=;
        b=Bo17DvOi/V2m/1HvqEYFEbTUW4n/JVe0y92pSh4UDML9GHTbXNYgA78LRjlBB2DF44
         o+4f0prkf8bVU5iwzQsNQDcZn+H2nXqRhUcXvuBKxnX0/+tJ735hBWkNJ67nSowbgipP
         iWAe3YWrb3JsytM5yCG4y+D3gVQERxG31rNMnCaBjrYg6QGzPDmXQfj8FHLlk+e9UJrn
         p9d5VtrqpWnGD0V6pwwa1uCQDbPGE4IZ6yvRCnUHxtBIkle2wyzlvM1fwVpH1+YwC1Bi
         voRDN8S1xzrQugdPqN07A05FKSqkoZh9FZUqbg3JzrlOp0Zf3HRzRk5vL2Wd41iCvkyt
         rysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794680540; x=1795285340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brX2hSaZg8oetdJBa0p7mNVdZYGvvoMmLGZG2mMzrMk=;
        b=QWJ8e4K7eLBJ7rAvYg0Hc/fRpHARwWxYDPsSzFuzJ8CFgToFgn9h2rHLP2CLiLwT+f
         Rwnz6mjF7QIyori8CWob8G8lUG9g/842wFGvYH/O7fIerLQRWWbbWetCv/DgyMz54w6u
         OHnKY8BlA/ZiD2DQf7urFVSUohwU13MDDfURHNmJdvAPNj5xnF8Z/xHG3ZDKG0JZ3fxW
         lGm5ARbdWJpmS0k97qsD++6mW0gy71IQ9ioqkCIF2c4MtAAMJGIjNDIfVJspRqqIW932
         4vJY0P0owUJ8eVcp9NN0pSnKqryiRcYdx9U0BVYf1Moa2BFfG38MCXFtOhlqeWaNlMpJ
         VtoA==
X-Forwarded-Encrypted: i=1; AL+hErFQWpyb+jtv78iIbLuy8POMnpFD1BipW4oW3xf0KmPkhTYhD+TvzCbprv2w70rkRzdqa4OzIas2oOM+DQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+z6s7+ezsoDkEW0MAqtFU50qAXzaSQ0KYfD5gUoULrPVlwGb95
	AnARrJGdUw6lR+AaKFNXYIwtGUD4pbogztv/bIJhqVfu+s94cwmNohhKB/y3+9GDJAZh/HrKg05
	pCpHrDHGfWdeh+4DtE4kGV0GI150uAj0XF2Nl/GPK6Q==
X-Gm-Gg: AYBFou3KJ3O6HeSRZ7vIlk/umFXGS9KItMIHFC8r3jLZdsevnqdZP0kdANfEOllnKBb
	aRp+ddTPDp0jKC3Q+7ugwF2vt8exqA3oowpjVvgh0LMYVgL6pG0jiBi8mDPnJkIuTKCY79DbszE
	cYTY0y+pihOstBCgjgpx7Mw0fiEyOgIX85ZbJeDY5n7DoMlEgvRjnrmGPw1fkchz8d8zXf6S4Fu
	dXGQqG8Dg7rNsC6o9gB9q9xwidid7zVER1pW02EdTdkcasgalTmkmpbDSSmOMmUQeyoh5AdJj6M
	3hASoqzoBBkSCbis1G1M6pwvOSZ0GcuYwhleIvYa2dSTsL8j1jkK9KUvTDs8CBQlS9GWVctXtfJ
	R0M+t20xyZO7UpjLWdWdZ3kaZqePcr8CDFk868A==
X-Received: by 2002:a05:6820:83d2:20b0:70d:73e2:ff02 with SMTP id
 006d021491bc7-71ab4e4dd2emr5063724eaf.1.1794680540339; Sat, 14 Nov 2026
 10:22:20 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115003349683IFDCSTYhPzQtBozUiO8qN@zte.com.cn>
In-Reply-To: <20261115003349683IFDCSTYhPzQtBozUiO8qN@zte.com.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 14 Nov 2026 10:22:09 -0800
X-Gm-Features: AclHuK90wndOV_f8yTMnaBoSKhlzLI2bHor72m5VaolatsM0n3yOElUuHNmhBmU
Message-ID: <CADUfDZqE4tXoVvFwmh_J1XfM8+fzRn9w4n2=QPwbicJrcKSOgw@mail.gmail.com>
Subject: Re: [PATCH] ublk: validate all parameters for zoned devices
To: shao.mingyin@zte.com.cn
Cc: tom.leiming@gmail.com, linux-block@vger.kernel.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 8:35=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> ublk_validate_params() returns as soon as zoned parameters are valid,
> skipping the subsequent DMA alignment, segment and integrity checks.
> SET_PARAMS therefore accepts combinations that it rejects for a
> non-zoned device, including integrity parameters without UBLK_F_INTEGRITY=
.
> Invalid parameters may reach disk creation or advertise an integrity
> format that the server cannot access.
>
> Continue checking the remaining parameter types after successful zoned
> validation. Preserve the zoned validator's errors and the requirement
> for zoned devices to supply zoned parameters.
>
> Fixes: e84025d2a9cb ("ublk: add DMA alignment limit")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Perhaps worth noting in the commit message that this only affects
CONFIG_BLK_DEV_ZONED=3Dy, since ublk_dev_param_zoned_validate() is
defined to always return an error when CONFIG_BLK_DEV_ZONED=3Dn.

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
> Tested on next-20261105 in an x86_64 QEMU/KVM guest (4 vCPUs, 4 GiB,
> 4 KiB pages), with CONFIG_BLK_DEV_UBLK, CONFIG_BLK_DEV_ZONED and
> CONFIG_BLK_DEV_INTEGRITY enabled. The same userspace program submits
> ADD_DEV, SET_PARAMS and DEL_DEV through io_uring to both kernels.
>
> Independently invalid DMA alignment, segment boundary and integrity
> parameters without UBLK_F_INTEGRITY are accepted by the original kernel
> and rejected with -EINVAL by the fix. The integrity test uses valid DMA
> and segment parameters; enabling UBLK_F_INTEGRITY makes the same paramete=
rs
> valid on both kernels. Valid optional parameters are also accepted by
> both. All five checks pass on three independent boots per kernel.
>
> Separate userspace function tests cover 4 KiB and 64 KiB page-size
> boundaries. The QEMU tests exercise SET_PARAMS only, without START_DEV
> or block I/O.
>
>  drivers/block/ublk_drv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3d322fa1bc83160f51fbd97fb89b17ee94bc1213..ce1c192e3590cb8ddfeb49562=
9540a653658513a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1011,10 +1011,14 @@ static int ublk_validate_params(const struct ublk=
_device *ub)
>         if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>                 return -EINVAL;
>
> -       if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
> -               return ublk_dev_param_zoned_validate(ub);
> -       else if (ublk_dev_is_zoned(ub))
> +       if (ub->params.types & UBLK_PARAM_TYPE_ZONED) {
> +               int ret =3D ublk_dev_param_zoned_validate(ub);
> +
> +               if (ret)
> +                       return ret;
> +       } else if (ublk_dev_is_zoned(ub)) {
>                 return -EINVAL;
> +       }
>
>         if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN) {
>                 const struct ublk_param_dma_align *p =3D &ub->params.dma;
> --
> 2.43.0
>
