Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19F310620
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260394; cv=none; b=D04DbgQO1nbGfZEQrZQAzE7LK0khe0m2GjNAJQR0HBgHZ2hqiZ7YFtqYM6YDeg4uKrMVWfquaYNqvTgaK8syLks1SknVPjEeLm8P8IQPS4364Enu3cqzcixRf/HuYnQIXUHkLP4reWzTtVNEBNS9rUGiyUBymOxBXA4jTpybTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260394; c=relaxed/simple;
	bh=Pa2jL2apofSyxbio8rnUG2GbSKIL5k8URnG7ZyGge7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMDBaY4Sk5Vtb5zhuI9MtpZoJCwfUvmFLNUpsN8AhfNDmG8mDrdhdDEtxemu7DvM7QB6sRI0EuSSQimrE2VBkaMba2caeOcdJh8I5yUVtUY3NfXJQVu33zi+0J8s4xuTazMsq2W7pM+ofmcy3HYVRcX7vJIZR7ZRQ9B6hosjxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiIVDxS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiIVDxS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D26C2BCB1
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773260394;
	bh=Pa2jL2apofSyxbio8rnUG2GbSKIL5k8URnG7ZyGge7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IiIVDxS/a0quM8sXkb3+BEwJwyCZipD9xI4sUfSzdMuygf1qn8RLEMjY1dGhV1zAi
	 iK/a3jClhSnzSax7jy7mne/oaT89N4DfPKWJbADyUqsEKEP0gyALW4uyTp49EZboAb
	 A59P5lZgJhwfOjbmjb5ewa28Bx7v7QYtdEXGgNZOuNLJhMzafGSzg2XxVNqsoM7g9Z
	 gcuyygEy1RIkJh/oGcdJfWjKbV1Q0ebKm515Jlx8M0ZT6rXKGA4Y0xllvmsTLXBxRZ
	 wlqgCQpCHQ3G5PEZtDkh76y9Rzx+D69hDt81xa5c+zfVAknzFhfXOAFGE6/HUVxdXd
	 t0rnnPMgUz6dg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b972641eb96so29162566b.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgLFPxy9kwTchvuxEj6cMQ8bkmdH3+p7D0c8Y6QnpJhGu6XdlVFA7Bb+7azDIz1pd+Td/VzvUHgw3J6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLUtQaRLlFiQrG825YjEoDNCxWtQeu9X+HOUMS+xQ9/ej9YL5
	STan6jfQDFbVESinPTr3cSxE8pTtfvkMtC4mFXdITeDzT3RwJjepubnLtceqq3KqUXSBuIqoDQ3
	J/TcimgkwmGCtVlCVfQw3OYm/7I3u8s4=
X-Received: by 2002:a17:907:da17:b0:b96:d6cd:29e6 with SMTP id
 a640c23a62f3a-b972e1b00e0mr194279666b.2.1773260393379; Wed, 11 Mar 2026
 13:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
 <20260311195153.4013476-4-joshua.hahnjy@gmail.com> <abHNog8CV0mWummY@cmpxchg.org>
In-Reply-To: <abHNog8CV0mWummY@cmpxchg.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 13:19:41 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPeL9j81bYMZ+8DGGj8KbUxh36RQXVwTxqHve_7nHV1JQ@mail.gmail.com>
X-Gm-Features: AaiRm52cagu4YYiBOSaKEy5MarD058OxU_wI3U6DBSzp2_XvMZJFVYn8nici7_Q
Message-ID: <CAO9r8zPeL9j81bYMZ+8DGGj8KbUxh36RQXVwTxqHve_7nHV1JQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] mm/zsmalloc: Introduce conditional memcg awareness
 to zs_pool
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <hoangnhat.pham@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

> It's a bit awkward that 0 is valid (MEMCG_SWAP). Plus you store these
> values in every pool, even though they're always the same for all
> zswap pools.
>
> How about:
>
> /* zsmalloc.h */
> struct zs_memcg_params {
>         enum memcg_stat_item compressed;
>         enum memcg_stat_item uncompressed;
> };
> struct zs_pool *zs_create_pool(const char *name, struct zs_memcg_params *memcg_params);
>
> /* zswap.c */
> static struct zs_memcg_params zswap_memcg_params = {
>         .compressed = MEMCG_ZSWAP_B,
>         .uncompressed = MEMCG_ZSWAPPED,
> };
>
> then pass &zswap_memcg_params from zswap and NULL from zram.
>
> > @@ -2071,6 +2079,9 @@ struct zs_pool *zs_create_pool(const char *name)
> >       rwlock_init(&pool->lock);
> >       atomic_set(&pool->compaction_in_progress, 0);
> >
> > +     pool->memcg_aware = memcg_aware;
> > +     pool->compressed_stat = compressed_stat;
> > +     pool->uncompressed_stat = uncompressed_stat;
>
>         pool->memcg_params = memcg_params;
>
> And then use if (pool->memcg_params) to gate in zsmalloc.c.

I like this.

I also didn't like the suggested prototype for zs_create_pool(), and
didn't like that compressed_stat and uncompressed_stat did not have
memcg anywhere in the name. Was going to suggest adding a warning if
memcg_aware=false but the stat indices are non-zero, but your
suggestion is so much cleaner.
