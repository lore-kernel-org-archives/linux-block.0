Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FC364927
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029079; cv=none; b=Sc7cnP+OONW2ZD/Bcrym0P6ikILrEfNlo2eLOetG2LnV10R5Ed6FmUqgoMTBa8ouaIClmY46O0p7tWCR+bCeuHdoikCqSTbNbPt4JuPABkbHVx/hihU5wR7LnUS5i3DqnATxQ/sASD2XHdPZgyNNj2xaSCEo1qrubj8uC9Ey6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029079; c=relaxed/simple;
	bh=jvi/C9nTXOmhhjc0Lb9aktYocYiVVnB804trf7lfPrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWDTWZxX0Dif/v0WdOjT5cZYQ0x6wU2tByEVaRoJl02EnuAgKlECvuivAqM89yGYMhPPoZmXjU0qkRkOqkXAKX3120yLv1BL2Cubss8odf7hWkr8Z8YYyjtVJDmBFlsc+LGvdyV8krTXM+tXxXYQIk3CCZ5p8OaqrzjAFyp5T8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEDllHkM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEDllHkM"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso2433772f8f.3
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029076; x=1784633876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b41+ZmPO1kjwWz2S29LAqh9eI9JWVyVGFI2NWPufoa4=;
        b=GEDllHkMR41S+dFNps77d42LYWFFvUETZcKa6lXe5Jznb1xNebSNVqjLBft4ultjhH
         qPDxg6pt6SzoDx06feDSqLh/R/K7JoAPcsjhcb5xP4Z9aHTtsfihFjuMh/JfMN4WLDNZ
         R9oKnySqSg266qG6syoaTLWYm4rD1FlA5PcK0holyYlTikmax3zsgTXs7Zi5uLiG8nGs
         jcKJBg2m0W4fb7Q3uk4qkVbyYvKB9be78gNuSW4O/uFxwxDKmalSJYbHlVhcUKGo8MBo
         u5+gwFL/wAdlaKM2RYh+QyfMAASBhfJf8BvWMSjIACaGt4mBpYCGmV3Fra+To33aBy7H
         Tt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029076; x=1784633876;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b41+ZmPO1kjwWz2S29LAqh9eI9JWVyVGFI2NWPufoa4=;
        b=YH0aBAbgqyvPvLZUX4Xi9th8fklZgwPoJ7LA0QQJwTw+2/topbMe9uHTAtuON0Lbip
         W/Bux4LPNIN0FGnY92pr9EKCyNDXw4X9qt/lKrLPfjGGfCgv6Jsbe4LgX1wLQ50VUY70
         NP7Eo6h1qSAycZAjof1L8j7DCv3UZ4IT4DaWS522FTIWotTVEDzWEhaS/DKbxU+tdW6w
         zueAFerlxrrJL0s/vMGum+/JUXVYo7AIiS/8oU7A3u2Od9Bi9U8TFrBYSvuFOdl8IThW
         D+99DrGuG7I1PSQPifV1AiXr0b33bFE+WYBXN5/nX8NciYd0bDmDIKyKYUi0t7Bp6KA8
         qYGw==
X-Forwarded-Encrypted: i=1; AHgh+Rrx5P7rnc0bik/QMY+w3prBlce1p/soiy+eMqM0s7PLLRZzLR+ZFFXKT78OFh2eZDCCJkMm75n9HJSueQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+5WM3vgMMleE+g/XrjUuOMKdqDRuYmYR6AdGc0822FM223c3
	zyx3vv1lKkWyEGCk0omtZbcHyIyuLd3mxuD4BzynmrlS3sxTn0qk6qAZOftsaD4r
X-Gm-Gg: AfdE7clFqWqRNbo9p+ZaOIp6YE74AuZro+UPJPN3K4ub2rQVoyIRKtyqJ8+4rbr4j8l
	R3cj0NyCehB6PLhQO9WBUmX6NP8tEWpSEO/hF+nptbkB8yId+70PJPDqkrt+RKrx7pIFRc4SRdY
	AvC20nJ03VRtqg9KtEW9lxEuo+jnVbx2oFHdLo5pLf2fGi5gYllJ+KI4gn0ApZaVn42QqsBqAay
	TY6TXR5tAJ6QadZOWVwwiNxwnlGdlXwkTzrOeaU0rva/JWQv7Yg5USn6hprXOx+zgcbQ6UCV6ff
	vORcDoiJ2ZgvA1Rup6lXjlDtCVqK2PfNClXWl6xC+oK5kixRTrw2IW8fs2II6Oehxf2kmT06GJ5
	0ShaLqq+XRuNkl0WqYmNKxw/mz0CTe3fpFG/TABTwhk41Eka5c5zy5bKvfpy4LLQ7i9ZIV16Irh
	/bnG1bnOZEcLzScE90LvckoV/wK0+scpXPEpQRURe1Y9CChUXvPw==
X-Received: by 2002:a05:6000:240f:b0:475:f0f0:9f01 with SMTP id ffacd0b85a97d-47f2dd05108mr15393267f8f.56.1784029076179;
        Tue, 14 Jul 2026 04:37:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm7440719f8f.37.2026.07.14.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:37:55 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:37:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] blk-throttle: fix divide-by-zero on legacy iops limit
 of 0
Message-ID: <20260714123754.7a88a65b@pumpkin>
In-Reply-To: <20260714103552.1335658-1-cui.tao@linux.dev>
References: <20260714103552.1335658-1-cui.tao@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 18:35:52 +0800
Tao Cui <cui.tao@linux.dev> wrote:

> From: Tao Cui <cuitao@kylinos.cn>
> 
> Writing a multiple of 2^32 (e.g. 4294967296) to a legacy cgroup v1
> throttle iops file (blkio.throttle.{read,write}_iops_device) silently
> truncates to 0: tg_set_conf() stores the sscanf-parsed u64 value into
> an unsigned int field with no clamping. The cgroup v2 path,
> tg_set_limit(), already clamps the same kind of value with
> min_t(u64, val, UINT_MAX), but the legacy path never did. Note that
> the "!v -> U64_MAX" mapping only catches an explicit zero and does not
> catch a value that truncates to zero.
> 
> With iops stored as 0, tg_update_has_rules() sets has_rules_iops[] and
> the next IO reaches tg_within_iops_limit(), which computes
> 
>     jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);
> 
> triggering a divide-by-zero oops.
> 
> Fix it in two places:
> 
>   * tg_set_conf(): clamp the value to UINT_MAX, consistent with
>     tg_set_limit(). This closes the truncation root cause (and the
>     general silent truncation for any value above UINT_MAX).
> 
>   * tg_dispatch_iops_time(): treat iops_limit == 0 as unlimited so the
>     divide in tg_within_iops_limit() is never reached, defending
>     against any future path that could produce a zero limit.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  block/blk-throttle.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index ffc3b70065d4..3f3c1374f4b2 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -883,7 +883,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
>  	u32 iops_limit = tg_iops_limit(tg, rw);
>  	unsigned long iops_wait;
>  
> -	if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
> +	/*
> +	 * iops_limit == 0 is not a valid limit. Treat it as unlimited so we
> +	 * never reach the HZ / iops_limit divide in tg_within_iops_limit().
> +	 */
> +	if (iops_limit == UINT_MAX || iops_limit == 0 ||
> +	    tg->flags & THROTL_TG_CANCELING)
>  		return 0;
>  
>  	tg_update_slice(tg, rw);
> @@ -1386,7 +1391,8 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
>  	if (is_u64)
>  		*(u64 *)((void *)tg + of_cft(of)->private) = v;
>  	else
> -		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
> +		*(unsigned int *)((void *)tg + of_cft(of)->private) =
> +			min_t(u64, v, UINT_MAX);

The LHS casts look horrid - there has to be a nicer way to do that.

And you don't need min_t() a plain min() will be fine.

	David



>  
>  	tg_conf_updated(tg, false);
>  	ret = 0;

