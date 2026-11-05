Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900354;
	b=5Rxz/h61DrT/zGd3FimWNTNlcErC4BEBd5KzUgxpf4j/CU+houC2TH31AiSpuy82WlOZ
	 m8G1KjdGX55n/1iygOv2IhIZKf/BwT4bWNYWJO5b7WS4N7O9j9YP6pt/niw7S4H2tvZtS
	 VkZNcTFjgb+N8dQJl8aPvUjztcKTC3dAafc6Pxl2NEwHmBqnxMjPG2LuyouF5DoBZJita
	 K0zNb5O56aAWTB+SgVzEkx4GoQoAemOFOErX9Bq+2V9C62VIU+STFm3WhAE26DICmHwBK
	 RZG/AIbUEJdGgif+4KYQVcnsUe8VZhf07X0HU1Ymv/ig3jfoc91sH1zB3v+wv4l8zXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900354;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HzBYPoNXExK3g6LJrj9PEcHUalu23GcWsA6GOIUdA38=;
	b=AF88i2p1Tz1ZNEM2OxOywN+dNyn3nXfvMKI6Hc5k+lxm4aPmyoDZjhHUk4uJF5pgcE4P
	 v+NtzDpGSE+3a47+BpcoplxKnMZNeYtk9zLm3M5vCBdb3vc3V8a0U+/Ltcv/p8OQPaKYx
	 W2GRKOIV4sMXujpnb3TJ8gXY3gGQ3jhX9WQsOgEG6Tkew41wFKc4PWZLg1+gD+IJt4mIU
	 nCNYgR995++wNzihvdTDZuktgjxvpIOJMbXEQ2e9IpkUrZZnDQmzhVLqBiJeWI4PkojuG
	 LfTQtXUSSmCSuUxcqXz5iB/2M0fODS8fdHlL5UEDF6EQtB4swJ3ps5TjeJ2pRgVjSHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW40lgCb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81876606A329
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW40lgCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6F61F00A1C
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900354;
	bh=HzBYPoNXExK3g6LJrj9PEcHUalu23GcWsA6GOIUdA38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WW40lgCbdr4WdQXjZnAc3Vqzr0TSw4tIFA35AjPj4QZdtnx+t/jy00hzJRRzBZgGN
	 RXBPmTCYysFkIa85fy+rtwrP4pCnQRrt6uDlsqUbc0K6GGgFMRnbpi98NPD+b2t12/
	 J95xHJnX5mHx05raho+02GfZDPrA7JXYO8XGkPZ2BLLIz8gkwZGzF8euAcfp0S19KJ
	 vNq0acSNWWnda5VvkIerj4MrXChcoM5vHxYczFdYAJU9XviuIFqQZDjIUu38f3DRlO
	 ltyQL1rTDWtMs5fkkGpRUJiL6cVsYvoZh+XRnRO0ZpwKyiYbF8EFYg34cdvUlHimkX
	 hzn0WaMsCitSw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c247f6687dcso370682666b.2
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2026 09:39:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxkBWa2PBfMwNDNntVb6A/Zbi3D11hz35UJtW9BoozWXDFOBj8a1gebvvNp8uLxueyxIVCW1Ah6MoQadA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9cSiN5LlNKzasJe10GqvC0zHNkWJYHf4pM1UylaTuv33ZGKnJp
	dPqlOQSvhTalTqZ/e6Bielb1NosVqjY5+42C05EUzNEMZagxEH6HcSRkOSCeSEyaVyXR+JSIguC
	m+cs79SfBki7dqhLCHhkRObVDCH3fT2s=
X-Received: by 2002:a17:907:868d:b0:c4c:b4fe:ca01 with SMTP id
 a640c23a62f3a-c4d35574cb2mr11395466b.37.1793900353057; Thu, 05 Nov 2026
 09:39:13 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <auy9UfB30AlYabV8@google.com> <CAKEwX=Nao4jWtY04FXEjxiHUNUhJU2A6nCZLqhRRm-dPBZTmcw@mail.gmail.com>
In-Reply-To: <CAKEwX=Nao4jWtY04FXEjxiHUNUhJU2A6nCZLqhRRm-dPBZTmcw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 5 Nov 2026 09:39:00 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP_K0NF0gt71Emh+2dXmUh+C27uiu5TsyBcGUdLbCus1Q@mail.gmail.com>
X-Gm-Features: AclHuK_wc8Ng7_JQZLGDjWOKAsvWhdwYYyChi-Wc1-2WmNs0g0WKT4b-vjQSbM4
Message-ID: <CAO9r8zP_K0NF0gt71Emh+2dXmUh+C27uiu5TsyBcGUdLbCus1Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] zsmalloc: redesign object alloc API
To: Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:37=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, Nov 5, 2026 at 10:31=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Thu, Nov 05, 2026 at 01:47:30PM +0900, Sergey Senozhatsky wrote:
> > > Both zram and zswap already have per-entry structures that store zsma=
lloc
> > > handles, so allocating a separate handle_cachep object per stored pag=
e is
> > > redundant.  This series embeds struct zs_handle directly into zram an=
d
> > > zswap entries and drops handle_cachep, saving 8 bytes and a slab
> > > alloc/free per stored object (2MB per 1GB of swapped out 4K pages).
> >
> > I always hated that extra layer of indirection, thanks for doing this!
>
> +1.
>
> The mental load saving excites me more than the memory saving :)

Oh I am 100% supporting this just for my own mental wellbeing, the
memory saving is the icing on the cake.
