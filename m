Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377118;
	b=E3Qj1SIo8M7JVvP9BKXM/yt7ekfipmMzMLCPQSiwl0yiH/taCnXZ5bLF1PJoC+wKyOtL
	 144lBDJTNQo343/ky6PUdOhoPTEHvGcdklzoSNeH1do4Z8CGvrtjdTQBs53VWk5ZQdNnF
	 gmDKQ41MJKXHi1KGhpw0t139nNpvutaqF1WwToNHUeqpGo+trYNcOFbjyjnGWaqihbSrI
	 AK8Ge3snhRGmi5diNJCXd55c6Z1YeMFLNK+UOiWMs1MBNMcRtfwBqXBXZn6gU7/ZKXUtH
	 POdC39IcIxHgbCWd7QXknTMiP8EyGwodXgPUJTVEH2LImXV4/edwaqy37n0ZLGXCWDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=IM8our1qODgBYXBjuIaJFEMcF7pAsbTKhqQQH1o60eI=;
	b=wSopNY0iMM+axxQcDgshZcv/uQWmceosXYBRnCtlTg6TBPtRZIeMkQfPav1UhK7s6uDE
	 1mbElK0zs+Ug0Q5ddW/dj6FMaCG3notq9aq8F5xPvEmBHejbTnc/HVbnu+cxwiact+qlJ
	 KglkTYKY6UHCMrsqZHFLZ4Y/Qn+tKdWbtzo9j6s7vW6KLseMCQuIOImJpX+SGtv33AUAS
	 xtAYUgxnc6W0wMc4WDPiY2MCbR6AbDFyMD+aIhqjYgVA902oGuCz/dr2MCicxs8ofUDl8
	 2RX4viHB5yigrA2BvKYM5LREy7pscZSPT1Nihxe/EfV8xq6GVa/smuD2buxpxFExcgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BM3W0ImJ;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A1606A321
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 386A1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BM3W0ImJ
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso1604876a91.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794377117; x=1794981917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IM8our1qODgBYXBjuIaJFEMcF7pAsbTKhqQQH1o60eI=;
        b=BM3W0ImJ/AnF6hGKXgR5cMiYjO9JnWPpCmADsQJeLCubm8lklE3HbOnzULfoeBiGFD
         9UsR25vVppFKHNWEwM52J84Osd3lAfTkcFb1cxZd7AJdGNiqjHw8FjR5cj8sjbr0q6GZ
         i4ZT6VY7c4lNVVwOIYCC54Tr6eAwgM9EugRO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377117; x=1794981917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IM8our1qODgBYXBjuIaJFEMcF7pAsbTKhqQQH1o60eI=;
        b=sImAbsWF3HSMACvF6hklVesraPVlVskH7KF59SUyo4OgWibhjsLbkodwEyoNBrc7Ml
         D6icgJ9gFPYIpELtv05N2G19qoPhqEdv9isBhNzqrno6ElcOwcLLQ7jyZi4algujNgCU
         Lc+xFqcqYfhlgrnpp3Lyo1RoPQPS7s3CAvdJL3+25P269svknJSv7Gg2dZZEyyNYANqM
         DE14ET7RqZfaeT4sr1fItZk6FOjNrj8RNFTJzFFTxy3cNLMkT/eJC3kGJd1x6ou0ENlZ
         wgD8XoAXyr9dyJQmF+yDwwkBhGpaUpS7LeBNQkUFOMi3112nYMVra+ZzsVkrg0KAljs7
         u7Uw==
X-Forwarded-Encrypted: i=1; AL+hErG7vIPvN6/tBDY3erwcXO5/+dw/RGLvHWklJ4vw5TlERNFfBopxMdV9c/PJpPyiWXqmpA+pwxJDyoYwnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qWsxCvA13x9PjjELyutRnSvnTmhpGv4LCM4AljekAcTqL6XOT
	WWz/HO84UD5BmS5Zb+PAJVBZIAyanNrb/nUN2RQL6EFknt2RV8WESY7so5ESxLCz/g==
X-Gm-Gg: AYBFou0UCq4O9zBs8dXPDt7VFosUyqmazpuoRqhmUqf6vXEUnabRySVZRKbVT4o1Gin
	vz0BQ5DFPKIaoe/r2iL/zA4+s/Eyqqn+zDzezCyEO/5YfxUZWiy0xh22NDpk1cJlxzDdtDzisGy
	ZUvuTu1Obq1GZVbpexbEY7jk/NkQoiXwjYdy37JGlS9C6zVpHJoAAu6JF4H0waAEYTEmy6ZfpuW
	EQuL832kYqrZHiKYAWXVCSPk39RzamrN4JfV/g67O0vrKxLdpC9TbVD7Rae6JYE9yUO7fRMsbhq
	PcDU0Oo3i6NM1ma4Q4QSeqpwTOGuo01xNUBlh95spdlTZkl+Hcsbv1UUt8gQBJ+uWU3LSBF1Hg8
	cWjAuDqSdaZ+s/IUfEAzJw0KeQtXqHdM6GmwO2R1a/aRCkf/nGqVt4GW74h8NGo4NitU3qngfUB
	rasab00ZfzVrU7BBr+Nf9Kh33feYkocN6WfZWL1eMvj8DlefTzu7/h4bWPQY05cjTmr5/1WC6rE
	mE1MkxQ0aOQLujgcQn9N2cwJnNgrBGR4sFO9udQg2uUolPZ8Ww7R40grm9NreLtkSBXfnu/yqGA
	YH7CEiLC63AiOi3DEIZPjzecHq4ne1CBr3QcFObLKDoLpJFtdKTCkW4rWObpBM2S4rQ0cA==
X-Received: by 2002:a17:90a:e708:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3b182f26e6bmr1551048a91.25.1794377117628;
        Tue, 10 Nov 2026 22:05:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e313932sm2766371a91.16.2026.11.10.22.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:05:16 -0800 (PST)
Date: Wed, 11 Nov 2026 15:05:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/11] zsmalloc: fold zs_obj_write() into zs_store()
Message-ID: <avQFhb2EwjRkSM-a@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-11-senozhatsky@chromium.org>
 <CAKEwX=PJObB4gDPtsOWGjW6FJD4dtoz0qDu9KpK9jzP0=N=d_w@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PJObB4gDPtsOWGjW6FJD4dtoz0qDu9KpK9jzP0=N=d_w@mail.gmail.com>

On (26/11/10 11:01), Nhat Pham wrote:
> On Mon, Nov 9, 2026 at 10:49 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > zram and zswap always call zs_obj_write() right after zs_malloc(), and
> > zs_obj_write() has to take pool->lock and look up object location
> > again, which zs_malloc() just did.
> >
> > Replace zs_malloc() and zs_obj_write() with one single zs_store()
> > call.
> >
> > zs_store() takes zspage read lock under class->lock, before it drops
> > class->lock to copy the data, while zs_obj_write() used to take it
> > under pool->lock.  Compaction and page migration already take zspage
> > lock under class->lock, so this follows the existing pool->lock ->
> > class->lock -> zspage->lock order.  We don't need pool->lock there,
> > zs_store() doesn't look up the object via the handle, it already has
> > the zspage from the allocation.
> 
> Oh nice, this looks like it'd save a pool lock acquisition?
> 
> That (effectively global) lock can be quite contend-y under memory
> fragmentation, etc...

Right.
