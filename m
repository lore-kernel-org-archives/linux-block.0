Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1E44E049;
	Mon, 18 May 2026 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108884; cv=none; b=JSFZQPFQfWhuDTvqLs4JBhpUCd7MOuq3HcQqwP1OrwqcjV2e8uDmvcEuIHTfOS/xaoc14uAnKkQeVGPqwW166Jcp0Dy6XPPuQrIbOY/ulcKcZqLT1SYa1mZvE4mxwMzzzKRyMRT3zyHeNNlyKC18IBN7du1ZNdTMI1x/G1Qk+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108884; c=relaxed/simple;
	bh=qzwxHa46d8OiBvbRlELnJjtjg0VQsci/0mO4COhc5b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJmaSzRGYSkGCQsjeNq+JYAlJvAdTQZGy4scMjmBS5/4QIiThNtVtwiAPkgJlLQhtUjXgZ/ttjLdOaMawUhex11SYXlLRVAzzUqmTcm9++H1dCreNlEMQzEujpcVbtCj6Fo8XFlSJUhHH6ECREe7eg9KDcXyHbZ8lBA6EWpjM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 003E768D09; Mon, 18 May 2026 14:54:39 +0200 (CEST)
Date: Mon, 18 May 2026 14:54:39 +0200
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
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260518125439.GB5754@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com> <20260513081929.GD5477@lst.de> <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 11:29:54AM +0100, Pavel Begunkov wrote:
> On 5/13/26 09:19, Christoph Hellwig wrote:
>>> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>> +		bio->bi_io_vec = bio_src->bi_io_vec;
>>> +	} else {
>>> +		bio->dmabuf_map = bio_src->dmabuf_map;
>>> +		bio_set_flag(bio, BIO_DMABUF_MAP);
>>> +	}
>>
>> This is backwards, please avoid pointless negations:
>
> I can flip it, but compilers tend to prefer the true branch. E.g. this

What kind of compiler optimization do you expect from code where
both sides of the conditional assign different arms of the same union
and just propagate the bit that was set?
