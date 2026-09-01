Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E971A6838
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277562; cv=pass; b=i0hwcIQykK7ZsDCssxC+jUXIqZ4a5pt/i05uxsfHeLlkWRjHcQk9gMbjU3PJOv2zQpMCaAfCHpw5gMMk/1j0ENGUjcPdZ91lwWjpXFGAINkKUZCbSk91elNffpSnBvjeXApaGXgwyuLx4pbTCTGWyEON//yIIYqRc7IgCNTHsCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277562; c=relaxed/simple;
	bh=eDOwdQXSRtgOf4mTyaflzKqNbnrUr4pbbePUikXSLlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC7przJoo/U4V7+YbdpjQ+1O1fwU5H0ywrj46W87LKpevNAdeXirdI9aWhmbHSaqCkvO7USLDg3mSvMcTOCrI7nWX7HR7HQ7AZNmxM29Klt1pfnHGVsY3dZ7NGUkLhpWUA0u/4aEXBN0B0SLj4G6qwxkiVliuPSolOlUHYut9+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeLD69Jb; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeLD69Jb"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f4f53975e6so807235a34.3
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 08:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277560; cv=none;
        d=google.com; s=arc-20260327;
        b=K1RHBpAuO38ujGWr8zFiqOTm0pq2Zbe2U7SCXQ0zk9QGANXiR4mBDY8egnzWaWLsFV
         RHte29olC57cc6cD/RnA6Z1bRJu/BwisQTpoAQ0z0AasYFl2QXL6gJ8o3P2/KTWoz2bB
         LYVOAX1Wd17YxynN/t29Rc9AL7a684QheVUQ1RsyKm4IOrnVMwZE1mh8jfwGbq17aqY/
         BSpXhgQooN33T6myst3kzoxjsuZkU+HyKL0mllVEN6r2Ot/IH7QIgpR60I+TMcTyOnyf
         23nSuAe1snmUACeOiISAibk4hxuLYgBvM/VIWCeqUzvDjjwYXH7ItuWjvIScXbXG9Qcg
         C1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gsQFi1OZbsAa51qs2HRH0J2IDHT8L9xs8AMXHKs0Nzs=;
        fh=5pifgl4p3JNpH2WvIzWvEY6PQEfWtVTMuqKSWkWHHak=;
        b=NTkQR+kAKrQpQAEMhDf/PmX1NObxz/HerDqbiSdFwJqWUzT0Y9TAucgLEbzKXvVUw2
         xw0+WTNGHH/5K+7Jr9861wmsTuxkVrAnJKhYM/KkmgJM5X6qFMGqo//09JATmc/MCmDV
         mI2IPPDUUaCyqQRN0iTwmW0rjjGd9PXxOzhs3qATPt6HZqGHXeFSvhnB0gmv6i+WD2IT
         PWy6PZA+5OMUn5Qv37OcpqRmPvDFdsK0WmDLEYx/oG3hdhmIInsWpBvx+Qt8OWAMlaFB
         QkrgcOhPOuYhiKVlQoD8z3N97X80T1JCtryglMkX0h7rVclG0nNaNLeeUQCGt8SDkSJe
         bmLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277560; x=1788882360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gsQFi1OZbsAa51qs2HRH0J2IDHT8L9xs8AMXHKs0Nzs=;
        b=FeLD69JbsHIAxDWi6r76ivUtRMUHszrYWwV3ny0LM95P5+sEsVjubd4zy6KvUOf+PZ
         utlWLWqBeg5aj+pXKGr4lcYqG4NH7lmulUwXt9MqdXa9YdvG7/CDadSGzytx6DvU7a+B
         2mRz9wJZUpIGLnRgxdmXGsUBYnQIxmrgd9ce9D+64RHKXB4G8Cmu1mvBZYgfXgXTjNax
         wVG8HCSM1ipYHazASi83xWTZranH8duNAlos/cggpwzPtexoVwSOgs+YY7CZscyMcrXN
         /6MVobTkVGnYVCxdPEZQzMUWZKfFbfAAHzXKnxQWUQGuCqwMhE0eLvJ+WMnUAolpVHYm
         hBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277560; x=1788882360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsQFi1OZbsAa51qs2HRH0J2IDHT8L9xs8AMXHKs0Nzs=;
        b=ruPSI6jzpOb+8RFep5n8h7KHTO+gmjqmxDL+4kUWBzqXhZm7f5huUChJjf+5PcrzSU
         nHJEQ3gUA2+Va5lD9AS5Pyivifks+7b2/c2GM5M+0/rBy6gOH9tyP7dgQ5A2IuK4tZ+s
         BkJxGudXnivvBE7NzttbfprUXYwI/yLksPrL3GWyWhmwaCPPCFxP0DNOafJOLquAGKdo
         KnQ30s6aYKXC0ePqboxRCyDTJypWSdKVNWNrnDPDoKt58OS606/KQLAcGxSBZBz1Y7Lz
         riJT+8EnOhIulzCOrNn38ZvOJf5by4PikpRlNlEHAys3WusHefIAnloaWxTORZOrTHvr
         k/cw==
X-Forwarded-Encrypted: i=1; AHgh+RrMtIWG9LX87AQpU15ExyDoMMaJ4tXSar9xqfStUsRyaKJj78g1dMoQn4CFHHgyK2eYTz2xBHwK1eOGyw==@vger.kernel.org
X-Gm-Message-State: AFuF++kv3mH4maRrT9KddGFtPIwR8ZK36qiKSLj2dpHrhC5reaNYMX/s
	uWB4YBUNjbogPn5/46lJVBpjkiHYPs3ms935+WM/NE1mXSPYYIeXk4nk9vbJfRG43yLlareitCS
	Y86j0dIyz3/7/e0k81B6r3TUK9qwm/CA=
X-Gm-Gg: AR+sD12UQcRe0rJ5WKr+NlDBnKFY/HX27e+DURPn9Ryx1ZcrO184ipVpcbjiwTyexH2
	VysGGnDbN8Z3xmIaOXaM7vS5a14sJ+I8X1b/ur9Y1r64LjxQSisCZEOL1Ogrp65Zja56leteHor
	4asAAIfJqXJkD+RbTzd1FggL4pon7+IhXJNiB/6gz7YRICImLJaHPk6nPElYCZFDeuMg1DFbpSk
	BULcyTMMmwyPTFr6JgzAUOnzEkDud0Vl+e/FoIB3W4mdrIpuqxDADF2meK6tZymEjzRM1EJk4rg
	/8olrDlDFA2LPYzq2j+NL/rn0PwTZ4rURfnBqYC51ALo+AF/VwBL0987xg+HwAP8FLNu7eg3L3b
	HQRISouUZtyNxN6Y2K8o6k/Kuzth7g0tWTyj1WYTnh7P3
X-Received: by 2002:a05:6820:4dee:b0:6b1:d18b:4057 with SMTP id
 006d021491bc7-6b1d18b4cf3mr27183383eaf.14.1788277559579; Tue, 01 Sep 2026
 08:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901142438.237586-1-yi1tang.yang@gmail.com>
In-Reply-To: <20260901142438.237586-1-yi1tang.yang@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Sep 2026 10:45:47 -0500
X-Gm-Features: AcwNN1WAKibAn_iMgh1g7gL5eDq1EGX5D1bvCdF1UgBxd1UvQDqs20gt_SkRPh8
Message-ID: <CACVXFVNs=yx1M5_S3QDawanrpjC1Kaiou++9BX-XcQVgAcFyrA@mail.gmail.com>
Subject: Re: [PATCH] ublk: add missing DEL_DEV_ASYNC to unprivileged
 permission check
To: Yitang Yang <yi1tang.yang@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:25=E2=80=AFAM Yitang Yang <yi1tang.yang@gmail.com>=
 wrote:
>
> ublk_ctrl_uring_cmd_permission() is missing the UBLK_CMD_DEL_DEV_ASYNC
> case, causing the command to always return -EINVAL for unprivileged
> ublk devices. Fix it by adding the missing case.
>
> Fixes: 13fe8e6825e4 ("ublk: add UBLK_CMD_DEL_DEV_ASYNC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6c5bec7da97c..ade5d7fddd9d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5716,6 +5716,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ub=
lk_device *ub,
>         case UBLK_CMD_STOP_DEV:
>         case UBLK_CMD_ADD_DEV:
>         case UBLK_CMD_DEL_DEV:
> +       case UBLK_CMD_DEL_DEV_ASYNC:
>         case UBLK_CMD_SET_PARAMS:
>         case UBLK_CMD_START_USER_RECOVERY:
>         case UBLK_CMD_END_USER_RECOVERY:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
