Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA0A22173C;
	Tue, 11 Mar 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680422; cv=none; b=kRBYukV6H0KDYqEcBnZ1tPYqHTYowctSlGGskqCcN8R31NCP8GbLpH9edvUzTPL7Di+J3ZfEsxtGtICef5+R3rYYfSojTZyJS8S5B1gYd8EXGD0o5x0a+lbDe19i1E0pvSWSyhogZFlOSYrvD8pXzaUga6YkkcKO1hGDikIZTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680422; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmard03J5EApAzynHmVyvT4jqB2MShkQ6ULpwdxlacF805vu4CXcLOKUcC48wMtoWswI3kTyHbL3Xj2ujmKn55bJ9HfGDSq8TqEtZx9FwIJ0TEkImMx/kO50GzK2n5W3ciRuwP6FzGNIlj819slpvRsTey61FIqVA3mgbF8ryw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mLIoZSAG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLIoZSAG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mLIoZSAGNKBRJnVKdpXKcOAFZi
	DSFPiuVylzASDCnowd5gEvpvwrMMRBNinFEdz7B7W/dP6ok+QxweCbEVPJb+HNLMfg4bGszg/Z5Mw
	CSL2JP2rFVGugc7GfQwtUX1RWb0gRUYHl9zZcMUULe6xJVH2/p+qKYIL2cibJfT/J8si7CHaR77VQ
	EEg3a+W8gME0yMPyd9FihExYiYQEGI1/U38uGofSirKRt9WJ5hOT0E+DiZmwnLUcqwJoAmyAgVt7T
	gRlcyseK33YAQmAkjcS+c1C7blgEeMPPEQHFrTWoUNM2H8RDZK6FnaycFDRRYu4Cf4s60d56mMYSt
	ed3IEBhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trudf-00000004wuj-2mj2;
	Tue, 11 Mar 2025 08:06:59 +0000
Date: Tue, 11 Mar 2025 01:06:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>,
	virtualization@lists.linux.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 1/2] nvme: move error logging from nvme_end_req() to
 __nvme_end_req()
Message-ID: <Z8_vIwT4AFAfbwwF@infradead.org>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
 <20250311024144.1762333-2-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311024144.1762333-2-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

