Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA853B4EB8
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638558; cv=none; b=GUeMEMeTNsATVaa1mYUKq3ueoHPPFhlLJc4P5QM1CKcxN+/P146QO1SAolh2Y5n9PgbQwEppKyYBd3h3PpBOV/tP+ph3JnPzj+/cj3Ar7q9hUomOQZhblG8NwrgUUmfUm8dq0gROXO8307hDqbTcEPc9kzivPqsB4KZIajZOD8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638558; c=relaxed/simple;
	bh=gOL+wA4JXTANAnqgvFRg9AOyjMDz3L1WezMuCG7zAc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRSLso2r38qpVucLnkxlai4GpEHsGyMzx49O/NfYaZyZikuWwbdGOkNrCs2sc8zUXR3iyIi1Lsft8V51JJVqfdzB6P8d8JdR5E1W1kdLo9xmFBWNOwEGYXWhMrDmgRqJRZuwRIU0Dw027T9sWg3CzvaF0GaRaz/uPbxnOXLSeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Dm6IjoST; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Dm6IjoST"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48375f1defeso52692375e9.0
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 07:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1772638555; x=1773243355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1mkQWDrumj00DSD6vvqkqYaNr3+NM2VS5dFTF9kbFs=;
        b=Dm6IjoSTCABrBVPb3RAwTIMFqaChMnGHjeX8dT2gM7ZNRn6Q9HT3ZEKKXI3TRdhOjg
         uFELP3PllExOd5kMjJ9fS+hvR0pZYG3oH46KGDgWsJKkNXb3khHY1JGGP169RqvqviZP
         378MDVY53FmZBC59Q1VtkOf0zONjF+EHJCgj9jvb8tX6qtPHen1wUqpPqEz1JaRLi+q0
         DXnZqrSP4VAdsHkYZI/KAcbTEvBQa/B5JSTmxWJgbHoVPHtLJ9E+/7R/HyAY/xAEStLK
         uSkfgcicdmZzgYSSc77cDXeF7aKiHNFRjzGfRWvcCQh/OycpKDRZsESaRQD37iIqkJx1
         zdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638555; x=1773243355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1mkQWDrumj00DSD6vvqkqYaNr3+NM2VS5dFTF9kbFs=;
        b=Y9uUNUq1yC38V15t6J5LhGiuQHAy9X4i2ZNMraRgxjt0hVcONcSCjP6Lx4eBYy+XIT
         gPGd5ElGHuEf2zx21r3Eyt1pSomU0p2CteM4SazK4lfLzWzKSH/wQKCuwW/LjjEO3wQ1
         7EPlyB1ban2kHlBISKlDH41fvUC6NNgyGfapNa/7skHIgjUzM5n2tsE63f/ZyXbssFFe
         fj1zT1fp6RsuuNIw1v1Wi19+M5jlpNKEuL3iMM7gQG9bjHxVw0a4W0OY4UnIlq1W6/PZ
         CeEqL9HpiBf50CjOFnexVaoZaZHrBJDj89h25rWzyEKhFOhYF1dv6fB/X1Naf1OnCTHN
         nVRw==
X-Forwarded-Encrypted: i=1; AJvYcCWFzmQIJGbeDg+/z1qAm642T7lUpzAG5zTbQSwgjmE5QoWc1DQ4QRwi4MFS7BK/Fn4PTXkd/gHrCaoGfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpiibHawGX0JrQCBBkPZ23rFlW6KMXkQdn5G8Zd7k4wEERbdNt
	ocbLl1t5+ME1uA79KrHLbWiANsg33I4aOMXHg5sId+y2J2kUCHa/sLVrFBPtVHqTOo4=
X-Gm-Gg: ATEYQzxQFPJZ5aW5CwW6QemMYseWFiERYNeK+ZKl8pmav8WJkiRcR07XrAJnA6Vxzv9
	CUD4u8vq2SgENJ4RB0yzvLLwNGF4lhytR+M30FrQa69UzYhLz7SN1Vf9ni3nrtMo4DxLAJLZShG
	db7PtEwjNooCy0WIgFq2ZvkDF7nlwkL2wiCUO1QhohB7bIpZ70/26fNdGyhP0t/F0dWO/vHZ0Sv
	f2vAU5gMFUBIwJ8SzA2bUQkW01OlDG+aIwZy+n1Ez1x4UvA21PxUWExZOez69RLo+5/6gvG/SIw
	nsQ5w5BMAe9/qRLWdmKW85QyiD0Adpmpq94/L3hmhTDxn5FaEw7+2L0URmVG7LHlVE1U8J7aJ7D
	GKw8UZXRo2ytc1gNgrbAfyhIipoY0dPuB3m6W6YpHxv0mYjzKWZmciPkEJ74gmmjZPj6F9YjwY2
	Q0XkxrUamwApryJ02uOw==
X-Received: by 2002:a05:600c:45c6:b0:483:c12b:fe4b with SMTP id 5b1f17b1804b1-4851984953emr39162205e9.9.1772638554307;
        Wed, 04 Mar 2026 07:35:54 -0800 (PST)
Received: from localhost ([2a09:bac1:2880:f0::3df:3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187db303sm63405395e9.0.2026.03.04.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:35:53 -0800 (PST)
Date: Wed, 4 Mar 2026 15:35:52 +0000
From: Matt Fleming <matt@readmodwrite.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [RFC PATCH 0/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
Message-ID: <wqv7kbfipi5rk5nt2r4bjcqslvluz5mklyz7u33vhytgie7djx@vbjz5ndkaf53>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
 <aac38JHJCRB0PbjJ@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac38JHJCRB0PbjJ@cmpxchg.org>

On Tue, Mar 03, 2026 at 02:35:12PM -0500, Johannes Weiner wrote:
> 
> What about when anon pages *are* reclaimable through compression,
> though? Then we'd declare OOM prematurely.
 
I agree this RFC is a rather blunt approach which is why I tried to
limit it to zram/brd specifically.

> You could make the case that what is reclaimable should have been
> reclaimed already by the time we get here. But then you could make the
> same case for file pages, and then there is nothing left.
> 
> The check is meant to be an optimization. The primary OOM cutoff is
> that we aren't able to reclaim anything. This reclaimable check is a
> shortcut that says, even if we are reclaiming some, there is not
> enough juice in that box to keep squeezing.
> 
> Have you looked at what exactly keeps resetting no_progress_loops when
> the system is in this state?
 
I pulled data for some of the worst offenders atm but I couldn't catch
any in this 20-30 min brownout situation. Still, I think this
illustrates the problem...

Across three machines, every reclaim_retry_zone event showed
no_progress_loops = 0 and wmark_check = pass. On the busiest node (141
retry events over 5 minutes), the reclaimable estimate ranged from 4.8M
to 5.3M pages (19-21 GiB). The counter never incremented once.

The reclaimable watermark check also always passes. The traced
reclaimable values (19-21 GiB per zone) trivially exceed the min
watermark (~68 MiB), so should_reclaim_retry() never falls through on
that path either.

Sample output from a bpftrace script [1] on the reclaim_retry_zone
tracepoint (LOOPS = no_progress_loops, WMARK = wmark_check):

  COMM             PID    NODE ORDER    RECLAIMABLE      AVAILABLE      MIN_WMARK LOOPS WMARK
  app1          2133536     4     0        4960156        5013010          17522     0     1
  app2          2337869     5     0        4845655        4901543          17521     0     1
  app3           339457     6     0        4823519        4838900          17522     0     1
  app4          2179800     6     0        4819201        4835085          17522     0     1
  app5          2299092     0     0        3566433        3595953          15821     0     1
  app6          2194373     7     0        5612347        5626651          17521     0     1

Here are the numbers from a 5-minute bpftrace session on a node under
memory pressure:

  should_reclaim_retry:
    141 calls, no_progress_loops = 0 every time, wmark_check = pass every time
    reclaimable estimate: 4.8M - 5.3M pages (19-21 GiB)

  shrink_folio_list (mm_vmscan_lru_shrink_inactive) [2]:
    anon:  52M pages reclaimed / 244M scanned  (21% hit rate)
           53% of scan events reclaimed zero pages
    file:  33M pages reclaimed / 42M scanned   (78% hit rate)
           21% of scan events reclaimed zero pages

    priority distribution peaked at 2-3 (most aggressive levels)

[1] https://gist.github.com/mfleming/167b00bef7e1f4e686a6d32833c42079
[2] https://gist.github.com/mfleming/e31c86d3ab0a883e9053e19010150a13

A second node showed the same pattern: 18% anon scan efficiency vs 90%
file, no_progress_loops = 0, wmark always passes.

> I could see an argument that the two checks are not properly aligned
> right now. We could be making nominal forward progress on a small,
> heavily thrashing cache position only; but we'll keep looping because,
> well, look at all this anon memory! (Which isn't being reclaimed.)
>
> If that's the case, a better solution might be to split
> did_some_progress into anon and file progress, and only consider the
> LRU pages for which reclaim is actually making headway. And ignore
> those where we fail to succeed - for whatever reason, really, not just
> this particular zram situation.

Right. The mm_vmscan_lru_shrink_inactive tracepoint shows the anon LRU
being scanned aggressively at priority 1-3, but only 21% of scanned
pages are reclaimed. Meanwhile file reclaim runs at 78-90% efficiency
but there aren't enough file pages to satisfy the allocation.

> And if that isn't enough, maybe pass did_some_progress as the actual
> page counts instead of a bool, and only consider an LRU type
> reclaimable if the last scan cycle reclaimed at least N% of it.

Nice idea. I'll work on a patch.

Thanks,
Matt
