Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362718C36
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424273; cv=none; b=Clao0SEpJUysWnsBnNJBwnkaF3ljxgbAoFqrmEbibej8Z8XYe5Tqh4+dNecDyEKWUhFB20j8EzUEdzfM8g4FQuMTrvtdHFKJhT4HJ/20NI6mbuTns888g6dg4QQMYSR2kwzYr3z8n41Htoj+qAkLY1BXGutotcC33caDlZfT+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424273; c=relaxed/simple;
	bh=fD0asjmvMmzMjjql3jhPQDI1SuDLA9AC7sNv528Y4gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHeqVMvIhEzIxmNVFyRbmEnmS/BdxmWPUSXO2PDi44b1BanS682XDyxlLAI0GL4vIMaN0boyhqQMIwokzHOK/rxh8588nNrsAT8k3ue2fRhWAX/gSbn8u6iS0dyYG4dodnMRZ72WJ9XhLhvVarS56w+ndr1Pdz2JmGAnHEk2YUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jbk/AibE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jbk/AibE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KJiSrUOBexuwhPRrW2odzFrfXoGhbhDle05LBXIav9Q=; b=Jbk/AibEu2KE9z8QZiDYrATL3D
	AmeenOmBtx0O3eVPgN+7Ws1ofe0G8gi1T24Ij0zUJF8blRcs8piVE28Xgd+IMo7G/kJpmXEcJiNiq
	BTi8MWkF1upbdxnyuZQ1QEUnrrf4TmB6f4SrPv7VmeEVc+++twtvTkeJLdjqwCUOY1wEVUtJ/O+oY
	KXyRHlWKJ6SFx0imCggwKLZSUHr17mSNLmjrwg+oZwxJXuQR8J6KbU2shssSqUhZDvE1yShh14Xzf
	uLH30A2DEJvbf8uN+WuVxdA036xbdMpRakopSWsR+7F5ie6WIIT6iFJXZ1oqokji7E38nDdcXi9QD
	ztKbMm/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhfj-00000002nWh-3bXP;
	Wed, 04 Sep 2024 04:31:11 +0000
Date: Tue, 3 Sep 2024 21:31:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix integer overflow in BLKSECDISCARD
Message-ID: <Ztfij7dEOBotfOtt@infradead.org>
References: <9e64057f-650a-46d1-b9f7-34af391536ef@p183>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e64057f-650a-46d1-b9f7-34af391536ef@p183>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Do you actually have a test setup for BLKSECDISCARD?  Given that
I've been ubable to get anyone to actually help with teting it
we might be better off just removing it..

