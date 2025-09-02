Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB31E5B71;
	Tue,  2 Sep 2025 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791448; cv=none; b=YBLSk/1d2WO6I4ysRsx1UlmZAcLATEJjow84qytb10CFe8ke1sLk7+DGIB2+67qxVdxC2GYYLiplQY6AP1BPvX/GfGvLcVGeZ8/OMcRVNREo0AGwAGW74ldZJnz8dvEQrN0netVgZjRK6KfBB4UympDuQWlwc6NGtR5SgH4ECHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791448; c=relaxed/simple;
	bh=KNM+GtB5kR1AX3DUuJ2Y8a1nW7CZSjEIVXHmL8UUMrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd1Kdv0HKMfbwCdMMxJ8CO+NVXq3HXrDZbRbenpG3AJuh+KSNK7oVM0NuDxs5PTNftHsC+JP/+0+t+lxn0OwFCkFFNtO59lL+UMQepN0yuxri11OKSifkaXr5cPFQCBeOYjR9ZVitgwj9OmLxr0rt4NVUfarReHk3zM7fSc6ghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gVjW74Fs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gVjW74Fs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F+FLnmC22p5k/k6CLJYOVZEPjCGwHkTBCCzbwynNin0=; b=gVjW74FsjgS4TUzUm5CQOMjkLD
	nPB3dGY7XBxgOiOIfYppmGsDjIaUExT7y26Q65nfVPqkROowFjrIT+aQ/eXYtlpiKEjybbO1MxerM
	MVh6lqpkYQ2nznMOfM8NFmss+KuW4W17MBp+jiRDjZ9igpdXbvafU7HDR8Z62mZzLXcga/44Rksnv
	N475eLViop7MfwOMDNZttUDeAqpFh2c+aBYFm05xhxWoybXhjx8tNHpti7/sHdvpcsHL2p3CrIAsv
	Wwu2eNL+L4MC39CuRS9S5Th0CP/W3H72qF9HOmoN8X7565HGOV30ul9MlU/0/OmAGA1ZEC0C7Smyl
	nfMztfAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJht-0000000FL0J-23mS;
	Tue, 02 Sep 2025 05:37:25 +0000
Date: Mon, 1 Sep 2025 22:37:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Longlong Xia <xialonglong@kylinos.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: use KMEM_CACHE instead of kmem_cache_create
Message-ID: <aLaClbE6jmcnGN0a@infradead.org>
References: <20250902033241.1623330-1-xialonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902033241.1623330-1-xialonglong@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 02, 2025 at 11:32:41AM +0800, Longlong Xia wrote:
> Use KMEM_CACHE() instead of kmem_cache_create() to simplify the code.

I don't see that this simplifies anything.  The only thing it does
is to add yet another magic macros that needs to be followed and it
adds and overly long line.

What problem are you trying to solve with this patch?

