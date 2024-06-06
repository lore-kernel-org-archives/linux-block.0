Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C213541E;
	Thu,  6 Jun 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656250; cv=none; b=s72HUwtkpRNg16WhyXGYgttNYjDsAC2f017czUFXG6+y0gpLhbgkfFSbiFWcw+VGF3yGbPhAswTIaub3DnX90l65Mac5R3mgQgDEuAK/FqOKZVLIEq/UvV/svG8BHMwr7ciYOjZhPrJadmKQCGencol+qS/SggKcsee6iWzeLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656250; c=relaxed/simple;
	bh=YmYACzC+f/zkf8DYh69144csDop+ChvMj9H5H/tUW44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTCAc+dWw1DdTxA50iVif95gbMCserwCJ2F7yM5EYdhZlUtT9ZE6fbl1vHKOC+N9lhgMYAkMTVgsy3M69E735paMNRqF5/mv6IOzZuoWdDTLLIOAqyTaTgqmedJOFRgwh5/WmRYK+OTtHGfCnH1sE5ZLI8aOckRhEjkP4SiA948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AEZOLhEg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AEZOLhEg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q64pOzEfC57FkqLu16lPl2Hcj+0rcnokfhBaRvoXXXk=; b=AEZOLhEg8wZrDtx3+wvnaduo7A
	x+LbgzKFwFgfSip121T0vxQUGV/dCAoOdy+AB0r/tJI40QlFPS9k+/PQpDoXcvj+YdcHaUmTrAg6s
	VyCBGNTuhrbDSodeND/f7bqh/uv28rvpMovYVFvTFqXViP7EiNWNdWOIL5/B5tVL0qJSRM/UXbNGt
	1/le5YJQZJNx8a+H24rn6A4vVs5LSrv8jTHy172wuX92qB3OmDQHcMiBQHgrbIgSPWIxF7xHKLWzs
	taPyKDX7CvCYrFhbd3ATomI2dxufmgFiaquSRzMTsV5xsM3ueOex4LAi4Tr8qxyNd4lK10xgmIPHf
	c/HYlfyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF6qz-00000008ZKs-1epc;
	Thu, 06 Jun 2024 06:44:05 +0000
Date: Wed, 5 Jun 2024 23:44:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com,
	Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmFatW3BEzTPgR7S@infradead.org>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606062655.2185006-1-yebin@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

What kernel is this on?  As of Linux 6.9 we are now always freezing
the queue while updating the logical_block_size in the nvme driver,
so there should be no inflight I/O while it is changing.

