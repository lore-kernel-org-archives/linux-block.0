Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425620E334
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786908; cv=pass; b=rMelHCgtrOH+XnJ5LJpi8mw5j4m8tFXQkH4X2Ub75S/ZczEkAQjsPSvX4/pv9w9G5iuds4qP4FSDSAFVQEu2/TGsJavLl80QkOTv6aJkLkJsZZXCFvbh5GB6RSvnTjmy//XTMlVXh7HIbx3Lk0Qo/n/jbSqw+ACYDozAaXB43u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786908; c=relaxed/simple;
	bh=GZJifi5xv/2zNGOHm6PWpOJpaLSfKnpwch9WlPfDXVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAi4aoRRKwOjUF9NjvuFUbQCjkeycgwJRnAt9nzKlWlZ0vneWFxhsQlnYaOHyKB+Jv7LaWpeP2D1cV/eaP0dDdSmm9rKeyR5ONToxRQXHn3DUhpXGuTCRY4BQPokoOebcuJCniNZsfurFiIaTg8ezyLzUsyMU2JUGivl7fP8nQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frb1R84x; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frb1R84x"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so2981990f8f.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 08:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776786905; cv=none;
        d=google.com; s=arc-20240605;
        b=KrtLC29MnhYLaq/9bRopMBKgxU+C1NR9Xj9F3zC7tM4K6m4xIeqIZrKU9YnWQSuCp9
         Tbog5RIntCjOPCwIK7qQREW5Lm0RBY6wCQlQoucD2sQeJm4nn7pdskSU5Y+Zww+amNb7
         bhuXSuD9ip3yeNf1Jk1X2XAQQO93CVx9rIP8L+R8iePETWK/4VjssYCMHrze8EYOFKFL
         1VA39KEI407xWRgbmLmPXkcoPDlq3PSjmGxDkZ9QYaBX9KsEs6nXBu/46Xh/R/7MUczO
         R3uZ6DCqFpW81ZAibe1XSxKrtKxhbbKpXX1IiS1u0TXO15vROSZzkFLbozFK+ClYHnNC
         E4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZJifi5xv/2zNGOHm6PWpOJpaLSfKnpwch9WlPfDXVM=;
        fh=TpKhC4dQCdSl8TSQ+AfmtGcnqVJ8DZjQY122sl/Bimw=;
        b=kPeXWyvv1o04qx1rwjumWkpXBLDOAqCHM+Zm7WpWZ57//703/UPW8xtHxB+vwDKypR
         BrvEobC8d0uUwA60mvoq5yzJPekbyY9dM88g0BaQNzYc4GEQoJkwc+XXSiHp1XUgsdli
         giMxnUFkuCjRbO84ZolVUfQCRhsS/ys1ZTl5LcTlnWzxASNfRNqkunjB8+NU84VwStsy
         5N9Y1am96pPKZk3fql8zzd8d0h0R47JdI3zp4WxtjquhBX2wnAJyykZigeAOkJRIUVKP
         ybj6tNOGOIYoxiIP2MrJVJM4GvHratgV/EvSvuw151GGfG26NBYY/Y4frttSHFwB1FHj
         AHeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786905; x=1777391705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZJifi5xv/2zNGOHm6PWpOJpaLSfKnpwch9WlPfDXVM=;
        b=frb1R84xQQl+sViEo3zF81S1V4b6XudwsIEZWPQ7iY/hQ+A+pT2rsCUTTtEOQU6Yzp
         X0iTYLK6ob7HXyriN8DUWVJNj6iXZqvVk2giORYiKDmHe+YwkssbVeBGN3w7mxqEdLKl
         26O3ymC6j6Ty+wF7U5AmnFKJlsiYG7QjFi16VbGZi1Bop7rGC+Y9GP70yP4mfOMiULw0
         fu/FcKWoLbBxS+31NSqsOJiQ5oCsykSmMpBm6kdE/y4O8YIc7t/ehAbMDineZxGhiuoZ
         a5ltNd/z86+rI1Td0mCn0RyoTZHawy2aCtnqIMQZWcmwV2cnzbpWHsMhAePVEousmjbc
         +HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786905; x=1777391705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZJifi5xv/2zNGOHm6PWpOJpaLSfKnpwch9WlPfDXVM=;
        b=GSOqCQpLK6k/v6eVk5CYBCZR/wYH8FYnfIe73hzM3C6Wdhev7ehpQ2GQgZ97MdXH7+
         IuLnnjQ+2VQSz5HJMLY2GEU3KTOCwXKE6jm2S5kElfNw0wjTHxXebmmCDdNDRNb0pUO7
         mTgcL20hP9PJr7htaNBR1KgeiFt6wZpWKHxahrcpCtzJ3DmHDECJB0pWGicUCvhIkW2A
         2LHTlCJqH3C5nTJoYUdCsRZyWrUQ7xYT7Oj3dzkmu/Gngc3BndOuVOVMgUpAeDoekxjX
         psg2gDkbkVit/Nq1Jj+5UFkKMO8Xet24k7g9ca5Avublaif/GH5pr/3zXj6aWGIsuIWc
         1aTg==
X-Forwarded-Encrypted: i=1; AFNElJ+9SbKpJzYQ+g8GR7aFTA5IwR8fcc+jPUUqCX0O7KDizq0Dgm1XlR0r56e85pKFsypA62bu+ruRGu9INw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbGkGG2rlvUtdHeBufKDOIJDcgQOGM20G3EQDkLo/LMsCjmaT
	PjAoA8RZOqa4f06CcfFONAUFWbhrxXfQzuG+D1h8g+6SwZVzPgdlbY5uJ24N0iDNQA+itXkfmV5
	wCbwHADKjLvko1OoYqvQL4q0rPxU2yrE=
X-Gm-Gg: AeBDies1Zv6JbqXDLjFF1BNX2aSvkozxl5Rt2I+BJn0R/iSv7dA/wXp5nxHZrspDzzg
	SMlLbhxtJVlwwl9A1NVBogIzGppgQXoVUJ1dGbP6iBZTJVsnyUDF+U0CyumQzRBpobf1KuncZ2Z
	qnubQ3dWTF8qDzcbzgeVhLX2s5E7bpUfx6K3XD9NcCUDt5SEBE32bF8sFqQtQYQo+CXBg7gVXAv
	2pS2xPIHWeKL2SOgn7rtNKfHzqWITPgmzuHPRT7xQVp6E5zizC1WXo4XZ5WcgzSEN/XLLLlXW3u
	0EyWmZRlyErS9EX+XGY6KZ0lWtSG7SvFJpZNq5wJcbJSvh3ZcA==
X-Received: by 2002:a05:6000:2387:b0:43f:dfc3:555f with SMTP id
 ffacd0b85a97d-43fe3e1f3eemr28962901f8f.43.1776786904997; Tue, 21 Apr 2026
 08:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
In-Reply-To: <20260421121616.3298845-1-haowenchao@xiaomi.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 21 Apr 2026 08:54:51 -0700
X-Gm-Features: AQROBzDF2ZcdhFQzlhJdAP9qpHTl51Ndnh4fL7thLPJceU614blRIDlQ6JBq81w
Message-ID: <CAKEwX=M5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodwbf1Fe=gzew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:16=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> Swap freeing can be expensive when unmapping a VMA containing
> many swap entries. This has been reported to significantly
> delay memory reclamation during Android's low-memory killing,
> especially when multiple processes are terminated to free
> memory, with slot_free() accounting for more than 80% of
> the total cost of freeing swap entries.
>
> Two earlier attempts by Lei and Zhiguo added a new thread in the mm core
> to asynchronously collect and free swap entries [1][2], but the
> design itself is fairly complex.
>
> When anon folios and swap entries are mixed within a
> process, reclaiming anon folios from killed processes
> helps return memory to the system as quickly as possible,
> so that newly launched applications can satisfy their
> memory demands. It is not ideal for swap freeing to block
> anon folio freeing. On the other hand, swap freeing can
> still return memory to the system, although at a slower
> rate due to memory compression.

Is this correct? I don't think we do decompression in
zswap_invalidate() path. We do decompression in zswap_load(), but as a
separate step from zswap_invalidate().

zswap/zsmalloc entry freeing is decoupled from decompression. For
example, on process teardown, we free the zsmalloc memory but never
decompress (if we do then it's a bug to be fixed lol, but I doubt it).

Zsmalloc freeing might not be worth as much bang-for-your-buck wise
compared to anon folio freeing, but if it's "expensive", then I think
that points to a different root-cause: zsmalloc's poor scalability in
the free path.

I've stared at this code path for a bit, because my other patch series
(vswap - see [1]) was reported to display regression on the free path
on the usemem benchmark. And one of the issues was the contention
between compaction (both systemwide compaction, i.e zs_page_migrate,
and zsmalloc's internal compaction, but mostly the former).:

* zs_free read-acquires pool->lock, and compaction write-acquires the
same lock. So the compaction thread will make all zs free-ers wait for
it. I saw this read lock delay when I perfed the free step of usemem.

* If this lock has fair queue-ing semantics (I have not checked), then
if there a compaction is behind a bunch of zs_free in the queue, then
all the subsequent zs_free's ers are blocked :)

* I'm also curious about cache-friendliness of this rwlock, bouncing
across CPUs, if you have multiple processes being torn down
concurrently.

Have you perf-ed process teardown yet? Can I ask you for a perf trace
on this part? I'm not against async zs-freeing (might still be
required after all), but if it's something fixable on the zsmalloc
side, we should probably prioritize that :) Otherwise these swap
freeing workers will exhibit the same poor scalability behavior - we
might be better off because we manage to get rid of bigger chunks of
uncompressed memory first, but we will still be slowed in releasing
the system's and cgroup's (in zswap's case) compressed memory

I'd love to hear more about thoughts from Yosry, Johannes, Sergey and
Minchan too.
