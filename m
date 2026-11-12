Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492210;
	b=JOzVSJaZFO5KqY7bKybkxmTDTaYhnFfFGNLDW0Bn001WQ2xDTnr36Ag9k7Mc58ztSrym
	 OI3psbgByQXJsesHQAT6ArUK6L3y6SqEw7k3CJLbWcGg/wwWoYiTyYHwDyZUph7UDpVRW
	 ukZi6sCWredRyk2lYj2y3fEtLjK2MuuJFWag1FAXIsWq0L33gtaLC5bY1K52zlYsLbcSX
	 5RYkhVFPjL75YKDnvZncrU9n/V9elaVlXJbRc0UptJAKln8n1yig7iKZw/jtFOmbZKULw
	 LfL9Gnmll0nuzB1voV7IuWXW9mx8Dj/j6soRxIMcJj/H5VrTr2GExYxJRZS+OZQhpiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492210;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=AqdwUakWs0FoP++o7P0uySk6AXm/DPOjV3YBeQ6DppOGxqzUo99RLj7JR/9SYEr7jmyk
	 SGzD+ufTWvPPrBe3pnja78NLN5xg+dtxWHoG25ybfTJAZazKsL9CPRd1ITNvSk/DVOgjE
	 Et+F4HrLR08MCFrmGyLcEb5NqRAMOvKEAOvSGiwQzRlxPgoi6Di8hPMk3/3yAZUAz0p7d
	 iuugkyQX2X60axU0ugerq98OkcHMgSFQSBUeqXBolOuy+toNp9R/x8IfSw69xmPPhqjGU
	 f8qz2UqIFYwxuYttNTLM/WU83bugDIOz7PuDKxoCW+Godbw9HwKcwUqKbE447O0HijA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pSyfo4RH;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C834A606A31C;
	Thu, 12 Nov 2026 14:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C834A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pSyfo4RH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pSyfo4RHTzCscXv7ZxxzmaLBtl
	Gl5CWM05eySyLdwEA8oJN0lSSYQofh5i6dKRoYB13VrtHvYxqWXhya9D031H6CBI5r3l+4Erlwq+M
	MlZScSPpA+mXBWfuBOLfrRGWvqsKJWQ9/wNBLJiuENCLxEIVHln1UKoTynQZnB7brzPELaYIqINu2
	RXrvsiGCtFOPCtySfIKDRkFZVy16uoPuCTUbUwnArT5w+0WQtNl6jPE7z7NqGcR4RArPd6HcQCt6x
	k8vkPSye+pJDu0VcAo2ez0KPLiPDeE+9MZaYe9gFSX6/xjRtwDu5HfXRB0c42bmk4qYySN0XiRPAS
	tL0yDm6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVOi-0000000AApX-3FUZ;
	Thu, 12 Nov 2026 14:03:28 +0000
Date: Thu, 12 Nov 2026 06:03:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: don't request a module for the none elevator
Message-ID: <avXHMOew2ZuSbEGI@infradead.org>
References: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
 <20261111-bug-block-elevator-unchanged-v1-1-583198bd4e21@linux.dev>
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
In-Reply-To: <20261111-bug-block-elevator-unchanged-v1-1-583198bd4e21@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
