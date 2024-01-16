Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C61C68D
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCqh2kvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2281C433C7;
	Tue, 16 Jan 2024 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705421749;
	bh=+Uo21ImWV1sQ3ZZIKuu0BtbpmQmilWlkOp3ElTUJ0PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCqh2kvEhnkZylfJTMCZLW5Jw2KoYE9iPJc6fADpDj4mF+zQBnwFlwlhILJBXGwWr
	 LSlGzKZJtn5LAdAFRMp261yXgYwT4XQXPEtT+CEF+iAEozuI+HC6b30O1w50amgTjS
	 pMoexdeLlbVL3r7l+ET5ZpsHW8UeK1k7HvBKUaUc9P8JRyGC8JK05W7KPDzCqYdgKB
	 +D/pf2/ZYJLbNgEjgzzJd/0BIQZGq7XqPCRtv004oHyfGHUf3gjrKC8HgnVJUgxPmj
	 +bM5mPVjMLxqCSWyLd1G3+k1I3uJ+XJITX+FZswE9+JEQCjhBb54pVB7bqfxoI1rxv
	 8Zk+95JypCUAQ==
Date: Tue, 16 Jan 2024 09:15:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: bio-integrity: fix kcalloc() arguments order
Message-ID: <Zaarswh89NBfpW8i@kbusch-mbp.dhcp.thefacebook.com>
References: <20240116143437.89060-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116143437.89060-1-dmantipov@yandex.ru>

On Tue, Jan 16, 2024 at 05:34:31PM +0300, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.1 20240116 (experimental)
> and W=1, I've noticed the following warning:
> 
> block/bio-integrity.c: In function 'bio_integrity_map_user':
> block/bio-integrity.c:339:38: warning: 'kcalloc' sizes specified with 'sizeof'
> in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>   339 |                 bvec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
>       |                                      ^
> block/bio-integrity.c:339:38: note: earlier argument should specify number of
> elements, later size of each element
> 
> Since 'n' and 'size' arguments of 'kcalloc()' are multiplied to
> calculate the final size, their actual order doesn't affect the
> result and so this is not a bug. But it's still worth to fix it.
> 
> Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
