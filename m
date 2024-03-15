Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FA1B810
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527253; cv=none; b=TaAhWKxvMXvyzMNf5LYmdPgeiTYHMsUXKdNK3DQsPITKoOzwSTVNoyZITWNRttqkkvgRaqkxem0IQxDptiB3GBFI2Gemq2ZYrbCQE2IgtngXOKHenC0jNBv2Cgczmu/Bva5OlQsJN4TU11lT84f/yuojsNYK0w9e3Olub3+hp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527253; c=relaxed/simple;
	bh=t7zsIKUnhTV4TD2I+phz/Yy/i7u16fE6nmD3SUFjtBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsFR2UaU8FMiatfJmchz7tE8dT2MqPE7LmKS0q0luzBclw5XE6YLC5xZ/KrZgQ5pKdf5UJkobsTa8238QVMFHcMQi5Nx/Y9SNsTYEigC2iuwvXSpHVBEKV1iinvl/UR3CS+kJTY6481Lfk+oDTQXmr446L4K/vOYWDhSBhAXXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2uwpXQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2uwpXQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51447C433C7;
	Fri, 15 Mar 2024 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710527253;
	bh=t7zsIKUnhTV4TD2I+phz/Yy/i7u16fE6nmD3SUFjtBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2uwpXQ13ChrVUGLUn7Q7vdMoBDOyutqbPnP2PpM/S5uWEagZVAxcIE63GlGzqhq9
	 0A5F9u31ev/8Vt96A97IIo6gDVgmE8344tW+EzeZXMLqjWnU01osZobv/J8QkvxWTW
	 uZz8nfbPVe3/RVc/Ee9/OHsFJT4JxNSMczgJQESBWkoOPT3+28eb/mvN35XiiTCj7U
	 ZpiB81tO640OpPIeyXV9pVouh50scXvMA1TJUvH6PctyLqVeQJG/FTpZ2Y3D+SHbz0
	 serpgrtHp+C84sVQOdB93ULeh+LpOlqp9QvTKOCEttQJ4v0GJPQ9ikQr6hyoLqTwIY
	 oircjMA3w5grA==
Date: Fri, 15 Mar 2024 12:27:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] brd: Remove use of page->index
Message-ID: <ZfSTE4pEiKjKecbj@kbusch-mbp>
References: <20240315181212.2573753-1-willy@infradead.org>
 <ZfSSG3z0rQffkwGy@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfSSG3z0rQffkwGy@kbusch-mbp>

On Fri, Mar 15, 2024 at 12:23:23PM -0600, Keith Busch wrote:
> On Fri, Mar 15, 2024 at 06:12:09PM +0000, Matthew Wilcox (Oracle) wrote:
> >  static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
> >  {
> > -	pgoff_t idx;
> > -	struct page *page;
> > -
> > -	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
> > -	page = xa_load(&brd->brd_pages, idx);
> > -
> > -	BUG_ON(page && page->index != idx);
> > -
> > -	return page;
> > +	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
> >  }
> >  
> >  /*
> > @@ -67,8 +56,8 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
> >   */
> >  static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
> >  {
> > -	pgoff_t idx;
> > -	struct page *page, *cur;
> > +	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
> > +	struct page *page;
> >  	int ret = 0;
> >  
> >  	page = brd_lookup_page(brd, sector);
> 
> This looks good. Unnecessary suggestion, but since you're already
> changing these, might as well replace "sector" with "idx" here and skip
> the duplicated shift in brd_lookup_page().

Sorry forget that, all the other existing callers just want the
sector_t.
