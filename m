Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF830DEBE
	for <linux-block@vger.kernel.org>; Sun, 31 May 2026 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780263496; cv=none; b=Y5ryAv1vvpPHbIhElN6lh3AX/YJG2Ozq4xSNKqBJGx/HK/DG7pIb0TDcD7zU5UszA4fQedE+YhaNgjDeTPygcRTWj8VUbcUhysueU3AbDv9EYu4b7Eaw/I0pxoSH3lTama8NOKDv7BKiVEEh/ijMcorXp4PH0TSKPODzWfQ/wRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780263496; c=relaxed/simple;
	bh=1dgxJgxepE0o2fv0Yk+5W+qdhqsbf6104R4lJWV5OpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7btnhzbu/VO7L74iPi0wzx7ymXVIqZsZB7hvjxvr/UF7Y7HlMUQg455vMUb3FnhiSljBacwCbPhOqGMv9D5kCR/lEsfF7UPFIrRPsEzd5XN1MJ1eK4x+wpEkKv9uqZo5wYhjqzauVljpX81v589Salwf3W5koMtf04gXC2XYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujsb38R3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujsb38R3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B33C1F00893
	for <linux-block@vger.kernel.org>; Sun, 31 May 2026 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780263495;
	bh=3ChlNi3gY4pmClyTFzjJW4JTye0c8PTWwo1dt2DbBgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ujsb38R3V4L+gQguxzwB8Xb+Q2WVperpa4SQqvZHHDKn6GCqR51/eYLNiz7UoTaUE
	 cb7cK6dY8Opj2E5hWjo66rJS1KuH3scYI8FLzLA0bANRhyLLwai95gckI3xhizj6Oh
	 4KV9+I7Y00c8yeGbcxFjbcy9Rs2K/csucO0eD7aVmQrf2skHut/6Fpwb7QJp0pg5V6
	 a+WT5HinCfwb4RQvZUsxtjLEBNMnCveigF5G0aUtSbdNsB87fXEhSccqdC6xf88cIC
	 C8gqSQZ8eH7ZIFTyClyDxJI/9K7KM2xzfKX6730jJXzzGLKziWv2QgFFq7SXSH3hjt
	 edhpaguCEJTpg==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91550d518c0so84037085a.0
        for <linux-block@vger.kernel.org>; Sun, 31 May 2026 14:38:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+lY8znRww/dKT/Ly/NkPjWBOdF+AXcFNJ+Px6aGaJd2MIgHwKteAy3Xuxynkg870DgWg+LkHGUaQDy6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVdhJJ9MelARPkqsPDVHm7cL/1oUMSIJ95O52SkANzyrkIoet
	riTU6ID447+yGvdCUM0lHmA6uXx3QP/as+tVtIp+YR2ORIkt0YECczWBBtb4wB/nHLs/IbxwN7f
	CCoccSw9+t3fWifeZT8ZS1SrE8jYnoOA=
X-Received: by 2002:a05:620a:448d:b0:914:dbb1:1487 with SMTP id
 af79cd13be357-9153da3f0f6mr1264775885a.53.1780263494750; Sun, 31 May 2026
 14:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-zram-fix-partial-io-config-check-on-akpm-v1-1-eb085d98faea@gmail.com>
In-Reply-To: <20260531-zram-fix-partial-io-config-check-on-akpm-v1-1-eb085d98faea@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 1 Jun 2026 05:38:03 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wB5XyUrPpg1O-pkySxo91RsHxaaUkR+Kt+heP4_OeeqA@mail.gmail.com>
X-Gm-Features: AVHnY4L6_UdjcCk4-_UTU0q2GUVmZ6B69Ux11hFD72dT9usvr_K3TiSBY_9PUJM
Message-ID: <CAGsJ_4wB5XyUrPpg1O-pkySxo91RsHxaaUkR+Kt+heP4_OeeqA@mail.gmail.com>
Subject: Re: [PATCH] zram: fix partial I/O config check
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:35=E2=80=AFPM Jianyue Wu <wujianyue000@gmail.com>=
 wrote:
>
> IS_ENABLED() expects a CONFIG_* symbol. Use the real Kconfig symbol so
> this warning reflects whether synchronous partial I/O is built in.
>
> Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
> ---
> zram: fix partial I/O config check
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 6e1330ce4bc1..72f89fd5572e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1510,7 +1510,7 @@ static int read_from_bdev(struct zram *zram, struct=
 page *page, u32 index,
>  {
>         atomic64_inc(&zram->stats.bd_reads);
>         if (!parent) {
> -               if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
> +               if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_ZRAM_PARTIAL_IO)))

However, I don't see ZRAM_PARTIAL_IO defined as a Kconfig option.

#if PAGE_SIZE !=3D 4096
static inline bool is_partial_io(struct bio_vec *bvec)
{
        return bvec->bv_len !=3D PAGE_SIZE;
}
#define ZRAM_PARTIAL_IO         1
#else
static inline bool is_partial_io(struct bio_vec *bvec)
{
        return false;
}
#endif


>                         return -EIO;
>                 return read_from_bdev_sync(zram, page, index, blk_idx);
>         }
>
> ---
> base-commit: 404fb4f38e8f38469dfff4df0205c9d18eeb1f57
> change-id: 20260531-zram-fix-partial-io-config-check-on-akpm-c62b972416f8
>
> Best regards,
> --
> Jianyue Wu <wujianyue000@gmail.com>
>
