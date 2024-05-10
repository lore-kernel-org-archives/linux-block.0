Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208713BAFB
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379585; cv=none; b=oG+8bxCTGapuM487YmTKQt+p0eIjx52mxPmpEWmOUAT4l85BAC2aokyVNc+cF8Kxj0Sus6uPPyRbBlQrRWIf1WM49z80ZpjJFXaBoDajFA4QDpi+gXCMR6pTWhD4dJ7evNbTh4jpRSxEKxQtjNg5fmSiUejZUDQpKBQEnQJcddQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379585; c=relaxed/simple;
	bh=0XffWd5sLG3pDSlUKfM1AJx/oYw1hhSvrwpfCMuquXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg1Y3FrlnYISa/wLbR4zJIr36Bh8r2cTJjKvxlY30a08Lmgj9DDOKjYSsjXJTaIwzWpyolxMzD6bNB5BV60q9iwBK+V0g6LCwPZdWJQWOYrAd+Rz3URdod7T+OzOn7ODNAWf9/w04SG1fcXTeaUjRjU3oOLeMYpnY+3TmzTAzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UWW8rNo5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWW8rNo5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hBrnX+U4pxDm7jtcvPTU+zBs2Ty6Lb9srPF/queK5b8=; b=UWW8rNo5+wP3OEtQWhtBvWYjYv
	MGWITLSJ1MEEzroRx6lXiYPQDQeJYKgiEjTZZisYpgkFAMwK8DzfFfz9T877tIgWZ6M5kyhpZcpRh
	WGyhh3MVNw//vQRpENVlUIJcK97i1nSxVOVu92vlxtrw1sIt5rpD9jkh1gReHciR0kjY10uW1xGgt
	5wCfmTqkcVKeF+gVQ3L284xijLAmESSG0DuXe8nxhU3U9bSJtme0vMZAH8NmqviSiYDOrHAAfePbj
	+I6UMOaPy3JxXCrTXvKJ703iGuO7BQlpvCCJ+vfxwoTewCiumxZYJRf2jJdzQsJkqNjhSj11tYNWc
	e1pb3RNw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5YaT-000000043J5-1hlz;
	Fri, 10 May 2024 22:19:33 +0000
Date: Fri, 10 May 2024 23:19:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/5] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Zj6ddYvmb2uIq5Ec@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-2-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-2-hare@kernel.org>

On Fri, May 10, 2024 at 12:29:02PM +0200, hare@kernel.org wrote:
> +++ b/fs/mpage.c
> @@ -114,7 +114,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
>  		 * don't make any buffers if there is only one buffer on
>  		 * the folio and the folio just needs to be set up to date
>  		 */
> -		if (inode->i_blkbits == PAGE_SHIFT &&
> +		if (inode->i_blkbits == folio_shift(folio) &&

yes

> @@ -160,7 +160,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	struct folio *folio = args->folio;
>  	struct inode *inode = folio->mapping->host;
>  	const unsigned blkbits = inode->i_blkbits;
> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
>  	struct buffer_head *map_bh = &args->map_bh;
>  	sector_t block_in_file;
> @@ -168,7 +168,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	sector_t last_block_in_file;
>  	sector_t first_block;
>  	unsigned page_block;
> -	unsigned first_hole = blocks_per_page;
> +	unsigned first_hole = blocks_per_folio;

yes

> @@ -189,7 +189,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  		goto confused;
>  
>  	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
> -	last_block = block_in_file + args->nr_pages * blocks_per_page;
> +	last_block = block_in_file + args->nr_pages * blocks_per_folio;

no.  args->nr_pages really is the number of pages, so last_block is
block_in_file + nr_pages * blocks_per_page.  except that blocks_per_page
might now be 0.

so i think this needs to be rewritten as:

	last_block = block_in_file + (args->nr_pages * PAGE_SIZE) >> blkbits;

or have i confused myself?

> @@ -275,7 +275,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  		bdev = map_bh->b_bdev;
>  	}
>  
> -	if (first_hole != blocks_per_page) {
> +	if (first_hole != blocks_per_folio) {
>  		folio_zero_segment(folio, first_hole << blkbits, PAGE_SIZE);

... doesn't that need to be folio_size(folio)?

there may be other problems, but let's settle these questions first.
