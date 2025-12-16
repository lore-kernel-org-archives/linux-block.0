Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCCE502BE
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846798; cv=none; b=GGC84R3cad7DaPZyMw7ztLiw3rGuM7wwF0oD9WHwXnhHWNeMLNy+CbF9dmbHg9WyMsaNedgePbwBjF4MhdyWhu6tV7wf4eb0FAH4d0gLOTpMvgWhCvmiNV6n0WTe/QoTf7V81feLGGGJaxOMelz9rxgq2D8r2tWfB7ft30Vdmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846798; c=relaxed/simple;
	bh=//4WIvg73Hu30GoTf9wmwm7I4ggtAnIAFr6aLd0jcFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV4y42bPJBGRlwZy+vq6vumnQZ01bC6ObwgsE/QKsyBbO4vWIAbpb/fuwR/H2FPVH8ben3V2J374l5bucNflqngrOu4yKQ9Zg6t3VZk1MN5aup3hLfUcxwFgBG/MHwSDvgnZE4JeltW3HwgD8V50BW/S1YQo9lXcziuKsVRtYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BmNwwa2J; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BmNwwa2J"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo4643364b3a.2
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 16:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765846796; x=1766451596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XwPO9yMCVhQskNTI1ysT1se2RsNXzL/QNGlyZ6nBCg=;
        b=BmNwwa2J3kvAkZxBLH/6BazfpMJ0uHYVTyWyk5eDY7JFIEzxpQsg5FxSC3PthTG+E1
         kXAzmVVda7Ip5xcyuO4p+BQX+SfhBzo/8Zb/8VNJ3o8/lu06XotNxGWRBJlPOA6brUhj
         YvojbCfNLM/sNzLCeDSdJxCDqs5zLWDNjo4lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846796; x=1766451596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XwPO9yMCVhQskNTI1ysT1se2RsNXzL/QNGlyZ6nBCg=;
        b=lz01kVKMd+oCbjNd4COZF9NcIC3N7UM0pFW2xX2tvGK++k7Yupn+lGe0O6Iu/kMTg/
         WAnNi6HPxU5Nv/zRwhmencXqoQzHsSCfWX599nWrgHlli5wgKl11Ld37nQtwT1w740VA
         grtULK3U7ecrgqZEFHiD4NruYoxwdOYUOKPNLWEo09hSCXNSBf9y6qLR0zBZ7R7QRN2T
         9wCgJheFqO5/DNfjgbyV0pSAaXhqvtRthdPaYAMuHMQ/iy+yIa9xMMCSA2sB2d5gUqz/
         0+8u3BSWRsDVE/0uXwCJxb1iQhs1k6u55AZKZVoMkg/apBm3U4qRwb/gzotMx9aqiSfs
         zLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjWfnSLyGP+p5hnN1onjD6RKg/zTpfJscAwFOLhi56CxhXeKmpf6y5nbLNmgR6/pUFVaDrk3J1tqyGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvmqaYPK93Y9qZm+7SAOtbyVelKsVps6s7rrIJtv1weVpzkVI
	w2/pkANGxrx8t0WS9BDyjtLvfI6JfFhX0qnknTKJ85cDqUeIXZMbXGd0rvMyTjDY7Q==
X-Gm-Gg: AY/fxX4dEX6WuIB3mg05abm1b/JQg0kdyEkckKcUqMqlIbjTiHHLlEErFbKWWCavdc1
	xFIC0MqO+rpWctCv/43bCWhRI5oxDPDwFUZNfFZxBcUtJBCKxeWc5PlOKwujibK/G/m/S/sIrUo
	HQiW6qCX2dug0ylt3fd+ztV/56UswZO5YCGbU7YewY9z5uniGYrLl4PwtvF3WomWNrSf5iF8qs6
	kqBP+Ma1ZfnE0pOytvVNaW6wzTcbyIJG0pomSO1iy8LE/hbZkHYS/j++1c3wDPqm7l0OI4/EOTO
	FV7983eNkr4DjYJujyjGFqUkCNqjD7uPDjc9p/YU0qjPXC6L9dyYyUmncIfk5hhmzdXx/FkO5m6
	7LnHNP8Sg6HkHnh+ZJp8pD8XhwsvQotz0GY7Kx3mKs8SRjCVFsYmSJ3NlPCAwSf9gHHTzo33s7F
	g13R3A3Vz1SY0zAbud6F+FLmeTbnZS98wMACCy5akXFWuyp/blxGs=
X-Google-Smtp-Source: AGHT+IGEC3wHBt1cpaWxFq3rArlKaxZEuML78xaGrv1POPMuUxQiI92/Ql/BFfcCGA/NMFccVMpAMA==
X-Received: by 2002:a05:6a21:9986:b0:35f:30ff:89db with SMTP id adf61e73a8af0-369adfb32camr12542999637.19.1765846796634;
        Mon, 15 Dec 2025 16:59:56 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:88fa:c762:fe19:6db7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2c963b53sm13573171a12.36.2025.12.15.16.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:59:56 -0800 (PST)
Date: Tue, 16 Dec 2025 09:59:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Brian Geffon <bgeffon@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	David Stevens <stevensd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] zram: use u32 for entry ac_time tracking
Message-ID: <gqkugg2q3hafwikx2wvnsh6oa44ifbtuskmigsqbrkaztjwj4i@33n5p55zq3nz>
References: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
 <CADyq12zu_o1fEz2B0nrZUFhbnEgiLPVkJv4ku5mrXYNBBNQ-Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12zu_o1fEz2B0nrZUFhbnEgiLPVkJv4ku5mrXYNBBNQ-Dg@mail.gmail.com>

On (25/12/15 17:31), Brian Geffon wrote:
[..]
> >  struct zram_table_entry {
> >         unsigned long handle;
> > -       unsigned long flags;
> > +       union {
> > +               unsigned long __lock;
> > +               struct attr {
> > +                       u32 flags;
> >  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> > -       ktime_t ac_time;
> > +                       u32 ac_time;
> >  #endif
> 
> Why not just always enable CONFIG_ZRAM_TRACK_ENTRY_ACTIME now that it
> doesn't consume any additional space?

It's "free" only on x64.  On 32bit systems the removal of
ZRAM_TRACK_ENTRY_ACTIME will unconditionally add 4 bytes
per zram_table_entry.

> Also, why can't we do this with a single unsigned long flags
> as before and have a simple method that isolates and casts the
> lower 32bits as a u32?

There are no upper and lower 32 bits in unsigned long on 32bit systems.
