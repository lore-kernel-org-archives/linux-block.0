Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AC287247
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068947; cv=none; b=g1Tx8JOASDsLBpb+d/xT5Uo6uZjhoYyCeyFYLH14BUfc69qA1g5qDfAfOpUCaC263D+moIm+ATfHrUhlU7Q1fKmCtVmADsR8GyO8alYXgaVLcxmUgBbXXDH6GPYK+eMYiCLZCgaEgwZfk6JdQGp5ZHLctw5Em1zSJmrkFgnddQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068947; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcAExGErdAyTlRo0mcsrmQhXfYrLQiwj98MyLya2aKnktxJTw6QdowGgM0CszajHD9yFkrEnQlq0zFVoPQe4RE9e9tjp6NP+pX/55X4pbedQ1rNPz5IX8NdOqSz2yMIIS0XgZW7V+j1ErS0lQU833fve6AcqflymbeeLMcr4fYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i90x77u/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i90x77u/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=i90x77u/ZR1JcxPfNMP+W+RNES
	0gNOgkMpv0Tnr6LOGxlP1U+9102bhc4O+c+EUxp79YrUtaB3TK+d57Ujn4XrdakBAJJPV/mt64PQ1
	bBqnlvJ8H454gWTKw9BR07WJOeGOGfDgW3kzjOv6P6GJEaG+I957/e5kR6d4yVyM23V8u+KOpbfkS
	2S90ef5zIxsbh3R5pp3wu/eQpgeYZClq5pe51MK9Bv8UnjlBkIPtezVxgL8EeaxouHiL4wf4baLzv
	nSH89YHxfEvrCNVxgRPC+tGwHqDMgaLfaorMaHygspQztYBvAAg8gLw4huPF/D9lLV7jVfDj4BfsW
	wm5RZYNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBOU-00000006oqs-1Kq2;
	Wed, 10 Jun 2026 05:22:26 +0000
Date: Tue, 9 Jun 2026 22:22:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 10/27] drbd: Make a mutex_unlock() call unconditional
Message-ID: <aij0knOBEMjFKd_x@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <803dcc7259a57e513e7ec06a82307e75acd187a6.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <803dcc7259a57e513e7ec06a82307e75acd187a6.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

