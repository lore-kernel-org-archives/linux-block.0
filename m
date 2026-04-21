Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE13BAD93
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800819; cv=pass; b=fGQHeP3fK/c0QgN0xvKXQMm5re3HvWzoag+t6oetFZ042M9clW0ZuLF/U++hf1+1FvG+ZPJUuw7GSJQ64YC+cwWRNWz7jLsla6j3v/zTdz/OK7zOtTob1Sldx3qArmxL0+dLgwkh40/cjDjx2D2ZjYGR/jT7ZYsdLTtEhpInKfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800819; c=relaxed/simple;
	bh=828ZyEINjkcxgfmMPIHRSuI+hAmzR3pDOL4pugpwYo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OE7wrg4M8xRsQTb9ibnUJnP3VsAz35h0iNT42hIdVg6BC95agco1/M0CWWPGwSM9/Rk5isJSuSbvMm5L8txLXxQvWIIaRWD0JXLwE3921sznTTffIMH6AJMwT5GXMM6aq8e/wDNUij6u+AC4tfFf4HCqTx7dPnPtSn+Z6NNG4Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT1A7yQE; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT1A7yQE"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43eada6d900so4580773f8f.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 12:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776800816; cv=none;
        d=google.com; s=arc-20240605;
        b=a//esjyfbiKnHg65ZG1unLUSq8eIv6ps4vVffqUYQfWutQIbWYWK8F7hgy6UKFD1+K
         sPo/QPrz2es6h7KmNAQoyj04X6Jf4r4P0OD3wYzyW82URn6g2Sw7XkH9GLq4jWdKSz8x
         soc6MwGjXkg7PBcSzyNHejM9axX6SnFt9IgPumwxl/Wz5pyI24w/UlpWh8a22IWbpcQb
         eO2RPj4XWEtvDZwlqo3JthrG5TCK21Dj/eRnxc5Ci8ZdMh+wLw5tCntAHSLeSZfVNIVf
         1byvgnBDfeCXPK3W99BkjzmxauMmYrMX9Bi6bdGZWF3i51WEuMuLuJGqiBTG5tim+mTe
         Ka7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LKc+3XShNvSGAUkrOOm7vc1nfqz/ste7x65pdAa0N94=;
        fh=IBWYOcIqJwoymU3ooF5zuNNJhcGJEx39U6mxtffzpnU=;
        b=jEcdi0edUOVyfpdNf0MltS/k1eu5W/xSp+HSzvr1/fV2leMxnIzcFXHNI4Tmxg80f0
         VEm28eloy7tm1rKiSa5uov99f8XNvzTgajjs74Lpjs+1NxPGwyQaodDaY1sRzOohTwpk
         Jgu95lVvSESm45vTJwyktPfKqi/+0FZIGscL+5TXmfUhEp91dkOquwFG2UZZSiUzefnL
         jRYmRvQx+oUpQpjs+V5NxuP8wFCpavpfz9wbNOPSoS6hcgREg4ayypIcXUS8BXlGqLkh
         Chi2oX3gbNUTcEnhxwA/agJ/1r7WSbI/w8P9k6MOoeudiwTkGbSD7mJ22zCQiEvfgJin
         ymjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776800816; x=1777405616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKc+3XShNvSGAUkrOOm7vc1nfqz/ste7x65pdAa0N94=;
        b=WT1A7yQEwGLNGBhhDstlkqCwPDQkNnQuTU624fzDMxk3QjYRY/8KLgtJpr+OKMNUIM
         ILnTac+PeCnLCpUcPNWm0l9IdDlEvsZJPV29wFWlMO7mJ3WFfvw/JSukrMyTtNj+GEfV
         Ro4PcUC2+TYuHYkzBnyKHgCFPqDznCVxAHHwmApkHnQV3qPnzxSnToWUzFHf7OHFi2tV
         DCVvE+qsUYXGJW4Ba1I59xGSxYc+DrZngB+7gOekOY3TWwmy3vEvrt0Rf4Ndt9xC94hd
         UpwHZiKH8m2jpgPFzNsbo/14H8hOnWu/pZ+Mu/EsWopWlehLBRD4TggPfeLpJIz/togu
         op+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800816; x=1777405616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKc+3XShNvSGAUkrOOm7vc1nfqz/ste7x65pdAa0N94=;
        b=k/nHM9PiKQ+pLmGeyrI9wFg0OoOL63QBmGMNy1wDkzcD0fjuQqQ26NA60+tPhy6HiD
         1vDEDNRzjM15xosm+G7EqiiuHfUAPcSQHKgOH8mhSJZ0wQfSI/gS9uv4E2/wfd9hUdCr
         KjVukjMLz91ToxD3wKpyB8pg4PdD3KCqI8yydXdz4R6j1uETsBHE/qMRbSIO60vWHncS
         2nl1XcY8ey8PpO2ZmVQ0RmVzto0Nkqc14e7wpm2gi3PW7kg+KYh8ADMnIvojxnA2FYnw
         5Eeeu6NbTFxJLU/nQdaYqloakbBkozMu4DyxR5LRse8z48RCl1MgEqzwaaKYY0P+7+IL
         8CmA==
X-Forwarded-Encrypted: i=1; AFNElJ9SGPaRzh3EMXXXTo7aAUux4ij+QPvYxewCE4vA+KzVPXPOv6Pwp33BjvD1aCbG3DPhI2GVhP7kl7Tktw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLruuYuddubbMH0KVe0fWcAPcyit/2XLAkDqbsuwh4R0eeAJjm
	ci0xDF5OCyYp/9eRqqS76O5mu2FBQN9k42hZmbW0qmDjFCDd4glasHkUACIfpKIQANq8JFqlJg/
	iZWaMZNILE27MQWzC1xKVJ3dmIPZtxSw=
X-Gm-Gg: AeBDietzJ/pb7GgicSZFUTpPkqYegfyCRWNvgRQNHVVf5G91ivkMy5nOKL/fXjvZTKj
	268hkIR/L1TKjNrmyadH4/ZiaAchfEtnk20CftpOZZMxF4ToD6UAEi066q2LHlAeoGcT+Q/T3kk
	4IXuK65hAzajPB5j4axCPb5MXJ03B+Cxl6+nqwudzeXRhe22L3iS9mQHv3Ni1WPnMrZ12OON13C
	7BybnuGnJ8LtoMmTE/nRuycEcAjGKh5g8zXJczsisZrLxioBtuWpA23iLrsxZuDynMf2G3UWzIZ
	vPufRZntzJ6R2qPXMPoiGwJKJCYxALZ7QkZXqhdf/oRLzxkZaMCfeVFVoQdmb5It5w==
X-Received: by 2002:a05:6000:1acf:b0:43d:7946:bae6 with SMTP id
 ffacd0b85a97d-43fe3e236c2mr28724047f8f.43.1776800815609; Tue, 21 Apr 2026
 12:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com> <20260421121616.3298845-3-haowenchao@xiaomi.com>
In-Reply-To: <20260421121616.3298845-3-haowenchao@xiaomi.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 21 Apr 2026 12:46:43 -0700
X-Gm-Features: AQROBzDBeKqAh3bxhbxh9vApl2qsd7P7xq3bhWanE7-5sQjVIdb4h2iu7McK_5k
Message-ID: <CAKEwX=P8_5qyou0KgvwvoPpRsUN4ohwsC7ysxjTW=Fbwk2uSOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] mm/zsmalloc: introduce zs_free_deferred() for
 async handle freeing
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
> zs_free() is expensive due to internal locking (pool->lock, class->lock)
> and potential zspage freeing. On the process exit path, the slow
> zs_free() blocks memory reclamation, delaying overall memory release.
> This has been reported to significantly impact Android low-memory
> killing where slot_free() accounts for over 80% of the total swap
> entry freeing cost.
>
> Introduce zs_free_deferred() which queues handles into a fixed-size
> per-pool array for later processing by a workqueue. This allows callers
> to defer the expensive zs_free() and return quickly, so the process
> exit path can release memory faster. The array capacity is derived from
> a 128MB uncompressed data budget (128MB >> PAGE_SHIFT entries), which
> scales naturally with PAGE_SIZE. When the array reaches half capacity,
> the workqueue is scheduled to drain pending handles.
>
> zs_free_deferred() uses spin_trylock() to access the deferred queue.
> If the lock is contended (e.g. drain in progress) or the queue is full,
> it falls back to synchronous zs_free() to guarantee correctness.
>
> Also introduce zs_free_deferred_flush() for use during pool teardown to
> ensure all pending handles are freed.

Hmmm per-pool workqueue.

Does that mean that if you only have one zs pool (in the case of
zswap, or if you only have one zram device), you'll have less
concurrency in freeing up zsmalloc memory for process teardown? Would
this be problematic?

I think Kairui was also suggesting per-cpu-fying these batches/queues.

>
> Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
> ---
>  include/linux/zsmalloc.h |   2 +
>  mm/zsmalloc.c            | 111 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
>
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 478410c880b1..1e5ac1a39d41 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -30,6 +30,8 @@ void zs_destroy_pool(struct zs_pool *pool);
>  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
>                         const int nid);
>  void zs_free(struct zs_pool *pool, unsigned long obj);
> +void zs_free_deferred(struct zs_pool *pool, unsigned long handle);
> +void zs_free_deferred_flush(struct zs_pool *pool);
>
>  size_t zs_huge_class_size(struct zs_pool *pool);
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 40687c8a7469..defc892555e4 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -53,6 +53,10 @@
>
>  #define ZS_HANDLE_SIZE (sizeof(unsigned long))
>
> +#define ZS_DEFERRED_FREE_MAX_BYTES     (128 << 20)
> +#define ZS_DEFERRED_FREE_CAPACITY      (ZS_DEFERRED_FREE_MAX_BYTES >> PA=
GE_SHIFT)
> +#define ZS_DEFERRED_FREE_THRESHOLD     (ZS_DEFERRED_FREE_CAPACITY / 2)
> +
>  /*
>   * Object location (<PFN>, <obj_idx>) is encoded as
>   * a single (unsigned long) handle value.
> @@ -217,6 +221,13 @@ struct zs_pool {
>         /* protect zspage migration/compaction */
>         rwlock_t lock;
>         atomic_t compaction_in_progress;
> +
> +       /* deferred free support */
> +       spinlock_t deferred_lock;
> +       unsigned long *deferred_handles;
> +       unsigned int deferred_count;
> +       unsigned int deferred_capacity;
> +       struct work_struct deferred_free_work;
>  };
>
>  static inline void zpdesc_set_first(struct zpdesc *zpdesc)
> @@ -579,6 +590,19 @@ static int zs_stats_size_show(struct seq_file *s, vo=
id *v)
>  }
>  DEFINE_SHOW_ATTRIBUTE(zs_stats_size);
>
> +static int zs_stats_deferred_show(struct seq_file *s, void *v)
> +{
> +       struct zs_pool *pool =3D s->private;
> +
> +       spin_lock(&pool->deferred_lock);
> +       seq_printf(s, "pending: %u\n", pool->deferred_count);
> +       seq_printf(s, "capacity: %u\n", pool->deferred_capacity);
> +       spin_unlock(&pool->deferred_lock);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(zs_stats_deferred);
> +
>  static void zs_pool_stat_create(struct zs_pool *pool, const char *name)
>  {
>         if (!zs_stat_root) {
> @@ -590,6 +614,9 @@ static void zs_pool_stat_create(struct zs_pool *pool,=
 const char *name)
>
>         debugfs_create_file("classes", S_IFREG | 0444, pool->stat_dentry,=
 pool,
>                             &zs_stats_size_fops);
> +       debugfs_create_file("deferred_free", S_IFREG | 0444,
> +                           pool->stat_dentry, pool,
> +                           &zs_stats_deferred_fops);
>  }
>
>  static void zs_pool_stat_destroy(struct zs_pool *pool)
> @@ -1432,6 +1459,76 @@ void zs_free(struct zs_pool *pool, unsigned long h=
andle)
>  }
>  EXPORT_SYMBOL_GPL(zs_free);
>
> +static void zs_deferred_free_work(struct work_struct *work)
> +{
> +       struct zs_pool *pool =3D container_of(work, struct zs_pool,
> +                                           deferred_free_work);
> +       unsigned long handle;
> +
> +       while (1) {
> +               spin_lock(&pool->deferred_lock);
> +               if (pool->deferred_count =3D=3D 0) {
> +                       spin_unlock(&pool->deferred_lock);
> +                       break;
> +               }
> +               handle =3D pool->deferred_handles[--pool->deferred_count]=
;
> +               spin_unlock(&pool->deferred_lock);

Any reason why we're locking, grabbing a handle, then unlocking, one
at a time? Why dont we just lock, grab all the handles (or at least a
batch of them), unlock, then process the handles one at a time?

We can also have a pair of handle arrays. Whenever defer worker is
woken up, just swap the arrays under the lock, then free the handles
in the old array :)


> +
> +               zs_free(pool, handle);
> +               cond_resched();
> +       }
> +}
> +
> +/**
> + * zs_free_deferred - queue a handle for asynchronous freeing
> + * @pool: pool to free from
> + * @handle: handle to free
> + *
> + * Place @handle into a deferred free queue for later processing by a
> + * workqueue.  This is intended for callers that are in atomic context
> + * (e.g. under a spinlock) and cannot afford the cost of zs_free()
> + * directly.  When the queue reaches a threshold the work is scheduled.
> + * Falls back to synchronous zs_free() if the lock is contended (drain
> + * in progress) or if the queue is full.
> + */
> +void zs_free_deferred(struct zs_pool *pool, unsigned long handle)
> +{
> +       if (IS_ERR_OR_NULL((void *)handle))
> +               return;
> +
> +       if (!spin_trylock(&pool->deferred_lock))
> +               goto sync_free;
> +
> +       if (pool->deferred_count >=3D pool->deferred_capacity) {
> +               spin_unlock(&pool->deferred_lock);
> +               goto sync_free;
> +       }
> +
> +       pool->deferred_handles[pool->deferred_count++] =3D handle;
> +       if (pool->deferred_count >=3D ZS_DEFERRED_FREE_THRESHOLD)
> +               queue_work(system_wq, &pool->deferred_free_work);
> +       spin_unlock(&pool->deferred_lock);
> +       return;
> +
> +sync_free:
> +       zs_free(pool, handle);
> +}
> +EXPORT_SYMBOL_GPL(zs_free_deferred);
> +
> +/**
> + * zs_free_deferred_flush - flush all pending deferred frees
> + * @pool: pool to flush
> + *
> + * Wait for any scheduled work to complete, then drain any remaining
> + * handles.  Must be called from process context.
> + */
> +void zs_free_deferred_flush(struct zs_pool *pool)
> +{
> +       flush_work(&pool->deferred_free_work);
> +       zs_deferred_free_work(&pool->deferred_free_work);
> +}
> +EXPORT_SYMBOL_GPL(zs_free_deferred_flush);
> +
>  static void zs_object_copy(struct size_class *class, unsigned long dst,
>                                 unsigned long src)
>  {
> @@ -2099,6 +2196,18 @@ struct zs_pool *zs_create_pool(const char *name)
>         rwlock_init(&pool->lock);
>         atomic_set(&pool->compaction_in_progress, 0);
>
> +       spin_lock_init(&pool->deferred_lock);
> +       pool->deferred_capacity =3D ZS_DEFERRED_FREE_CAPACITY;
> +       pool->deferred_handles =3D kvmalloc_array(pool->deferred_capacity=
,
> +                                               sizeof(unsigned long),
> +                                               GFP_KERNEL);
> +       if (!pool->deferred_handles) {
> +               kfree(pool);
> +               return NULL;
> +       }
> +       pool->deferred_count =3D 0;
> +       INIT_WORK(&pool->deferred_free_work, zs_deferred_free_work);
> +
>         pool->name =3D kstrdup(name, GFP_KERNEL);
>         if (!pool->name)
>                 goto err;
> @@ -2201,6 +2310,7 @@ void zs_destroy_pool(struct zs_pool *pool)
>         int i;
>
>         zs_unregister_shrinker(pool);
> +       zs_free_deferred_flush(pool);
>         zs_flush_migration(pool);
>         zs_pool_stat_destroy(pool);
>
> @@ -2224,6 +2334,7 @@ void zs_destroy_pool(struct zs_pool *pool)
>                 kfree(class);
>         }
>
> +       kvfree(pool->deferred_handles);
>         kfree(pool->name);
>         kfree(pool);
>  }
> --
> 2.34.1
>
