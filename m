Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18644D034;
	Mon, 18 May 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108814; cv=none; b=tt1W8GpGxbeFE36XVJRMpLMIdZmDaMreCmNpZv3CHyM8MlketpgVQBdDXD4my+m2rGRjBxp5vN2xQ3RkSTBQ9nmLKd7ObaX6YvPuxrhWAIlxu52zS8W+XeVbL8XgDIcccBZp2OOOg9vFJO3OKfEyOyqFY0WWrRd5sjrdZYhA8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108814; c=relaxed/simple;
	bh=TwyLBl69r25hklCxBzlLL0p3vLTOlk/jgnXWfAUetwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMK4gm4bMrunkmL6ppRrqzeaGJItkrC8qkxyfBkiJOt3+9BxMpGGLEKp60tNav5edJMgGumRn/C7AipSAHBYJqZ0xVLPTQVO6oclt5TY7mRz/aE23I/hawbMiyFX+v+5MgIzixu9ZmyWDWQeEX8B6rU+aylSPUbxi6WAUYBmVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BE4068D05; Mon, 18 May 2026 14:53:26 +0200 (CEST)
Date: Mon, 18 May 2026 14:53:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
Message-ID: <20260518125326.GA5754@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com> <20260513082431.GA6461@lst.de> <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 11:14:09AM +0100, Pavel Begunkov wrote:
>> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
>> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
>> But I'd like to hear from the dma-buf maintainers about that.
>
> Looking at what Ming is saying, it'd make more sense to keep some of the
> parts like iterator and the file op more flexible and not automatically
> imply dma-buf even if it's the main and for now the only medium. I.e.
> ublk/fuse can use a similar interface for mapping buffers to the server
> even without dma mappings.
>
> I don't know how the API should look like, maybe passing memfd, and dma-buf
> supports mmap, but I think it's better to call the op something like
> "register_buffer" instead and keep all it in lib/ for the same reasons.

Let's get the current version landed.  If we come up with some kind of
non-dma dmabuf in the future we can refactor it and move it around.
I'm a little skeptic we'll be able to share code as long as dmabuf
is allergic to physical addresses, though.

lib/ is most certainly the wrong place for something that absolutely
is not library functionality but directly interacts with a few
subsystems.
