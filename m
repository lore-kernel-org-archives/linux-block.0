Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95224908AF;
	Thu,  3 Sep 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432991; cv=none; b=HA8v++yWdLAHp5VCrgWttuSO1ldE1eK5YMuvyK2x+g+Wi50NjAeIZaDvm1eAEV1TJEVyK5nGR4UZC9txSrLa1rYW/MqltNWVW/gS+/I42zvK1ArY1bvDEI4ocqndfVQrCr0lQ7r6ynZWO3G3kukNCz8CRKMoa0mJyShi7BTTWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432991; c=relaxed/simple;
	bh=lwTpyZsknjtOsT7aiRREEBNesf4osvgthLVVk9ZmZSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWz5cqvXI33fZesQqIqeh/Dj6qAnVWNOwelDZvu+t1+uMoiIH/IWzTpOWoa35Jj3o5P8quWtKmWCOmMr2bxrdFf9guplnNl9y36wT+gdCL17t5+kxIMX+1OzSWegSwSaO7OFqo1IAm4ThsC0dv7w47fpT4Xj9VoA79DFHPr9VL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1YJ8g4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1YJ8g4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDAF1F00A3A;
	Thu,  3 Sep 2026 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432989;
	bh=XiQkSdBuViJhK1RAwv/WcHb/2F2HMU7HpXbahyvM+E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E1YJ8g4ZDmJgFYPmGdtkXbt2SbGloE5KgPWiNDmzYD5H+0i1jL8mpi84emSVbjnO9
	 irmLmjENy8Zbj5AWR/LdO0ZYMJQhl6SXrMNxaCHkawiW1PStgucE6DgdDT96bqGsUD
	 Fh0FRbuEPJCfS2Bpb3MuSbwk6FnaCOoy0D/G3SzzNTwMoBScNNCuwa0A/nh5tuwvPh
	 fd1MXtLfC4O2IeYkEY9m4uOFEafrLJJILsc4dqdfNz7gS0mct91aAnrv0Yn7VTKC3D
	 6RCcENIlKlTGaeuoLwdE4s58mGXaMLJUbgNe1NfPhzX9/2AMwL6Q/AOUq/9O6WXjoI
	 nnym8RX/8zigA==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id 893DA198003A;
	Thu,  3 Sep 2026 06:56:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 03 Sep 2026 06:56:25 -0400
X-ME-Sender: <xms:UVKZamIPGdTSwMXtzhWS2XNv8V_X9rqvclDcQIAPmBw85vqcUJt6Dg>
    <xme:UVKZaluFRNc4_GnzSaVHhjuuJvG0gyG16pboe-5XeHfbXKV9u-P0pIYp5YmLVG0Eb
    Khmr8tAx3g8GmCiP_OvbFFyZCY-AZr-LAsQAPSKCTUEspI9Qb1QhCcl>
X-ME-Received: <xmr:UVKZao-g67Pcb9Wn8J8SHlaa4cGtpwQki57Zw4nXVwEpoTglk44pC0cSXJM>
X-ME-Proxy-Cause: dmFkZTE2vw9rBDB6ZhLsQ6+CrQI8s2qKm/A60heJ0L01+aqdfpUavd9W3Flk9ygWT+QFwp
    mE2BJJQAcCNCN2yQEO/QNo8KqvPVSjQoVwmD4wh4iPm8SCtGX51Fbl1bfGk9nIvo94LLoS
    DbPAK6SQ3yRsfQfYBB0+cE/W+NgrQM5sNhf3OIrcEjQyPKYN4EtdPVRvdBYBHV7r+8O3ty
    GFcSK+Bkq8lHnOAo1KINJ21TichzO92EIRCe84TVoF8p9/h9hPQ2maXMkXaApGSTamLSVj
    6eIZPnbWRfl3kYuq/qf8QcVCAY+VEQWf25EY6cu9oyTGFOCPLa37QrM2nNlI3l5ueXcTos
    5TCMAY7rReahwfAH1qHbxHW7xpWJcNLmCn+3rqMoJAeCGR5jwVyFsp0Oz5VmGvoYHGvyb+
    kJGgIziu8a+oKvOpjtc21O6XEF/aL2I7Zn6LHE/9vKjTtecpD8laqjfIf0jHF1MVlf5nO6
    8i49U7BEnv56JRBs7gao47i+61WcgJ4fymJ9+5VgMEQaQWQemyZCGatLnbOaRiIh9o4HfS
    EYAz9ALEXEOjrmODtSpJrHE37mSwVjcoCse/txxs/Z0VrrJrf19mMM8rpqzsvnkoFTQkgd
    pssiaV6OsxXcD4Ho/PWwP8pkfJmG//FmEK190CuZAcxVorlErU5Vy73zeKLA
X-ME-Proxy: <xmx:UVKZamB3Y_uWvPz_oiuNVGzSsWaY4aI4n_mmLyKSmcVOHxuYkoxYww>
    <xmx:UlKZat4klBgTOvEbFB_Et7ymvuHEd4t-Mu3omx7quS7XrgX2A63ftA>
    <xmx:UlKZaodyHZawt2FctaHJVhVeW6ErTzyJ51ZmVy6iw8uvhItT4odFzw>
    <xmx:UlKZat8eeJ2VADripRpoJZNPmFmfApz2o4p7BFblWIAv7XpTx3ssJw>
    <xmx:UlKZavGKRHYccIDnxaZpJU5lAykHr1junb0145CTbKA9TveQZtq7K8yc>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 06:56:16 -0400 (EDT)
Date: Thu, 3 Sep 2026 11:56:15 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 Barry Song <baohua@kernel.org>, 	Binbin Wu <binbin.wu@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, 	Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>,
 	Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, 	JP Kobryn <jp.kobryn@linux.dev>,
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>,
 	Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>,
 	Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 	Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Minchan Kim <minchan@kernel.org>, 	Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 	Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 	Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, 	Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/25] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
Message-ID: <aplHq9bvNdyPGEw-@thinkstation>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <16b39f43-d91e-7b23-900e-90cec13837ff@google.com>
 <apAllneItXmyjRPo@thinkstation>
 <7b30ca86-dca6-83b7-a632-180e35ed2a0c@google.com>
 <apThx6sWOQ-aZcN7@thinkstation>
 <821cced3-dcc8-6c80-a92c-c568c2639e5a@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821cced3-dcc8-6c80-a92c-c568c2639e5a@google.com>

On Wed, Sep 02, 2026 at 10:41:56PM -0700, Hugh Dickins wrote:
> On Mon, 31 Aug 2026, Kiryl Shutsemau wrote:
> > On Fri, Aug 28, 2026 at 01:40:51AM -0700, Hugh Dickins wrote:
> > > Do you have a head for smp_mb__ barriers? I'm more anxious that
> > > I might be missing one or two of those.
> > 
> > I think the release side of PG_lru is missing.
> > 
> > You effectively turn PG_lru into a lock over folio->lru.next.
> > 
> > The acquire side works: test_and_clear_bit() has a return value, so it
> > is fully ordered.
> > 
> > But there's a problem with release. set_bit() is unordered. You
> > correctly placed a fence in __folio_add_lru(), but every other
> > folio_set_lru() is problematic.
> > 
> > For instance:
> > 
> > 	CPU0 				CPU1
> > folio_batch_move_lru()		folio_batch_move_lru()
> >   lru_add_del_folio()
> >     lru.next = LIST_POISON1
> >   lruvec lock
> >     list_add()
> >   /* no barrier */
> >   set_bit(PG_lru)
> > 				  folio_try_get() == true
> > 				  folio_test_clear_lru() == true
> > 				  lru_next == stale BATCHED ???
> >   lruvec unlock
> > 
> > If CPU1 sees a stale BATCHED, lru_add_del_folio() returns true without
> > doing the list_del() or the NR_LRU_BASE accounting, and CPU1 then goes
> > on to lruvec_add_folio() a folio that is already on a list.
> > 
> > I think we need to have a helper that would set PG_lru and enforce
> > release semantics.
> 
> Thank you very much for this, Kiryl: it helps me considerably.
> But I have to cool myself down close to absolute zero to think
> about these things, and can only manage that occasionally.
> 
> I've nothing useful to say yet. I believe I understand you, and in
> particular your last sentence, which I take as an observation that
> clear_bit_unlock() is well-established, but what we want is
> set_bit_unlock(), perhaps better named set_bit_release().
> 
> Of course I'm not competent to add that to N architectures, most of
> them unfamiliar to me.  So I'm looking for a reasonable compromise,
> to minimize the additional overhead needed for correctness here,
> just using what we have already have (test_and_set, smp_mb__).

It would not be N architectures. This should be good enough:

/* include/asm-generic/bitops/lock.h */
#ifndef arch_set_bit_release
static __always_inline void
arch_set_bit_release(unsigned int nr, volatile unsigned long *p)
{
	p += BIT_WORD(nr);
	raw_atomic_long_fetch_or_release(BIT_MASK(nr), (atomic_long_t *)p);
}
#endif

/* include/asm-generic/bitops/instrumented-lock.h */
static inline void set_bit_release(long nr, volatile unsigned long *addr)
{
	kcsan_release();
	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
	arch_set_bit_release(nr, addr);
}

/* arch/x86/include/asm/bitops.h -- mirrors arch_clear_bit_unlock() */
static __always_inline void
arch_set_bit_release(long nr, volatile unsigned long *addr)
{
	barrier();	/* LOCK prefix is already a full barrier */
	arch_set_bit(nr, addr);
}
#define arch_set_bit_release arch_set_bit_release

I don't know if we want to make it _unlock() to match
clear_bit_unlock(). Naming is hard.

x86 does need an override, since it has no locked OR that returns the old
value -- arch_atomic64_fetch_or() is a cmpxchg loop.

arm64 is happy with the generic version.

ppc and riscv need a definition of their own only because they do not
include asm-generic/bitops/lock.h, so the #ifndef above never reaches
them. ppc can take the generic body. and riscv is a one-liner right next
to its existing arch_clear_bit_unlock().

This set_bit_release() gets better results than alternatives:

                set_bit_release()  smp_mb__ + set_bit()   test_and_set_bit()
x86             lock orb           lock orb               lock btsq
arm64 LSE       ldsetl             dmb ish + stset        ldsetal
arm64 LL/SC     ldxr/stlxr         dmb ish + ldxr/stxr    ldxr/stlxr + dmb ish
ppc             lwsync + loop      sync + loop            sync + loop + sync
riscv           amoor.d.rl         fence rw,rw + amoor.d  amoor.d.aqrl

I can prepare a proper patches with what I listed above, if you want, so
you can prepend to your series.

If you don't want to go there for the initial series,
smp_mb__before_atomic() plus folio_set_lru() should be good enough:

static __always_inline bool folio_test_clear_lru_acquire(struct folio *folio)
{
	return folio_test_clear_lru(folio);
}

static __always_inline void folio_set_lru_release(struct folio *folio)
{
	smp_mb__before_atomic();
	folio_set_lru(folio);
}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
