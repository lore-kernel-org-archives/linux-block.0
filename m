Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492191;
	b=KB5tvTciDBJ6V1uInuMU5KHo8TC3sNXiKiNH72RP/Ml/iwYf3RQZJ3ADrjBqPF4B0DxA
	 AWGiAbnlEr0rxyp5tyxkRWa+w0RJaKhmvlV9rJT9zn+V4bVcx9oR6NBjbx0OmBpbGhnUQ
	 fM8nZ1f+ItOz9/Bljt/ezL6q16dz6hbg31lGYfhq9EGmsQKl+wPfgVbO5UOuZQBEauAwY
	 iE4NichgHIuc01UUFwCsMHkk48eA+Yb6dCW0ANKhc7ySU5lKgtFOevHwZNnHj6cwI/YnI
	 SRL868zXbBH49d3kxGT9q2SUJh72LO2FAbeNFsbPlqmMYRt2f1+LLjc/45YNu8FKoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492191;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=82eMXmhzgoPTKKBAMOVTGfqvSuE7xkGl7D8/qkqwjWA=;
	b=D8E2MZBIhKMTIOhTnPPvuCSsQb2u92isf3IDNVxW92PC2o3cydh02yLB4ajnjd7xafji
	 MwTnt9oZVy9XsOmHLNGe2aW4rKC9uVdeMQwo88jEyZGFmgHxyKNZ9c11o/iHUq4PwYCO+
	 VoAfnwa+Me/Ap5cMKkGf4rCEOhln214afVCp12tdYLZdlfNxsMTuO98ZKf+0Aol7fDuwS
	 JYimEw6GLONY5eNkP2kUypbMiKjnw3kmJ56ducaUjX7bo5f5fdD4lwprqa8B61AGU14Tj
	 mqOh6oXVoctIVgykuqlkjRBTaMqX02iLYPvoDLK+aycyvkNHmvHXj7IHRt7aPtr3KqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DTR9xK5V;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014A606C711;
	Thu, 12 Nov 2026 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E014A606C711
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DTR9xK5V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=82eMXmhzgoPTKKBAMOVTGfqvSuE7xkGl7D8/qkqwjWA=; b=DTR9xK5VBNTsK4/4jnuGCPoD+X
	PXtzrpiEnaNC6K/tVZF9hN6IdxNx4xfBsi021dY++3HCLcBBqnMAPPoRiaADjyu69SUYvvXeu9YHc
	XH8c9ho0ck/ghYPr+q/4UeYylQvBO84gSd/tA+a/1sJyD/0EmjKvwY/Tt7xLcyug6LmSywoJS3t1H
	A67/0OjvyEyW4KfDq5t7eGeIHpcUAIhB+pqpzDfHJS//TVQ93dlE2G1LYst7W6msiI0k9gO+wnu+b
	AC0ET99n3xUYMgcZOiklcQwOEAjX+8TV7sW4AP2qXFp9Q+haNqGtM1vIUcY7NfytxZliAesPgOtDH
	NYYwvpYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVOP-0000000AAnA-0ija;
	Thu, 12 Nov 2026 14:03:09 +0000
Date: Thu, 12 Nov 2026 06:03:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] block: make rewriting the current I/O scheduler
 cheap again
Message-ID: <avXHHU1LxT4_dCNv@infradead.org>
References: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Nit, but I think the Subject should say "change" instead of "rewrite".

