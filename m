Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0636EAB1
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789252517; cv=none; b=CgBHd2pRtN/TOHFXz8WEsVVBfANw/mCgNxzAUQHq+QaiKHcQNKC7tV8W3UO1lQ8ofTqN/5r986jnnJJzjqJHkWyeOJgWoGM6C2vvsgauhrTc7nxEC3Bir2o+OM2PkwBuhqlbei3sAwDDCUHzJi1hMJvRpZg7NW+o38IjNTTQycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789252517; c=relaxed/simple;
	bh=dNxIy8a69k/1fYH+eiiinSZ2mf/9dsJ9XtaFpi81jpY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fw5zPWGWe18WWOAaHNVBtBVmC6vD7Zn3bM1J+lAv/ukPFI5NZo8N+6C7tg0v9WTVYa9xlvM90ZbZt83MFEl3ClzlrRdX88XkijQdFccuR+Uxfnn53DD6wkgNhxLLSWpXmiH0CFTyNfrSJcGCARe3oQtGQ0rc7zzXk41dkFNuWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whl4qRtE; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whl4qRtE"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso6829455e9.0
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789252514; x=1789857314; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyqTSD7+XEJxR7K9Lr2Cp4DYcxTxFY5cqwi53+WEaFU=;
        b=whl4qRtEs6oE/VTOzPGEwfrXBx/N9YwyZxLS9AQmxXOmuijw9NgHp/X7WMEJH32em8
         KG8Xdh+IsuuvgkiUC7nwRtSLcUy4n5c3Naawg5xZHVqOg0KOMFj4D3zpataJKDQwKmRG
         sqRufb9tvTG2hwqLkGt+CJe2fjAWSbWQ7Kp4UtrVpOTQPZCxnj3G5fm9jrVUB7s/9Fpa
         RXMQSlV+IJpjJ6En9n6t/ntBVfctR1uzVAstGA+dt+sOzCveKP9mKu0oz1OIpSC66mE8
         X3Ge9we2oFRLgtzApXnxCZP2POX1ufQV+HHE/dPKZ+t6wo/sKCia3bPANSsod2hg2oT0
         1D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789252514; x=1789857314;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyqTSD7+XEJxR7K9Lr2Cp4DYcxTxFY5cqwi53+WEaFU=;
        b=WuKm5b2IwsLfVHiVXj5bggVFitHZ2NBQUbUxX5LmrgapXM4TIP+3bFeacrWpx3PODv
         IkSdeKQ5q3ATWZplkbSmEaFoFGICfIDVIg9NhB0rEkV/NdlUhHC/yFm0/6mcLgojRuNE
         dOOLypGUDR3G281qcV7dFcHpDqEclxg5U1luNwn78H1A9NbISNdcS0/ddoT+bSVpIwSd
         WJy6OkTkhxesh2VcuOw9Iwmi7xYeOPuARBxIOYm/UtXCZjSaLxKs8NGoyTWwxTtevJ14
         Z7tZ/deaqRMmyiGHDFLZ2k3hk4iEaJvWHWzgLKlCpr+sAkkAchWbVN0uKPTkpH1ezPhc
         neNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwK6a2ieNbHSa0IZiQm/APFiCZYAdINYV2enptmd4gUh909Cn1yZa/CnBu+DMGyCdiKgKii8cgY91HdcQ==@vger.kernel.org
X-Gm-Message-State: AFuF++np4vPWVKVKfYXFh+Oj75wlY6OJCmy+chdcSV0oFF8yltlqH6Cq
	S4dsf0mrJYx0J+WV9JGkezmkqCM3KCkhx8ObJyOLl0wnW+oq+JRd7FTNiJwgibmUGA==
X-Gm-Gg: AYBFou1ICTljreLBgumYq9nIDrPmXGRiZmYWXOU6dsAYRr29TlSQMWTU41tOeU/csiz
	/WfI6/KT1ChDYBrHfDZ1aZTMkdSeQYgmIbmxEWnAL0bXbx/UaIK/CVwJHmiRq6B0xYJ3QjSN1dC
	8+O9pJ6ovfk/eheeOmv0+zJ5wgfW+NFMhoAJBvIe66eIKne8WXXnBvYCV6A8kuWzxaNd5Aq3Non
	Y+RkYOgqVMZuolmz+zn3rlpgb935byR2WXCBohdxoqWKY0NlaVvfnGmp1qz0WbNer+EypP87/yx
	FR7K6K0raEisrwZiuLUj4G8aqQT3h39/6+YFujGw23hMywKruq4eNIl1DtfnVh6u1CpmYMX/NA6
	fMyKEsKvEVYaR0RuAIXxQIkQy7aW8Fg4UrLwYd/uJX4Von7E2zxbSQm4XQGsV2TIYpU1BKEAR7e
	oetD9BCEHnvqSFbR04x9O+8k6l4iD9KvcRg5djLPAO8Fbnb5nYavhIaC0dgQ0k5Awxgp2WdphYB
	INXuj76eKNYVSt2s0CD
X-Received: by 2002:a05:600c:3513:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49e619c0357mr193958835e9.7.1789252513196;
        Sat, 12 Sep 2026 15:35:13 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60acff8bsm191751465e9.9.2026.09.12.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:35:11 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:35:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/26] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <ddab52d0-48c7-4d2c-b403-45f11e041654@kernel.org>
Message-ID: <bbf33dc0-6812-f204-188f-f2176a4faf4c@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com> <ddab52d0-48c7-4d2c-b403-45f11e041654@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 10 Sep 2026, Vlastimil Babka (SUSE) wrote:
> On 9/9/26 11:55, Hugh Dickins wrote:
> > Implement an equivalent to the old __lru_cache_activate_folio()
> > optimization, to activate a folio recently put in the lru_add fbatch,
> > without having to put it through the lru_activate fbatch too. Neither
> > lruvec lock nor lru bit can guard this safely and efficiently, so resort
> > to try_cmpxchg() on a further, LRU_NEXT_ACTIVATE bit in folio->lru_next.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  include/linux/mm_inline.h |  4 ++++
> >  mm/folio.c                | 23 ++++++++++++++++++++---
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 8420b1276535..8f5efadf9c7c 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
> >  enum {
> >  	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
> >  	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> > +	LRU_NEXT_ACTIVATE,
> >  	NR_LRU_NEXT_FLAGS
> >  };
> 
> This addition, and the comment "/* This mask will do nothing on 64-bit */"
> in folio_add_lru()... does it mean that now this is breaking 32-bit? Should
> we make this optimization, or perhaps all of the cpu fbatch, 64-bit only?

Answering second question first: those could have been options, to
disable the activation optimization or all per-cpu fbatching, on 32-bit;
but I much preferred them not to diverge, and tried hard to keep 32-bit.

First Q: This does not, in the end, break 32-bit at all. But while I
was developing, I thought it did, and reluctantly switched the encoding
away from holding lru_add entry pointer in lru_next, to holding
lru_add cpu and lru_add index in lru_next: from those the lru_add
entry pointer can easily be calculated, and there's lots of space
left over for more flag bits (which I thought might come to be needed).

But then I had that marvellous realization in folio_batch_move_lru(),
that it needed to service "wrong" entries in exactly the same way as
"right" entries, therefore didn't need to distinguish them, therefore
didn't need any address there at all.

I have kept the address for debugging, and do put it to some use in
the paranoid vmstats patch 27/26. On 32-bit, with 4-byte pointers,
this LRU_NEXT_ACTIVATE bit does then leave one pointer covering two
adjacent entries, when it's deciding whether the folio points back
to this lru_add entry. Is it possible for two adjacent entries to
hold the same folio (and so perhaps miscount the stat)? Yes, it is
possible (if that folio is freed and reused and readded immediately);
but so unlikely that it's of no importance when gathering stats.

Hugh
