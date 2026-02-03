Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB233A9E4
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119756; cv=pass; b=OxO19OyIfnMrw3X71pDgVr/Xb/HFXlnZ5BYCcm04Ma6hN1xN/Q6SS6hr7Z9eFC6rcRFlhYIpzuO4y1zwXRHE4c6HnZ9Mtp7TZaRTO0v5IkqM1xpKSAhrdODziQpvXPbZ6aAcORTNvMQTRxBfwqUr2oKeFkScgrnGdTl9FDx63+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119756; c=relaxed/simple;
	bh=7Pxv2L8BpJWyfUqSmlz7ojW9DgUGKLJAcrIJ+nffUVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBgbtwaveh/nsR4QEKKfuG3gWnoW2fZTUZ47sOWYqRCQKo5m3xqhECOV7oh/ejiw6tJl89ctM3ESXR2Oix2gmJGBvoGg1Ew/27DZwlTV4837VZ9bxgLXBK48cyB82vPDfXDuwcKIDqQIklzinhiXO1OevVE0bxmk+XfpKCe4MN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eg2r5Dcm; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg2r5Dcm"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b76844f89so5241813e87.1
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 03:55:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770119753; cv=none;
        d=google.com; s=arc-20240605;
        b=JK+IEA7iBM1lQ8ANHUBznTy7ZmHVFs1NaTXRHpmSiIH2uhQUBU9Bcz0kbG+ZF1/oNc
         kMpBeAe7tI+MSgPp/laAZ6XZ971AuZ2jAnBR9g05oghxYXhm+GJrpeZ5IzeMiaFWxXM+
         ErdfacuS2is+CkpUbv97MoWwZo3nRlcO6niCW65o0iL3+CIBf6swmdzOjLhmcmHqdSGr
         dkt5iDvdPrVm/GkG0YL02sDVklxwEVDWspmjRSDn+xLBkDiWpPfg21o/XpZQOgjSN03E
         s1agJKtjYgNTpJdsAmbXC2qBhx2Wi5CNs1vfL8l+UOOPcC4FVzzskv4vJTjPY0P/7mWR
         Bpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MDE0sCrdONDLnFFACkETJtEg6lOLX5zuUsL6oiXslhA=;
        fh=45h8yJzqwq4kHO5+GwyD48H1nyGKxNvv2kxsawe6pdE=;
        b=BIfNx2MqM1S+2rK5FRllzhwvSLrZKbqkAX4bk/QxA8oVBjclVqkd1tgsNQibctZ+Y4
         ba/ZNJuA5bgaPBGNaXQlxoDwrjNDhiqliZMgrYttmVCcMiWXFOtVs1xCgkXKyeU/4/7m
         UtGU4YEdKsNbTlpJK1rE/QsZVFrKyUXtKe6KIzCM3Ujdhl88YUW61QvhQ/jbuPtjjjI0
         QVYJJYhwtHWnkYAI1uTgVmpmcy0CgJOZ96EN3GXe4zF7nFDSRtDoebQNjL8JbVKo3qtp
         riY736V+YkHxeJo2VxBJsQ8PdpvIWAxLRoGTKaj+YWXTzJZJKxccJ1daNGnDE6Q0E3iL
         lu3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770119753; x=1770724553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDE0sCrdONDLnFFACkETJtEg6lOLX5zuUsL6oiXslhA=;
        b=eg2r5Dcmt0fsJPNi07Fc2zVkUyPZwNdlgD6lJMWDOOnjAfR3HVNlsbAqwup+KkCzbj
         TIKKsmgEUPG7IfSnO3iVfMBi6CtV16uf0MtsMx8zuNQRQkw2Gks0Z8tJmLqd0eRJ4Uak
         Q9hloPRePxIOFVZHoYLIlWmiXyDYvb9cC6TwniegNy2jjjtjKmMhRstSNsXqSgkwIU2Y
         a8qhxS/6bM+0W/yLQuEDxRmlvYVwCFVBhlBbHiflO6uFmbM+ZVj2ugf92owpzuxrNsxa
         6OlMfx/YnEEIc+Roq5eUoLOhveC778hQ1b8BZ/i7O0kzM+liNqMJsQc+a/5w2vM+4b7z
         9Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119753; x=1770724553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDE0sCrdONDLnFFACkETJtEg6lOLX5zuUsL6oiXslhA=;
        b=uGnyLIvxuShSCL/yyit5BL4V5CMB7ebcUsBmWtk+84LguT9HgXesYbsjcdYPPBy980
         KJAv4GV3CgcdMpt5DqOKBSrfzkZsw/qA9f/4DJgAspPawCZHkrB+moSLGwOklvUUVtrk
         2LvIfP+3838zke00qhE9zR8O4e4/R7/pBAzjJvCCxTeyhlaiBv7s1+mrUy0GQ8Uvr6uW
         CNgULAqybNDyXELS1HXxKhfQV9ReI21hQy7m25YJddcRfllWKugyA/Gxu07WS4uWu/2T
         mK6ZvTc0al2em05APtaxCnd8Egw0/9cf2gu0Z5i8vOMSJtL8DsucSFKXsbXuMg073e+v
         LyiA==
X-Forwarded-Encrypted: i=1; AJvYcCUlTXH7OOqW8YLmc5/xdF457j//C7DGXLDzcuRWl1dYp+PqW3s5/um09noueWrog+fazJFXZEBQum5Oqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmggMAzqqIOIXryFjd2o6LOcAUWrj1Z2Uz2KGPjJVziqP1mSU
	ZRBgFQ28k2dTlABfdWTHQtdppeoiz9kq7QNcyRevFYTtl9YM3vc8BmAiDgTwE86r7NfyaI/c4X1
	iYQ5q96YHxgaLEsdEr0RSeHvyAV9CchLefK8dd6uEzA==
X-Gm-Gg: AZuq6aKrdleshlPVJkgaSeuxC+aZ4IMyTug8EbIJSyxHeVa7802iWw5pW9/vOn5RltO
	YBAbtcfAQFBm5Lt1vLsMzFpBWrHUvJfB+w7OVBjfHpHm33E4whH+qQ7mToXMEE3G4VSLf+tpRxJ
	mntECODoJdb1HzLrVPrJ/xXGunIlMvBLaRZUu/hYlBsfRkKZByhWpkm0J9Dqv2kLa1tf2kh/hkE
	J01CCugR57QyjnH8gYOn3kIbC4PAfw53F2n3gV66PHzWAwbCmx1eRoOfW6wWGrgCBd24Sd48zc2
	/8NtEII=
X-Received: by 2002:a05:6512:3f25:b0:59e:17b:f4ce with SMTP id
 2adb3069b0e04-59e1644a0f1mr5248014e87.50.1770119753362; Tue, 03 Feb 2026
 03:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203102903.2953660-1-ziniu.wang_1@nxp.com> <20260203102903.2953660-2-ziniu.wang_1@nxp.com>
In-Reply-To: <20260203102903.2953660-2-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Feb 2026 12:55:17 +0100
X-Gm-Features: AZwV_Qhy5FVK3X1zDmepaoff3JHzpQHSqhwDgipwjkDYIj5M4Whz8OPbSR5lqkA
Message-ID: <CAPDyKFpu6BEqJCg+=E3VDH1DutEy0C-bobtvEXucRBd6JvRbVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] block: decouple secure erase size limit from
 discard size limit
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 11:27, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Secure erase should use max_secure_erase_sectors instead of being limited
> by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
> REQ_OP_DISCARD to allow each operation to use its own size limit.

I don't know this code well enough, but is this change really sufficient?

Don't we need to adjust blk_queue_get_max_sectors() as well?

Kind regards
Uffe

>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  block/blk-merge.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
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
> --
> 2.34.1
>
