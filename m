Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8C3DD86A
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462558; cv=none; b=gASQ1OE+aoYJCkQNr9rtirYF0de2gKd7lfCmJ1HGrj97/f1PUKZGWdOVU/T8HVx3LMKUXXkYCKkossKXq/osTtZAXvwErLSzvVOvDpnrId/Kq9DmVdxXHH0ALVqVKkbNig3svBqrlKmHvCVtNSTSLomW5eX9/fpSV3hGchmNXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462558; c=relaxed/simple;
	bh=zohLUEHoUGucyIqh2JCSr6NzM/L90VLWTpNmRSm/PsI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R52sT/sCMZQDwRSwX6ztKNa7qGKgm37dES83SfT8rbHVnhlTgqvUTQhM8Cc/N2PyolVWVQf/zpOpVHJ6C8+SO9NElFhE9illpdGEvhW7m9a6140FExAImI7LDbqlu7gTK/dI6PCPRpEiii+ZJ1KuqfSYHnOP0aewGMOuo5R2KNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofibgSda; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofibgSda"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-86162c086f8so2648267b3.1
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788462543; x=1789067343; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0jjBKM/T0lxzBL1G/oFuXqJ/xjVo9f/c2XBOtxdJVs=;
        b=ofibgSdaJwnFgZeNiEwciUuhLlr9Fs7OmYZBi5ay3ML37iA0pO/SL9WGsipJwDbXW+
         RbtQ0AcaLfXPjPGttww3mXWPhtTrzoiZ3WLgmOC2zL9+v3044orn5T6gk3a/asd0yZLA
         mAZIXOct4AmPt7wd5yajmvX3cJwOrSFBh7LlBtoVE2a0wHT/kCgIj+aHnAH+QSSrvJuH
         bAj0+tSYniTJ/4x28jIMjdu1U7bYQ3m4zC7mk6wawObwfAs4KfV+LRLApq1oMi7HepwJ
         Kjx9LnVe4t5uLNqhwH65otVXAFCEPfv0H6EqWxIvZuyoRX9e5OLKpCwI9lvf0W1XuldM
         egdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788462543; x=1789067343;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0jjBKM/T0lxzBL1G/oFuXqJ/xjVo9f/c2XBOtxdJVs=;
        b=HYtREyDI6z4Nqq6uVQpfkJaPus1Jp3FAy1PRQXcFvlF+wEpcuDpmFvViOwCffeSX29
         Rhw8nNCN8aYmPy/UP1161lUfNwgppQSvJ2XeaZRGN+yCBuAcLW1Y97Gigj8QzW+WAQad
         B0PlXbsCzqLxBCZ6q8RrNXXyxBhbYkAzvvB+MyJPQzfa+vzqZh8f6QL/XOqpNhttcE9D
         3TVBfT13MJzjndUWFVdyW2y9X4inX7zEtBRsE8NYxiLvZSLOA2nTlMpJffQW+N5de1Dg
         PYlswAhPR5Y/HFHHNBq1XeCnD4CdGLkkYy9d3cfWCkbvGufvP1nNVuSCqppPQPfqP9z2
         QUFg==
X-Forwarded-Encrypted: i=1; AKwUvBzoEv8d0Gbwf1Kn2ew16ct3yIUJyMIjYUrPq99OQVFLOg7HJCV0l057SEQFXd8EuVpTN6UjbdmnD0r4Tw==@vger.kernel.org
X-Gm-Message-State: AFuF++lNV3D21Zmhh6MawKYyD2o9RsaKpt8QXqwcyB4HSEydOPRIONKJ
	1NDTYWC/bw+r+/hb672AgmjK58EymAFZ8OW+0DyARRpfDUstnH5JZ2GfyFw21iiH1A==
X-Gm-Gg: AYBFou0l6UeAjnFejozMG3WDft4wTMru4vRPeLbpsUH3KjR2uNcuUVrbKHqqh9GNx8U
	SyEGhNID7MNJYctKq9mfF3EQ5pg5HnFUqGxEsiv4Lb602l4AX38JVmnu8gqJsY2oXhpeYc4Fvs3
	Qf3xNIW5WV45qTyquoFkQ4+Ta6Jr1ZCDeZ5QeyipfmW5VAVha2cMULkDf+BRwuXNZekTk9hjBrl
	CG+c+hVY0OiUQtVjcWDOUlGW1wHNIKvqZNVSIks9ohqtHCkEYXCbuQCan02F/s3KnMO0ZP9KPgy
	dwoV14B/3c4RxlCGEQZdQ5Q84kcNixUjp37pbJBToFgQZIlsLk9Yo+xZeDVyyX0NXFwto5xAsBu
	6Q/lnrqE5HTOSqN7swyFRbx3SnQpjjFFDK/X4RzVF7i8Cf6sjcHDPgzCQf43voY2dUdvbnX2DZF
	nFJ6VExslVyAktI5Vco9+Cs5pB3nsPpavF1ZJrIFPhzexyKrQklyB4y0+VkOEZEKiRTqtygr+o/
	zMsSACYgtU2UvWVCpFoEDdogb7mQ9JUtJotdRZoIkiE/Zns
X-Received: by 2002:a05:690c:e257:10b0:80e:c332:1796 with SMTP id 00721157ae682-86e7081d3ecmr33938977b3.10.1788462542453;
        Thu, 03 Sep 2026 12:09:02 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714af5581bsm2146627b3.36.2026.09.03.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:09:01 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:08:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kas@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/25] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <aplHq9bvNdyPGEw-@thinkstation>
Message-ID: <e2098d3b-722a-50aa-3b01-ec012f05c1e5@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <16b39f43-d91e-7b23-900e-90cec13837ff@google.com> <apAllneItXmyjRPo@thinkstation> <7b30ca86-dca6-83b7-a632-180e35ed2a0c@google.com> <apThx6sWOQ-aZcN7@thinkstation> <821cced3-dcc8-6c80-a92c-c568c2639e5a@google.com>
 <aplHq9bvNdyPGEw-@thinkstation>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Kiryl Shutsemau wrote:
> On Wed, Sep 02, 2026 at 10:41:56PM -0700, Hugh Dickins wrote:
> > On Mon, 31 Aug 2026, Kiryl Shutsemau wrote:
> > > On Fri, Aug 28, 2026 at 01:40:51AM -0700, Hugh Dickins wrote:
> > > > Do you have a head for smp_mb__ barriers? I'm more anxious that
> > > > I might be missing one or two of those.
> > > 
> > > I think the release side of PG_lru is missing.
> > > 
> > > You effectively turn PG_lru into a lock over folio->lru.next.
> > > 
> > > The acquire side works: test_and_clear_bit() has a return value, so it
> > > is fully ordered.
> > > 
> > > But there's a problem with release. set_bit() is unordered. You
> > > correctly placed a fence in __folio_add_lru(), but every other
> > > folio_set_lru() is problematic.
> > > 
> > > For instance:
> > > 
> > > 	CPU0 				CPU1
> > > folio_batch_move_lru()		folio_batch_move_lru()
> > >   lru_add_del_folio()
> > >     lru.next = LIST_POISON1
> > >   lruvec lock
> > >     list_add()
> > >   /* no barrier */
> > >   set_bit(PG_lru)
> > > 				  folio_try_get() == true
> > > 				  folio_test_clear_lru() == true
> > > 				  lru_next == stale BATCHED ???
> > >   lruvec unlock
> > > 
> > > If CPU1 sees a stale BATCHED, lru_add_del_folio() returns true without
> > > doing the list_del() or the NR_LRU_BASE accounting, and CPU1 then goes
> > > on to lruvec_add_folio() a folio that is already on a list.
> > > 
> > > I think we need to have a helper that would set PG_lru and enforce
> > > release semantics.
> > 
> > Thank you very much for this, Kiryl: it helps me considerably.
> > But I have to cool myself down close to absolute zero to think
> > about these things, and can only manage that occasionally.
> > 
> > I've nothing useful to say yet. I believe I understand you, and in
> > particular your last sentence, which I take as an observation that
> > clear_bit_unlock() is well-established, but what we want is
> > set_bit_unlock(), perhaps better named set_bit_release().
> > 
> > Of course I'm not competent to add that to N architectures, most of
> > them unfamiliar to me.  So I'm looking for a reasonable compromise,
> > to minimize the additional overhead needed for correctness here,
> > just using what we have already have (test_and_set, smp_mb__).
> 
> It would not be N architectures. This should be good enough:
> 
> /* include/asm-generic/bitops/lock.h */
> #ifndef arch_set_bit_release
> static __always_inline void
> arch_set_bit_release(unsigned int nr, volatile unsigned long *p)
> {
> 	p += BIT_WORD(nr);
> 	raw_atomic_long_fetch_or_release(BIT_MASK(nr), (atomic_long_t *)p);
> }
> #endif
> 
> /* include/asm-generic/bitops/instrumented-lock.h */
> static inline void set_bit_release(long nr, volatile unsigned long *addr)
> {
> 	kcsan_release();
> 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> 	arch_set_bit_release(nr, addr);
> }
> 
> /* arch/x86/include/asm/bitops.h -- mirrors arch_clear_bit_unlock() */
> static __always_inline void
> arch_set_bit_release(long nr, volatile unsigned long *addr)
> {
> 	barrier();	/* LOCK prefix is already a full barrier */
> 	arch_set_bit(nr, addr);
> }
> #define arch_set_bit_release arch_set_bit_release
> 
> I don't know if we want to make it _unlock() to match
> clear_bit_unlock(). Naming is hard.
> 
> x86 does need an override, since it has no locked OR that returns the old
> value -- arch_atomic64_fetch_or() is a cmpxchg loop.
> 
> arm64 is happy with the generic version.
> 
> ppc and riscv need a definition of their own only because they do not
> include asm-generic/bitops/lock.h, so the #ifndef above never reaches
> them. ppc can take the generic body. and riscv is a one-liner right next
> to its existing arch_clear_bit_unlock().
> 
> This set_bit_release() gets better results than alternatives:
> 
>                 set_bit_release()  smp_mb__ + set_bit()   test_and_set_bit()
> x86             lock orb           lock orb               lock btsq
> arm64 LSE       ldsetl             dmb ish + stset        ldsetal
> arm64 LL/SC     ldxr/stlxr         dmb ish + ldxr/stxr    ldxr/stlxr + dmb ish
> ppc             lwsync + loop      sync + loop            sync + loop + sync
> riscv           amoor.d.rl         fence rw,rw + amoor.d  amoor.d.aqrl
> 
> I can prepare a proper patches with what I listed above, if you want, so
> you can prepend to your series.
> 
> If you don't want to go there for the initial series,
> smp_mb__before_atomic() plus folio_set_lru() should be good enough:
> 
> static __always_inline bool folio_test_clear_lru_acquire(struct folio *folio)
> {
> 	return folio_test_clear_lru(folio);
> }
> 
> static __always_inline void folio_set_lru_release(struct folio *folio)
> {
> 	smp_mb__before_atomic();
> 	folio_set_lru(folio);
> }
> 
> -- 

Thanks a lot for taking this further, and we may indeed want it later;
but you guess correctly that I don't want to go there for the initial
series, and I've not yet convinced myself that it's what we want anyway.

Assuming that the existing pre-series code is correct just to use
folio_set_lru() throughout, what I've added are these additional lru_next
transitions, unprotected by lruvec lock, and it's just these which need
the additional protection.

So, I haven't finished thinking on it, but what I'm currently inclined
to, is putting an smp_mb__before_atomic() after the LIST_POISON1 in
lru_add_del_folio(). That's a long way from the folio_set_lru() it's
intended for, which is unusual, but it seems more to the point than
always using folio_set_lru_release(). We can switch to a proper
folio_set_lru_release() later, if that's usually seen to work better.

Hugh
