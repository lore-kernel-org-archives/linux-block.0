Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332460;
	b=l8QjmATWWgOfinfKtxhUrDKBudYc+U8D5ZYVijguDlzScwB+6ijcKwfDuZuX/t0TTzXJ
	 51cr6+md2rNvBvYj1Vy7Kj9VPIZE1Q7rtFmy+tSAUZ8r0hxP0+J6k/ju/TOodvlVH0Gpo
	 GPRuZdQhd01cbRcStOP2Jclt6tPWRqxdqXG5M6gqVrdjqcl/AuB1TR7sL0dXrJ8gq7a2b
	 BzVpS/VTk8WAsoPkjVhSEY+tPEZaQ3xKz42xwlru5gF+8JK8XEoRiWTa3LoUpSobYBhgF
	 1xI5rJj5UxAgYQgkVo/sIJryAoGsr/2ONmD0w3ENGFlPYiyJVWUPx7466uk+GD3Bt9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QgcKWslE/fvIIVroU82DW+IQYjBmplAQL93Fdoq2p50=;
	b=quDHURBXv5+U53LSZ6EUfnNbJ3RPYv8pAp8jJK0MFk9wO0DEHX26D4/ZltQhEtC7vxGi
	 3ys6+ohfaEDhAT7sBoNftLOs5sS2CfysW6uiQyd5EIBY4zBwua6K1E2x1RH01ULalEI22
	 BddX3uE+vAV7fUCMVAABbWwpMb7tc1H1P83XPy8p6eOEtjU3H1b7e+Y+eOQHVGK3Z6SxH
	 kGlJCuJeg/NDsgVsH3kbezVRFYT6rx0vG32b/k2nOuWPXopfugFqKVbitTyZF5SnMsYpr
	 MXu4tUG9bRR37rGVpWcA8vi+OsPRPb/QO+VWQbezVaZvrzRH3t2o58zMaWgV8wn2rpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwV8IN18;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A0606A326
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 17:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE5A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwV8IN18
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso1768889e87.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 09:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794332458; cv=none;
        d=google.com; s=arc-20260327;
        b=C4IHWQGAYDlhkc65PfTPDRjqs1oFuIpALhq6URfm5+b3Me/6lr/eIJ+iKtANZ4NpCo
         H3/DKoRIaZNUxC1hV20nJGxAcAWHQrFr1F89hH2Mv5bvU9lHV6rVZ3y/1jomUtB3oHEb
         xO9N0KlMdleiSblDd1LEVaUKp0f7WG3BgaIkK8XHMoKdVfjOKRYrlngQ4AToTRM18ivo
         WBwDFJ5z5VSDnj+RVoOb9ENK36T6fV/ddbXzwNVxeZa3H8zCCZuNN+vCdptsGHTl4HGd
         770wDiTv2LEsHseRpYc4imeOUl7Z0i4amTWVFPmJmVDXhiIKkRk/yaCptVqPdPEW25bU
         F+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QgcKWslE/fvIIVroU82DW+IQYjBmplAQL93Fdoq2p50=;
        fh=DvMnPukLYiamwR8L1Wh3reLAXffZUycgpGMewhAD3uA=;
        b=APYx7SdLouvu5iGFBFwiPZOPwGeTvfnN0VOaj+DC/5CLx3165nu+LYyApqjC1TgJGR
         pBzv/j3HITCqIo/jSmzDPS4T1oMqnbGCIM55rKg2ppZPZLm4DV4F02MIH0fUu6N01E4C
         MM/bAnaBMz/S0SXA4+lQznAPxPcGLVNeaCFsvYlNfPXmt7TtWYa4Fd0dzQb6UHh2l+W/
         ordBAi9d/2ZjDHwwZudHfdE33fRevfDe7CGuh8yvmli45E/VD9emrK55D2k1srTgPwJl
         WeGtis8OPRgBAQgaEoia+xAZltTrc+WaD2z3P3VvcOGMCoGoV6Z/SbaDRaoTbb6LiNhs
         vlFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332458; x=1794937258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QgcKWslE/fvIIVroU82DW+IQYjBmplAQL93Fdoq2p50=;
        b=OwV8IN18ChH9GSyAvCZytPW9z+0QGo+xoXMH/dcrIGwjwXuydP4VNR1ynqT3YWa8sQ
         tTXOrS0CkkFj/bTEWiZqqKnN920fD1pjkYuTaNVmc83vUWHAdTC0fUC3Ki6Ir69HhzRA
         61dvfN21vPzpv0DwVrmkai/NOcSpwr2lJR7y+YHvlpahCSjpxh7VRHrWr4LF8hb4eCCv
         WyyH0v91Eiioy5v6Ox7ph3wcO3OX+ZQjsvUyH+tA/gkVOh97WvKfjUTN1cozhH0fYD5/
         F7KSuv+XQBNYtskZwwH/zbeNvymdKva031bKsXwIRrNatOqW/jYCORQ613WRx7xWxhRg
         ZSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332458; x=1794937258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgcKWslE/fvIIVroU82DW+IQYjBmplAQL93Fdoq2p50=;
        b=xWHGw7H3T1jDh7IKr6mlAoXMNj8U0+qyn1d7WhVS8rH9bdNZLLthoCbpbsuCb92alT
         w0d2CLaHWYAVOtJzCd4tJto28edlqZ7GK/sdmC9ez+RuKFfkbcQjFvHpRxUa5eKV4aQV
         t+hyX17XCLCnxYYWcTN/ICMZkOaZVdrjA8sWq62GWxJWmPPnZb2mM6LTI1PVIT+KZ+Fv
         HjVYfgPE+yq6+Qtb8y7agDbmsmaS21VyUcCQq94X+/ZOTX8z+uveUJTxoqfdUEdcmWJ+
         ZjP6VK+hTTf7Y5E4q2ayc8+QpGlMEDZiIojO60M+GiRZO8k1NMIW5cA6HId5xcJryuBe
         Ru4g==
X-Forwarded-Encrypted: i=1; AL+hErGkmMGjdWbd1rnw2Uoe5GmhZU8A2K4dEABGmuxRKfnv6nU2d4mD5UnwGBRNJZf4VCkkiumqVzfULzaVRw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+N6eXhUwqNOjuFfpTWuJ/S5hnphC2XpshFPAYuEERQgbyi2Fwb
	YUha+CdN784XhG/KyKmI/XQPNuUkJ01SW2fkHvJkuRDftV4n4ICRbEfDRtoaC6CCe0kL+PSMhK3
	Jawuiw2dQ2YE7KE3ZT8KoPOLxcALD9h4=
X-Gm-Gg: AYBFou1iJ7qymlORFsM4AD1w5Nu1rqM4WZkcNStpqArc/OL6iXPtzcfYHBuYFzF24cn
	3Gmf0/rVIM4zrubfb/SJWBrFvVX3aCw3qGzT7cevhz6WZsESESblft0he1vzPfL28oXtuVuhSm3
	kXbiWXk0l1tigYmG8J5XjdCbyWyx0u96AanXgKudNIknNwjHfMweAanbXU5GiUZrjl/Y8bw+mGA
	JDYfDQoxfC7x/6eyZaqqrhB2OtGdNBZuyvZsIXdXL1iIzLmyobfOzzSsW9hU7d1LgINihZgXvTI
	NHr+evVgAk/+VAddc6OT1PeZV91a3kbvw4Mth7eY32NI3yjaZKaQD+DiXiwtXMSDW62p0mC5CbY
	RzSMCZbEhwvbpQ2pmSarNP3+VM1s0z+sAUzzxGMECjd63Sq6ELbp8dKWjWRHRPygXKlLFP8Tm11
	uZTIB0oawyuNaf9S2FH1/VTobcMu1simNaI6YbUpPAcLUPkjYpntJT
X-Received: by 2002:a05:6512:1256:b0:5c1:4bbc:45cf with SMTP id
 2adb3069b0e04-5c156ed1806mr917830e87.48.1794332457809; Tue, 10 Nov 2026
 09:40:57 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org> <20261110054836.1515030-5-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-5-senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Nov 2026 10:40:45 -0700
X-Gm-Features: AclHuK9g-rt6zF29XhO_FN13akwxVP6MwcYrtYAv2oyltJQHd3ALM1tNti6L_YM
Message-ID: <CAKEwX=MWLim2q7RaSchFRZ215avMfW161hKAKhxs888NgRRMOw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] zsmalloc: switch handle type to struct zs_handle
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:48=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zsmalloc handle is an unsigned long that holds an address of a
> handle_cachep object, so zsmalloc and its users have to cast it
> back and forth.  Introduce struct zs_handle and switch zsmalloc,
> zram and zswap to struct zs_handle pointers.  Functions that only
> read the handle take a const pointer.
>
> This is a preparation for embedding struct zs_handle into zram and
> zswap entries.  No functional change.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
