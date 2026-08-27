Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B743E49C2
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820575; cv=none; b=ZwG6lYKwmbQq3ix2tkK/mvGpVwWzOGDS/wMT/UYRitGJQWsr6iT8QbkWAxsm99HmW3hhsE9mpfK9GS9pL+Hae5/ia0qbumNYkeBwds0In5f34ZPO2TRuYV7yYCu8AUP75Epyv2Eh2aU1J8H43AV3opNWcKTeU7G7xdAVXua5sfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820575; c=relaxed/simple;
	bh=xOo52WEwM9OcvK3XM7gppK9P45+gQdtp6SHuVaRQ8xQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ncUkLWZ5Ye5uiXUgxtaRE1leczMjFQAHIpO/Jqup2ewN7kqMQHeNu835Wj0qZpM45lmcRI/62EJ1DuHAoCFRwFkLe9nKSkuxeekPrLPCRTQgfWaIBDlPJvko/1pbC6GOAW47Ec/2KpTZk3SJKDfN/PS6jIkDc0dWiHpCfZ7duhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLK/unnv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLK/unnv"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81e6f0b4610so19910957b3.2
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787820572; x=1788425372; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1qjuH7DPdLHxaMJrgal+nSqcPVjkvrEhw9rBC64WAk=;
        b=TLK/unnvDueiRDw0p19YY9LJInr+bAz6RJn/uhc2MjNoONapzkLRyqgMoEOEX68sKj
         V1wShyCVWvpQl1vJWbA69ZAa8rzZEeFoR/GamjLhCEsDw4Wrez1Zr/vDfLZp5OUp6wnN
         oWgtEMEV9sBRzENHNAHW/VWom9M/MVqnQ2C6Ypo3HdgRfpGZBKbZSeO2a/fKMV9XykYk
         xggeaYbtnJos9DzAWoe1zE9UTwd6F+xm5xF63NFUnoxdXsPqL5RQqAyc3ewIxhZhiBh9
         UeZ/Tbl/Xr+XjEZCIY3HVRm+kVkkVGaI09NU3p4tK6MT/dJOy4ja997IpVrtw4aERwRO
         UWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820572; x=1788425372;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1qjuH7DPdLHxaMJrgal+nSqcPVjkvrEhw9rBC64WAk=;
        b=U1Zesg1Nz1mz/dl60N6idD5ol9eM4bzNoq80upmfH1lxvW0t3cUEdL2TKX4Mm7iXM4
         IjdIDJn+Jwvd+sZ0my8M9zY+n0plIJ19csB6n4V3e2Bd6MAntZoOEfv2+6hiMgN6VNb0
         bXNJPvjTlL6adDq42VieOJo+x6rn4Pw8Hr2WcLMPZ0dgzbMuCrKxIZFB3RHnRQ8jIPIB
         5t6LSGSz4bPQDCn32ojphPcB4s1DRS6cHH5ifa50xiFYJpnHusHG5AlETzja/Ca7T/JS
         K/chjDhCx9C3UVWZEer2qE4MaK0WkRxm6HqNvL91ooCudHdPdnw7A+kfBAFIiH5GyHrM
         qsUA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8u91ffO7TE2ebaYmkMMighYaxHrMpSVnkdccbttfB76sRR0ioovBvWu3Sndm7aeRHQVt/3BwSIaIf0w==@vger.kernel.org
X-Gm-Message-State: AFuF++kdDuSXtoNX0WEX1eUyOPt5duTVTvkgt1gQs+veuALNOUyy+C1F
	N40SceBZDw3fZecQkEUn12tiyLWRp8SQP1Bl/CeSlix9XYzhZ3j9qlCoQxZyD1CM5Q==
X-Gm-Gg: AR+sD10q3Sg40p08Pj8biAd2ieMCFpDi0plR8i6RMh5DSGS9CYD9GRRxGVwG3jgamVc
	Y1Ek6kPQo0Z+7sNSI7z7QwKNyxSjBTctLf+b0PV65JONC/oGU0UDUjxxxbkL24P/PjrMLi23hWy
	Tz6elu5l9Q/uQhheaumv4skJfG/7NK4dM7o09XwcQn4ZKgNMY1VCVNH0gM/9Ynadws05eYrG5Oi
	aISwCpt2f1hYDVWbqxUjWGmTwgsXMqfshuqR7Wlfiw0YfddmGg7NpO0Kxqzy5yvzMN1g3fc8+5M
	D/H9VFAWXbK8ymYfxpA5aVwmrNOtl+/cQ7MbFUJJhr2DTLrYacfJ93zPEOT/I40xreF3Fs4XT2S
	yVt3h4ONecxX3v2A/+eyg6h6txvLIHpbVNbPcoZbaYmdYGEL08tfKXq/hiDTOFFbajfU8ikinPV
	xTAORWceoEqm7w6z/wl6c2DFmI4/jgJVyuFAVnfA+6qMCQYgO5O+pYi3vkbVuJkIHB/0a/EdQLi
	TN6KYncKzbpjgFjT5DvXNEv0I21VeRkqYitGdrVU586JddU
X-Received: by 2002:a05:690c:ec9:b0:85b:35f6:bc5d with SMTP id 00721157ae682-85b35f6bdb2mr18592327b3.13.1787820571154;
        Thu, 27 Aug 2026 01:49:31 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b5cccdd31sm6315477b3.18.2026.08.27.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:49:29 -0700 (PDT)
Date: Thu, 27 Aug 2026 01:49:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
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
Subject: Re: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <20260826155722.0198d3ce@p-imbrenda>
Message-ID: <2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com> <20260826155722.0198d3ce@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 26 Aug 2026, Claudio Imbrenda wrote:
> On Mon, 24 Aug 2026 07:39:12 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> 
> > s390_wiggle_split_folio() has no good reason to lru_add_drain_all(),
> > now that the per-cpu fbatch references are gone.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  arch/s390/kernel/uv.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index dc14ebc0105b..120a467026a5 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -364,7 +364,6 @@ int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio)
> >  
> >  	lockdep_assert_not_held(&mm->mmap_lock);
> >  	folio_wait_writeback(folio);
> > -	lru_add_drain_all();
> >  
> >  	if (!folio_test_large(folio))
> >  		return 0;
> 
> This is black magic for me, I am not sure I fully understand all the
> details, but what's the new purpose of lru_add_drain_all() ?
> 
> will we have a guarantee that no stray references to mapped folios will
> ever remain?
> 
> Any unexpected reference (i.e. not due to mappings, see
> expected_folio_refs()) will cause a protected guest to hang.

I most certanly don't know s390 or that code well enough to guarantee
you that no stray references to mapped folios can remain there. What I
can guarantee is that no references, of the kind which lru_add_drain_all()
used to be needed to remove, can exist there: so there will no longer
be any point in s390 (or others) calling it for that reason, to help
split_folio() to succeed.

You wonder then, what lru_add_drain_all()'s new purpose is, why it
still exists at all? I did hope to remove it completely, but found
two usages that I could not argue against: one is in user-forced page
reclaim (two memcg interfaces and a sysfs interface), where it's
still desirable to push folios on to the immediately reclaimable LRUs,
rather than leave any on the per-cpu fbatches preceding those LRUs;
the other is in memory hotremove, where it will be necessary to erase
stray addresses, through which a subsequent folio_try_get() might have
accessed a struct folio which (I imagine) might have been freed.

Yes, your split_folio() may still occasionally fail, because of
transient references and folio_try_get()s on that folio; but that's
so before and after the changes. And there is (in my mind anyway) an
open question of whether "folio_try_get() blips" will be visible a
little more than before.

Hmm, looking again at s390_wiggle_split_folio(), it seems rather
odd that it was doing an lru_add_drain_all() at all: because any
large (hence splittable) folios have themselves been immediately
flushed from the per-cpu fbatches, not left queued up there. Maybe
there was an earlier time when mm did not enforce that; and Barry
is currently looking to relax that, so the limitation intended for
pmd-sized folios is no longer forced on the smallest large folios.

If Barry's relaxation goes in before my drainage changes, then
there is value in that s390 lru_add_drain_all() in the interim.

Hugh
