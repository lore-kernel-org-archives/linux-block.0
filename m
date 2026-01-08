Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28633B8D4D
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880159; cv=none; b=tGvXMJKAkXw9vKNONpYxqHEYOCI+WNOgBegdeD/8H5c+hLYLMoYScHnBL02CLAwFUsYTeZ6YIOogkLcSs6GwptAZzZBFqBLGnJqfRtQkGHUtkdb9vTM7AT5SXQYWzLA+gJ7vVYK+ZNKuARdmXiqpOqvmJRflbN9c0fbzz3tUUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880159; c=relaxed/simple;
	bh=6fw8nfiCyPXM/3wOS5JtNuX8wnGAp9x6E6m3ALvHYv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC5jPvaBvYCjGEaKz71Oa83YN8PfPj4YKa/FbQ1lXUJQ0r9n6xO4whYr/ev+clCbJAunhhTsFv4HqrxtPZ+Ugr3JU7FTtnIUYqF9nNyKW4tJbPNuXXR6oomDyyfyvp5NeQJBH8ENTR4d+F1nvLheqiWttI8v5D+wnBcgnmzPdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vGh/yFqy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vGh/yFqy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6fw8nfiCyPXM/3wOS5JtNuX8wnGAp9x6E6m3ALvHYv8=; b=vGh/yFqyji0aLzE6L/vui4FNuo
	KD4xqnH+QSwEVgXtUz7FoypyW7S64zB9LhAIhbUEsR2e1UNEWk9cRnsC81zJuUJVzf0sfZvawlO3o
	GmOoAX1/cbJVCmIGNl6viE/VPkkVDkAsH40/neQRpM35ot1lDiwNrkt9DeAyx6YHuc8XQPJQoB/ny
	zmTiAMRQWuZ5KOPpQ/kF672t2+MpV0eB34LkvnQngMA28ox/oQBtgpVQdB5NjrHQ9rKfve44e2LlC
	XUyBpX7mj3lKdJqNJS/u3v1JTAnL590LQk/xHWZSVBxDaIqwrtf8vBNfftD98raVZbK5Uz8ZnT4Y7
	5ueEFjMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqO2-0000000HEDV-1t8B;
	Thu, 08 Jan 2026 13:49:14 +0000
Date: Thu, 8 Jan 2026 05:49:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix blk_zone_cond_str() comment
Message-ID: <aV-12qrgk3mf0Eil@infradead.org>
References: <20260106070057.1364551-1-dlemoal@kernel.org>
 <20260106070057.1364551-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106070057.1364551-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, I always hated that XXX as it triggers the todo list detector
in my syntax highlighting setup.

Reviewed-by: Christoph Hellwig <hch@lst.de>

