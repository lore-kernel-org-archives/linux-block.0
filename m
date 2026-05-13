Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB823A901C;
	Wed, 13 May 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660679; cv=none; b=Ez7EYd1SruPSHBtmxClZvPZxEt1Mc8EpAkN/OhX4i0Apkj5QFyYcFQUUE49sSHcT+AfhpDwlGeoDRGBgrkypq9gYqHKA2W6adzT/XQPmItiyoJrSkGOn3btUPq7GoEo5smqoXOZXG5tnJsyGTjVYCwiOShPMwuZ4iTw1UNIu3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660679; c=relaxed/simple;
	bh=+KRgQoJdvEjg/oT8U/UXtzDkd3yCWo0KK4BcSS30biE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpnXe+4ylePno4/1LMFau1aBvOz2AVdC86NCUDOsx+DDGPZYxOIbEbzWrXRGiLAydCcwxorVyK54zDj8DhBNrrKdMjZJ67LX6N4KeKzXWIlhNi0Ean6rcXKhHa53qd1NHO8JsSXaGtb7cRaAZ1ZixP+oJtsZRs41uYgS/PvadMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7BA0668C4E; Wed, 13 May 2026 10:24:31 +0200 (CEST)
Date: Wed, 13 May 2026 10:24:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
Message-ID: <20260513082431.GA6461@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Naming and placement:

This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
But I'd like to hear from the dma-buf maintainers about that.

Config option:  as this unconditionally when DMA_SHARED_BUFFER is enabled,
why does it need a separate config option?

Interface:  io_dmabuf_token_create / ->create_dmabuf_token filling
in a structure allocated by the caller feels odd.  My gut feeling
would be to move most of io_dmabuf_token_create into a helper called
by ->create_dmabuf_token so that the token is allocated in the
driver data structure and returned from create_dmabuf_token.

