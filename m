Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC63CF95C;
	Mon, 25 May 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693386; cv=none; b=Dlznxz4m/Ijf6AarClP1JbUZvDH3jbdYhotJiUF5qwceyueF/KN+krgO31d6OSsrZCtNFASPBhADUYri8Ug/xc/gfuGBjjL3pf6rPeMYwzld/7JYx2FxlP/vf9ioXcK7+3cN5zRAdOksiikRmVeYUT9gL9ae7nIIoxGEZWsDUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693386; c=relaxed/simple;
	bh=g8W22Bw5iNSk5w3Ew4aSOSGxIWIubPOgcGP0hR0gwdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv2B2dF8V13XeDsiuFWmb6z+EOAwj4NDu7N7d2eHdDJtzGI8s2nasSphoHZu2qywbF3yK8+dpqY23vWkiRM1GWJYvngGIspHyFTCwzphNqgY8/I+ymLLwnwPKCQ0YLLSrxJmaHCXUGh5mEeNhR0CRhGB8d1qVkMBRUdxt9NvvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=orbBgvPD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orbBgvPD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BlgskWC4o5Qm0DMaNhMfLNKI2AtdeS9nvBrbJtwACp4=; b=orbBgvPDaxmqagpne2detWrEEp
	u3RL+AZpBb3xQQH/2ZQrAY+P1ADM4Z8zcgBuJVsIZJoY9OJKcERabXlGyjePihqKXYixveQ+D4GOy
	eoY9katUbX6HiGom0p/dcIBdDXr3bhwU64i5AhjJ+v+v8XNYh6eDjzB9+kVyZHHoYWr0RGqKpN9Qu
	7wuxU+dAkV+z8KPkBkkHxXoqiTvp59JSsrG0F/aZqe3hfknPlJx0TpWVAVqqdM2ybKK+BlhqMoeDA
	LDWGMt+8ac+Rz9BT0CddOWkt5/Jh4yqbgvqTXRZfhcYt3r3dxCElCSyDqNfYrE4WXVNrldHn8zkyL
	umMMl9GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPXz-0000000GVcp-3QkF;
	Mon, 25 May 2026 07:16:23 +0000
Date: Mon, 25 May 2026 00:16:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Message-ID: <ahP3R2nH8-bHMVf0@infradead.org>
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org>
 <ahPxmSqT4Y4jcAbQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahPxmSqT4Y4jcAbQ@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 25, 2026 at 09:52:09AM +0300, Mike Rapoport wrote:
> On Sun, May 24, 2026 at 11:08:31PM -0700, Christoph Hellwig wrote:
> > On Wed, May 20, 2026 at 11:15:52AM +0300, Mike Rapoport (Microsoft) wrote:
> > > check_partition() allocates a buffer to use as backing buffer for
> > > seq_buf.
> > > 
> > > This buffer can be allocated with kmalloc() as there's nothing special
> > > about it to go directly to the page allocator.
> > > 
> > > Replace use of __get_free_page() with kmalloc() and free_page() with
> > > kfree().
> > 
> > So I heard various vague references that we should replace
> > __get_free_page with kmalloc, but nothing definitive.  Can you please
> > point to a good resource for that?
> 
> There was quite recent discussion when I posted patches that change
> __get_free_page to return void *:
> 
> https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/

This doesn't tell much more.

> And an old thread when Al posted similar patches:
> 
> https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/T/#u<S-Del>

This does, but it still fails to explain why kmalloc performs just as
well as __get_free_page(s) these days.

And such an explanation or link to it should go into every patch doing
this switch.

