Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B373DEAC0;
	Wed, 13 May 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660765; cv=none; b=M8vZni6m8xjIaqQoUvbbXOYz0ydfET5X2njixXoalFTsKORfFlG2OKJrh1PFiHvJkl30p9eVkmYfdA1QOK6g6/pyPtzRrz4SoEkNFcm8ZibON8tOHYjkiMl4J1sZljhfGkCLRFqWLfhC82V20JI554g8rSTdKaQaIyrRC4Q9GXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660765; c=relaxed/simple;
	bh=yCQtFTalb5Ynr54N1G/xdLlP8+o4xIQhljifn+SuQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWHqnsB3RaAFs31sRMuu4CwKH6B/qfitWtsdhqxea436cMsoB4WrxzeJeBgdkrS+to+cuckhIbxcHUpdTZXB/eJTrEeUVWYh7A4LkuUACDVJNWEtefdSYN3A8X6XNOlXxnypV7rSBK1GaPXcHrGuAfUsNLTwl1aZT8B0X1D+E9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD03168BEB; Wed, 13 May 2026 10:25:53 +0200 (CEST)
Date: Wed, 13 May 2026 10:25:53 +0200
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
Subject: Re: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
Message-ID: <20260513082553.GB6461@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 29, 2026 at 04:25:52PM +0100, Pavel Begunkov wrote:
> Add a trivial implementation of the create_dmabuf_token call for
> block devices that forwards the call to a new blk-mq callback if it's
> available.

This should go into block_device_operations as there is nothing blk-mq
specific about this.  I.e. even if this patchset doesn't handle stacking
drivers yet, it should be easy enough to add them in the future.

