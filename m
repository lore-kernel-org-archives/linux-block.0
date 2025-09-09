Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF541E1E04
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393114; cv=none; b=urFi48p6S7IOgKn1zly6X9ovc7r/wUuM6SRenhNcBGuFxlAh3P0nQfgJqWDdR68yNV8e8+qS9ZyWRGXsEi3PqHPNvo7gQipLuyCbeFagtLJeUOWP0cZTFDQR9/cTVI2H3z2VYvdVT72du3NOoOAx7m6F3oKQ69NYZdGr+2LJcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393114; c=relaxed/simple;
	bh=h2zLb98Re6+TqRKu8El0vTIE3NVBQlmVT7tAxCoi1P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acdmvzzT36DzUpTGkOOKwHG2haJa3OX/TPHUh8GjaTotSXZ2h8EnAWXwDYDY2hLaGFbB/8WDREyifsaKbLImwgE1a+fG/wlttdnF89jzhTb7XQ8aNbbCM4DKtAraoVLmuUrSlyML2vSfTBiBdQoiE6RKrAKLCfNSKJ5I4iJapZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xf2hMHBl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xf2hMHBl"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4260098b3a.0
        for <linux-block@vger.kernel.org>; Mon, 08 Sep 2025 21:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757393112; x=1757997912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw9FRVGeGdiCd/bJmRIQ4WxU0vZY58/+OsQY+gXf61A=;
        b=Xf2hMHBl+UXL8Lp3bTw79IOd9pGlCaUUfYkJFA3vr/qq3N5kaKV9YNd4RoikmNY0xx
         h7WJmVSu4g7UWkRy/EVdL3FtOwr6y56r9QQ+7a7cPOIIa2CEMsNTuZ45ZKRlN0F4OQaG
         e3ZukZasF7Crsx1jKp2oxpk0DOJ1SC0J0snt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757393112; x=1757997912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw9FRVGeGdiCd/bJmRIQ4WxU0vZY58/+OsQY+gXf61A=;
        b=gsJyiMDHLH1g+GdbnheUXAsZ2R7Wb2MfNtait+kfNepXEeUvKuGzVW0SGF1HKRPvWr
         jI6oPDTw82AxazxMZJKnL5bhLlfUMy0rqn0PbRXZswQbEpPbdxtg5G/nYGbL/si+rOO/
         q6NCq1FnRW597LMAxDfMVdIaT7eljq8+w+IMBM9EjdosyX3ebJDM42SNL0Prgmk1H846
         Ykej9ZXAx1ooe5KGmlTXWpWVSlsBnBG6eddsxjiXN7vYLfz0QpeY2XqqNk7tqtGu3mE/
         lX+OVAREXKNpfce5nPA+hZWNI+lOVfw18+SkbfMQiI6hZjcBlTJUNLiXy0JeVWRDNghi
         My0A==
X-Forwarded-Encrypted: i=1; AJvYcCXZZhgkvY1Y9gzNihg5E5IKRWFH89spig9Pi/ZoHF+6BaTQO9+hOvWmRRt84o5YMaEvfA95MSo7cl0MZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRPQUYCV4QOyKltYGLSFEp3KwOo0BvXkFk8x9c/hg+0NjQJqL
	GmWVvK8bl2fK78UtzeDcAeA0rKDcItPNanb5ce/z/vY0zCFnMyPqgJRPnKwhFMffrQ==
X-Gm-Gg: ASbGnctsQfBfrClxAZWDqz1fVV6iDMmEnBsrUrImprmXWcQZiJb+UJWs/53/NVxXROM
	Mqy+B+Ue6Uq5iG7yPP/ohoyLJltjuHMecTtfTBJHr8LwW/Q3rae4sWlmW1jipF+pfZIPO/2bTei
	iH9Xb93fcloxoTfNu2qGp+k5cUYIugj4ak7bJtelGm8JJTjmF1DFy+XPO1YYwwr/XqPIK91NMOI
	5ArolvwN+ZEG8PfJygxouM/0Fe3tgpFJBXFEevPXnWCiUwgr/chmuoh7Dj8Xa7v4W2ABO2hWNJe
	bOU5qYiTampAZQKeaNooAfsD/483E/aUsQtza7CH/r/6kmorpXaae0+ak4N6v2jYI6Ld6hKr0bH
	yArbPZmpp3LTiTW9twE0FZbVtTba9SlrEb1MN
X-Google-Smtp-Source: AGHT+IGCqtZZ46cDNSS0o0PTPi1cbO52ZNRmi+3GMrDkXr5MYMYXI/v2R/W4TFVfMyFz8piB9a3T8Q==
X-Received: by 2002:a05:6a20:2588:b0:243:a2fa:e526 with SMTP id adf61e73a8af0-25340b1a86bmr17101612637.25.1757393112270;
        Mon, 08 Sep 2025 21:45:12 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:337f:225a:40ef:5a60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1cfbbsm27816286a12.23.2025.09.08.21.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:45:11 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:45:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Changhui Zhong <czhong@redhat.com>, Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix slot write race condition
Message-ID: <hpzh3r5ie2lc6abtaefhmijoxwem3f3myjixjzup2npcgd4hfh@vmqtdxtoeu6c>
References: <20250908193040.935144f444ab0e14c2cdde60@linux-foundation.org>
 <20250909043110.627435-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909043110.627435-1-senozhatsky@chromium.org>

On (25/09/09 13:30), Sergey Senozhatsky wrote:
> @@ -1848,11 +1851,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	unsigned long element;
>  	bool same_filled;
>  
> -	/* First, free memory allocated to this slot (if any) */
> -	zram_slot_lock(zram, index);
> -	zram_free_page(zram, index);
> -	zram_slot_unlock(zram, index);
> -
>  	mem = kmap_local_page(page);
>  	same_filled = page_same_filled(mem, &element);
>  	kunmap_local(mem);
> @@ -1890,10 +1888,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		return -ENOMEM;
>  	}
>  
> +	zram_slot_lock(zram, index);
> +	zram_free_page(zram, index);
>  	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
>  	zcomp_stream_put(zstrm);
>  
> -	zram_slot_lock(zram, index);
>  	zram_set_handle(zram, index, handle);
>  	zram_set_obj_size(zram, index, comp_len);
>  	zram_slot_unlock(zram, index);

Let me send v2 shortly.  I don't think I like overlapping of
slot-lock and stream-lock scopes.
