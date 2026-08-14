Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F248437476
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702059; cv=pass; b=C33v4bHHc5F0RiwPlIJJ8Ht4Jm9nnzVTP8tWnyt+00OYg9NNwbu25Z7r2QxPncNNmPFyuBTF9rKkNfPc5WopIkPatH8/mIUdn4o2cvyVoCtUJ9E4hHXJCPhAIy2T3OimKaD/0DQI9UFSVHXxQDw+QwayIyGLtuISgG9uol+zZBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702059; c=relaxed/simple;
	bh=dih5yfhVzD9YOCDkAqWifhHeNamtD5unYv0nZnZHxAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+PH9o9azWzItnv1mi92V35VNUU2RvKQuiUQj3n14ONJrVk/YEIz1Y+YEtTcPLCWFu6Whq53FREV0CRZIpsN249iuEtpf5ltTOpAO1tIz/dPPJIA/SDQIka2mg+MNb1BQxuYRGzCNoEkQjHlHb6X1K/7d0OV4Qbnb34MI0kHy+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyy3XGcB; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyy3XGcB"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b051516aaaso512066eaf.2
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 03:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786702044; cv=none;
        d=google.com; s=arc-20260327;
        b=MFOoXlvhLsgseGo8PDBB7kfCJE13l9tJuHs9PA2Q+tW5TYUQZjAW05v9sKu3+1wQeX
         e1LCeRYbDyo9AzIqPHZEcUhx6O3A1RAjoKJO29AzSjKAxoCkF6C+jAoxFbzAQAJXR5kM
         WK1A0wz44rnXNAQxTRwxHS4u3cxTPRXuLK6R7Ene/t7dizevSyGgm/OR8k1VCBM4vO6A
         2/v/3vZd5Cp7hVGGWmh+ftief8vzTMxwb/6Z9xtCN7n2ZhTnP717QKwOJWuKXMINJ9Gn
         9rOR67+yoA6MdA5DjvWPXhOohyaB3ELTKZMwQz9VUBciJ7+ko1T2ieZ8Zlgd8N2ECh0C
         xh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1RkqMsDi42d8/QAfB18WfJfpcXU8KgxUsUMWb6sZViE=;
        fh=QWuhAgqzypks5D4k1Jgd7f/7FGPGZimKj5fOr0dWamE=;
        b=FfCq4V/1qFZ8BRqHVTmnHw20Pe11AZxmoIGT+1jwlPP7rOY2MIISuUuShGRqz2kO23
         XP9Nno5Ng6XI3gSa6S1lpOYbQpljL9octATw0Vph9J+OU0J1faIv7/a/2Vh+JekGUx51
         8vZ/dDtHYBDH9bMKeB/Y7sYnoAJdOH78yoF6+ZBcK3zKoEPiFRBdK/Wg91WxX8LilNY4
         zrzZNB0akdDiK9nS/NcRp505VO7vzgYLRT7tglsxmgOXBQd+WnMacaHMBlC1CdruQCdV
         pl8o/1vnUnyC+0f81xnS7CwjDBHMqcmDITXpYH0PaTM888yDjr/5vGpItrpawOYXumhS
         AiYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702044; x=1787306844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RkqMsDi42d8/QAfB18WfJfpcXU8KgxUsUMWb6sZViE=;
        b=hyy3XGcBRRqZx31yc5djGg/7v/jyP209uS0NeP+s9bDYYFxSlpTYs6ToLMIeQCAi6f
         gntgpUOQnIFaOiffJER7giwOT51tUdM1bVBm92qqhNCyHzXKz+FxwJNdkYWa1Op9qMVu
         CKwIln4y+FHTqMlb+NfI9Lv4PDSWZ+0Olok7Dh35mecojyEa1UvnZXpvBoCCLFtHv5X2
         jdjz4ZZhDQpZIDyRXN6v7AXBVMDFJKl6z+O1B3C1QIRVy2jjGvVDEQEYdWD1UL6E0hUn
         urpwh8j/xt2RCwH8Khp4hg6GKGP1FWg5gP5/VggjjAFVcuKzJzb5XbV0u+XuwjdQ4K3x
         eEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702044; x=1787306844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RkqMsDi42d8/QAfB18WfJfpcXU8KgxUsUMWb6sZViE=;
        b=QXG5g/ujP4JwHOwbQ7ViQmIjZ0/lsiVfYEddYX64Vkn/lIt/mhctZ69bS8oMHKnFv2
         hVWeM4JQKqVE8ishbInVQVj/c7fM0SWrUbPfXQDzVlZxGjNRl/+FMzxVrWbIMeJGp/m3
         3PSGEKGLCrMFxIqiipL8e9Ye1QS6S1KMRwoosal6QLvM7I2QEQ8Fn6fuD99O0pLpD2ac
         yhgEZDU6Ty958gJBGSopyfsgNXfjObSfE2fKD6I8Qh6JscYxS+AdeAsqcWEPHZAlp41o
         44zupA4mA35pxbJaqldoC0HAxyWgM5s7/Pu5IhpZ2RxROQIJY5zb9YYMND9vLS1+SGIW
         lLWg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5bHckS/go+B8CsxSBsc2zZET+GdkROJK7+hfhZCnVH4Tr8Hgt/QoliRXvtLJIRyyTJOPnpE43i3ulXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+zcylN4/elxMeUVXiLevfGXfsy7OzqmEMsdYV1npLlE4xzEp
	xPb2zB3RJG84LjPTDCHwfbsJE9/N9bcu01oCD1M9RyfxOy0d7WgFQrROnfPIE0pDYEfEVCQPWvd
	KiAv/AqrkFfau11TyU8efpbZWRq+xHpdEfhiOooQ=
X-Gm-Gg: AR+sD11DU/B7geqcBwpKmhEUIVp0i1Blyxtqhw5Iyp+T+hDkRWDwtdDyEu4Ju2I56s5
	lFgXj8E8ZoZvoYVRaJxAvlu3fPIPLxfTR2drfDcWrql2mvIA0f4qrP5UjxRzmL/KMlg1yem8jKW
	aTuSfLx+VrrQE0DJjdN9pKgWULCyzY5MGnTc+K+b+YO4Fs1a21bulj7wC5ZPtdDuau583+4kFOq
	fdc+FkqlHkDfTXqG7/qImHr2Uph6VX21d2Q2BCE3M7HI7TSJVvhuX1HQa24SKamqUjMP8Zm92uq
	mH6caA4IoNMmrdr6/HnHuD8QRzpPXCOkOJ+8eMWaCqRMWEGdb/Eg3B3A3KlTBYtmVcMbtpcAYh/
	4kPAOf1QNU08uNmUAuJ95Y4oXqfyTLwE0RoptzBNVZtD+MAH1nw5FBpUAE5I+
X-Received: by 2002:a05:6820:151f:b0:6ac:a9c6:92c with SMTP id
 006d021491bc7-6b0d6147261mr4169707eaf.10.1786702044534; Fri, 14 Aug 2026
 03:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814023226.354288-1-sangyao@kylinos.cn> <20260814023226.354288-2-sangyao@kylinos.cn>
In-Reply-To: <20260814023226.354288-2-sangyao@kylinos.cn>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 14 Aug 2026 05:07:13 -0500
X-Gm-Features: AUfX_mwosHxYX949eUiz_Z3hdmKgMSdPKtoCpIYLwL8VKHEYDal_oR3cLeG7K3c
Message-ID: <CACVXFVP1gc3arTkP8eStdokYZCUU-KEFJ7dJ_VNiF8i0j1o1jA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] ublk: reject non-power-of-2 zone sizes in SET_PARAMS
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:33=E2=80=AFPM Yao Sang <sangyao@kylinos.cn> wrote=
:
>
> UBLK_F_ZONED uses params.basic.chunk_sectors as zone size. ublk uses
> ilog2(chunk_sectors) to get number of zones, so the value must be power
> of 2.
>
> If chunk_sectors is 96 and dev_sectors is 96 * 16, userspace asks for
> 16 zones. But the shift calculation gets 24 zones.
>
> Block layer rejects such zone size when the disk is started. But
> SET_PARAMS has already returned success, which is confusing for
> userspace. Reject it in SET_PARAMS with other zoned parameter checks.
>
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 853cd40a3403..193f6ebc3b37 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -980,7 +980,7 @@ static int ublk_validate_params(const struct ublk_dev=
ice *ub)
>                 if (p->max_sectors < PAGE_SECTORS)
>                         return -EINVAL;
>
> -               if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
> +               if (ublk_dev_is_zoned(ub) && !is_power_of_2(p->chunk_sect=
ors))

Looks fine,  and is_power_of_2() returns false for 0.

Thanks,
Ming Lei
