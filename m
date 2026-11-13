Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554782;
	b=QFTR3A6xcTi4MQTfO00TXxms+ZiK18kNxQM36ytsDHu3QSpslOPo0D88VUCOIkgIFks2
	 XYs+QXFVJeE5hOru4iVfyw4/NU+aTnb/IpOUP+KWhcHDaje1+q+1A1DpTX5cK4Ze72r/a
	 eY1aTyPRre3UEYqeMdNJ2PmuB/Oa+m9m54bdDluJrY16ZA/go1k8z8ukudDOvgYZ9Q8WR
	 xxYIVgp2DsPafeaAyi2OsAPY//mQ3/Aisz2Y/kkxGEloBOQg50tyiu7WUBhoWEMBA+eFX
	 9nBjGEjf1j83hRiOWkUQ1iylzMYcOkhxAfMnYmgApAudIGn/eo6+YhWOX7vfQvyZwjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554782;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mjetfSPbiI8lpCBkAc9d8XX/FbfRsCkUf9M0ZvVFMfo=;
	b=ac2a6++esm63hbslYKUcbn0MV8CQTjgEWiPm8T5Lkdbrxz1+NRCYf9wnbNkKv7vlD5jK
	 HGn0PuFjh0cYQvRDSIXGnLxn/CdfXWV+7NRrfONY5VwDfnXGELs465xJZWAmW/SLeqZ8C
	 tuj+JZnrCfDP8POctG4EB5pRcFXV8PubVusKD+GlCAWNN+UteSjx7Bxp98OCW7fl5RJCo
	 XZesjB2B6UnHULz8AgGJD7o3lfbswYVFEZcxpETfaIa6cEgRTePRxXn8AYktcNm4EEoyn
	 gRjGTHpsk2bYs227dxYp262eUdUufaW+xuZgvFeiimTy6mUxAh3OAsfPXjOVXmu6ZbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=pBI7ON1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F96606A321;
	Fri, 13 Nov 2026 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=pBI7ON1M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551521F000C4;
	Fri, 13 Nov 2026 07:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794554782;
	bh=mjetfSPbiI8lpCBkAc9d8XX/FbfRsCkUf9M0ZvVFMfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=pBI7ON1MSiLCMpsXkclVp2s4htuA6KX7gsbrUSt5jIBYqpWSgEPrJtVMQWPhS4Tew
	 akJdCZaHtme9YY8L2SZbeoQBt/DfoTBZqoXBQ5lUfUmCM7R2/VAF3zq0taItxmB4SB
	 BUIcADXrNinI7DB5jqXHfQSKMFWh6s1SVKhHY5ho=
Date: Thu, 12 Nov 2026 23:26:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, raoxu <raoxu@uniontech.com>,
 minchan@kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] zram: Avoid duplicate slots in batched writeback
Message-Id: <20261112232621.6e8916a6e92bbb1afeb1e2a3@linux-foundation.org>
In-Reply-To: <avK6Y1VmIYIBrorl@google.com>
References: <F24EF6333964B482+20261110061830.272091-1-raoxu@uniontech.com>
	<avK6Y1VmIYIBrorl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 15:40:13 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (26/11/10 14:18), raoxu wrote:
> > The writeback interface accepts multiple page_index and page_indexes
> > parameters in one operation. Their ranges can overlap, but
> > scan_slots_for_writeback() only excludes slots that are already being
> > written back or marked as same-filled.
> > 
> > A slot selected by an earlier range is placed on the post-processing list
> > and marked with ZRAM_PP_SLOT. Without checking that flag, an overlapping
> > range can enqueue the same slot again and submit it for writeback more
> > than once.
> > 
> > Skip slots already marked ZRAM_PP_SLOT while holding the slot lock. This
> > keeps each slot in a writeback scan session represented by at most one
> > post-processing entry and leaves the existing release and reuse paths
> > unchanged.
> > 
> > Signed-off-by: Xu Rao <raoxu@uniontech.com>
> 
> LGTM.
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Jens, do you want to pick it up and route via block tree or should
> we route via "more traditional" tree (Andrew's tree)?

I grabbed it.

I did recently attempt to pull zram out of the mm project, by moving it
from mm.git's mm-unstable branch and into mm.git's mm-nonmm-unstable
branch.  Because "why does the mm project contain a block device
driver".

I undid that change after about a week - it didn't work out because
zram is joined at the hip with mm/zsmalloc.c.  zsmalloc is also used by
mm/zswap.c.

Oh well.  afaik the zram story has been going smoothly for a long
time(?).

