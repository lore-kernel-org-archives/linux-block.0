Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696561;
	b=0RvelwGDVlJpUAOpqfDu59U0xOcNzx6CSq3uTvF64+ftJka35+taXd+n2WacsYPfwQvq
	 mNUjr71TarPEtTLPs/Agj5IlJ30d/jT+mwfyj/ZObgsGBbOif4Gl/TXXntLqOqmL0Fnbs
	 IJmD6IV56C6CObdg2itHfFB+0cip+RgvC+8gEg7TcAeGu2vMBLOcxG7n7yt4JxWCFMNLs
	 m1T7Zv5zc2eQ9p4QTraBraO/sd2Yflha13XU+5klw5Zf7UbH8E7/Q9jZT+fzebMwQ7WRq
	 4DMLgTmgGyTbWlIvETjgt+L9F5Y4ezDrlixeX0LayNlg65JChe4YDnEDFqRC7FbF+Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=LWIvex+EJW9vCLXQbA9ZAE7jkop1tjSSd80f2cNzUHA=;
	b=cC2SsLHrEnWnW36hOlHS8/qjm7tYMpX7y21VAjTl3DTzLCT7iRkXuNlm4zdjfez6hGh2
	 ajq1jhica8AcK1N0PbM3PnF1VNIGlfsSsYd9sIQXWr4vE8jgGtWMY6HkEWYUHsNRK76io
	 qgKdustYg8d0Xj+YDtlf/N9V7EIfE2n4iCLMaYm3o/W+xcI7pkBsWF8oBSfBo04LlEbkk
	 vdO3Sm987o00IsxZQOYSEv2AdNxELARPqDGnKDN9OrZuOO19/Zr58PNsCjb09kGmTOFy3
	 kEotPhmbs209hfPTPqvquMiqyQ6YcRXguHhiteg8DbYNuG4dC43F8Wb9ChJ+8IyJXGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m+OOJcoJ;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABA606A326
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 09:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EABA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m+OOJcoJ
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67a2bd0c297so3240263d50.2
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 01:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793696560; x=1794301360; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWIvex+EJW9vCLXQbA9ZAE7jkop1tjSSd80f2cNzUHA=;
        b=m+OOJcoJwiL51jeriWTMyZuiFm+or1dUuGcCqkMhaZwIOB/kSTKFEQPIGr8WuK9ZEo
         LRUy4cn/m252zf6081d1O1HZrLCt2WU0XnubtKsyQVXOLit23DtESUj3D/NFVSSkFwAr
         X5iT5q8h5NsF7CayN1uFj+0erKrpInD1Oe3cNsdDx7Pvsa/BY3SRpbKNQgHpLo/W+A5i
         y9CCgIHXgaFG4rHMNUx8sH4uTctKrt3SVqc+HENJQjChpR2R6rP4ZFQa10iSJMgnahi2
         /V/vr0PYDLYyt3fh28qy84cStFAon5oOZQWfsrpZj3oJqIoJ3M1QwCNytFqLMFVYK+K5
         Q6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696560; x=1794301360;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWIvex+EJW9vCLXQbA9ZAE7jkop1tjSSd80f2cNzUHA=;
        b=R6uTCkzh1JrJO03EboEEaOHNAwortAHgHe09urN55Nacfb773zDcYpFv7rXKggoO5V
         1H3OYQs4uExO4mB8Wya4g49xgnxqoW2zXQVO53+8XkOnKQqExIU4VQLA6RnoXb2kSr6e
         Ovu/vxBAFRk/Wd9T6VJ7jBc8QC+6Xmhbbh8pw0dP/0hgjXKerk2sYZSZxWDILYdjd+GN
         k18WKppTtgGQG7oV4/xB4uvhoX5klgK5I81tARrXHmyTCy+FkI+4aoACPrO51HDvs8ic
         79g2QNZR7LsD3L5lpDVS63ihrCqQbGnegyBY2jCOYkfT4nyP3pLhujZD85HMzWBsMZro
         N3hg==
X-Forwarded-Encrypted: i=1; AKwUvByXGP9jYs3DwYc19n17vSRN+lyyPO1BmC3+eAPjjv/0j936cFYJg3HtxWBmCGy0ZasdXMX0cGOjNZudwQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+R8JzEzFDmoANTa51TgzXMt0+74kPQwbt2zW9zUpvtBCpRwSm1
	YmNOSZcbQCTT+6mz6YVhthsZMIP+SVsTJ5/jtrj33BMIkKoijGlgT/Prn8RvyADJZA==
X-Gm-Gg: AYBFou1KsCINUGwAAnVdOX+RDUzlxf7RTLNLe1PN/xGpBwyTcNsYCJHFox4sNobVkPA
	qgXhIbtWP2dittDyZnkax7VwfMs+YidACnR/zSx9UHhiifkb8fMtxoWmbKQCTnxFTBdT95gPfIq
	lvQ12LyjRqwVrYfoUmFzFDFGlUUgkYQ/EHBHb6z7jl6pjb3JaqqEKexK+wlQVwukuFeoqxf5ypp
	8kar5+cEunka7KXlBMUnRrJLsaMlNUyC1P2PE9YxWlo3DJRxm1vm3ZpsY9QTvaKPAW23sTYEucS
	JcxNdbHBdeQQtvi19SYwWjBYARbYi6haQhKPNI+Mvg2+9hCMWzQURqSp20KsGums8cM3yBScoXZ
	Iy7AummTz/1IuPyCj2ITc51tOW8zvcUOyqV+eCKoTKv/ns6r5++BUk92F1Nt1LCZ9OC8BeW9kKO
	EyV9dZ2MGFW4BNmU4udBjuFYaMQWKwJHMnr2/oBBpV0KQMgyuRgeNDaned/OxlM0/80cSuFw9ZG
	G5sGpNyfv+f1hPDtgfcV8PdolUpdkdJOm2H+1STJYsvXTrxC2H8FKs901pwgbu5Kcls1/BxL4vf
	jRDeCGrikHgmyK6MeCEykBQd4IhcSuqBbbPTkYDPuEum3w==
X-Received: by 2002:a05:690e:191a:b0:679:8dac:aa85 with SMTP id 956f58d0204a3-67ba4fbad8cmr9812036d50.25.1793696559513;
        Tue, 03 Nov 2026 01:02:39 -0800 (PST)
Received: from darker.attlocal.net ([172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf148ed8sm6751439d50.3.2026.11.03.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:02:38 -0800 (PST)
Date: Tue, 3 Nov 2026 01:02:32 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Alen Karnil <alen.karnil@ideasonboard.com>
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
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 17/26] mm/fbatch: no lru_cache_disable() in
 __alloc_contig_migrate_range()
In-Reply-To: <4898b6a7-1824-412a-aef0-ae6bde021e38@ideasonboard.com>
Message-ID: <304cbee9-0f1f-e1fc-7fe3-3cc4935a0d28@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <84ed3bf8-da32-3447-0577-052c5d1a56b2@google.com> <4898b6a7-1824-412a-aef0-ae6bde021e38@ideasonboard.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Nov 2026, Alen Karnil wrote:

> Hi Hugh,
> 
> I've come across your series because of a usecase I have, namely this patch.
> 
> Not to bore you with details, I got an IMX8MPlus with some cameras.
> Due to the cameras (and other associated HW), it ends up allocating multiple
> framebuffers using CMA (currently 16 per camera)
> which is quite slow (~200ms for a single camera).
> 
> I've spent some time profiling and found that the biggest
> stall is when lru_cache_disable() is called. Just applying the patch on its
> own, I saw greatly improved performance (cutting the delay almost 5x).

That's useful information, thanks for trying it and reporting back.

> 
> This is on a 7.2 kernel.
> 
...
> Can the patch stand on its own?

Yes and no. Yes, you can include it in your own builds if you're finding
it useful: it's not going to cause any corruption or crashes or suchlike.

But without patches 1-9, it does increase the likelihood that, once the
system has been running for a while and memory has become fragmented,
compaction for CMA allocations may fail. It's a temporary failure which
the lru_cache_disable() protects from, and maybe the retries and system
activity would work out, but there is this increased likelihood that your
camera will not work when you need it to. (And I don't know how long
the camera's memory buffer is kept, between uses of the camera.)

So no, I would never recommend this patch for a release, without the
preceding patches of the series.

Hugh

> > ---
> >   mm/page_alloc.c | 3 ---
> >   1 file changed, 3 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 12fac9084c48..3e085a25a776 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7147,8 +7147,6 @@ static int __alloc_contig_migrate_range(struct
> > compact_control *cc,
> >    	.reason = MR_CONTIG_RANGE,
> >    };
> >   -	lru_cache_disable();
> > -
> >    while (pfn < end || !list_empty(&cc->migratepages)) {
> >     if (fatal_signal_pending(current)) {
> >   			ret = -EINTR;
> > @@ -7182,7 +7180,6 @@ static int __alloc_contig_migrate_range(struct
> > compact_control *cc,
> >    		break;
> >    }
> >   -	lru_cache_enable();
> >    if (ret < 0) {
> >     if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
> >      alloc_contig_dump_pages(&cc->migratepages);
> 
> -- 
> Thanks,
> Alen Karnil
