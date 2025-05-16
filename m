Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28309206F23;
	Fri, 16 May 2025 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370265; cv=none; b=jrkuPrZnKZvZ+V4JZLtGebJf58lP553urj/F4eqD3PVvRF/FwphxbXvmBt+8oaJUcQ+bXg6k9XjQtZdTlQi/Avf7qcF3KXkWrKrwyC8Kl4r2qv/MkXt2UX3MZtN75BcwA9tb+ZpmXgpkF98cASdX1777HW1g+wFrloS43mMnL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370265; c=relaxed/simple;
	bh=WaKI9gNXth+mQA/2U4+nsTBmttlOm2HrhL0YToOrOkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mONitQtpsoo5VSyErl+fEVexpaEkILx9al8O48c4a4jAwuy/CDNXdA9t9FM/fXQoGi46GjVirVFztnijk5VsZxCbBqn82kIfVILmZK47yQK3doMWsGcM8Rrm+6IOPKLZbo/GDGNZWEtjezRYrY+r42BTjoMukBa0mAbi/qkzS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RfW1QzMK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RfW1QzMK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WaKI9gNXth+mQA/2U4+nsTBmttlOm2HrhL0YToOrOkI=; b=RfW1QzMKc75AW7TEflla3wEgfl
	m0x+kMNPyZO1ExmhXAV12X4wt6xym4lpyr4TTTsuRcYA+svQfX/rYB/LjQMtXtJxf4TCv7hoXK9+o
	ilsKNNc2RsYlm1H/1rcPIhhA956INYNfv2cKVDH2KAXDTks5Apztw+gPCD1zcajrOONqJlluUrB6c
	d2BDa12XC0VEcFwgmNeL9/lq2DXYRl6iw17OGBQNpndJSySup2qWfxevW07k1hO9VzVdaUC412bBD
	tdCVWyB8nw59VZ6bofhBn8MKt6UmI2c45VJYdKp8h55R+3Ara9e9lud1RgD/nCo/v+QYyYAi0ydpa
	ktF1qfNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFmpG-00000002T2z-1yhX;
	Fri, 16 May 2025 04:37:38 +0000
Date: Thu, 15 May 2025 21:37:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics
 function
Message-ID: <aCbBEg-DFYvx0Dpa@infradead.org>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515061643.31472-3-kerneljasonxing@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 15, 2025 at 02:16:41PM +0800, Jason Xing wrote:
> +extern size_t relay_dump(struct rchan *chan, int flags);

Please don't add pointless externs for function prototypes.

> +EXPORT_SYMBOL_GPL(relay_dump);

This export seems unused even with the entire series applied.

