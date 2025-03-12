Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB123DE80
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781957; cv=none; b=q3ddTyv9lWZJFQLjDvQUcnhUdweFwdHCZB7dOy665o7Fgmij2zE+fsZbG/Qcv29+z2U1BHKnHcSkoITnQDB46YeFJuqUokRTCkamcgJ/QiPUTpR0XJz+2T/R/wH8K+iHAMXo9JK2mCq13jHK22wy/78SLzzfWTy3ArXWLuv6XC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781957; c=relaxed/simple;
	bh=BWuDljHVuDUljr6cNXW+iGfRyK9qtjv01gG1xShZXvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpakBqj95xpZZXMc4fkMnwORVnfpRxkKXeQsyvds8RZl/EjYkwf6JVLZqJIjOzuvVfHeLN2uNj15CshG0gXQM6I6jNCWtih9AxbLi+9PIuVGNPnqqfvT7rLRMcfYZjVlha9gtpNYFA5yJ2jyKDkBWHGJNCrrGLTomQMeqmidQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UDyJ0MVv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UDyJ0MVv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nKghgKkuetfkeZiZWMOSJG22nMOAsbrQtAQOBcqgh6M=; b=UDyJ0MVv9n2h4I2L50JPHI56Js
	xehI/b+JO9PqspzWOKm4KUH1XNLFsIdScWsRNT68DyqxtqWehh9x7lqqU+7m/0HXoVhK1yiPw0mDd
	tcgEJjsGSlgg1B0MoIyZxVJPCSeAQFjjfhh35uBzvoCSUOFs+1ej1zWQ0p9mfTi4QokzZvnS7Vk1X
	JVH6W3E6fEK1MFlPDGR6eIf4YI0OXJagPLF7SeOOFHouQwYSc4IArO9HwtFfG4OLP3LbcxgCnZrwa
	iZLt8W9SVs4HuLxPVx86fwZP3mcw9NVbRXO/A0Q1ulEUvP3SwFDXL9IjaJbokEykAf18iob91pdfE
	S+cpL+Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsL3I-0000000CobH-278F;
	Wed, 12 Mar 2025 12:19:12 +0000
Date: Wed, 12 Mar 2025 12:19:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] block: fix adding folio to bio
Message-ID: <Z9F7wOB0PqouJfss@casper.infradead.org>
References: <20250312113805.2868986-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312113805.2868986-1-ming.lei@redhat.com>

On Wed, Mar 12, 2025 at 07:38:05PM +0800, Ming Lei wrote:
> +++ b/block/bio.c
> @@ -1026,9 +1026,17 @@ EXPORT_SYMBOL(bio_add_page);
>  void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
>  			  size_t off)
>  {
> +	struct page *page = &folio->page;
> +
>  	WARN_ON_ONCE(len > UINT_MAX);
> -	WARN_ON_ONCE(off > UINT_MAX);
> -	__bio_add_page(bio, &folio->page, len, off);
> +	if (unlikely(off > UINT_MAX)) {

I think we should probably make this:

	if (unlikely(off + len > UINT_MAX))

because I'm not sure that everything will cope well with an I/O that
crosses the 4GB boundary.

Actually, why bother with the conditional?  Let's just do it always.

 {
+	unsigned long nr = off / PAGE_SIZE;
 	WARN_ON_ONCE(len > UINT_MAX);
-	WARN_ON_ONCE(off > UINT_MAX);
-	__bio_add_page(bio, &folio->page, len, off);
+	off = off % PAGE_SIZE;
+	__bio_add_page(bio, folio_page(folio, nr), len, off);
 }

Also you need to do bio_add_folio(), not just the _nofail variant.
