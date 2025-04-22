Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180C63D
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301666; cv=none; b=c2CuW1DNE5TD+OALR5M4FXgJsnddHBCztA1p4qz0svu0FzFto3o5rLKt4oT8V/67kcSvKZaTeSAPoEn+/QaldmDqVeCzV0qxOtLGj7eR6ckGbdnQR3Zcl88LPsGDB/60dkgJEuUrMQzv+GVBggFY+fI8ljIw4nG095aHPlRayEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301666; c=relaxed/simple;
	bh=ryrrb1y06tmN0kQiAjkDpAfgEs20dlNc0D51dW/4PXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPuO5RcmH1TkkDAbNbaF0efNv1iTB3h0tJsnekrA9KL6RqvU3AK5ti7AIds+W1vMWAG5djU4okDhPzwSGzQNcte7Z2MwivrCwoOnsyBI812r3GvfjaxthabnpwiENV9ukX0cDCRXetDHgz+Twdabd+YeEbbQWkYmqWAKA72ECfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZn+PJ9D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZn+PJ9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745301663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmVaZQzLh9EzB5YtxGNfRajzM5T5KN9CVrb+5GDKEow=;
	b=DZn+PJ9DiSTKVVzI0Uu5ZQwjGuOdl/CQza8frSdqYxoXnLINgGBTyxtLTTjWo35kH2Tgs/
	GT61soQoSGCoF6VdrbbL5fA27POgiVbXFPbZQG6YR+vlKDRo2Oi8X/ihZCbsOKQM7MOtLy
	iGovMM6YSOY5YOq33teT51TRM1AJvi4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-nbGvSk5KNfWOEzTLPh0ZnQ-1; Tue, 22 Apr 2025 02:01:01 -0400
X-MC-Unique: nbGvSk5KNfWOEzTLPh0ZnQ-1
X-Mimecast-MFC-AGG-ID: nbGvSk5KNfWOEzTLPh0ZnQ_1745301660
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bf647866aso17981791fa.1
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 23:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745301660; x=1745906460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmVaZQzLh9EzB5YtxGNfRajzM5T5KN9CVrb+5GDKEow=;
        b=cVFXPWItjFdDRm1BCL4mgx0utiuV0p3u3BC5rLv6xfTWKn/Lm0yunEnjjuUJQ/M2As
         blOv5TjQG2rNa2aNip544+joGbkCEJU+H/ClIfDO97UFhWlXdNPXgQ+hPwiDyBeKwwdE
         WlMXmapcqM0X4xyTDKgDUXkZWyu+MLkK9bc8bxyVTb+qPNBVMMP2b+tMKXLNHzn6vIvk
         Of5lwEm/hCBI5tVJIVs+Odm+qcIJK3tQKt2E6JQ4GVn5HuR3EDORSrRTBgLQmYtffRrh
         ftNWIpHcB4Tiubvx0q3IAeRBOfaQNHTsk9n12f26h9hdN/EuqMZyWuizU2bECmP/nnul
         om/A==
X-Forwarded-Encrypted: i=1; AJvYcCX1+JflyiiZYkW3JksZTORmAyNFPzC8FNf81/USSgNA/a9bSrzAnRaF1WuIG+B2lj2WIEEKjUcxPZZbwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE865R7n4Leynj2KRC2j5/gP6rAGSM+CZh5lUjlJ3RSxER43HC
	MBUDrQ4if+U3MVxHcxMpvY/km4x4V7GlbR09yb/eAz7QAqDvSm5i3t/FBIZ8lNIIwtJJBCkSYPE
	8MuAbj9JeSbjXss0DMIG9O1DfF20P4jEnVhvop3F9ZCLYyiSzqFhzWedlHOtW5CYzOev00w7WL5
	NibP1Luvhitxc1ZzwB4Fjm4hVlGbu5NeoSxlg=
X-Gm-Gg: ASbGncvMER9n8/8J2lzXOMye4FbutbrJpUnW/898+2fetceKz3t9KnA1LQXa6EWsThG
	7wZzaS5PyeUQrcast9ekGnFUO5ecAg8OjTvSGL+8cjDbLbAJ10ofAl/U8J8pCBxxWMoM5BA==
X-Received: by 2002:a05:651c:2225:b0:30b:b9e4:13b0 with SMTP id 38308e7fff4ca-310904dc746mr39170221fa.12.1745301660068;
        Mon, 21 Apr 2025 23:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqU1jpMVzklLc0LYUoiw2pX2+zQ+Ae1Qiw/Dlcjlmsl4WFlusGSEBhgoXOJ4AXz/ONZUVxLjoJd3VFiEjDhek=
X-Received: by 2002:a05:651c:2225:b0:30b:b9e4:13b0 with SMTP id
 38308e7fff4ca-310904dc746mr39170021fa.12.1745301659584; Mon, 21 Apr 2025
 23:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418010941.667138-1-yukuai1@huaweicloud.com> <20250418010941.667138-3-yukuai1@huaweicloud.com>
In-Reply-To: <20250418010941.667138-3-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 22 Apr 2025 14:00:47 +0800
X-Gm-Features: ATxdqUGoL_dvxnP97XF7H0NhlTFLX63ezZFe3gUv617gquhQtrDzo9ggZhcnrJM
Message-ID: <CALTww299yYNHAMeYy8TczxsUkuHyj53g6yErNAtkou2mG9z7tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] md: record dm-raid gendisk in mddev
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	song@kernel.org, yukuai3@huawei.com, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, nadav.amit@gmail.com, ubizjak@gmail.com, 
	cl@linux.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 9:17=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Following patch will use gendisk to check if there are normal IO
> completed or inflight, to fix a problem in mdraid that foreground IO
> can be starved by background sync IO in later patches.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/dm-raid.c | 3 +++
>  drivers/md/md.h      | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index 6adc55fd90d3..127138c61be5 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -14,6 +14,7 @@
>  #include "raid5.h"
>  #include "raid10.h"
>  #include "md-bitmap.h"
> +#include "dm-core.h"
>
>  #include <linux/device-mapper.h>
>
> @@ -3308,6 +3309,7 @@ static int raid_ctr(struct dm_target *ti, unsigned =
int argc, char **argv)
>
>         /* Disable/enable discard support on raid set. */
>         configure_discard_support(rs);
> +       rs->md.dm_gendisk =3D ti->table->md->disk;
>
>         mddev_unlock(&rs->md);
>         return 0;
> @@ -3327,6 +3329,7 @@ static void raid_dtr(struct dm_target *ti)
>
>         mddev_lock_nointr(&rs->md);
>         md_stop(&rs->md);
> +       rs->md.dm_gendisk =3D NULL;
>         mddev_unlock(&rs->md);
>
>         if (work_pending(&rs->md.event_work))
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 1cf00a04bcdd..9d55b4630077 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -404,7 +404,8 @@ struct mddev {
>                                                        * are happening, s=
o run/
>                                                        * takeover/stop ar=
e not safe
>                                                        */
> -       struct gendisk                  *gendisk;
> +       struct gendisk                  *gendisk;    /* mdraid gendisk */
> +       struct gendisk                  *dm_gendisk; /* dm-raid gendisk *=
/
>
>         struct kobject                  kobj;
>         int                             hold_active;
> --
> 2.39.2
>

Looks good to me, reviewed-by: Xiao Ni <xni@redhat.com>

