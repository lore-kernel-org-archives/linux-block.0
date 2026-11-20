Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795184413;
	b=0d8Vczt9O+1w4giJcHpz8uildVGovA5ojndzLZbf5tFheUSvqwOLeMXccxtPHTqQ13RH
	 ZwZ6Q43Wwwtv6eiVXqC11hsqtMphPZJjV+1KlXxWSN3csB9MspkwEX8eT33N09/SDAi01
	 5RgBSx9ncMW04/BZK7bs/VPPwO6kUnqNr6mzZfrDfGXA/Dp/ZvwRnG++gyK6+XdkO4tnJ
	 Sm8XyZRE0lf3Jsxs+lrjziohWSsbE/CRMCiphfFijhiFzMR3AaPVXLj9daL5c53K6CZu6
	 wmBc8LOnBvfs8CcJe/cluQRuHKYx1hio+KGzngaH98L6nbxsbtqNWvEK1qytQk/Ww2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
	b=Ejs8emhnOclyr9WK4wYNXF0KLG1oFuHZNw1uqjhMgcDQBfAmepNwmNRybP7/Ig5+fOPn
	 ztcGmceH40GFf5ZUMcRQDeOYXsFK5Ec8D31MY32FPA6oyWB4cogBloCHBhWPjksFXKHk6
	 5zUQoZXXdCh5I5uiAbdHIMqGzvKcCknJS9mQpf8x5lp90uTWwJse+40MnRU0GG2vFHS6S
	 tktGH0Eq3AA1iyhu7b7ThhwPDduhPtWq1k2ZoiCgzAeAmceEjKiAO68qYEli6m4RzL4xY
	 hA3bjQceejY+wJul+iX9rRce2KIBrXKUBSrpoXdmjjTvCAgn6bM3GSWYdHvH/6ZSmLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aPrxrTV3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9E606A32A
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 14:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C9E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aPrxrTV3
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-54492d8a988so289021cf.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 06:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795184412; cv=none;
        d=google.com; s=arc-20260327;
        b=CfqH8/SMWAH3ISLoqlAqjnl1YwSmHvo5ORw7f4bmKylr4aafGEHqlDcvb73qIYhqn4
         Zc3Do8xuBrKNkjP6fuz9fFhu2Eott+MRv8PvEPxUO9DUAZh49EF3V5heHKFYG0JfZmTd
         lwlPgvFNF4K9O4LR1c5914MgFkowXNNZWctug2qMVm+cAq6l5LVLDOQHOE9RETz8umAN
         T0UEPST7lRKcQgRxRBKqSfooqDw8RK2B/EvsAA3teaWsiAQZsZOwne7lyiQ8x/ofNj3r
         xEDZaGqHp5aQpnFOmSla7ZdWMfNkMQaffugeS6HyQ55dDlzHqNpm8wYMihw4c0ThwSXT
         uSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        fh=p0tjlkDknX9edQO8J8+ShN8JICQxHG8kZ1j/oln3kqc=;
        b=ezcdF90TJnTJl+E1LB5nGuViEJT7q1Iegf7721Ufj5uJOsPP2bVui5wolJPH1pYX99
         5YmheNGcK5rjQmcdSVxEc1V4I+M581kRdWBM1FYyp+/UzW7wWlwsGt7OeNQaCMahoD/N
         niJiCgfZUMg77gGUJqzbw1pjRaxXpUiRTKxTp/A2cX1ZXdfNzlr476GqQF0LfOD81AG0
         8hluIt5WjAUGw2EK9CMhpNpky/eDpQvCnCo3D50nTWhQx00VEGoHMkD4R9aSdPJetEKe
         2d/HwDD24y5FaL+6ivte21KMu7J9yCsegWOaiqu/02b6KKlix8MGSEQiLZ1FZnagjYXH
         A9CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795184412; x=1795789212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        b=aPrxrTV3tjNKVZRe0o/QZnrHtJ88Cq0pnVQFh7mHgAvBJzDrEJpUWOT7AK49X/t9t1
         p7Vunzt0X2Jci5rymoMAfsIElmpqm511Q1t7p8xn1jTunsDcwP+6GaXxEB2IFTgFyMZ9
         0iof2il/XdRNNVwakcxSw0onlzvNI9i3hcQnJoO5i5GHUKuFzFtrzC3+IMt6INHHgjGk
         xqTd0Wgb4Ec0WCLoQA1db0uoMdVOIYDq9ySwBT+7Mn0wwGKDTjTrt/aa7XbbUc+3QID5
         2e3M416nZRs+/ass9ys+Ro5LBwyHkmnva3YwUsJ7NnD60k9CYZmdfaxSg5dN/4GGjxa8
         eNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184412; x=1795789212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        b=q96nNkri7xXvdqudVbzZY2WFGcyJaywibO3mOfnTWP3E7SYj1aVQZ9pXh76xMNvp2p
         r1dxKqMAzq4RluMvgTZfF1EA8wt9+nrMC+qwRtmNBWJcQqGOHzmQk9FblICES7gZbFvS
         qO1ImuERwaJUCcKDJI/5a3ABSznLgbWcX4Lc4FfmmbmNKJxCm27a3H/2imknLpGOtnO7
         +U4pvHAPch2JpCLYRqyCpE1xX46pX/xZZLeOuaAbwf+QgXjmakFGv2fusuUb5wDSG4Zc
         yZaaXM4yWO8kYAMitOE0D2LBwC47pZg8HXKprpHSc8V/klpS/yTIzMl258NwAHrFotws
         JdVA==
X-Forwarded-Encrypted: i=1; AL+hErG3QmDAhgkxpCdLv5bNAmfV8fVmPLubifbA1MJxTAmtY7PtTIom8xrzwVsYcCV6Nb9RXpTI7sBY5MSokQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/b05AVHf6ekywuLtJSU6QcxKffgXC871FH18Aam1XIeyziifvv
	5IwTprfBjvHCAElnxt/EY/7QSAhwWr/4pld6EJnGD3rswvRfAwYmb7hBixkLvqcMReZTMsV4Lx/
	6Bo6sSGG+0DdZ5RRbwvZT/CTYTJs6kVqsjgJCpH1K
X-Gm-Gg: AYBFou2aLohqnQhW6fudLfkFHwIMLvsP2V3bSA9SoCfBAPuT/F8enLF5+BKQ2DCaSb0
	zA9lxTZ7+5PSbRjiA+BRQu0CTcgwEN84B7J2l413hgpXCDPkz9oXrUcWNf4STrNu+P5+Ut1LSrF
	d5xq61kSCt76fGCLnCzsmg8+ZZjWpvE8cplaXAeWqflRrB2jrvpX+rw5nNYNjLYSXVQtJ7/LiPB
	zWF4vJ3fyPDLoc6tGM3TLdQzq1r3YmgO0sc8yJWFxfOC1sa8ubJc2UlAV4gh/Prw+pGqkpBZD0u
	9SPyGXxooZLAr2/3Pz4jxlpUXbs6MIbSDfnLCm+57bBHgeW9ryGcbfEHxUk9gbD6d6ymKkRIBxn
	Qo1wrTs6JxkWfiuszTEx1dAmAkpKZLCEMYNdmfA==
X-Received: by 2002:a05:622a:8c8:b0:55b:ce7e:e65 with SMTP id
 d75a77b69052e-55d7a37902amr16973301cf.12.1795184411359; Fri, 20 Nov 2026
 06:20:11 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
 <20261120135013.GO3115493@ziepe.ca>
In-Reply-To: <20261120135013.GO3115493@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 20 Nov 2026 15:19:34 +0100
X-Gm-Features: Aa3M54r79-wonm4abHk_49DjjJPxLMhPkMzG33LcM6yDH6fwirGgzaIY398cqTc
Message-ID: <CAMOZA0LmZ9PFzxLcc1SuS8piFyZu6P=vX_qR2jy-3QRUoNCUKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Dragos Tatulea <dtatulea@nvidia.com>, Naman Gulati <namangulati@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> > This is v3 of the RFC previously posted as DMA_PMD [0], now renamed PIS=
A
> > ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> > Documentation/core-api/pisa.rst (patch 25/25), which has the details.
>
> I thought the conclusion was to just do this stuff in netdev pagepool,
> now you come with an enormous AI series spread across the entire
> kernel?

There were surely comments claiming nothing outside net/ cares or needs thi=
s.

I respectfully disagree, witness is the fact that e.g. there was already an
io_uring proposal which is smaller, but does not address applications
that want to use the standard disk I/O paths (libaio, buffer cache etc)

Nothing has changed from the initial series in terms of size, use cases or
subsystems involved. Large files are placed where they should,
the series covers the same three use cases (disk, network, CoCo), and
touches three parts which it has to touch: mm (most of it; it is a
memory allocator
extension after all), dma (it hooks into map and unmap, not a large change)
and net (the pagepool change is a couple of lines; the tx path needs to
touch more places because the current stack assumes all paths have
the same I/O requirements).

For CoCo, there are very fine grained controls so the bounce buffers
can be enabled only when they don't pose a risk, which in turn
depends on the threat model.

Specifically, for network tx buffers or disk writes, the user-to-kernel cop=
y
is basically a bounce buffer provided it is used correctly and not leaked
elsewhere (which is the design; of course the implementation
needs to be verified and possibly fixed so that it matches the design).

cheers
luigi

> > - Needs bounce buffers: in Confidential Computing VMs, PISA allocators
> >   pre-decrypt 2MB pages in place, avoiding swiotlb bounce-buffer copies=
.
>
> It seems this was ignored too. We want the bounce buffers in CC. They
> serve a security purpose. You cannot loose control of the shared
> memory buffers have have them leak into SKBs, user mappings and so
> on. It is not secure.
>
> I don't see how any of this is valuable or necessary for CC,
> especially when we really don't even expect to have an vIOMMU for CC
> very often..
>
> Jason
