Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E91295DB8
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215636; cv=pass; b=VvY/wH8nvw/tEOOSJEYZRCDHUaWNHE15dupGrXEVVMFSMYWsldJCbvr2lfTWob7wpKFaaupYENJbGza6jkfiM5T/oCaZI0EvWbKrWeZswkIoJz3R2RSqnzxhVuYp2XsTmEnWX67sdpWb0MNLrysio+uqBrwiUqKAQXbmA2HxgiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215636; c=relaxed/simple;
	bh=EYXRe70f0VhAsUwZXbYgNsIOmrBCn09wFHpU0kQzeaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5K0l5ViyOl79bvMo35b/rXe5/znwKIhR5MDcyOOlvPpVJxukfAaLtnviG+xElZdk3LmaiKww6WvSReEx8ePAkEAsmbybAwsNRvQpjoGALlCf/mZLBylNJrosnfwb9fpTGAQSMG/YcEqN4XoOJdFxkHhIwHNMgOPyBowNxQJpJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu21RlCl; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu21RlCl"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64969550a1aso6797991d50.1
        for <linux-block@vger.kernel.org>; Wed, 04 Feb 2026 06:33:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215635; cv=none;
        d=google.com; s=arc-20240605;
        b=bJhuS2UrmwkR7GTlwC+DJ2w6i9lNrhwpb1pFpwGU7Fme0IoVxg6NDZVnxyn4qG5pJx
         FAD/x8YeheOsoe5EwGEwHe76kQ+Fhg6MI7Jkrf0zHlRU/I7/sAw6Z3nhrrbHCAn+i4mm
         0djl9vEHDyT3LIZ+t52NM5TCaEazymWaSZ9nlol7tS1Urp9bmQQjAEp0IvCMWXyIIio1
         WeNR3gNNob7Y2Ld6Xssgep1tu+vCrKlNNZknjGc9C2tdcEMWxTBiEEikaeSZHZa/xaiM
         FG+k2Vghuzw/Sfkp4s0iLxNKueNZElxDnJdxiAkg0sETndmBiradpUd8p7OND+uE2+ey
         3nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W8AAMIJsoWGn8x1NtmyKbgTrFaMWwEU1ewpQmfJpncU=;
        fh=zK8AeDf/p7CjX6jafO3JTYLoVEaoFkTu28pj4A42+KE=;
        b=AKKmuavnz5/T3QlRZlEQcCcwSfGPItz43YLQAXvg322kTUCppBrhCOppSnxuUXlIg8
         CHjiYG99pvp73Knn3NcnIoI48ei/jMhgVYYKLnMlqKfpuUvNSOmm7QE0vmGaY3g3Tc+F
         r3wurd7SakCnyTBzaF5iFbz4NxI14JokvykLz98j+Aw+g06etKO/zMCot2p+/YeNHLG3
         8xbIUX59IqnjhupCEazlGntSDYyxrxIUAzGM9aV7KkAQzkJJlBkNaViJecV8S3o+TRjK
         8n4PEwbIbwcxYJVvLytxfCXugQrkLB6AbSUq0SXSOj7BnF6O88xLp+9Byiv6Hef9A0l6
         4I4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770215635; x=1770820435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W8AAMIJsoWGn8x1NtmyKbgTrFaMWwEU1ewpQmfJpncU=;
        b=eu21RlClGiIiH1lIvxhIpgSvXmR1oYucAYPiecNulSM3r1w9T0H7mRPfXs7pV9wTH+
         O6/kXNOBp1e3VuzRJCZRU9O/qMKP5Yf5+acCsIiy2X2FeuB3jhfxgUPWlv+dtRG3FTnD
         Ubw2WsKVuWeY+wGaeSCxX0F2siDwOQFShZkKNEU+9M1G5YnN7d3SzPxmS73JLYvzirBK
         sUjwZyFiOYi7N2TC2iYX9k7lhlTrhehqlyguUq0pndN0NpMmcoLyhuLcNR1ILMLjYL4q
         aaavAZWrFpQLCeyF/PlR9S3Yv5bq8IZMwWKKav73bkMJKvK/9QZJNbqe7N3jFsXRoDNb
         0nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215635; x=1770820435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8AAMIJsoWGn8x1NtmyKbgTrFaMWwEU1ewpQmfJpncU=;
        b=JpB1gECcC+YxcPnJT76jaRQAwZXV0NHHxll3euOKykkQJfCrmJDlvcbGt2/MrgGFGC
         wpzBXxU5xVXgPmxngw/tlF4r0PHejPYs3AInUp07LnDM77SMuT0lIpiOb26Be1mZWvG6
         9whqO4SS3xAfPfeDVcI9PcY2yu1lEVGXTKeTd2wbBJ5TvKKBk5rq4EAlnl9AS7pz9Ssc
         GAGInF4xHlTMdtFPoKZA1QeEz5m1rAa27t+4AN1hwj43Xj5DQZ+oXMmKYzYZ4OvfNFDy
         KIcfta2ti3WPl9DWZLMG7XYzrnD8fypTZlVtPjRUm3iSVJbNrVeE4/K1l8YoCSh8HhSm
         LfXw==
X-Forwarded-Encrypted: i=1; AJvYcCVKvLUvrY8n3elFPPAeDYhvJTgdZ72DENJv3cEvMR0R/EjbE7C2k7gGyUuhITHgpLEQ3ZUcEbJORyoJQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/7L/MScsdQ+GqOWP5KtvxRHfanllC/CJ7VPdOtG2o6C0+Cov
	Rp1lobWPXKBHFwYGc/3jFbuZw8NN/vpGPyt8kuiox0aGv34RsH/mUvlzf2Dp6kkmuIW0ZdiM7yZ
	S6wu2TZZ4MS2qgt+n4+jj8CeDVAojI1vQpnxUapb4rg==
X-Gm-Gg: AZuq6aL6VcAZe/Mj4IGbJFc8wAw7L4zNN4FLEAvmmFzG+kNtepnwowrmmkOhSq8oDf1
	fiptmPaBBhJXWxij0uZbIj372vhPhY7MCVhwQqNM1Gxv4mM805e4vM2hFg7pjlDwCUOs1xbrYeN
	wm0fOC3ltULNg4D4yu9q5cTfrPbF48UuTdT+pGe0Qjs4oqgAkx8b2d7cgkQvz5ztd7BgSpsrmmy
	YS3SCuOryar+bCEimSzg2S/O3KwMYqDdmMvBX4JCLe0ADLcWqCGBIB+nEQ17HzoA+cnRu1o
X-Received: by 2002:a05:690e:1205:b0:649:da44:78e5 with SMTP id
 956f58d0204a3-649db4e3aefmr2396467d50.95.1770215635430; Wed, 04 Feb 2026
 06:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com> <20260204034003.2961402-2-ziniu.wang_1@nxp.com>
In-Reply-To: <20260204034003.2961402-2-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:33:17 +0100
X-Gm-Features: AZwV_QjdaIiuyJLYtm5HRUl8trj1dPtvjGw045l2G2FIxpBa3pt8KtgU9SUnB38
Message-ID: <CAPDyKFrnbvkp2_WP837-nsTZN5vatKifETihn-y+YQ1=DjbADQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] block: decouple secure erase size limit from
 discard size limit
To: ziniu.wang_1@nxp.com, axboe@kernel.dk
Cc: hch@infradead.org, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 04:37, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Secure erase should use max_secure_erase_sectors instead of being limited
> by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
> REQ_OP_DISCARD to allow each operation to use its own size limit.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

As I said before, I don't know this code in great detail, but FWIW,
feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Jens, please funnel the patch1 via your blk tree. I have already
picked the mmc patch (patch2) via my mmc tree.

Kind regards
Uffe

> ---
>  block/blk-merge.c | 21 +++++++++++++++++----
>  block/blk.h       |  6 +++++-
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 0eb0aef97197..fcf09325b22e 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -158,8 +158,9 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>         return bio;
>  }
>
> -struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
> -               unsigned *nsegs)
> +static struct bio *__bio_split_discard(struct bio *bio,
> +               const struct queue_limits *lim, unsigned *nsegs,
> +               unsigned int max_sectors)
>  {
>         unsigned int max_discard_sectors, granularity;
>         sector_t tmp;
> @@ -169,8 +170,7 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
>
>         granularity = max(lim->discard_granularity >> 9, 1U);
>
> -       max_discard_sectors =
> -               min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
> +       max_discard_sectors = min(max_sectors, bio_allowed_max_sectors(lim));
>         max_discard_sectors -= max_discard_sectors % granularity;
>         if (unlikely(!max_discard_sectors))
>                 return bio;
> @@ -194,6 +194,19 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
>         return bio_submit_split(bio, split_sectors);
>  }
>
> +struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
> +               unsigned *nsegs)
> +{
> +       unsigned int max_sectors;
> +
> +       if (bio_op(bio) == REQ_OP_SECURE_ERASE)
> +               max_sectors = lim->max_secure_erase_sectors;
> +       else
> +               max_sectors = lim->max_discard_sectors;
> +
> +       return __bio_split_discard(bio, lim, nsegs, max_sectors);
> +}
> +
>  static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
>                                                 bool is_atomic)
>  {
> diff --git a/block/blk.h b/block/blk.h
> index 886238cae5f1..a6b1de509733 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -208,10 +208,14 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
>         struct request_queue *q = rq->q;
>         enum req_op op = req_op(rq);
>
> -       if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
> +       if (unlikely(op == REQ_OP_DISCARD))
>                 return min(q->limits.max_discard_sectors,
>                            UINT_MAX >> SECTOR_SHIFT);
>
> +       if (unlikely(op == REQ_OP_SECURE_ERASE))
> +               return min(q->limits.max_secure_erase_sectors,
> +                          UINT_MAX >> SECTOR_SHIFT);
> +
>         if (unlikely(op == REQ_OP_WRITE_ZEROES))
>                 return q->limits.max_write_zeroes_sectors;
>
> --
> 2.34.1
>
