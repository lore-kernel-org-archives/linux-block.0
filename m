Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC31C5D7D
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286601; cv=pass; b=W4YZsMrWVIk9Hl7B3IueXlgI9UC2+mdYEFDyq4eAtCavsU7F5WXPMt9OvzSPKST1HJr8JovdEuELuoerD6cqSEBmmVzAmzIc6RE9O9yZXln3oeZSqwoznNkLvItd4CNDHDcHr8TNpWX3DTeIVWPq7uLFdN5t9KbYzFJlewQW0qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286601; c=relaxed/simple;
	bh=pTB/MuRh3vrX/gwlmNvDLhzVQIyOf4SELhhm3nQYRJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OftQatQR/OA13c52snaTek0yIDCGmkzrddTBPsbYum8HJYLuYfHT5DCIugC4kiuuUuY3dRjSX+GGpFVp6Y5RcAD1cpJ8QvR+vNfEUL+ieCT6fqDBv2a6tXIB/b3qBFjLN77FxDTvqNdSEAgAVzAsG7qNmFRGSnirpi+IRl9Le24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi4ObCJh; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi4ObCJh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-441209fb77eso1522204f8f.1
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 17:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778286598; cv=none;
        d=google.com; s=arc-20240605;
        b=dKxqeI8w0CKf/aBLHNFT4eW85cnaXQPRBuHcixuRp787S8LZyaaV/xEpHAB7MAYizB
         MKHr9L+EGnzdAGvMds5yubuNyfBOPNw0Cm0o9qhO/AzrxB/fTTFcnFuCIW39RWAPWfne
         95t8g2BeXGBio2eMGBsuktuPdlrxaSyKee5gh9cNX7tSHVURk1sDcwDvEQ0ZBMU2XFC7
         y9FfruODJQI+N5FllDb2WZ8qI1pPiLFT+US2iGfmE0gI7L/R/j+cqjW61Y045QaNV+Uj
         j1xHCwFKqPftSRbrC6kvNwjp3fgDyS/UFyZgqop/TugiBwpODIG9dBOBJMVlANLRq4iu
         q0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0G3a8pDIQfohQ9aEjyLWVBL5s8318IMIlNp3JjCVu/8=;
        fh=qAo4/SyCm2dNmMibwMNNar0KNQgFK9f10PIWRZ8hQgk=;
        b=Oi+rQEpNmukH27XwHvCDPh4QpJFmGGqR1z1+e5Ze6Pu/cv+41BJgrllotu7TINA1LK
         +qL8yaduVMq/0DwwBP+lZz5MY6uL4lDIr9KR5ZGU8JR0cuBofEiFtEs8bYHXbw3N+xPl
         oPGVPA9kFBtbcK6MYwKsUwAAYcxISIFvPI/rvk6H6DbWNE/ZA+2K+vzx5Ve2xPrVMpZn
         A9e7kS2mZpFsDcGoX0b6a4TrVPoVJHZhOLriQWcmKgSVoAuVpoE00qKw/0OmrQwvaHXI
         Ea03xYrZXrBCKL8G8iis2EXE8cA/QDeN/Qo492t1/DF5eELpCadVOLK4yv/gSWFfRdnh
         ZXZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778286598; x=1778891398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G3a8pDIQfohQ9aEjyLWVBL5s8318IMIlNp3JjCVu/8=;
        b=Zi4ObCJhamiUbGB3ShrKsBP4GIyu23uqJxs3LaQeumWxSa0ePFo6etfL+B3W5g4Esb
         7KDPRDzLvkUtK9ikY3hTxtnanvPXBOBKZ1D01rtDkn7haZNbeGQum6uxoTrzHd+RRif8
         g8RZN19boGB/SSACWampMjXbVq93u0uJELHLmSkpbUxVuEbUnbfPjwTgmypctDxUxzMd
         k7hQ0oiMOtHDN4cgAMNFL7qGh+/UJEwtXzLx00wIGXrHjH1YZQNizqrzdk87NM8MNskl
         B+4xWPHkfwnOSsxC6oafmhiCgqbynbS7zd/VFh2F81h6sLrp1wXF4ifypndXRspwa4rl
         j7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778286598; x=1778891398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0G3a8pDIQfohQ9aEjyLWVBL5s8318IMIlNp3JjCVu/8=;
        b=atOuZryWRxG3mqXopg0JMSg/AF36/+NG5rHQOqwR602/WO+YXSnrQrfsWqoUP+moGq
         L6gE1szD2mlacgb9499U2inSK0JEr9yNI/8U2CUPes3fDF8zwvbUlag6dyGMo3ws66Sg
         RbBiIBHcJ954SCj1rcI1olulnc+qxcpY53mglIOHPXTWwJTnML7iZ98A9gmWCZ4rwutN
         QHWDw50FsAlNp7N7ri45kMc7Amn93Of7APoBaWyFkWVyJPKqIGzusL1MAJd4F7m6zDcN
         2YVeXTxXY1jRtoHvtXe59R++FQAI2V0j5nehqu6r+svZTEdkr3ggAFVbQFL/91KVTW3A
         WbvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zRM6UIbVNM2Xp2Y9+Qm9FqWy3vctF0AZ6K33pf6yzgnL15T3Rm1w+5kJSV3JZ6/rhzmISm4K0iH3FMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz763lkza3G6HevMldBBjDSSrTdo/mOWo+HKv8W7DncCQaPCsBv
	Guo4VGyZoq1s1YYguTaupkbLRhqJGT/dRuyEFbKjHWY+S1K94nAV9khAmNFkgwKnZROaP6OLj8K
	fP9DfomO/p+pnA2sVUY0Mf6tGK+xjZ3o=
X-Gm-Gg: Acq92OG5ZhYaSD7JEqcibP5w8PA4bMD9voRZEMpRKj/4Kedn3kx9ssyvdgXucf5FUqh
	jw6lUjWYfU9ywEkdWiTj0jq4I1gCGtMu5x7JhBrycjoxcrSmyVSOoPbR4TNSoTpqcsEWAW74Slt
	f1V2E1HwHjlguArR5gENi9TkaOA0VEThdZYTYYGGiMvFefM7DTvMRUV2VVNnBIVsLNkYIoZrvqj
	hOFmvsEKFO8lAj5NF3c9kKMNA1T/6NbgSZNaDWfm/5+M53ttPI/TDTX1aiu1b7vIs/h8vJ4TiSr
	XE/Xfqbw+EtIleealL754LJyOu2+YYM9O0NiyU3SAI6k173NOnsT/imnlvU=
X-Received: by 2002:adf:e6c4:0:b0:446:708e:1e8d with SMTP id
 ffacd0b85a97d-452ea742ea7mr9621915f8f.30.1778286597751; Fri, 08 May 2026
 17:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508060724.3810904-1-haowenchao@xiaomi.com> <20260508060724.3810904-2-haowenchao@xiaomi.com>
In-Reply-To: <20260508060724.3810904-2-haowenchao@xiaomi.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 8 May 2026 17:29:45 -0700
X-Gm-Features: AVHnY4KP3V33whk3hf4lfJjbsavyCuPedc3dt7_hzKzLAbMLN3db3L4C4L4lMuY
Message-ID: <CAKEwX=MzLKTF2uQRaJU8UK5B9UeW-Sh-LE_8fdmo7y-MPPbwyg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] mm/zsmalloc: introduce deferred free framework
 with callback ops
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry@kernel.org>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 11:08=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> Add a per-cpu deferred free mechanism to zsmalloc with a callback
> interface that lets callers (zram, zswap) customize push and drain
> behavior.
>
> Each CPU owns a single-page buffer. The hot path (zs_free_deferred)
> writes a value into the current CPU's buffer via the push callback
> with preemption disabled =E2=80=94 no locks, no atomics. When the buffer
> fills, it is swapped with a fresh page from a pre-allocated page
> pool and the full page is queued to a WQ_UNBOUND worker for drain.
>
> The drain worker invokes the drain callback which performs the actual
> expensive work (zs_free, slot_free, etc.) in batch, away from the
> original hot path.
>
> Page pool management:
>   - Pool is pre-allocated at enable time (ZS_DEFERRED_POOL_SIZE pages)
>   - Full buffers are drained and returned to the pool
>   - If no free page is available when buffer is full, the push falls
>     back to synchronous processing by the caller
>
> Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
> ---
> +#define ZS_DEFERRED_POOL_SIZE  (256 * 1024 / PAGE_SIZE)

Seems oddly specific? :) And this doesn't quite scale with number of
CPUs, or memory size?

> +
> +struct zs_deferred_percpu {
> +       unsigned int count;
> +       void *buf;
> +};
> +
>  struct zs_pool {
>         const char *name;
>
> @@ -217,6 +224,18 @@ struct zs_pool {
>         /* protect zspage migration/compaction */
>         rwlock_t lock;
>         atomic_t compaction_in_progress;
> +
> +       /* per-cpu deferred free */
> +       const struct zs_deferred_ops *deferred_ops;
> +       void *deferred_private;
> +       struct zs_deferred_percpu __percpu *deferred;
> +       struct work_struct deferred_work;
> +       struct workqueue_struct *deferred_wq;
> +       struct list_head deferred_pool;
> +       unsigned int deferred_pool_count;
> +       spinlock_t deferred_pool_lock;
> +       struct list_head deferred_drain_list;
> +       spinlock_t deferred_drain_lock;
>  };
>
>  static inline void zpdesc_set_first(struct zpdesc *zpdesc)
> @@ -1416,6 +1435,171 @@ void zs_free(struct zs_pool *pool, unsigned long =
handle)
>  }
>  EXPORT_SYMBOL_GPL(zs_free);
>
> +static struct page *deferred_pool_get(struct zs_pool *pool)
> +{
> +       struct page *page =3D NULL;
> +
> +       spin_lock(&pool->deferred_pool_lock);
> +       if (!list_empty(&pool->deferred_pool)) {
> +               page =3D list_first_entry(&pool->deferred_pool, struct pa=
ge, lru);
> +               list_del(&page->lru);
> +               pool->deferred_pool_count--;
> +       }
> +       spin_unlock(&pool->deferred_pool_lock);
> +       return page;
> +}
> +
> +static void deferred_pool_put(struct zfs_pool *pool, struct page *page)
> +{
> +       spin_lock(&pool->deferred_pool_lock);
> +       list_add_tail(&page->lru, &pool->deferred_pool);
> +       pool->deferred_pool_count++;
> +       spin_unlock(&pool->deferred_pool_lock);
> +}
> +
> +static void zs_deferred_work_fn(struct work_struct *work)
> +{
> +       struct zs_pool *pool =3D container_of(work, struct zs_pool, defer=
red_work);
> +       struct page *page;
> +
> +       while (true) {
> +               unsigned int count;
> +
> +               spin_lock(&pool->deferred_drain_lock);
> +               if (list_empty(&pool->deferred_drain_list)) {
> +                       spin_unlock(&pool->deferred_drain_lock);
> +                       break;
> +               }
> +               page =3D list_first_entry(&pool->deferred_drain_list,
> +                                       struct page, lru);
> +               list_del(&page->lru);
> +               count =3D page_private(page);
> +               spin_unlock(&pool->deferred_drain_lock);
> +
> +               pool->deferred_ops->drain(pool->deferred_private,
> +                                         page_address(page), count);
> +               deferred_pool_put(pool, page);
> +               cond_resched();
> +       }
> +}
> +
> +bool zs_free_deferred(struct zs_pool *pool, unsigned long value)
> +{
> +       struct zs_deferred_percpu *def;
> +       struct page *new_page, *full_page;
> +       enum zs_push_ret ret;
> +
> +       if (!pool->deferred)
> +               return false;
> +
> +       def =3D get_cpu_ptr(pool->deferred);
> +
> +       ret =3D pool->deferred_ops->push(def->buf, def->count, value);
> +       if (ret =3D=3D ZS_PUSH_OK) {
> +               def->count++;
> +               put_cpu_ptr(pool->deferred);
> +               return true;
> +       }
> +
> +       if (ret =3D=3D ZS_PUSH_FULL_QUEUED)
> +               def->count++;
> +
> +       new_page =3D deferred_pool_get(pool);
> +       if (new_page) {
> +               full_page =3D virt_to_page(def->buf);
> +               set_page_private(full_page, def->count);
> +               def->buf =3D page_address(new_page);
> +               def->count =3D 0;
> +
> +               if (ret =3D=3D ZS_PUSH_FULL) {
> +                       pool->deferred_ops->push(def->buf, 0, value);
> +                       def->count =3D 1;
> +               }
> +               put_cpu_ptr(pool->deferred);
> +
> +               spin_lock(&pool->deferred_drain_lock);
> +               list_add_tail(&full_page->lru, &pool->deferred_drain_list=
);
> +               spin_unlock(&pool->deferred_drain_lock);
> +               queue_work(pool->deferred_wq, &pool->deferred_work);
> +               return true;
> +       }
> +       put_cpu_ptr(pool->deferred);
> +
> +       /* ret=3D=3D2: value already queued, will be drained eventually *=
/
> +       if (ret =3D=3D 2)

=3D=3D 2? :)

> +               return true;
> +
> +       /* ret=3D=3D1: value not queued, caller must fallback */
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(zs_free_deferred);
