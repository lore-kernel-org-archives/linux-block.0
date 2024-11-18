Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7511E1311
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963114; cv=none; b=Y09gcIqTjJn8FQBayOjpAReQK6u4A7T1CwXrk/Nw0kK6G8uNuGCIwHZ5Y1vh0XLHcN295KGe680WKUnssvpy/XQYwW5r16ORJAvBn7MJChzR+c9R4PCWJE5A14Sf5V51CdsjrgBammTnEEotF0kaC2OhQcRH42fgXTwlLKRt7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963114; c=relaxed/simple;
	bh=p+GDErgzw0Glr0Xn64o8gbqsyGweQdFNYhOKf49v164=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0/KQu0Sy1WGrC3JVPFAgilOehAQlzKt2Q9O3/tuaD0rTMi+yczi/hxlVhAWmmM9q7v4XxgErTwQLiAjOMEcfEpEb4fQFbR9PSaMLf5cpmJF8+myfFrMXtXsz0rYKBOkd9pECKqkqv37p9pwsAOExm1+clTWHPLsapaGTuoFHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqjJvRhf; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqjJvRhf"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5148381f2a4so69383e0c.2
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731963111; x=1732567911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5Sci9h+K/0i3HCnejYDAVxJjCkyXJeFe1d7FNheC8g=;
        b=fqjJvRhfnvUWhsP5aVx01s+Ya42dOgTRu+o5BT2QxOBqyrZHPe3YiibNRNNyC0Ltm1
         Hb17Ks5fEtTNP/LcBLu0O9Do1yVHMkouQ41kY9meHdWSEd8pzYSwZzJCLLy14w947f/W
         4xdKOntdxbHRLeYElBGGPGj+H8hoZC6K1DOYG9bAzbRZvn3w94zVX96DNfDWAl5DKEAm
         s1bwXJsiUFBksLfhAIt1fOlFvd68Mijh0YoixDxr3SHucSEmscHKRhPW1EKbzL/PZh6N
         jV9zVdyCp1Rh/+4fvb/S5d7DCuEw8NvNPjd6FjpPVdHeor7ortW3gaq/6nQnDeEXGDf6
         rKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963111; x=1732567911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5Sci9h+K/0i3HCnejYDAVxJjCkyXJeFe1d7FNheC8g=;
        b=S78RHa5pTBecRF7bGqpfeBELIbGMhRmzrGhxA3eoTjPZz7UzrWvq8bPMtuQ8mzpaFs
         J410ryXx5/J6wU4moqRtQV3Fz6RFquBiuXJK35pIAeCnM1r7akw9HetD5lEStpxLHQQt
         aAC6blwTos9+zcniNCIHgyqUf4u0q/qLNXPo1AqsuaVdj4fZJy++sIk3gGvpaB6pPzV/
         XyGxeeIs0x+QFULHfb0JUb6Io5vYqmcOeP2S+cAt/LY9hWP0fWV1xGORtSk7MGTFd248
         s88cqAzee8wKXNt3W6AyYLcWTqxKTOUOVcsnN5e4fy8J2hcXE+JE97K+1MJ63US8LQFQ
         9PBw==
X-Forwarded-Encrypted: i=1; AJvYcCVnXmrbHPtXrPXARWF4VS8zzgD958HZ/qaRAwmV7N2aY+dJBovLqarv3vaCF9LRGpjsFE8nSCoUtwLb4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6rcDmzSIr4wmP8jx9QTZHEezkwN/sHwEtNA3WSZULFfLAyB7
	d0YP42kYy+d2VM8w5Llk6kw2j+pYJLmGQmK4ct77OYqjbGYK02F51h7eeG0RlmS//v1itt3GPAf
	4+FaAQreZZDXRL2CTI9QCJrIuBC4=
X-Google-Smtp-Source: AGHT+IFieKajStEKf2n2UwIPjmS1IcNu4189Paql8tM6RsHz94Jv8rUKUwOZi9m33ukBlZ1Cr//UqUWMM0LIvzXg/k8=
X-Received: by 2002:a05:6122:1787:b0:50d:85d7:d94b with SMTP id
 71dfb90a1353d-514786d3b56mr11349794e0c.11.1731963111290; Mon, 18 Nov 2024
 12:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
 <CAGsJ_4y+DeCo7oF+Ty8x9rHreh9LaS9XDU85yz81U9FQgBYE8A@mail.gmail.com>
 <CAGsJ_4zojYeEqgTcH-sKek9LW0pYOUoXcrzOzjoMuzMMODujbA@mail.gmail.com> <92b25b7b-63e8-4eb1-b2a6-9c221de2b7e4@gmail.com>
In-Reply-To: <92b25b7b-63e8-4eb1-b2a6-9c221de2b7e4@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Nov 2024 09:51:40 +1300
Message-ID: <CAGsJ_4w7bpQ+20jEQ2stmoS_Y+MWcP40i6CrgdzuS=r6uq8VyA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, ying.huang@intel.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, bala.seshasayee@linux.intel.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, 
	kanchana.p.sridhar@intel.com, kasong@tencent.com, linux-block@vger.kernel.org, 
	minchan@kernel.org, senozhatsky@chromium.org, surenb@google.com, 
	terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com, 
	zhengtangquan@oppo.com, zhouchengming@bytedance.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 9:29=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 18/11/2024 02:27, Barry Song wrote:
> > On Tue, Nov 12, 2024 at 10:37=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>
> >> On Tue, Nov 12, 2024 at 8:30=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> >>>
> >>> On Thu, Nov 7, 2024 at 2:10=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>>>
> >>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> When large folios are compressed at a larger granularity, we observe
> >>>> a notable reduction in CPU usage and a significant improvement in
> >>>> compression ratios.
> >>>>
> >>>> mTHP's ability to be swapped out without splitting and swapped back =
in
> >>>> as a whole allows compression and decompression at larger granularit=
ies.
> >>>>
> >>>> This patchset enhances zsmalloc and zram by adding support for divid=
ing
> >>>> large folios into multi-page blocks, typically configured with a
> >>>> 2-order granularity. Without this patchset, a large folio is always
> >>>> divided into `nr_pages` 4KiB blocks.
> >>>>
> >>>> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> >>>> setting, where the default of 2 allows all anonymous THP to benefit.
> >>>>
> >>>> Examples include:
> >>>> * A 16KiB large folio will be compressed and stored as a single 16Ki=
B
> >>>>   block.
> >>>> * A 64KiB large folio will be compressed and stored as four 16KiB
> >>>>   blocks.
> >>>>
> >>>> For example, swapping out and swapping in 100MiB of typical anonymou=
s
> >>>> data 100 times (with 16KB mTHP enabled) using zstd yields the follow=
ing
> >>>> results:
> >>>>
> >>>>                         w/o patches        w/ patches
> >>>> swap-out time(ms)       68711              49908
> >>>> swap-in time(ms)        30687              20685
> >>>> compression ratio       20.49%             16.9%
> >>>
> >>> The data looks very promising :) My understanding is it also results
> >>> in memory saving as well right? Since zstd operates better on bigger
> >>> inputs.
> >>>
> >>> Is there any end-to-end benchmarking? My intuition is that this patch
> >>> series overall will improve the situations, assuming we don't fallbac=
k
> >>> to individual zero order page swapin too often, but it'd be nice if
> >>> there is some data backing this intuition (especially with the
> >>> upstream setup, i.e without any private patches). If the fallback
> >>> scenario happens frequently, the patch series can make a page fault
> >>> more expensive (since we have to decompress the entire chunk, and
> >>> discard everything but the single page being loaded in), so it might
> >>> make a difference.
> >>>
> >>> Not super qualified to comment on zram changes otherwise - just a
> >>> casual observer to see if we can adopt this for zswap. zswap has the
> >>> added complexity of not supporting THP zswap in (until Usama's patch
> >>> series lands), and the presence of mixed backing states (due to zswap
> >>> writeback), increasing the likelihood of fallback :)
> >>
> >> Correct. As I mentioned to Usama[1], this could be a problem, and we a=
re
> >> collecting data. The simplest approach to work around the issue is to =
fall
> >> back to four small folios instead of just one, which would prevent the=
 need
> >> for three extra decompressions.
> >>
> >> [1] https://lore.kernel.org/linux-mm/CAGsJ_4yuZLOE0_yMOZj=3DKkRTyTotHw=
4g5g-t91W=3DMvS5zA4rYw@mail.gmail.com/
> >>
> >
> > Hi Nhat, Usama, Ying,
> >
> > I committed to providing data for cases where large folio allocation fa=
ils and
> > swap-in falls back to swapping in small folios. Here is the data that T=
angquan
> > helped collect:
> >
> > * zstd, 100MB typical anon memory swapout+swapin 100times
> >
> > 1. 16kb mTHP swapout + 16kb mTHP swapin + w/o zsmalloc large block
> > (de)compression
> > swap-out(ms) 63151
> > swap-in(ms)  31551
> > 2. 16kb mTHP swapout + 16kb mTHP swapin + w/ zsmalloc large block
> > (de)compression
> > swap-out(ms) 43925
> > swap-in(ms)  21763
> > 3. 16kb mTHP swapout + 100% fallback to small folios swap-in + w/
> > zsmalloc large block (de)compression
> > swap-out(ms) 43423
> > swap-in(ms)   68660
> >
>
> Hi Barry,
>
> Thanks for the numbers!
>
> In what condition was it falling back to small folios. Did you just added=
 a hack
> in alloc_swap_folio to just jump to fallback? or was it due to cgroup lim=
ited memory
> pressure?

In real scenarios, even without memcg, fallbacks mainly occur due to memory
fragmentation, which prevents the allocation of mTHP (contiguous pages) fro=
m
the buddy system. While cgroup memory pressure isn't the primary issue here=
,
it can also contribute to fallbacks.

Note that this fallback occurs universally for both do_anonymous_page() and
filesystem mTHP.

>
> Would it be good to test with something like kernel build test (or someth=
ing else that
> causes swap thrashing) to see if the regression worsens with large granul=
arity decompression?
> i.e. would be good to have numbers for real world applications.

I=E2=80=99m confident that the data will be reliable as long as memory isn=
=E2=80=99t fragmented,
but fragmentation depends on when the case is run. For example, on a fresh
system, memory is not fragmented at all, but after running various workload=
s
for a few hours, serious fragmentation may occur.

I recall reporting that a phone using 64KB mTHP had a high mTHP allocation
success rate in the first hour, but this dropped to less than 10% after a f=
ew
hours of use.

In my understanding, the performance of mTHP can vary significantly dependi=
ng
on the system's fragmentation state. This is why efforts like Yu Zhao's TAO=
 are
being developed to address the mTHP allocation success rate issue.

>
> > Thus, "swap-in(ms) 68660," where mTHP allocation always fails, is signi=
ficantly
> > slower than "swap-in(ms) 21763," where mTHP allocation succeeds.
> >
> > If there are no objections, I could send a v3 patch to fall back to 4
> > small folios
> > instead of one. However, this would significantly increase the complexi=
ty of
> > do_swap_page(). My gut feeling is that the added complexity might not b=
e
> > well-received :-)
> >
>
> If there is space for 4 small folios, then maybe it might be worth passin=
g
> __GFP_DIRECT_RECLAIM? as that can trigger compaction and give a large fol=
io.
>

Small folios are always much *easier* to obtain from the system.
Triggering compaction
won't necessarily yield a large folio if unmovable small folios are scatter=
ed.

For small folios, reclamation is already the case for memcg. as a small fol=
io
is charged by GFP_KERNEL as it was before.

static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
{
        struct vm_area_struct *vma =3D vmf->vma;
        struct folio *folio;
        swp_entry_t entry;

        folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->addres=
s);
        if (!folio)
                return NULL;

        entry =3D pte_to_swp_entry(vmf->orig_pte);
        if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
                                           GFP_KERNEL, entry)) {
                folio_put(folio);
                return NULL;
        }

        return folio;
}

Thanks
Barry
