Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C40387350
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791020; cv=pass; b=s7tQXeB8+uPfVDP4moo66RiKQOXWR0TcUnQBsUcGP/qvJiy8RYXUhefvePcQJRDv48vCurenDKUg3vo5AT9GJaE67qf/23PZ78IXCLUu0/GZIAitCFVWrns+sKBPFOFjp9eBHkzZNSa8bQlr0dwlLPPQ7jwHmN9qc4eya8hkpfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791020; c=relaxed/simple;
	bh=cQcQJnN79UfoKmSnEHd7RkqFzZkMwoiYm5oNe18HPdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E52YwaEuQk1vtUFqbEUX58ozPGbXU83wQ5PAF9iF4ORF8lX155HxjeQbQivAM16GWSinDNJkzjJP7dCATGXJBqqwWQQ80RrP11lV9dxtOKtiiP79E5j2tpauNZKUfL2vWDGw0+kHAQU/4q3vNYQkyOCG0wxDqNdyD7z11Xs1e+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1E7zozW; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1E7zozW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891b0786beso22274395e9.1
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 10:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776791016; cv=none;
        d=google.com; s=arc-20240605;
        b=eINHU5pP9zBYl51MDEabGqkSVg1GgRXfse9m8mJDQ3CL4EofJwHuseL+7MzCfz937g
         slWDV4pdhOFBDBt5XIYtW/wzqjIRQj5gQkclFPF1iY/qFdXQKibLlkodL1LnaFarG82u
         lfpzh8h6hKU6jLlZZVJwvRyIYUcn0jo200f8LpscrjqhriOTIm2SezoSpFlHhhXuEiWK
         Lg83UDM26kNS6c8LTlfGp53LKsoodUyoc6MBV39nIS19uB1h2Qkcqvzgje/HsXsDq71T
         KRjryZiq5wLUmCyalUeBMTuBhi41ci3jqWlDhdaGZbdkSNKu/VsVMrGjqMqstp8Yj4qq
         nHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhj7kC72/ufPnD9jgw5y/w8fCS/UdSYLVH8rDMZ85/I=;
        fh=aCgTjbzMJkWtPCJG01PWkSnM0vYkRF1WaKjzs4RZxaU=;
        b=LDWLTxvDxoCdSNpIgUHV7Fuxt6OsD6KSudJwP3jyupvmF/DTWvBEL4vZrLzDVEX5wh
         ojAY/lcZII4Dr4l9W2kHnCPw0Ksv0AUP+o/cWgBSiIXqqoMIRuER0A0H8F8i+Yqmeng0
         cwTt88O2RGCK1BLpk2//LDmSSOPPBqdYKHgKtefinG3XXZK25I7kYrhfciU5imNLWmYg
         6Q2Pw6ajV3y1KcI4K5NMirK+t4VPWEC13QHFi8++W9wv9tH5L0TuXa4FGI0ByKnhMun8
         vP/Vo3BPjX9PFvzENZOPfCytNcnSWwjhYKch2rx1/imhPZ1ApSox2zKPDu/pkGJeJ6Ux
         dW4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791016; x=1777395816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhj7kC72/ufPnD9jgw5y/w8fCS/UdSYLVH8rDMZ85/I=;
        b=l1E7zozWIGz2Ewv05z57FWm0VB4hZO8YwTXy7DixRLeNSVAGtMBR7PYaQmorRCyhDB
         25AX1mz+kgs9n9MrPK+zVDfqxmdqTZ5sLK17q1UfrtDLpGRU015GVkFDkV6pyAwCi1mA
         hnv3fNGaVnK6jOG7/RbKNIXN3pC0tKhmyfEjfFTl03wcoTSVGCjgAPmn1byMsiAsLrT/
         3ijgRLxagcvIGefrOUv+ErY2kh04MPlTnkNAmBIOOmFFBsxRK4Ayk0/JAnPPQVYm93Yc
         AN7mmtg5i0og8lN4YpqpxHOpk4l2PZhk87tsMefFPcGodFDR5CzzveL7yCnqbTpLMiUV
         I8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791016; x=1777395816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhj7kC72/ufPnD9jgw5y/w8fCS/UdSYLVH8rDMZ85/I=;
        b=Hk1DfCJ8l9t2gmV6vz9lg3HUolVyHgWGQoX5GuG4983D5Z3Z8PVPS9trgLJxKf23iE
         OPDYSKBnuaZ08pIVgGfIuP9QKD7uLBbOPk4/uGETL2qzt1z1rlizxuF08wXV/nP4Vf1z
         uwXLFYNM97Hj78bqNv0eOV5T5bjS9ZNRV8xzWrnH4/Wlp0ff2ScLfn1YQyZgpF1y0tMV
         FPlfzBI5rvwRLIqZP2gJLZQLeUVswdab+wLNxo7zq2z0PsOuArhbaDRejQdZWgFm1bQp
         GOVTGnmZi/qXV1WxO2gOfaxh6+QvFtIKbCdwjxJzkCUjFhwGD++2zrqR3Y1YERmmMZ8U
         ebJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+31POwIVr/K7Apyhp/Ew8V3B1iJcktUSPvghJ5XnHAhStjSdoug2XzU1l2ImKcVwlpSrkfG8W0SK/WGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2mNSY+xXppw/1ZKam7NBex92bDbAyXMBna7v0ySeawPhCQYI
	i0WbEcHiTwovR6B4+63gV2+XW4dRiF/FBacVk2KP7cH0GGjcPEwvS7DdkxBUG5xHd75jAvtHAZ/
	eLi/wcYPhVhUrNKB6hDdxbrKWFyx8XYWUgR7MGko=
X-Gm-Gg: AeBDietf0Bcn6ZuZFW/4xko/3gbZLUnPnoP9AP4sNxmi1dr7X6TKilDwqGijpqpSudH
	FYr4vYXxTd+WE11/ZVdjUjOIud7UA0v+EgMc+bVILSr+cx4FQhBmbCv+BrmWAkbjg7rLxVwEPl8
	V09LOGd0YZt5O3hS5fH2FNVDMn6fkqguyIb+bPHPGuOjNS6YK3kzeRkwF6SqSNcFr3GaLekfkCI
	3xSM7gluYtkW0Ht6bd7b7TYcpoueKth2vvO0JZMI08bddWTyEacVFarV5TzGume3+l2E49glTWg
	WonwXmZhvVz8wdWJHRVz7TB/CnjWNr6F/OQrosKFIj7UL9roMg==
X-Received: by 2002:a05:600c:a314:b0:48a:54a1:38bd with SMTP id
 5b1f17b1804b1-48a54a13b5amr52563555e9.21.1776791016057; Tue, 21 Apr 2026
 10:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com> <20260421121616.3298845-5-haowenchao@xiaomi.com>
In-Reply-To: <20260421121616.3298845-5-haowenchao@xiaomi.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 21 Apr 2026 10:03:24 -0700
X-Gm-Features: AQROBzDF239IHDN0FbLVGZBy-mxj3aW6qMj4rkqOv1Sy_1Rk5OBnxqima7exgRo
Message-ID: <CAKEwX=O484K1KmELVW8Sh8k0iZ0CySPL=BBvjBC24veVCJObGA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm/zswap: defer zs_free() in
 zswap_invalidate() path
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:16=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> zswap_invalidate() is called on the same process exit path as
> zram_slot_free_notify(). The zswap_entry_free() it calls internally
> performs zs_free() which is expensive due to zsmalloc internal locking.
> Unlike zram which has a trylock fallback, zswap_invalidate() executes
> unconditionally, making the latency impact potentially worse.

Hmmm my understanding is that we don't have contention at this point,
because zswap mainly relies on swap cache to synchronize.

But yeah I can see the effect of slow zsmalloc entry freeing here.

>
> Like zram, the expensive zs_free() here blocks the process exit path,
> delaying overall memory release. Additionally, zswap_entry_free()
> performs extra work beyond zs_free(): list_lru_del() (takes its own
> spinlock), obj_cgroup accounting, and kmem_cache_free for the entry
> itself.
>
> Use zs_free_deferred() in zswap_invalidate() path to defer the
> expensive zsmalloc handle freeing to a workqueue, allowing the exit
> path to release memory faster. All other callers (zswap_load,
> zswap_writeback_entry, zswap_store error paths) run in process context
> and continue to use synchronous zs_free().

I wonder if this approach can speed up zswap_load() (i.e page fault
latency) too?

Code LGTM correctness-wise (assuming zs_free_deferred works) :)

>
> Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
> ---
>  mm/zswap.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0823cadd02b6..7291f6deb5b6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -713,11 +713,16 @@ static void zswap_entry_cache_free(struct zswap_ent=
ry *entry)
>  /*
>   * Carries out the common pattern of freeing an entry's zsmalloc allocat=
ion,
>   * freeing the entry itself, and decrementing the number of stored pages=
.
> + * When @deferred is true, the zsmalloc handle is queued for async freei=
ng
> + * instead of being freed immediately.
>   */
> -static void zswap_entry_free(struct zswap_entry *entry)
> +static void __zswap_entry_free(struct zswap_entry *entry, bool deferred)
>  {
>         zswap_lru_del(&zswap_list_lru, entry);
> -       zs_free(entry->pool->zs_pool, entry->handle);
> +       if (deferred)
> +               zs_free_deferred(entry->pool->zs_pool, entry->handle);
> +       else
> +               zs_free(entry->pool->zs_pool, entry->handle);
>         zswap_pool_put(entry->pool);
>         if (entry->objcg) {
>                 obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> @@ -729,6 +734,11 @@ static void zswap_entry_free(struct zswap_entry *ent=
ry)
>         atomic_long_dec(&zswap_stored_pages);
>  }
>
> +static void zswap_entry_free(struct zswap_entry *entry)
> +{
> +       __zswap_entry_free(entry, false);
> +}
> +
>  /*********************************
>  * compressed storage functions
>  **********************************/
> @@ -1655,7 +1665,7 @@ void zswap_invalidate(swp_entry_t swp)
>
>         entry =3D xa_erase(tree, offset);
>         if (entry)
> -               zswap_entry_free(entry);
> +               __zswap_entry_free(entry, true);
>  }
>
>  int zswap_swapon(int type, unsigned long nr_pages)
> --
> 2.34.1
>
