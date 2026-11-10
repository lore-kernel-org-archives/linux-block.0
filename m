Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327401;
	b=e4ze/k13K4nQ91YfRZKLyxVKj3+UjGDE/+fs4rpLr9cPu3prKn7+b2/nbKMVxCDo7/zA
	 fDPlNJObg5MUk72OvvkeluAu5liToMLFQt3cNe6vgVW+WsrD4T2hgTGYJcJdXZvh+Ciid
	 76BNLT6J62+juSvkR0W3XqQy5HHvJOnE5oiZodOyS8eXew2juggzBuzXTn4AUOVFDHW6G
	 c95AeC93GvpGT9NpvXv+65jatfPfFuUlzlQtaGztcIVzFUwgB82r/hddedalMucku3GCv
	 qhneic21RrfXkyKcYntj2z2EPHHD/hzrQo4qnZv2rX37UwSSdItDMubwv4a+an9IobA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327401;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t/2MuWYVBhNCrWHxBkQfWYvbU9j9ZMayABUoxRH/r90=;
	b=KkGvBpJcASx7b4T5+adEjbmAXsdO+hBUuZvcSsdxJgdnEMWA/AwBf+5dEXl2mu+x9DOR
	 wAiUnaqSRBkMoLsK3u9b+ijieJ+jBBlZ3Qb6ABNQtDjH8vPMaXG7TreokPBx79lRJUZRS
	 GZ9BpEv4C3XrFgcupW9V6bsq9c5I4vFWmgWd6DKy8gmLdS3PQfQwR7xvRl6BbnkQ+7JXP
	 VTtAG5zjmhFO4XItii8ODFHMzk9Hnm5uq5djGHhc9PtTX3JTxClqBQGLCAEFQ62Glgj9e
	 VmfsrLPTRcWP5c1nGEdZW7S8Eldre7Evvk8J/u2b25Sq+4bXgwJTJv11JB0WKfvYRyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgjQ7b6Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAA606A320
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgjQ7b6Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B791F008A5
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327401;
	bh=t/2MuWYVBhNCrWHxBkQfWYvbU9j9ZMayABUoxRH/r90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GgjQ7b6Z84JEROSbvsW1NEndXwpDWmRJ5mdiK0eU50fDHy4S2q/4x1fnZM9peLwEn
	 ZmB7VeDTwD7CNnPWJkKtIX6OPYrwC/4nwt4t0B5K/Gyapwig1ADFvptXyr8zatX4kR
	 xk7Qz/a4olH9pCPm6U+Ws3I4BDq3fyyoDwTUwKLQny70Mpy316Co5KZZ3wvKrJ3wTi
	 akioaTVIzkGHEOo0dJcUu7a4EvYFXqk0VX1JszXvYsLZnReYIz88ULmV5AOnuHcj23
	 xh2qcM6D+FuL63WiuCnwJ8Lo/IvIP/nHiexKLWz4uZsaPpHIgfJBJzp13LGoWWrosU
	 hhnMljyw0UiwA==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f22a8515eso178103185a.2
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 08:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHF6b28E4Ma2pFrJXu0ynIC3SkD5DMILNpXhS3qHM6Fbsqhmz+VZeS/9LLNB/JLPKEtTTEj9/TZCfBWLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+k3xlLmb5ZP8u6XACG5zzePvML/V4865SNLxHv/3lxqqIb2Ya+
	aklym4+fag3MYuNlvqweRXZ9LA8AfOL7wC7/leagC2q3O2n6r4Kcvsosb1PZBv6hStu6Dlp9tlW
	+5sphXdRzTll6SkIyXBNq1HUwmiDhr58=
X-Received: by 2002:a05:620a:414c:b0:93f:353c:6bee with SMTP id
 af79cd13be357-9479f2e6ba0mr519311385a.41.1794327400308; Tue, 10 Nov 2026
 08:16:40 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-1-senozhatsky@chromium.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Nov 2026 08:16:25 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMW4T+0-UFtPUi5EDdvP1b53=0Tpasx7kc5ZkdbqHW0Og@mail.gmail.com>
X-Gm-Features: AclHuK-dt6QyaQbEWS9LvYKZc0TVuyB5CsV5lfGXmiKwVChcOCfSsn2FOyFBdvY
Message-ID: <CAO9r8zMW4T+0-UFtPUi5EDdvP1b53=0Tpasx7kc5ZkdbqHW0Og@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] zsmalloc: redesign object alloc API
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 9:48=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Both zram and zswap already have per-entry structures that store zsmalloc
> handles, so allocating a separate handle_cachep object per stored page is
> redundant.  This series embeds struct zs_handle directly into zram and
> zswap entries and drops handle_cachep, saving 8 bytes and a slab
> alloc/free per stored object (2MB per 1GB of swapped out 4K pages).
>
> It also folds zs_malloc() and zs_obj_write() into zs_store() so we don't
> take pool->lock and look up object location again right after allocation.
>
> A simple zram test on a 24-vCPU VM
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 165 fewer kernel instructions and 0.7-1.8% fewer kernel cycles per write;
> lz4 single writer +2.3% IOPS / -2.6% average latency;
> 24 writers +0.9-+1.0% IOPS; no regressions.
> Memory: 8 bytes less per stored page.
>
> v1 -> v2:
> -- addressed Yosry's v1 feedback (too lengthy to mention here, Yosry
>    posted over a million comments, or something very close to that):
>    split-ed some patches, squashed the other ones, added handle
>    alignment run-time check, added 0 PFN defense, etc.

I will take this as a good thing :p
