Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46402135B8;
	Fri, 18 Sep 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721006; cv=none; b=JiLuxSY6PNhr7td3lEkz3zYvZ2aYFkv2dKLcaCdXMNNPSH10x1fnh/feqgMeeB80scxCGbpkm+eBrUBSNPR4nwjLhECidJBKsGaaxj9Ljhc3uAMiTmZvwWBX50grJ/0qoBkZQMD+C4gjGJbUOlNp7dwYxNhOY4wbRR4FeAJiV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721006; c=relaxed/simple;
	bh=3M9a/35OVXvz350BzCHPFrdNKIx6w//3HhXy9OwBmT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+cUOKeN3Et67R3K8mC25Nf6dGBzfdYQI+i3kdBOJGlunxCf+eHOjbjxMb+RhVfRsHrI3Myxgth7QNrfFdqjaiNGsw9UiaPRLxyhlF1NNHvMAoZuykph+XNP6ZmK3I0fsG671NrP8VPIutgEhdzlSg3AwqYLuBw88jd+5M8uGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7C2168C4E; Fri, 18 Sep 2026 10:43:15 +0200 (CEST)
Date: Fri, 18 Sep 2026 10:43:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Message-ID: <20260918084315.GA12283@lst.de>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu> <20260909-blkdev-fixes-v3-6-1a5222c6e8ad@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-blkdev-fixes-v3-6-1a5222c6e8ad@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +
> +	/*
> +	 * __bio_release_pages() only unpins the pages still covered by
> +	 * bv_len, so drop the pins for the pages trimmed off here.
> +	 */
> +	npages = bvec_nr_pages(bv);
>  	bv->bv_len -= nbytes;
> +	npages -= bvec_nr_pages(bv);

Wouldn't it make more sense to calculate npages once after the
decrement here, or am I missing something?

