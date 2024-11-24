Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767CD2500BA
	for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732484845; cv=none; b=Vxe3xAzHy9aCSw8yeV2DtwbA0Pl1Re/XbHDE1X7LXQA0mpcvr+XQhg51EKPxdQkDpd4Oo84tSFq6UVetiA9WD6vVko6zEAJ1uVyGnKiFcg5Q/SF2RmDwFZjmzflfan2NgTJdSBi78sdjZOwXFs+Hr2rgQ/ik4FOYdhR61enTIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732484845; c=relaxed/simple;
	bh=KsAK9rs9Xbh42LL2LV2GYZ8OYISsWgvODdAH6QK1ADI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMjPCbv8lEFovdO0RjWyYJlfbi14BItpGuuc7JKev859FYRZk2Jw3WNYTMKyNAP0nAl+FrnWIwbNcAu1tIV1UbDFR3/r4aVv8SOSjodIMveekJXRaTg1lcEZmfqU/Hp1vqRqyi7y1CBJiytjZBuZadmVVH6cEHr4EG1+4pM1w4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S13uqz2x; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S13uqz2x"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4af1578d288so178284137.3
        for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732484842; x=1733089642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eu0TB/V7oqFEe+lDchGLszfbJsxC0JpZQV7RTnBmzBc=;
        b=S13uqz2xAWQSvVfwoMCjq+Oj3owNZDWI1/hOFE2kyc3bddjO/b8X7itf2+vep/LWwO
         Ft2RQFmyqS5W50tInSbpNgxbswpd5ntJ9pc54OgPeyNu+SN726y/ozajE/yuAoAAE+oR
         NY7/01Od1On+e+yzhGx9/8aMAmrASFf0BhECtAz1DAVccVJGaRbi7z9+CX6P2Mt82/QO
         tDhNwIUTD+QZxtybl58XeTgQ1nvIvDbS5fr9VY3FecptaA/EjZ7Hd2JTA0NgywH150p0
         KWqQfqpB3MBYl8NoB08tEGYMBV7XVNzCoxZJzGk0mneDrAwURSgw8fOEpbdsxToq1WiW
         IYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732484842; x=1733089642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu0TB/V7oqFEe+lDchGLszfbJsxC0JpZQV7RTnBmzBc=;
        b=M66MSNzV8ELTozfcL0tkpLqu/oyG2kWIMTP7gzQbgWkHCnX5IOulk2bG2mzbRAPz/t
         9H/3bvBsLb7XKBh5j/ZlTu+n74KafRSovrVKG7kRvPKw3Tz7umbGOQr0elMIfzThCXWl
         RKsBoRBWcVMc1vXDECrVMu0ZHzqdveMmW2A+JBSUohbmd5jwkdvT7jjhNmQimKeXv0xJ
         m0nQYZS6z3FKPGBvflCvidsvy5SGH/bcr0gR+/ztDbYQXaIHsTtrX5yutErq7h1KpopW
         1Rgl0JVHKCGzzY9Rw8E1CsB0Uwf2VpVYTpIOjVYNpyijQC8GyFtSuWKaN/HVWFqWyc4K
         fyRA==
X-Forwarded-Encrypted: i=1; AJvYcCUdT4iMor3bYwNt+SNsk8coNUGO4VzIrM43bKufdmqGlEeF0aTaarS/4n4bZ4AjJCMV+rPcbWPUd+QsjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1c+vdq+VMr+1mpYEwkhOROlLuljqRC15MuS9unRL9cs6UrbQD
	Bx1RBKHwsZsS90Ivu/wZazial7ctWt+rKOJjtTi1eboJe2xmGXBsqb05eB8aEaR8mnyl5yAUHNB
	2a58YIVgZySSa2xrwwTlNRZ0Qbyg=
X-Gm-Gg: ASbGncuW+o9hXviUNdnttsrcMuEQOKRLWiH9M/4reHBAKjaMbilVNnw725/bibC5MBK
	0J3Lpwxbn/+nHyS1crYpe2yTtkvFYjpH6ckShPedOi7fKPoSKaET33/IoWpj/++YPgA==
X-Google-Smtp-Source: AGHT+IEPN2NNNSrJpEn/f5lFWsbUf0DODZzY9QjggEOm3fcnwsgl+2tZVf7A+UwS/bHkvIWRhU7NgPSQ0dbUrlAqqEQ=
X-Received: by 2002:a05:6102:358c:b0:4a4:781f:167e with SMTP id
 ada2fe7eead31-4addcc83b71mr10928936137.16.1732484842183; Sun, 24 Nov 2024
 13:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121222521.83458-1-21cnbao@gmail.com> <20241121222521.83458-5-21cnbao@gmail.com>
 <24f7d8a0-ab92-4544-91dd-5241062aad23@gmail.com>
In-Reply-To: <24f7d8a0-ab92-4544-91dd-5241062aad23@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 25 Nov 2024 10:47:11 +1300
Message-ID: <CAGsJ_4wL=CgXdCt+2QC+aSKPh1873QyD_4ZkRSBniUipKX9AVA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/4] mm: fall back to four small folios if mTHP
 allocation fails
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com, 
	ryan.roberts@arm.com, senozhatsky@chromium.org, surenb@google.com, 
	terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com, 
	Chuanhua Han <chuanhuahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 3:54=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 21/11/2024 22:25, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The swapfile can compress/decompress at 4 * PAGES granularity, reducing
> > CPU usage and improving the compression ratio. However, if allocating a=
n
> > mTHP fails and we fall back to a single small folio, the entire large
> > block must still be decompressed. This results in a 16 KiB area requiri=
ng
> > 4 page faults, where each fault decompresses 16 KiB but retrieves only
> > 4 KiB of data from the block. To address this inefficiency, we instead
> > fall back to 4 small folios, ensuring that each decompression occurs
> > only once.
> >
> > Allowing swap_read_folio() to decompress and read into an array of
> > 4 folios would be extremely complex, requiring extensive changes
> > throughout the stack, including swap_read_folio, zeromap,
> > zswap, and final swap implementations like zRAM. In contrast,
> > having these components fill a large folio with 4 subpages is much
> > simpler.
> >
> > To avoid a full-stack modification, we introduce a per-CPU order-2
> > large folio as a buffer. This buffer is used for swap_read_folio(),
> > after which the data is copied into the 4 small folios. Finally, in
> > do_swap_page(), all these small folios are mapped.
> >
> > Co-developed-by: Chuanhua Han <chuanhuahan@gmail.com>
> > Signed-off-by: Chuanhua Han <chuanhuahan@gmail.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/memory.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 192 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 209885a4134f..e551570c1425 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4042,6 +4042,15 @@ static struct folio *__alloc_swap_folio(struct v=
m_fault *vmf)
> >       return folio;
> >  }
> >
> > +#define BATCH_SWPIN_ORDER 2
>
> Hi Barry,
>
> Thanks for the series and the numbers in the cover letter.
>
> Just a few things.
>
> Should BATCH_SWPIN_ORDER be ZSMALLOC_MULTI_PAGES_ORDER instead of 2?

Technically, yes. I'm also considering removing ZSMALLOC_MULTI_PAGES_ORDER
and always setting it to 2, which is the minimum anonymous mTHP order.  The=
 main
reason is that it may be difficult for users to select the appropriate Kcon=
fig?

On the other hand, 16KB provides the most advantages for zstd compression a=
nd
decompression with larger blocks. While increasing from 16KB to 32KB or 64K=
B
can offer additional benefits, the improvement is not as significant
as the jump from
4KB to 16KB.

As I use zstd to compress and decompress the 'Beyond Compare' software
package:

root@barry-desktop:~# ./zstd
File size: 182502912 bytes
4KB Block: Compression time =3D 0.765915 seconds, Decompression time =3D
0.203366 seconds
  Original size: 182502912 bytes
  Compressed size: 66089193 bytes
  Compression ratio: 36.21%
16KB Block: Compression time =3D 0.558595 seconds, Decompression time =3D
0.153837 seconds
  Original size: 182502912 bytes
  Compressed size: 59159073 bytes
  Compression ratio: 32.42%
32KB Block: Compression time =3D 0.538106 seconds, Decompression time =3D
0.137768 seconds
  Original size: 182502912 bytes
  Compressed size: 57958701 bytes
  Compression ratio: 31.76%
64KB Block: Compression time =3D 0.532212 seconds, Decompression time =3D
0.127592 seconds
  Original size: 182502912 bytes
  Compressed size: 56700795 bytes
  Compression ratio: 31.07%

In that case, would we no longer need to rely on ZSMALLOC_MULTI_PAGES_ORDER=
?

>
> Did you check the performance difference with and without patch 4?

I retested after reverting patch 4, and the sys time increased to over
40 minutes
again, though it was slightly better than without the entire series.

*** Executing round 1 ***

real 7m49.342s
user 80m53.675s
sys 42m28.393s
pswpin: 29965548
pswpout: 51127359
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11347712
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6641230
pgpgin: 147376000
pgpgout: 213343124

*** Executing round 2 ***

real 7m41.331s
user 81m16.631s
sys 41m39.845s
pswpin: 29208867
pswpout: 50006026
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11104912
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6483827
pgpgin: 144057340
pgpgout: 208887688


*** Executing round 3 ***

real 7m47.280s
user 78m36.767s
sys 37m32.210s
pswpin: 26426526
pswpout: 45420734
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 10104304
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 5884839
pgpgin: 132013648
pgpgout: 190537264

*** Executing round 4 ***

real 7m56.723s
user 80m36.837s
sys 41m35.979s
pswpin: 29367639
pswpout: 50059254
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 11116176
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6514064
pgpgin: 144593828
pgpgout: 209080468

*** Executing round 5 ***

real 7m53.806s
user 80m30.953s
sys 40m14.870s
pswpin: 28091760
pswpout: 48495748
64kB-swpout: 0
32kB-swpout: 0
16kB-swpout: 10779720
64kB-swpin: 0
32kB-swpin: 0
16kB-swpin: 6244819
pgpgin: 138813124
pgpgout: 202885480

I guess it is due to the occurrence of numerous partial reads
(about 10%, 3505537/35159852).

root@barry-desktop:~# cat /sys/block/zram0/multi_pages_debug_stat

zram_bio write/read multi_pages count:54452828 35159852
zram_bio failed write/read multi_pages count       0        0
zram_bio partial write/read multi_pages count       4  3505537
multi_pages_miss_free        0

This workload doesn't cause fragmentation in the buddy allocator, so it=E2=
=80=99s
likely due to the failure of MEMCG_CHARGE.

>
> I know that it wont help if you have a lot of unmovable pages
> scattered everywhere, but were you able to compare the performance
> of defrag=3Dalways vs patch 4? I feel like if you have space for 4 folios
> then hopefully compaction should be able to do its job and you can
> directly fill the large folio if the unmovable pages are better placed.
> Johannes' series on preventing type mixing [1] would help.
>
> [1] https://lore.kernel.org/all/20240320180429.678181-1-hannes@cmpxchg.or=
g/

I believe this could help, but defragmentation is a complex issue. Especial=
ly on
phones, where various components like drivers, DMA-BUF, multimedia, and
graphics utilize memory.

We observed that a fresh system could initially provide mTHP, but after a f=
ew
hours, obtaining mTHP became very challenging. I'm happy to arrange a test
of Johannes' series on phones (sometimes it is quite hard to backport to th=
e
Android kernel) to see if it brings any improvements.

>
> Thanks,
> Usama
>
> > +#define BATCH_SWPIN_COUNT (1 << BATCH_SWPIN_ORDER)
> > +#define BATCH_SWPIN_SIZE (PAGE_SIZE << BATCH_SWPIN_ORDER)
> > +
> > +struct batch_swpin_buffer {
> > +     struct folio *folio;
> > +     struct mutex mutex;
> > +};
> > +
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> >  {
> > @@ -4120,7 +4129,101 @@ static inline unsigned long thp_swap_suitable_o=
rders(pgoff_t swp_offset,
> >       return orders;
> >  }
> >
> > -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > +static DEFINE_PER_CPU(struct batch_swpin_buffer, swp_buf);
> > +
> > +static int __init batch_swpin_buffer_init(void)
> > +{
> > +     int ret, cpu;
> > +     struct batch_swpin_buffer *buf;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             buf =3D per_cpu_ptr(&swp_buf, cpu);
> > +             buf->folio =3D (struct folio *)alloc_pages_node(cpu_to_no=
de(cpu),
> > +                             GFP_KERNEL | __GFP_COMP, BATCH_SWPIN_ORDE=
R);
> > +             if (!buf->folio) {
> > +                     ret =3D -ENOMEM;
> > +                     goto err;
> > +             }
> > +             mutex_init(&buf->mutex);
> > +     }
> > +     return 0;
> > +
> > +err:
> > +     for_each_possible_cpu(cpu) {
> > +             buf =3D per_cpu_ptr(&swp_buf, cpu);
> > +             if (buf->folio) {
> > +                     folio_put(buf->folio);
> > +                     buf->folio =3D NULL;
> > +             }
> > +     }
> > +     return ret;
> > +}
> > +core_initcall(batch_swpin_buffer_init);
> > +
> > +static struct folio *alloc_batched_swap_folios(struct vm_fault *vmf,
> > +             struct batch_swpin_buffer **buf, struct folio **folios,
> > +             swp_entry_t entry)
> > +{
> > +     unsigned long haddr =3D ALIGN_DOWN(vmf->address, BATCH_SWPIN_SIZE=
);
> > +     struct batch_swpin_buffer *sbuf =3D raw_cpu_ptr(&swp_buf);
> > +     struct folio *folio =3D sbuf->folio;
> > +     unsigned long addr;
> > +     int i;
> > +
> > +     if (unlikely(!folio))
> > +             return NULL;
> > +
> > +     for (i =3D 0; i < BATCH_SWPIN_COUNT; i++) {
> > +             addr =3D haddr + i * PAGE_SIZE;
> > +             folios[i] =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vm=
f->vma, addr);
> > +             if (!folios[i])
> > +                     goto err;
> > +             if (mem_cgroup_swapin_charge_folio(folios[i], vmf->vma->v=
m_mm,
> > +                                     GFP_KERNEL, entry))
> > +                     goto err;
> > +     }
> > +
> > +     mutex_lock(&sbuf->mutex);
> > +     *buf =3D sbuf;
> > +#ifdef CONFIG_MEMCG
> > +     folio->memcg_data =3D (*folios)->memcg_data;
> > +#endif
> > +     return folio;
> > +
> > +err:
> > +     for (i--; i >=3D 0; i--)
> > +             folio_put(folios[i]);
> > +     return NULL;
> > +}
> > +
> > +static void fill_batched_swap_folios(struct vm_fault *vmf,
> > +             void *shadow, struct batch_swpin_buffer *buf,
> > +             struct folio *folio, struct folio **folios)
> > +{
> > +     unsigned long haddr =3D ALIGN_DOWN(vmf->address, BATCH_SWPIN_SIZE=
);
> > +     unsigned long addr;
> > +     int i;
> > +
> > +     for (i =3D 0; i < BATCH_SWPIN_COUNT; i++) {
> > +             addr =3D haddr + i * PAGE_SIZE;
> > +             __folio_set_locked(folios[i]);
> > +             __folio_set_swapbacked(folios[i]);
> > +             if (shadow)
> > +                     workingset_refault(folios[i], shadow);
> > +             folio_add_lru(folios[i]);
> > +             copy_user_highpage(&folios[i]->page, folio_page(folio, i)=
,
> > +                             addr, vmf->vma);
> > +             if (folio_test_uptodate(folio))
> > +                     folio_mark_uptodate(folios[i]);
> > +     }
> > +
> > +     folio->flags &=3D ~(PAGE_FLAGS_CHECK_AT_PREP & ~(1UL << PG_head))=
;
> > +     mutex_unlock(&buf->mutex);
> > +}
> > +
> > +static struct folio *alloc_swap_folio(struct vm_fault *vmf,
> > +             struct batch_swpin_buffer **buf,
> > +             struct folio **folios)
> >  {
> >       struct vm_area_struct *vma =3D vmf->vma;
> >       unsigned long orders;
> > @@ -4180,6 +4283,9 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
> >
> >       pte_unmap_unlock(pte, ptl);
> >
> > +     if (!orders)
> > +             goto fallback;
> > +
> >       /* Try allocating the highest of the remaining orders. */
> >       gfp =3D vma_thp_gfp_mask(vma);
> >       while (orders) {
> > @@ -4194,14 +4300,29 @@ static struct folio *alloc_swap_folio(struct vm=
_fault *vmf)
> >               order =3D next_order(&orders, order);
> >       }
> >
> > +     /*
> > +      * During swap-out, a THP might have been compressed into multipl=
e
> > +      * order-2 blocks to optimize CPU usage and compression ratio.
> > +      * Attempt to batch swap-in 4 smaller folios to ensure they are
> > +      * decompressed together as a single unit only once.
> > +      */
> > +     return alloc_batched_swap_folios(vmf, buf, folios, entry);
> > +
> >  fallback:
> >       return __alloc_swap_folio(vmf);
> >  }
> >  #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> > -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > +static struct folio *alloc_swap_folio(struct vm_fault *vmf,
> > +             struct batch_swpin_buffer **buf,
> > +             struct folio **folios)
> >  {
> >       return __alloc_swap_folio(vmf);
> >  }
> > +static inline void fill_batched_swap_folios(struct vm_fault *vmf,
> > +             void *shadow, struct batch_swpin_buffer *buf,
> > +             struct folio *folio, struct folio **folios)
> > +{
> > +}
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> >  static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> > @@ -4216,6 +4337,8 @@ static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> >   */
> >  vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  {
> > +     struct folio *folios[BATCH_SWPIN_COUNT] =3D { NULL };
> > +     struct batch_swpin_buffer *buf =3D NULL;
> >       struct vm_area_struct *vma =3D vmf->vma;
> >       struct folio *swapcache, *folio =3D NULL;
> >       DECLARE_WAITQUEUE(wait, current);
> > @@ -4228,7 +4351,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       pte_t pte;
> >       vm_fault_t ret =3D 0;
> >       void *shadow =3D NULL;
> > -     int nr_pages;
> > +     int nr_pages, i;
> >       unsigned long page_idx;
> >       unsigned long address;
> >       pte_t *ptep;
> > @@ -4296,7 +4419,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> >                       /* skip swapcache */
> > -                     folio =3D alloc_swap_folio(vmf);
> > +                     folio =3D alloc_swap_folio(vmf, &buf, folios);
> >                       if (folio) {
> >                               __folio_set_locked(folio);
> >                               __folio_set_swapbacked(folio);
> > @@ -4327,10 +4450,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                               mem_cgroup_swapin_uncharge_swap(entry, nr=
_pages);
> >
> >                               shadow =3D get_shadow_from_swap_cache(ent=
ry);
> > -                             if (shadow)
> > +                             if (shadow && !buf)
> >                                       workingset_refault(folio, shadow)=
;
> > -
> > -                             folio_add_lru(folio);
> > +                             if (!buf)
> > +                                     folio_add_lru(folio);
> >
> >                               /* To provide entry to swap_read_folio() =
*/
> >                               folio->swap =3D entry;
> > @@ -4361,6 +4484,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               count_vm_event(PGMAJFAULT);
> >               count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> >               page =3D folio_file_page(folio, swp_offset(entry));
> > +             /*
> > +              * Copy data into batched small folios from the large
> > +              * folio buffer
> > +              */
> > +             if (buf) {
> > +                     fill_batched_swap_folios(vmf, shadow, buf, folio,=
 folios);
> > +                     folio =3D folios[0];
> > +                     page =3D &folios[0]->page;
> > +                     goto do_map;
> > +             }
> >       } else if (PageHWPoison(page)) {
> >               /*
> >                * hwpoisoned dirty swapcache pages are kept for killing
> > @@ -4415,6 +4548,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                       lru_add_drain();
> >       }
> >
> > +do_map:
> >       folio_throttle_swaprate(folio, GFP_KERNEL);
> >
> >       /*
> > @@ -4431,8 +4565,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       }
> >
> >       /* allocated large folios for SWP_SYNCHRONOUS_IO */
> > -     if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
> > -             unsigned long nr =3D folio_nr_pages(folio);
> > +     if ((folio_test_large(folio) || buf) && !folio_test_swapcache(fol=
io)) {
> > +             unsigned long nr =3D buf ? BATCH_SWPIN_COUNT : folio_nr_p=
ages(folio);
> >               unsigned long folio_start =3D ALIGN_DOWN(vmf->address, nr=
 * PAGE_SIZE);
> >               unsigned long idx =3D (vmf->address - folio_start) / PAGE=
_SIZE;
> >               pte_t *folio_ptep =3D vmf->pte - idx;
> > @@ -4527,6 +4661,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               }
> >       }
> >
> > +     /* Batched mapping of allocated small folios for SWP_SYNCHRONOUS_=
IO */
> > +     if (buf) {
> > +             for (i =3D 0; i < nr_pages; i++)
> > +                     arch_swap_restore(swp_entry(swp_type(entry),
> > +                             swp_offset(entry) + i), folios[i]);
> > +             swap_free_nr(entry, nr_pages);
> > +             add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +             add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> > +             rmap_flags |=3D RMAP_EXCLUSIVE;
> > +             for (i =3D 0; i < nr_pages; i++) {
> > +                     unsigned long addr =3D address + i * PAGE_SIZE;
> > +
> > +                     pte =3D mk_pte(&folios[i]->page, vma->vm_page_pro=
t);
> > +                     if (pte_swp_soft_dirty(vmf->orig_pte))
> > +                             pte =3D pte_mksoft_dirty(pte);
> > +                     if (pte_swp_uffd_wp(vmf->orig_pte))
> > +                             pte =3D pte_mkuffd_wp(pte);
> > +                     if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pt=
e_wp(vma, pte) &&
> > +                         !pte_needs_soft_dirty_wp(vma, pte)) {
> > +                             pte =3D pte_mkwrite(pte, vma);
> > +                             if ((vmf->flags & FAULT_FLAG_WRITE) && (i=
 =3D=3D page_idx)) {
> > +                                     pte =3D pte_mkdirty(pte);
> > +                                     vmf->flags &=3D ~FAULT_FLAG_WRITE=
;
> > +                             }
> > +                     }
> > +                     flush_icache_page(vma, &folios[i]->page);
> > +                     folio_add_new_anon_rmap(folios[i], vma, addr, rma=
p_flags);
> > +                     set_pte_at(vma->vm_mm, addr, ptep + i, pte);
> > +                     arch_do_swap_page_nr(vma->vm_mm, vma, addr, pte, =
pte, 1);
> > +                     if (i =3D=3D page_idx)
> > +                             vmf->orig_pte =3D pte;
> > +                     folio_unlock(folios[i]);
> > +             }
> > +             goto wp_page;
> > +     }
> > +
> >       /*
> >        * Some architectures may have to restore extra metadata to the p=
age
> >        * when reading from swap. This metadata may be indexed by swap e=
ntry
> > @@ -4612,6 +4782,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               folio_put(swapcache);
> >       }
> >
> > +wp_page:
> >       if (vmf->flags & FAULT_FLAG_WRITE) {
> >               ret |=3D do_wp_page(vmf);
> >               if (ret & VM_FAULT_ERROR)
> > @@ -4638,9 +4809,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out_page:
> > -     folio_unlock(folio);
> > +     if (!buf) {
> > +             folio_unlock(folio);
> > +     } else {
> > +             for (i =3D 0; i < BATCH_SWPIN_COUNT; i++)
> > +                     folio_unlock(folios[i]);
> > +     }
> >  out_release:
> > -     folio_put(folio);
> > +     if (!buf) {
> > +             folio_put(folio);
> > +     } else {
> > +             for (i =3D 0; i < BATCH_SWPIN_COUNT; i++)
> > +                     folio_put(folios[i]);
> > +     }
> >       if (folio !=3D swapcache && swapcache) {
> >               folio_unlock(swapcache);
> >               folio_put(swapcache);
>

Thanks
Barry
