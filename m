Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943246A5E0;
	Tue,  4 Aug 2026 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852071; cv=none; b=EWLSwomwW317TinlvnDHqNFyxK7Qlr6BX5l1K5bIK8qre9O8fkRJzYfXMknbVBBq3DTTP2efIYaDdAVu/2GjKiipyOpJmZ7iQJGuDnnNhQB57ccSNeMkgaMJXtiVPBdem47mXLMee2McUspJw8vnUdm3YyAETP9UcbJpNibM7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852071; c=relaxed/simple;
	bh=v1E4PJ2ISw17jiQ/jEPu+Qlhl1mKKzZT1ifavlxqtik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alc+kkWQKtgdBubyt4/ZVgx/XF8paA/Q7TEyRN8JKd8E6FZcm3nH8dJXZcdIXvqXDC362L1yL2gWTwG5cHP9W0AfvvgN8u3TTtSGAsueKC4PJoJ8nPHprNDQar3Go7yEYer82md1HIPF3p87KxiHSIMXigV3UKUFbvpZ6aXlZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1E666732A; Tue,  4 Aug 2026 16:01:02 +0200 (CEST)
Date: Tue, 4 Aug 2026 16:01:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 1/2] block: use iomap_dirty_folio for block devices
Message-ID: <20260804140102.GA8894@lst.de>
References: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu> <20260802-blkdev-fixes-v1-1-a82fc549fd74@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-blkdev-fixes-v1-1-a82fc549fd74@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Aug 02, 2026 at 07:14:26AM -0400, Tal Zussman wrote:
> To reproduce, on a device with a sub-page block size, write a known
> pattern with O_DIRECT, mmap the same range, store to it, msync() and
> fsync(), then read it back with O_DIRECT. A reproducer is available at

Heh, shared mmap writes to block devices..

> [1].
> 
> [1] https://gist.github.com/tzussman/18ab05cba4b3fdc79cce0a69d1fd05b4

Can you submit this to blktests?

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
