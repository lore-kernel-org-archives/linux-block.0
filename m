Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91381346FAD
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776463194; cv=none; b=tXhzI51U4aJuJNBlw6SbzVAsiRwOL6DsqTplUDbTHXp5XMBDzlrd/iO0PL/YQradIEXwD+7hGN6gob4mHOykWME9NdY/AJbCD3qDIepbL0/3NrkprQNj4ldxn68xkyWnMWu7hjVlu60WRBz+JBbtMU7/UhuhyAzl4e5xY/slUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776463194; c=relaxed/simple;
	bh=JaCdgcmEUHbDeA2gw7iUfkcJu19kiK3sUUgMzqWDC18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLglv18ag2bcN9rY3CiKQ5MxZfM7cgsYw4TfSI2POvbh4qkGXQ17bGMF3fKdeagVmF3xJqOB6Xln2P8AD9BukBMwIO9dYBMgabZ8jN0HSvsD/3ill8moyuHYaD8Z1z5jS52pZUHtniVGjxm88DnLVhfdKZfdzh4FNf44HwYFKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1bq9x/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1bq9x/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A188C2BCF5
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 21:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776463194;
	bh=JaCdgcmEUHbDeA2gw7iUfkcJu19kiK3sUUgMzqWDC18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z1bq9x/ZiH4MJAoheHkTRVkq4JXTfRg/lftEnj6n88YSLOTjinLLMsKpV34LstEs7
	 +x4In20NNnbbyk/2txpnLlz8YfcOFlLfw+8sZZhsNm1onZ9xMbaFRLdIEACELoE5CF
	 aIxsb9ZYbFp7hqk28r1RRGJdCA3dKiPfr466jlsBmWtEJpsTn+Qa4/Zt1ylXIc0Y90
	 hdHcGZ+s7eqkKC6X23WVLYaV01dzYkv36iKMbqhlQP21GYq1WuK5FOqf1P6T6E9rgU
	 ih/W9cGMlct7oz86FzDTLDlCpF8/DM0vjzxLXbuhlbprE93o81W0Csq4cukdmba2d6
	 TGoFWwLM+RVyg==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso17655126d6.0
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 14:59:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+PqfuZAe7MDglcYlFgENXbNAmzAEB5mP2TkTZdRInZhQ8crUQstAgkF0IttGMDlTX4LGlmDrRtPwzmDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnkd7thAmsUNvEixt386ymKArvC6Il6NnZKl+Cu0Is/vKfxOI
	XHbbYV+72LeEGSy2jscai/YaBHOwwgAPNsYnpszWAnFUe6E4FdysWqSC2ufqrd6T0XZBpE2eSxR
	AobePfCeBrOrJI8F0uUxCW64qLL0BxLk=
X-Received: by 2002:a05:6214:29e9:b0:89c:6bbd:76d8 with SMTP id
 6a1803df08f44-8b0280b2f12mr73952556d6.19.1776463193295; Fri, 17 Apr 2026
 14:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412060450.15813-1-baohua@kernel.org> <adt3Q_SRToF6fb3W@KASONG-MC4>
In-Reply-To: <adt3Q_SRToF6fb3W@KASONG-MC4>
From: Barry Song <baohua@kernel.org>
Date: Sat, 18 Apr 2026 05:59:41 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zSCkDGzvpaBGAqnUSQSWx2ikmrqpihYPBhqdwC-PKDOQ@mail.gmail.com>
X-Gm-Features: AQROBzC6BuZtWVY0sxybxJ4MxSOu-q_1G8tDdEt1b4FjEKKUjwM1uiPXApMWkwM
Message-ID: <CAGsJ_4zSCkDGzvpaBGAqnUSQSWx2ikmrqpihYPBhqdwC-PKDOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] zram: support asynchronous GC for lazy slot freeing
To: Kairui Song <ryncsn@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, chrisl@kernel.org, 
	justinjiang@vivo.com, liulei.rjpt@vivo.com, 
	Xueyuan Chen <xueyuan.chen21@gmail.com>, Wenchao Hao <haowenchao22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 7:48=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sun, Apr 12, 2026 at 02:04:50PM +0800, Barry Song (Xiaomi) wrote:
> > Swap freeing can be expensive when unmapping a VMA containing
> > many swap entries. This has been reported to significantly
> > delay memory reclamation during Android=E2=80=99s low-memory killing,
> > especially when multiple processes are terminated to free
> > memory, with slot_free() accounting for more than 80% of
> > the total cost of freeing swap entries.
> >
> > Two earlier attempts by Lei and Zhiguo added a new thread in the mm cor=
e
> > to asynchronously collect and free swap entries [1][2], but the
> > design itself is fairly complex.
> >
> > When anon folios and swap entries are mixed within a
> > process, reclaiming anon folios from killed processes
> > helps return memory to the system as quickly as possible,
> > so that newly launched applications can satisfy their
> > memory demands. It is not ideal for swap freeing to block
> > anon folio freeing. On the other hand, swap freeing can
> > still return memory to the system, although at a slower
> > rate due to memory compression.
> >
> > Therefore, in zram, we introduce a GC worker to allow anon
> > folio freeing and slot_free to run in parallel, since
> > slot_free is performed asynchronously, maximizing the rate at
> > which memory is returned to the system.
> >
> > Xueyuan=E2=80=99s test on RK3588 shows that unmapping a 256MB swap-fill=
ed
> > VMA becomes 3.4=C3=97 faster when pinning tasks to CPU2, reducing the
> > execution time from 63,102,982 ns to 18,570,726 ns.
> >
> > A positive side effect is that async GC also slightly improves
> > do_swap_page() performance, as it no longer has to wait for
> > slot_free() to complete.
> >
> > Xueyuan=E2=80=99s test shows that swapping in 256MB of data (each page
> > filled with repeating patterns such as =E2=80=9C1024 one=E2=80=9D, =E2=
=80=9C1024 two=E2=80=9D,
> > =E2=80=9C1024 three=E2=80=9D, and =E2=80=9C1024 four=E2=80=9D) reduces =
execution time from
> > 1,358,133,886 ns to 1,104,315,986 ns, achieving a 1.22=C3=97 speedup.
> >
> > [1] https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.=
com/
> > [2] https://lore.kernel.org/all/20250909065349.574894-1-liulei.rjpt@viv=
o.com/
> >
> > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
>
> Hi Barry
>
> This looks an interesting idea to me.
>
> > ---
> >  drivers/block/zram/zram_drv.c | 56 ++++++++++++++++++++++++++++++++++-
> >  drivers/block/zram/zram_drv.h |  3 ++
> >  2 files changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_dr=
v.c
> > index c2afd1c34f4a..f5c07eb997a8 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1958,6 +1958,23 @@ static ssize_t debug_stat_show(struct device *de=
v,
> >       return ret;
> >  }
> >
> > +static void gc_slots_free(struct zram *zram)
> > +{
> > +     size_t num_pages =3D zram->disksize >> PAGE_SHIFT;
> > +     unsigned long index;
> > +
> > +     index =3D find_next_bit(zram->gc_map, num_pages, 0);
> > +     while (index < num_pages) {
> > +             if (slot_trylock(zram, index)) {
> > +                     if (test_bit(index, zram->gc_map))
> > +                             slot_free(zram, index);
> > +                     slot_unlock(zram, index);
> > +                     cond_resched();
> > +             }
> > +             index =3D find_next_bit(zram->gc_map, num_pages, index + =
1);
> > +     }
> > +}
> > +
>
> The ideas looks interesting but the implementation looks not that
> optimal to me. find_next_bit does a O(n) looks up for every gc call
> looks really expensive if the pending slot is at tail.

Agreed. It=E2=80=99s essentially a prototype at this stage to demonstrate t=
he
idea.

>
> Perhaps a percpu stack can be used, something like the folio batch?

I guess a major difference is that folio batching aims to reduce
lruvec lock contention. Once a CPU=E2=80=99s slot space is empty, it batche=
s
draining folios into the lruvec by checking whether some slots can
share the same lock. This procedure is synchronous within
folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);

In our case, we might not want a synchronous procedure, so each CPU
could launch its own workqueue. I=E2=80=99m not sure whether this is actual=
ly
beneficial, as it might trigger the zsmalloc lock contention we are
trying to eliminate.

If we end up wanting to drain all CPUs together, that would make things
quite complex again.

So I guess a hierarchical bitmap, an XArray, or even a simple array
could work. If we cap it at 64MB, the array would be at most 128KB on a
PAGE_SIZE=3D4KB system.

I am CC=E2=80=99ing Wenchao, who may be interested in further measurements
and also involved in a more efficient implementation.

>
> > -     slot_free(zram, index);
> > +     if (!try_slot_lazy_free(zram, index))
> > +             slot_free(zram, index);
>
> What is making this slot_free so costly? zs_free?
>
> >       slot_unlock(zram, index);
> >  }
> >
> > diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_dr=
v.h
> > index 08d1774c15db..1f3ffd79fcb1 100644
> > --- a/drivers/block/zram/zram_drv.h
> > +++ b/drivers/block/zram/zram_drv.h
> > @@ -88,6 +88,7 @@ struct zram_stats {
> >       atomic64_t pages_stored;        /* no. of pages currently stored =
*/
> >       atomic_long_t max_used_pages;   /* no. of maximum pages stored */
> >       atomic64_t miss_free;           /* no. of missed free */
> > +     atomic64_t gc_slots;            /* no. of queued for lazy free by=
 gc */
>
> Maybe we want to track the size of content being delayed instead
> of slots number? I saw there is a 30000 hard limit for that.

Yep, definitely we want size, not number of pages, since PAGE_SIZE
is not constant.

>
> Perhaps it will make more sense if we have a "buffer size"
> (e.g. 64M), seems more intuitive to me. e.g. the ZRAM module can occupy
> at most 64M of memory, so the delayed free won't cause a significant
> global pressure.
>
> Also I think this patch is batching the memory free operations, so the
> workqueue or design can also be further optimized for batching, for
> example if the zs_free is the expensive part then maybe we shall just
> clear the handler for the freeing slot and leave the handler in a
> percpu stack, then batch free these handlers. zsmalloc might make
> use some batch optimization based on that too, something like
> kmem_cache_free_bulk but for zsmalloc?

I=E2=80=99m not really sure a per-CPU approach is the right direction, sinc=
e
zsmalloc already has a lot of contention we may want to eliminate. If
we introduce per-CPU workqueues or similar mechanisms, we might end up
increasing contention rather than reducing it.

A kmem_cache_free_bulk()-like approach might be a good direction to
investigate for zsmalloc. I guess Xueyuan is also thinking about it?
Right now, zsmalloc frequently takes and releases multiple locks for
each individual.

>
> if zs_free is not all the expensive part, I took a look at slot_free
> maybe a lot of read / write of slot data can be merged.
>
> This patch currently doesn't reduce the total amount of work, but
> if above idea works, a lot of redundant operations might be be dropped,
> result in better performance in every case.

Yep, hopefully we can optimize for every case. Of course, that will
take a lot of time :-)

>
> Just my two cents and ideas, not sure if I got everything correct.
> Looking forward for more disscussion on this :)

Thanks for your suggestions=E2=80=94they are always welcome. We may
discuss this further.

Best Regards
Barry
