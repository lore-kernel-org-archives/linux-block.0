Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB2AC47083
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 00:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623286121D
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 00:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhFCAmP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCAmP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 20:42:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9FAC06174A;
        Wed,  2 Jun 2021 17:40:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba2so3343143edb.2;
        Wed, 02 Jun 2021 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CFIdtfCVONeG6gnjlO+gl1YZNVeFMWnZ56hoy0mYJEQ=;
        b=KeHhROLpKkrGKwvKgQLyA9T6sYwrNEtJyLyRcV8sNumGhSxdD0IEfH4hH79vLxSovA
         eutgQmzwKBsX0BpFvyRa7BKSWbn6X9ESDE1HtqQv9FHOjqA8vdkXj+psY1Ngs2sgZors
         /uQRP1k1PrFqYL7w3a3Ora1Noq9uHRcl25+rw62V07yLvDjFniHE0Ci01EeYckJm+iVW
         iu73Sy2Ct3aiRQDMcpCT0EHvRjUfz5RpjjAAA1XNqisMn86v+sS8Q67TqYBcbzU1bqhR
         TfZf+N9bhptrzQbW6iyJbOTYlNpKnqk3DJ4c/Vl9PwJgcTu/DQd6Xo2tQeRLrsML+BCS
         xjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CFIdtfCVONeG6gnjlO+gl1YZNVeFMWnZ56hoy0mYJEQ=;
        b=ZhkdL3P/2aNEljkkCU/cy5pHxvwjkE0jP9iSeHwTrgVIryTQDsHfcLrufGlum1owge
         FxFHbV3R7H8wZ9EIOebFCiOpW+9SAQgXNevNvE+mvRn51+JAlNM0WigHNDWPnXqyAESl
         K0w3tDOLdJaaxpH12UsgJbMwbV5E3bXC0Jer8yRy3ojN400abY7D8CzaSAxW4xB6dFFl
         fGp3SYhu+r3PyVM9P8y8cFJL3AOCmZGFW22FpSlQsZntmKGmtwNLeIhWcZg11sKoA6Sd
         LyJ+SL6AHZggy26kMzc9QV8dQLp97Q6EA/f31yTtissiLv2PL1gtBud3l9KL7N5j6U2n
         38fg==
X-Gm-Message-State: AOAM530HQkV8GWQKhOT0VHVCmd4t477dGLG8CtbpTI/+UFnhz9N2j0e9
        j2ZQEBalunyJaf8GE4ETVnDpSSGBmJr/8vhejZQ=
X-Google-Smtp-Source: ABdhPJwvxS9g5Bxa79K2k7ki8ng5/DvQ4fHh5ABeB9XlJzdUhJTqNnrdDdk7DEkuQ85MrBHMkDqrdU4GjeRnkUdir9w=
X-Received: by 2002:a05:6402:4381:: with SMTP id o1mr42581478edc.188.1622680821319;
 Wed, 02 Jun 2021 17:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOH5QeCiBF8AYsF853YRFw=kKq+7ps_a30qOFwYOwbinYLbUEw@mail.gmail.com>
 <13c28e69-cfd9-bcf6-ab77-445c6fa4cc6e@redhat.com> <CAOH5QeDapb6zsUZK3QA66PNfWJovqR4gWMODnckVdfbvte0Vqg@mail.gmail.com>
 <4350ee16-15d0-1d37-6074-cea5185aac51@redhat.com>
In-Reply-To: <4350ee16-15d0-1d37-6074-cea5185aac51@redhat.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Thu, 3 Jun 2021 08:40:10 +0800
Message-ID: <CAOH5QeBhmBeB-6yytorMtYQ++Vy2zZWgw5C2aM0UxLPRz_eogg@mail.gmail.com>
Subject: Re: [RFC PATCH V1] zram:calculate available memory when zram is used
To:     David Hildenbrand <david@redhat.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's a good suggestion!
I do think SwapAvailable is more reasonable too.
SwapAvailable is corresponded to Available!

I will remake the patch and submit it later.
Thanks very much!

David Hildenbrand <david@redhat.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On 02.06.21 02:06, yong w wrote:
> > Thanks for your reply!
> >
> > Indeed, when zram is not triggered, MemAvalible will be greater than Me=
mtotal.
> > As you said, this modification will have program compatibility issues,
> >   when there
> > are some user space scripts use MemAvailable for calculation.
> >
> > How about providing another proc interface?
> > Such as /proc/xxx, When execute =E2=80=9Ccat /proc/xxx=E2=80=9D, it ret=
urns "available
> > + swapfree - swapfree * compress ratio" value.
>
> Good question. What would be an appropriate name and description for
> this entry?
>
> We do have in /proc/meminfo already:
>
> MemTotal:
> MemAvailable:
> SwapTotal:
> SwapFree:
>
> I wonder if we could add an entry either for "swapfree - swapfree *
> compress" or "swapfree * compress". But even then, I struggle to find a
> fitting name. We could either define something like
>
> "SwapAvailable:" An estimate of how much swap space is available for
> starting new applications. Note that SwapAvailable is different to
> SwapFree when swap compression, as implemented by zram, is being performe=
d.
>
> So a user can compute
>
> "TotalAvailable =3D MemAvailable + SwapAvailable".
>
> or if that doesn't make any sense:
>
> "TotalAvailable:" An estimate of how much memory and swap space is
> available for starting new applications. Usually, the value corresponds
> to "MemAvailable + SwapFree", however, swap compression, as implemented
> by zram, might allow for making more efficient use of free swap space.
>
>
> I'd prefer the first -- if it makes any sense.
>
> You should CC linux-api on follow up patches.
>
> > Thanks in advance=EF=BC=81
> >
> >
> > David Hildenbrand <david@redhat.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:17=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On 30.05.21 19:18, yong w wrote:
> >>> When zram is used, available+Swap free memory is obviously bigger tha=
n
> >>> I actually can use, because zram can compress memory by compression
> >>> algorithm and zram compressed data will occupy memory too.
> >>>
> >>> So, I count the compression rate of zram in the kernel. The available
> >>> memory  is calculated as follows:
> >>> available + swapfree - swapfree * compress ratio
> >>> MemAvailable in /proc/meminfo returns available + zram will save spac=
e
> >>>
> >>
> >> This will mean that we can easily have MemAvailable > MemTotal, right?
> >> I'm not sure if there are some user space scripts that will be a littl=
e
> >> disrupted by that. Like calculating "MemUnavailable =3D MemTotal -
> >> MemAvailable".
> >>
> >> MemAvailable: "An estimate of how much memory is available for startin=
g
> >> new applications, without swapping"
> >>
> >> Although zram isn't "traditional swapping", there is still a performan=
ce
> >> impact when having to go to zram because it adds an indirection and
> >> requires (de)compression. Similar to having very fast swap space (like
> >> PMEM). Let's not call something "memory" that doesn't have the same
> >> semantics as real memory as in "MemTotal".
> >>
> >> This doesn't feel right.
> >>
> >>> Signed-off-by: wangyong <yongw.pur@gmail.com <mailto:yongw.pur@gmail.=
com>>
> >>> ---
> >>>    drivers/block/zram/zcomp.h    |  1 +
> >>>    drivers/block/zram/zram_drv.c |  4 ++
> >>>    drivers/block/zram/zram_drv.h |  1 +
> >>>    fs/proc/meminfo.c             |  2 +-
> >>>    include/linux/swap.h          | 10 +++++
> >>>    mm/swapfile.c                 | 95
> >>> +++++++++++++++++++++++++++++++++++++++++++
> >>>    mm/vmscan.c                   |  1 +
> >>>    7 files changed, 113 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
> >>> index 40f6420..deb2dbf 100644
> >>> --- a/drivers/block/zram/zcomp.h
> >>> +++ b/drivers/block/zram/zcomp.h
> >>> @@ -40,4 +40,5 @@ int zcomp_decompress(struct zcomp_strm *zstrm,
> >>>     const void *src, unsigned int src_len, void *dst);
> >>>
> >>>    bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
> >>> +int get_zram_major(void);
> >>>    #endif /* _ZCOMP_H_ */
> >>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_=
drv.c
> >>> index cf8deec..1c6cbd4 100644
> >>> --- a/drivers/block/zram/zram_drv.c
> >>> +++ b/drivers/block/zram/zram_drv.c
> >>> @@ -59,6 +59,10 @@ static void zram_free_page(struct zram *zram, size=
_t
> >>> index);
> >>>    static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
> >>>     u32 index, int offset, struct bio *bio);
> >>>
> >>> +int get_zram_major(void)
> >>> +{
> >>> + return zram_major;
> >>> +}
> >>>
> >>>    static int zram_slot_trylock(struct zram *zram, u32 index)
> >>>    {
> >>> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_=
drv.h
> >>> index 6e73dc3..5d8701a 100644
> >>> --- a/drivers/block/zram/zram_drv.h
> >>> +++ b/drivers/block/zram/zram_drv.h
> >>> @@ -88,6 +88,7 @@ struct zram_stats {
> >>>     atomic64_t bd_reads; /* no. of reads from backing device */
> >>>     atomic64_t bd_writes; /* no. of writes from backing device */
> >>>    #endif
> >>> + atomic_t min_compr_ratio;
> >>>    };
> >>>
> >>>    struct zram {
> >>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> >>> index 6fa761c..f7bf350 100644
> >>> --- a/fs/proc/meminfo.c
> >>> +++ b/fs/proc/meminfo.c
> >>> @@ -57,7 +57,7 @@ static int meminfo_proc_show(struct seq_file *m, vo=
id *v)
> >>>
> >>>     show_val_kb(m, "MemTotal:       ", i.totalram);
> >>>     show_val_kb(m, "MemFree:        ", i.freeram);
> >>> - show_val_kb(m, "MemAvailable:   ", available);
> >>> + show_val_kb(m, "MemAvailable:   ", available + count_avail_swaps())=
;
> >>>     show_val_kb(m, "Buffers:        ", i.bufferram);
> >>>     show_val_kb(m, "Cached:         ", cached);
> >>>     show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
> >>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> index 032485e..3225a2f 100644
> >>> --- a/include/linux/swap.h
> >>> +++ b/include/linux/swap.h
> >>> @@ -514,6 +514,8 @@ extern int init_swap_address_space(unsigned int
> >>> type, unsigned long nr_pages);
> >>>    extern void exit_swap_address_space(unsigned int type);
> >>>    extern struct swap_info_struct *get_swap_device(swp_entry_t entry)=
;
> >>>    sector_t swap_page_sector(struct page *page);
> >>> +extern void update_zram_zstats(void);
> >>> +extern u64 count_avail_swaps(void);
> >>>
> >>>    static inline void put_swap_device(struct swap_info_struct *si)
> >>>    {
> >>> @@ -684,6 +686,14 @@ static inline swp_entry_t get_swap_page(struct p=
age
> >>> *page)
> >>>     return entry;
> >>>    }
> >>>
> >>> +void update_zram_zstats(void)
> >>> +{
> >>> +}
> >>> +
> >>> +u64 count_avail_swaps(void)
> >>> +{
> >>> +}
> >>> +
> >>>    #endif /* CONFIG_SWAP */
> >>>
> >>>    #ifdef CONFIG_THP_SWAP
> >>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>> index cbb4c07..93a9dcb 100644
> >>> --- a/mm/swapfile.c
> >>> +++ b/mm/swapfile.c
> >>> @@ -44,6 +44,7 @@
> >>>    #include <asm/tlbflush.h>
> >>>    #include <linux/swapops.h>
> >>>    #include <linux/swap_cgroup.h>
> >>> +#include "../drivers/block/zram/zram_drv.h"
> >>>
> >>>    static bool swap_count_continued(struct swap_info_struct *, pgoff_=
t,
> >>>     unsigned char);
> >>> @@ -3408,6 +3409,100 @@ SYSCALL_DEFINE2(swapon, const char __user *,
> >>> specialfile, int, swap_flags)
> >>>     return error;
> >>>    }
> >>>
> >>> +u64 count_avail_swap(struct swap_info_struct *si)
> >>> +{
> >>> + u64 result;
> >>> + struct zram *z;
> >>> + unsigned int free;
> >>> + unsigned int ratio;
> >>> +
> >>> + result =3D 0;
> >>> + if (!si)
> >>> + return 0;
> >>> +
> >>> + //zram calculate available mem
> >>> + if (si->flags & SWP_USED && si->swap_map) {
> >>> + if (si->bdev->bd_disk->major =3D=3D get_zram_major()) {
> >>> + z =3D (struct zram *)si->bdev->bd_disk->private_data;
> >>> + down_read(&z->init_lock);
> >>> + ratio =3D atomic_read(&z->stats.min_compr_ratio);
> >>> + free =3D (si->pages << (PAGE_SHIFT - 10))
> >>> + - (si->inuse_pages << (PAGE_SHIFT - 10));
> >>> + if (!ratio)
> >>> + result +=3D free / 2;
> >>> + else
> >>> + result =3D free * (100 - 10000 / ratio) / 100;
> >>> + up_read(&z->init_lock);
> >>> + }
> >>> + } else
> >>> + result +=3D (si->pages << (PAGE_SHIFT - 10))
> >>> + - (si->inuse_pages << (PAGE_SHIFT - 10));
> >>> +
> >>> + return result;
> >>> +}
> >>> +
> >>> +u64 count_avail_swaps(void)
> >>> +{
> >>> + int type;
> >>> + u64 result;
> >>> + struct swap_info_struct *si;
> >>> +
> >>> + result =3D 0;
> >>> + spin_lock(&swap_lock);
> >>> + for (type =3D 0; type < nr_swapfiles; type++) {
> >>> + si =3D swap_info[type];
> >>> + spin_lock(&si->lock);
> >>> + result +=3D count_avail_swap(si);
> >>> + spin_unlock(&si->lock);
> >>> + }
> >>> + spin_unlock(&swap_lock);
> >>> +
> >>> + return result;
> >>> +}
> >>> +
> >>> +void update_zram_zstat(struct swap_info_struct *si)
> >>> +{
> >>> + struct zram *z;
> >>> + struct zram_stats *stat;
> >>> + int ratio;
> >>> + u64 orig_size, compr_data_size;
> >>> +
> >>> + if (!si)
> >>> + return;
> >>> +
> >>> + //update zram min compress ratio
> >>> + if (si->flags & SWP_USED && si->swap_map) {
> >>> + if (si->bdev->bd_disk->major =3D=3D get_zram_major()) {
> >>> + z =3D (struct zram *)si->bdev->bd_disk->private_data;
> >>> + down_read(&z->init_lock);
> >>> + stat =3D &z->stats;
> >>> + ratio =3D atomic_read(&stat->min_compr_ratio);
> >>> + orig_size =3D atomic64_read(&stat->pages_stored) << PAGE_SHIFT;
> >>> + compr_data_size =3D atomic64_read(&stat->compr_data_size);
> >>> + if (compr_data_size && (!ratio
> >>> +     || ((orig_size * 100) / compr_data_size < ratio)))
> >>> + atomic_set(&stat->min_compr_ratio,
> >>> +    (orig_size * 100) / compr_data_size);
> >>> + up_read(&z->init_lock);
> >>> + }
> >>> + }
> >>> +}
> >>> +
> >>> +void update_zram_zstats(void)
> >>> +{
> >>> + int type;
> >>> + struct swap_info_struct *si;
> >>> +
> >>> + spin_lock(&swap_lock);
> >>> + for (type =3D 0; type < nr_swapfiles; type++) {
> >>> + si =3D swap_info[type];
> >>> + spin_lock(&si->lock);
> >>> + update_zram_zstat(si);
> >>> + spin_unlock(&si->lock);
> >>> + }
> >>> + spin_unlock(&swap_lock);
> >>> +}
> >>> +
> >>>    void si_swapinfo(struct sysinfo *val)
> >>>    {
> >>>     unsigned int type;
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index eb31452..ffaf59b 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -4159,6 +4159,7 @@ static int kswapd(void *p)
> >>>     alloc_order);
> >>>     reclaim_order =3D balance_pgdat(pgdat, alloc_order,
> >>>     highest_zoneidx);
> >>> + update_zram_zstats();
> >>>     if (reclaim_order < alloc_order)
> >>>     goto kswapd_try_sleep;
> >>>     }
> >>> --
> >>> 2.7.4
> >>
> >>
> >> --
> >> Thanks,
> >>
> >> David / dhildenb
> >>
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>
