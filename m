Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8C150981
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966528; cv=none; b=WMPNcKRdFxckUXRpxXnRh2Iu5J0GnPMDmfIwMGmq5wUiTLqAlO5ztaFiawFxFPU/9L8Lmjd04RkATs6e5NHlPveWNLQaNLT5KapN93lWtldI06ZQERdzERWX036lpBBjxQpt6DX7E3+nJC526HQoF13U38iyclASgLc5ThOzmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966528; c=relaxed/simple;
	bh=/YsjWFS375nXc+lIp1eMRMlBXlqUq0o9oZwuJ8yoPMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qdu+jHaZ9CYvmp1/tXxYNjPrznM+Ur89WaHNvA/J3zCyOaWEMjPmMnfdpvFRXmZgRhgdQylUPNFAJ7omcQA6r8kj5a4bNk6cnoLfuRBKGjdkTRxg7BiVOio63kXKjfu+/CZm/1Jki1nf39RigHeJ5GB6VzOC+SmrvgB3ru1CwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvS1Rfg1; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvS1Rfg1"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d2e71de18so103808e0c.1
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731966526; x=1732571326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYh+kQd0XF+ytQkempQEUVTdixXzqVhemjF7IG0EZ5A=;
        b=ZvS1Rfg1PqQWR7O/vCGnDxnBI7bgOq75Rbu5LiZnorU+S0oMDNQmtRGEctEtoxs4Vn
         eb2M3pIq19Fx5kgq2U0ulDJoHfHIqjvg0pmBElmqv+EUqt5VSwWfM4wGxp1b9G2+w8AM
         ys6j200sLpaOt2Ll7SyzbWUecqqxAkYPg4uSS0xTJO/enCndNGZO5VbRlFbOrgDa0JnQ
         R83HMQGL6+V/jAKW8HkHwQXzM3zqVekAMStAdqj1hWC1KIMIAM/T2EUlMVuTxNXjgPAG
         G90cEpjzsY87rAqw8P8s0tVTQUNICCsrLNDTXfxHgPLYW01frySXgL0EA+V8pnrcVQDy
         AvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966526; x=1732571326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYh+kQd0XF+ytQkempQEUVTdixXzqVhemjF7IG0EZ5A=;
        b=GWQfEN8t99p99jVjwTQnzGq5nbt0G7FJXRuUPFAm5HvCSd8hqjhqONeLmR8/MtgBTT
         lfx2KShWa4IEpHhnGKVkK+CZKqsfqaKqbZLCefm5pM1eiBs6POt5TnsuL8WxohVRJs9X
         js9YSQTydMgId1LB4F2CGS/yBUljuGwtdafQqJlC6eipOtf81aAVqaIqrGBhHlcFsIWl
         dLFv/qO+bA+kMVg5iNWQBn6KcuocFpheITbNqeLXkhWICxa4rqzPHC9/YTDUqUqNkU1L
         iQjeU6RIm5yEW0ltjPoRQXXJBXZPaUM4JGlkD+2Ib5Y0K6rNHhJkGpfKPxq45yWBvh4l
         OJwg==
X-Forwarded-Encrypted: i=1; AJvYcCU3XoWo6y0E1KUe4tHGVtEdCYDJtPBD2NjYw67T3sbvtdNkaDFgwuzpsCXw1L0UDSeQj/zOm3gLdm1CSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPa5M7v52QraMmRtuPqOoAznHp3Ri67KGoFzRn6J/pwlblc/U
	w04gWyDaR0xCux1on9EigATmcw7zJxstPEelnMivn8tPcIxG6R4P5U3KTsygS2C/dkEQG2Mq9m4
	ZiHt4orXmt2nvOvr4XrZg2VFbp0o=
X-Google-Smtp-Source: AGHT+IEQs6pmJWbU/udkZ6IZc/obTKkq117A5GzPxOhgY9m44kOQ96oczaJVlXXqdU4wgWyxUUc9v72dLxq5p/Gm4ms=
X-Received: by 2002:a05:6122:2015:b0:50d:5095:f02b with SMTP id
 71dfb90a1353d-5147829aef6mr12649001e0c.0.1731966525965; Mon, 18 Nov 2024
 13:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
 <CAGsJ_4y+DeCo7oF+Ty8x9rHreh9LaS9XDU85yz81U9FQgBYE8A@mail.gmail.com>
 <CAGsJ_4zojYeEqgTcH-sKek9LW0pYOUoXcrzOzjoMuzMMODujbA@mail.gmail.com>
 <92b25b7b-63e8-4eb1-b2a6-9c221de2b7e4@gmail.com> <CAGsJ_4w7bpQ+20jEQ2stmoS_Y+MWcP40i6CrgdzuS=r6uq8VyA@mail.gmail.com>
In-Reply-To: <CAGsJ_4w7bpQ+20jEQ2stmoS_Y+MWcP40i6CrgdzuS=r6uq8VyA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Nov 2024 10:48:33 +1300
Message-ID: <CAGsJ_4wQgagzNM9yj8rLFQLGvEnhzzdHwtu80s6qqcvt02Qt-g@mail.gmail.com>
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

On Tue, Nov 19, 2024 at 9:51=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Nov 19, 2024 at 9:29=E2=80=AFAM Usama Arif <usamaarif642@gmail.co=
m> wrote:
> >
> >
> >
> > On 18/11/2024 02:27, Barry Song wrote:
> > > On Tue, Nov 12, 2024 at 10:37=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> > >>
> > >> On Tue, Nov 12, 2024 at 8:30=E2=80=AFAM Nhat Pham <nphamcs@gmail.com=
> wrote:
> > >>>
> > >>> On Thu, Nov 7, 2024 at 2:10=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> > >>>>
> > >>>> From: Barry Song <v-songbaohua@oppo.com>
> > >>>>
> > >>>> When large folios are compressed at a larger granularity, we obser=
ve
> > >>>> a notable reduction in CPU usage and a significant improvement in
> > >>>> compression ratios.
> > >>>>
> > >>>> mTHP's ability to be swapped out without splitting and swapped bac=
k in
> > >>>> as a whole allows compression and decompression at larger granular=
ities.
> > >>>>
> > >>>> This patchset enhances zsmalloc and zram by adding support for div=
iding
> > >>>> large folios into multi-page blocks, typically configured with a
> > >>>> 2-order granularity. Without this patchset, a large folio is alway=
s
> > >>>> divided into `nr_pages` 4KiB blocks.
> > >>>>
> > >>>> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> > >>>> setting, where the default of 2 allows all anonymous THP to benefi=
t.
> > >>>>
> > >>>> Examples include:
> > >>>> * A 16KiB large folio will be compressed and stored as a single 16=
KiB
> > >>>>   block.
> > >>>> * A 64KiB large folio will be compressed and stored as four 16KiB
> > >>>>   blocks.
> > >>>>
> > >>>> For example, swapping out and swapping in 100MiB of typical anonym=
ous
> > >>>> data 100 times (with 16KB mTHP enabled) using zstd yields the foll=
owing
> > >>>> results:
> > >>>>
> > >>>>                         w/o patches        w/ patches
> > >>>> swap-out time(ms)       68711              49908
> > >>>> swap-in time(ms)        30687              20685
> > >>>> compression ratio       20.49%             16.9%
> > >>>
> > >>> The data looks very promising :) My understanding is it also result=
s
> > >>> in memory saving as well right? Since zstd operates better on bigge=
r
> > >>> inputs.
> > >>>
> > >>> Is there any end-to-end benchmarking? My intuition is that this pat=
ch
> > >>> series overall will improve the situations, assuming we don't fallb=
ack
> > >>> to individual zero order page swapin too often, but it'd be nice if
> > >>> there is some data backing this intuition (especially with the
> > >>> upstream setup, i.e without any private patches). If the fallback
> > >>> scenario happens frequently, the patch series can make a page fault
> > >>> more expensive (since we have to decompress the entire chunk, and
> > >>> discard everything but the single page being loaded in), so it migh=
t
> > >>> make a difference.
> > >>>
> > >>> Not super qualified to comment on zram changes otherwise - just a
> > >>> casual observer to see if we can adopt this for zswap. zswap has th=
e
> > >>> added complexity of not supporting THP zswap in (until Usama's patc=
h
> > >>> series lands), and the presence of mixed backing states (due to zsw=
ap
> > >>> writeback), increasing the likelihood of fallback :)
> > >>
> > >> Correct. As I mentioned to Usama[1], this could be a problem, and we=
 are
> > >> collecting data. The simplest approach to work around the issue is t=
o fall
> > >> back to four small folios instead of just one, which would prevent t=
he need
> > >> for three extra decompressions.
> > >>
> > >> [1] https://lore.kernel.org/linux-mm/CAGsJ_4yuZLOE0_yMOZj=3DKkRTyTot=
Hw4g5g-t91W=3DMvS5zA4rYw@mail.gmail.com/
> > >>
> > >
> > > Hi Nhat, Usama, Ying,
> > >
> > > I committed to providing data for cases where large folio allocation =
fails and
> > > swap-in falls back to swapping in small folios. Here is the data that=
 Tangquan
> > > helped collect:
> > >
> > > * zstd, 100MB typical anon memory swapout+swapin 100times
> > >
> > > 1. 16kb mTHP swapout + 16kb mTHP swapin + w/o zsmalloc large block
> > > (de)compression
> > > swap-out(ms) 63151
> > > swap-in(ms)  31551
> > > 2. 16kb mTHP swapout + 16kb mTHP swapin + w/ zsmalloc large block
> > > (de)compression
> > > swap-out(ms) 43925
> > > swap-in(ms)  21763
> > > 3. 16kb mTHP swapout + 100% fallback to small folios swap-in + w/
> > > zsmalloc large block (de)compression
> > > swap-out(ms) 43423
> > > swap-in(ms)   68660
> > >
> >
> > Hi Barry,
> >
> > Thanks for the numbers!
> >
> > In what condition was it falling back to small folios. Did you just add=
ed a hack
> > in alloc_swap_folio to just jump to fallback? or was it due to cgroup l=
imited memory
> > pressure?

Usama,
I realized you might be asking how the test 3 was done.
yes, it is a simple hack by 100%fallback to small folios.


>
> In real scenarios, even without memcg, fallbacks mainly occur due to memo=
ry
> fragmentation, which prevents the allocation of mTHP (contiguous pages) f=
rom
> the buddy system. While cgroup memory pressure isn't the primary issue he=
re,
> it can also contribute to fallbacks.
>
> Note that this fallback occurs universally for both do_anonymous_page() a=
nd
> filesystem mTHP.
>
> >
> > Would it be good to test with something like kernel build test (or some=
thing else that
> > causes swap thrashing) to see if the regression worsens with large gran=
ularity decompression?
> > i.e. would be good to have numbers for real world applications.
>
> I=E2=80=99m confident that the data will be reliable as long as memory is=
n=E2=80=99t fragmented,
> but fragmentation depends on when the case is run. For example, on a fres=
h
> system, memory is not fragmented at all, but after running various worklo=
ads
> for a few hours, serious fragmentation may occur.
>
> I recall reporting that a phone using 64KB mTHP had a high mTHP allocatio=
n
> success rate in the first hour, but this dropped to less than 10% after a=
 few
> hours of use.
>
> In my understanding, the performance of mTHP can vary significantly depen=
ding
> on the system's fragmentation state. This is why efforts like Yu Zhao's T=
AO are
> being developed to address the mTHP allocation success rate issue.
>
> >
> > > Thus, "swap-in(ms) 68660," where mTHP allocation always fails, is sig=
nificantly
> > > slower than "swap-in(ms) 21763," where mTHP allocation succeeds.
> > >
> > > If there are no objections, I could send a v3 patch to fall back to 4
> > > small folios
> > > instead of one. However, this would significantly increase the comple=
xity of
> > > do_swap_page(). My gut feeling is that the added complexity might not=
 be
> > > well-received :-)
> > >
> >
> > If there is space for 4 small folios, then maybe it might be worth pass=
ing
> > __GFP_DIRECT_RECLAIM? as that can trigger compaction and give a large f=
olio.
> >
>
> Small folios are always much *easier* to obtain from the system.
> Triggering compaction
> won't necessarily yield a large folio if unmovable small folios are scatt=
ered.
>
> For small folios, reclamation is already the case for memcg. as a small f=
olio
> is charged by GFP_KERNEL as it was before.
>
> static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
> {
>         struct vm_area_struct *vma =3D vmf->vma;
>         struct folio *folio;
>         swp_entry_t entry;
>
>         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->addr=
ess);
>         if (!folio)
>                 return NULL;
>
>         entry =3D pte_to_swp_entry(vmf->orig_pte);
>         if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
>                                            GFP_KERNEL, entry)) {
>                 folio_put(folio);
>                 return NULL;
>         }
>
>         return folio;
> }
>
> Thanks
> Barry
