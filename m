Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DD25A329;
	Mon, 24 Feb 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415143; cv=none; b=fwYt0XrNqeqmJLHwh35mxsJoLwbHMGLKMozVqEbd0np6fo8p+OdQMFfUkMZVgMnROM/ifYXuh/fmQT/XesMOeUJmj2GExl/RLloI6lOHp2THSBACQQwEtMNKo7RYvrRlpLsfBXQHvotH2UCqPaNQs3RyMq3lZCs+jAlII2y8/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415143; c=relaxed/simple;
	bh=qBKzDyjWfLmWXprxvnJItC7T8gVRv1MLXFy5GtdsfPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkVm7oCSqD6Q3zfTB3FVD28KzLMZTtgWnZP/fAA4edU0+i8UUbdl4w3VNB5+afRzJztks/yOD3nYyQWRSVZN6Kh30iWtLuHdn5FoDG/sVuP1nWjFexf40a/HnvV7tfkgr0bvOcS+NoZNPH7hdD+lLlwVi3n5XtG7b5C7A1dVI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R8lPeSA6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8lPeSA6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZOAgTK9YJm2QBLwD2cDF+huwjTvookcaPAGHBGMqPGo=; b=R8lPeSA6+vDeWo/u/01PmcHNH/
	U7mccx6QQI4/4O3P3i10HXQbQmlQLuSrSPzdM8zytB4x/dXj8T3pLb1uw0DUSxZ5uHGMjzx8m7kAS
	T/WYHhxgmFlmjM6xwKKA02UyeYPEorVKgO8aRbb4vJVO2K0lt4XYP8zllJDQUkx5FcILPIYOKd9Ea
	TNw6vjireiWCc0MQ6Kygl03dc7aMQY0itFEwm9YYjgZJhfsU+BJQnVeKdCxzFugA+12Ac21p4bI/B
	uuzLSrVoZoN0pNWXyNuiCKAWxYTnXC4j9GbpXLlhp0Pgd6ET/vudISihJsta53LLc/4fmnvRnrnES
	TVmUDw9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbTx-0000000ETEn-2onk;
	Mon, 24 Feb 2025 16:39:01 +0000
Date: Mon, 24 Feb 2025 08:39:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/8][next] block: blk_types.h: Use struct_group_tagged()
 in flex struct bio
Message-ID: <Z7ygpff-kUHPtEQp@infradead.org>
References: <cover.1739957534.git.gustavoars@kernel.org>
 <ccf673b997e771430b7570fb8a6dfc11d07a2bde.1739957534.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccf673b997e771430b7570fb8a6dfc11d07a2bde.1739957534.git.gustavoars@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 24, 2025 at 08:25:08PM +1030, Gustavo A. R. Silva wrote:
> Use the `struct_group_tagged()` helper to create a new tagged
> `struct bio_hdr`. This structure groups together all the members of
> the flexible `struct bio` except the flexible array `bi_inline_vecs`.
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> 
> This new tagged struct will be used to fix problematic declarations
> of middle-flex-arrays in composite structs, like these[1][2][3], for
> instance.

Well, I guess this goes with the context-less nvme patch.  I think
you're much better off just removing the bi_inline_vecs array entirely,
and just add a new structure for bio + inline vecs for the few callers
that dynamically allocate the bio and actually have inline vecs.

Similar to what I did here for the bio integrity payload:

https://lore.kernel.org/linux-block/20250131122436.1317268-4-hch@lst.de/
