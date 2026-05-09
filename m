Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE49390CA1
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316490; cv=pass; b=JCqtq17xcVWLiugdlJuj5c35ouXuyrbrApkx+wFa5eMUy7xqPqFxMgIAFRykL7sHhxqEVzFJT15vPF//RDCuru1XcNP0Sz6JBHpn2QWkWjJu8z0WSJ6FP6Xj4qKQlc5UZ81jce+k5KCROozsRrnPVKoNywKPSoNL2mRFUm3o5UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316490; c=relaxed/simple;
	bh=oaRxlLbcznN5M2wsy1OHTi3r75GilxYQYWMZXLK9K9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYllFGy3JguZvT1UXLQ/jZl8J6/ym71T47nDFW3pu7Dfr8KSjcBzkiRJC/FN1gEF10haZ6EbF4pj+wCSpTPefzMsM2tmD7lSBTRjA/7O1gCUavsfvDm34KyfTkJWwqadzVOjD1dJLGdHYT88DkMjmlrZPj5yP89Uws9QSPOP6SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn3ioq+W; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn3ioq+W"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c7a459105so3195918d50.0
        for <linux-block@vger.kernel.org>; Sat, 09 May 2026 01:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778316488; cv=none;
        d=google.com; s=arc-20240605;
        b=KdRPRspEZfyACqlMXCLAwi/m+b9csgWlEafuUNsU8DCskifcp0030OTkNiu540FRx5
         V6x3pO5ZM3P9os2EBUOll9IMb6Wbfzmhp9xWM5QtPchswH/XgXS18vLgEtHUIqEJ9FNW
         ZD6DcrCfj76P/mqiuCfPLgE+kRUnK6Hhfgyw8Kh68qU1/PbCJb53aZEQcCUwW7BesRrr
         ncbS5S9BU7B8S1mbNNiusgHpVfrr58DF7gL9e6GGJWb/fOfSBwcMmOIdoIFfMH+seEi7
         aRiGcSkpietzu+1bWnTwW6Idue8F2JRR035o7g+lSPDzZObzgY5t78wqbTLdt/4nnC4x
         qN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K3qF25jvgZAKkMW+NjZ+nl1TbSQf0Fcc08uA3kp981w=;
        fh=uAHjg2eG1HXvaqC97EKIY3sgsWfE/E+9azqUuWKLO/o=;
        b=aXJVIPnEW4lEJYZ45QfmJV+Ekn0MqfN1+WIJMkg8/IFKyGPU8QIYEYhlcLvbYeW9rZ
         H0HFAk5JnOrHefEWVndcN6QPFcW/lXN6Xpgk6dn95gZ30A79ZeBFnPo1mO3y0LB/4lN+
         RZQkiKCMlxdg2RZvGqSWQOjfk1XUKcf3e8F62VEoffd8bo/KLHCiVE8UZKixctkstvdJ
         uLgXqLXKej9/H03KTllURKXoNWdJFnkffMGUX8FUVefxJvH7Vd3OYLXy+dXrmSG/AmJI
         Rs/8PmNGvmwf0MPp88slWTC7T449+dtL9bja2X69Ie05lcvudfy1ZqQB9uo5SxrRNzSX
         9v/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316488; x=1778921288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3qF25jvgZAKkMW+NjZ+nl1TbSQf0Fcc08uA3kp981w=;
        b=Qn3ioq+WLshG6u7CDGhAVushOL03Wo2RgsXSW0HSA0P46+gj0XxmBXs9DATehANjnn
         uIvmqdhUJaLTI4fIkLRC33JrGojDAKx4LOS4DPUJ9FmQcPODHmi9QsqdxF7ijfDHloLO
         uoQxghOLRLCV9HWDfS/asStmcj3iv/04opdi5QJVE12OReDLSfpRyaEuCC7+ZHeZXhqA
         40Zzi74FjCJv8K39moV09IahkOknAS3GCLCLB/gBCwmYvRRIKA6wQ1DupSua1JjouQSx
         rvY5hx0USRq/dCMAOGnPPcSHNK/6NNy5Rorb2iiFzFRDH+Yk2bQ3fRuHDyNqma6GryZD
         sfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316488; x=1778921288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3qF25jvgZAKkMW+NjZ+nl1TbSQf0Fcc08uA3kp981w=;
        b=fhRHkKvOXvcRPa5o1CfSTjwYJcJSjmt4I9Y7bkky7WcByrSqxiMSzVa7BO4Z2Y7FWO
         QCzXMdEyWcm7dZnHe5VFZ1J9MzNRpKrKxZqyeJrhOkHTqOOF8HhMl+LQXweWbj7K/PgR
         ycnndvkQHB2fUNOux0aXJQDbHN99Fs/i8ic4yDQQj66ZpbvH0hcJyl15CLZXJUSxZcB0
         bCAmzQQH30Q0I0wgM6hrfrOF1Fzd7WWACehRCH89LMt2gtRXxtLUulcMTpirbnvsOaSw
         WSh67agj7+rWEeikhHlkjhA6h8aCUyNfRmPj1J2BzqV7CODQsiR9RRA4sp1IEf4r6SYe
         TtEg==
X-Forwarded-Encrypted: i=1; AFNElJ8Qp3ERU5wL1WeU+hgjXC6To3vwh92/+s5uMY3f8mXLouE3GYLOHrDD06QPEQD+yyspBXDnb5gMh1lqhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3NjJ9Tp16aZ1EvAUEdAN8R7KFFoGZ2UGwzovMliXk16SeLHC
	wbds4Eaip04CHY/0Hymz/WptXonjVrNZnAnWY4zPborF315lZ+MLgEdCdx7Qwy1XftSMiLkODNO
	mGvVOg764LtbjoL67+KDcb/M2g+LFneg=
X-Gm-Gg: Acq92OG4/bYw184uvyTeqry/2O17fap3wn82BuE247MNqczSIo7HhMW5OmaoySlcvTj
	49hr3PRHI0kZjoM7LM8DwaPFWvVeOG9v2nN8mF91TdWMrNZlQix0irnRTgvJAPYyFcvHLlj40mh
	cRZNsA777/ppxTlnjunU9QVJLJeGms2o8bgCW+nSeKdwbqMOOl3tQWN443gXDca0+dYqev3UXB9
	OadczdA9E+B7rTjttjTKoHwlItmjzOKJWl3OXyW9VREWgvikh0QIu8yvak/lExb96xjSbwOir0W
	sdRk6Zou
X-Received: by 2002:a53:ac8b:0:b0:651:c41c:80ce with SMTP id
 956f58d0204a3-65d7e782ee0mr9032266d50.16.1778316488245; Sat, 09 May 2026
 01:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508060724.3810904-1-haowenchao@xiaomi.com>
 <20260508060724.3810904-2-haowenchao@xiaomi.com> <CAKEwX=MzLKTF2uQRaJU8UK5B9UeW-Sh-LE_8fdmo7y-MPPbwyg@mail.gmail.com>
In-Reply-To: <CAKEwX=MzLKTF2uQRaJU8UK5B9UeW-Sh-LE_8fdmo7y-MPPbwyg@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Sat, 9 May 2026 16:47:56 +0800
X-Gm-Features: AVHnY4It_UXh4NngbQgPwWNgoNxLei8GvwX1tCgHjP3tCsKGiSXiBnVS9MeknAQ
Message-ID: <CAOptpSMaAEDMfGOufrWkJY5VchFBx+ON=Uc1j19JP5vw_wJdEA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] mm/zsmalloc: introduce deferred free framework
 with callback ops
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry@kernel.org>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 8:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, May 7, 2026 at 11:08=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> >
> > Add a per-cpu deferred free mechanism to zsmalloc with a callback
> > interface that lets callers (zram, zswap) customize push and drain
> > behavior.
> >
> > Each CPU owns a single-page buffer. The hot path (zs_free_deferred)
> > writes a value into the current CPU's buffer via the push callback
> > with preemption disabled =E2=80=94 no locks, no atomics. When the buffe=
r
> > fills, it is swapped with a fresh page from a pre-allocated page
> > pool and the full page is queued to a WQ_UNBOUND worker for drain.
> >
> > The drain worker invokes the drain callback which performs the actual
> > expensive work (zs_free, slot_free, etc.) in batch, away from the
> > original hot path.
> >
> > Page pool management:
> >   - Pool is pre-allocated at enable time (ZS_DEFERRED_POOL_SIZE pages)
> >   - Full buffers are drained and returned to the pool
> >   - If no free page is available when buffer is full, the push falls
> >     back to synchronous processing by the caller
> >
> > Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
> > ---
> > +#define ZS_DEFERRED_POOL_SIZE  (256 * 1024 / PAGE_SIZE)
>
> Seems oddly specific? :) And this doesn't quite scale with number of
> CPUs, or memory size?
>

256K holds the deferred metadata for ~128MB zswap or ~256MB zram
entries, which matches what a killed process typically has swapped
out. Pages sitting in the pool are memory that can't be used
elsewhere, so I didn't want it to grow with RAM/CPU. Happy to
parameterize it if you'd prefer.

> > +
> > +struct zs_deferred_percpu {
> > +       unsigned int count;
> > +       void *buf;
> > +};
> > +
> >  struct zs_pool {
> >         const char *name;
> >
> > @@ -217,6 +224,18 @@ struct zs_pool {
> >         /* protect zspage migration/compaction */
> >         rwlock_t lock;
> >         atomic_t compaction_in_progress;
> > +
> > +       /* per-cpu deferred free */
> > +       const struct zs_deferred_ops *deferred_ops;
> > +       void *deferred_private;
> > +       struct zs_deferred_percpu __percpu *deferred;
> > +       struct work_struct deferred_work;
> > +       struct workqueue_struct *deferred_wq;
> > +       struct list_head deferred_pool;
> > +       unsigned int deferred_pool_count;
> > +       spinlock_t deferred_pool_lock;
> > +       struct list_head deferred_drain_list;
> > +       spinlock_t deferred_drain_lock;
> >  };
> >
> >  static inline void zpdesc_set_first(struct zpdesc *zpdesc)
> > @@ -1416,6 +1435,171 @@ void zs_free(struct zs_pool *pool, unsigned lon=
g handle)
> >  }
> >  EXPORT_SYMBOL_GPL(zs_free);
> >
> > +static struct page *deferred_pool_get(struct zs_pool *pool)
> > +{
> > +       struct page *page =3D NULL;
> > +
> > +       spin_lock(&pool->deferred_pool_lock);
> > +       if (!list_empty(&pool->deferred_pool)) {
> > +               page =3D list_first_entry(&pool->deferred_pool, struct =
page, lru);
> > +               list_del(&page->lru);
> > +               pool->deferred_pool_count--;
> > +       }
> > +       spin_unlock(&pool->deferred_pool_lock);
> > +       return page;
> > +}
> > +
> > +static void deferred_pool_put(struct zfs_pool *pool, struct page *page=
)
> > +{
> > +       spin_lock(&pool->deferred_pool_lock);
> > +       list_add_tail(&page->lru, &pool->deferred_pool);
> > +       pool->deferred_pool_count++;
> > +       spin_unlock(&pool->deferred_pool_lock);
> > +}
> > +
> > +static void zs_deferred_work_fn(struct work_struct *work)
> > +{
> > +       struct zs_pool *pool =3D container_of(work, struct zs_pool, def=
erred_work);
> > +       struct page *page;
> > +
> > +       while (true) {
> > +               unsigned int count;
> > +
> > +               spin_lock(&pool->deferred_drain_lock);
> > +               if (list_empty(&pool->deferred_drain_list)) {
> > +                       spin_unlock(&pool->deferred_drain_lock);
> > +                       break;
> > +               }
> > +               page =3D list_first_entry(&pool->deferred_drain_list,
> > +                                       struct page, lru);
> > +               list_del(&page->lru);
> > +               count =3D page_private(page);
> > +               spin_unlock(&pool->deferred_drain_lock);
> > +
> > +               pool->deferred_ops->drain(pool->deferred_private,
> > +                                         page_address(page), count);
> > +               deferred_pool_put(pool, page);
> > +               cond_resched();
> > +       }
> > +}
> > +
> > +bool zs_free_deferred(struct zs_pool *pool, unsigned long value)
> > +{
> > +       struct zs_deferred_percpu *def;
> > +       struct page *new_page, *full_page;
> > +       enum zs_push_ret ret;
> > +
> > +       if (!pool->deferred)
> > +               return false;
> > +
> > +       def =3D get_cpu_ptr(pool->deferred);
> > +
> > +       ret =3D pool->deferred_ops->push(def->buf, def->count, value);
> > +       if (ret =3D=3D ZS_PUSH_OK) {
> > +               def->count++;
> > +               put_cpu_ptr(pool->deferred);
> > +               return true;
> > +       }
> > +
> > +       if (ret =3D=3D ZS_PUSH_FULL_QUEUED)
> > +               def->count++;
> > +
> > +       new_page =3D deferred_pool_get(pool);
> > +       if (new_page) {
> > +               full_page =3D virt_to_page(def->buf);
> > +               set_page_private(full_page, def->count);
> > +               def->buf =3D page_address(new_page);
> > +               def->count =3D 0;
> > +
> > +               if (ret =3D=3D ZS_PUSH_FULL) {
> > +                       pool->deferred_ops->push(def->buf, 0, value);
> > +                       def->count =3D 1;
> > +               }
> > +               put_cpu_ptr(pool->deferred);
> > +
> > +               spin_lock(&pool->deferred_drain_lock);
> > +               list_add_tail(&full_page->lru, &pool->deferred_drain_li=
st);
> > +               spin_unlock(&pool->deferred_drain_lock);
> > +               queue_work(pool->deferred_wq, &pool->deferred_work);
> > +               return true;
> > +       }
> > +       put_cpu_ptr(pool->deferred);
> > +
> > +       /* ret=3D=3D2: value already queued, will be drained eventually=
 */
> > +       if (ret =3D=3D 2)
>
> =3D=3D 2? :)
>

Will replace with ZS_PUSH_FULL_QUEUED, if v4 still has
this logic.

Thanks,
Wenchao
