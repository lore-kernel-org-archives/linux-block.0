Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EE13D53C;
	Mon, 25 May 2026 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689312; cv=none; b=ZwAHmBPPsIWFKVzGqEU/fWv2Re5D9+bXA9EtPqGIAaBsG3wQql3zwEArwBWVMwlfOoFAUPBuCgiwvo5rPut0iQ6kjqu6hrgjqJrSL0aSnHKExEd1A2zDVbBiYhTmsRgWjudfmWDq1U0jHd6ucBFPjZkUcH36e2HQRL5dopVi5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689312; c=relaxed/simple;
	bh=V/jOkVdlLWRW8bn4awrpsjqRqZqG4akxJTnW2Uw/P0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSIdNarzWRu1vB5zXEEC1Tm9IDVP2tXeDIhLDu0MI2j1K1l6VlMLoj6gErh3useykLVNK1GbkJ6VvlB2tXAxZ18zduHKaL6uF1cnpr2GqwQU3ohw8EEy0iGS9IaOlGQRotHtXpfKDUn0TEViXWcPGA2ncx9Mf9uIFrLg878Os5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=omAVCkbe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="omAVCkbe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mCg31p2xOKCKydn/P3nu+tddPYsDeLtUBR4m8q8r3Ng=; b=omAVCkbeVegfS/UW8xEIv4Ylhx
	UvfRBDpWwG6N3luMYv2OhkLkV9qF0hdpFJvl12Env24n4MZ6pPIZxiShTtOLq+Gy0xIKa9n1dHL51
	071kkDtCyoSJQuahR6eDXTIC0yWd/CYvn5jlT3MUpuh5QxExdiAaD8zLgaL61DJ+1KhHw8u0VbxaO
	8BBs3zvz1OLbN6lYcYEXe6CPpl00V5G/gcGOGxn0M3/J8HtQuGz4RTyBDYpY5lGYS4RK8Bm60GFn2
	2gJCqu1yEEC5UJa+zHK7nst0F/X2mu3vwKtU0UpwVr3nLQd0ehHELHyxa9J8ZBrTV/Pg+GJtV56j3
	wwgHiWmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROUJ-0000000GO04-1423;
	Mon, 25 May 2026 06:08:31 +0000
Date: Sun, 24 May 2026 23:08:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Message-ID: <ahPnX-CwVgK-9chp@infradead.org>
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-block-v1-1-6463dc2cf042@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 20, 2026 at 11:15:52AM +0300, Mike Rapoport (Microsoft) wrote:
> check_partition() allocates a buffer to use as backing buffer for
> seq_buf.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().

So I heard various vague references that we should replace
__get_free_page with kmalloc, but nothing definitive.  Can you please
point to a good resource for that?

