Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9F3A6EFC;
	Wed, 20 May 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265854; cv=none; b=J9vdqMDCowwt+vIwc7wgx2wsKa4k6kFMUwlJqfJ/16+pz1qk/Oeov6Qgwg2vplPlxjn9GBWrb81eY/reoIzguhjKDYSEtAdOlc/uvXpKXG6qOuJHtVthyXATHvkiRRFygzUAF4BSR8C8JXOR7cG47NE/WATzM97SIX3syZt1XMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265854; c=relaxed/simple;
	bh=jygiFH8g59vaOuCLT8rxUUXIp0l6xQbMECWG10ie+QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfyYutS3C08qXtEMdiZpf2EykwjmAE+c5YPd8KPA8SDn3a0UORHSATWT6MahoFNvfDWX7u0xhY6qJsZeHRkFCEmde/+T9yj23IMFzcngp5eR1cuX29BVF4PJYbiuZjUerFcqdE/GOwya3PeU0b44QwgBnkGN+Oj+av0uJAWZ7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A580068BFE; Wed, 20 May 2026 10:30:44 +0200 (CEST)
Date: Wed, 20 May 2026 10:30:43 +0200
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
Message-ID: <20260520083043.GA18893@lst.de>
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
>>>   	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>>   	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
>>
>> Shouldn't this be a REQ_ flag as we should never mix and match bios with
>> and without this flag in a single request?
>
> Do you mean adding both and propagating it from bio to req? submit_bio()
> takes a bio, so we still need to set it there before it reaches blk-mq.
> And there might be bio-based drivers using it in the future.

I think I forgot to reply to this, so let's do this now.

REQ_ is actually used by both bios and requests, so if you set it in
bio->bi_opf it will automatically get propagated to the request, but
it can also always be tested on the bio, including by bio-based
drivers.

