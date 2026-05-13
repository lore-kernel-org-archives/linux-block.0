Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690C384CC1;
	Wed, 13 May 2026 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659912; cv=none; b=Zp9GtF7VC0fE/qH8kJgj6RTJ0Ta/YgtqP1hBl5xDsR/EAQWFaqVFEt/38/F/IWD2YheJf9t1ZfDzoaZ2anKHlbYkQvG6yFAu0eG3BIW0auLcGy1tWNVupo1ceJPFIIyxUVSnpr2fR2746UvbBplYU4atwQ15CqYUeL7s5/hfC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659912; c=relaxed/simple;
	bh=/SaFSDQLD3FaYoZjds+Cbk2lHBxtsmswA/kMoCoN3p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPzEDfx4MflG21MlaNSGbMzWrL2JxqiXarnZc6eUXjkzqppsrP8UL7CgQapbzbCBVwtMbk3sYZi/QZZ6BZiLlZACgBwTPpxLagho21HPhxY76YcVtbd+OcivKN83xhV3zizIudG6hhlRNJoFSwnb/0oDmGF1nGnBrAih0iV+hHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F89A68C4E; Wed, 13 May 2026 10:11:47 +0200 (CEST)
Date: Wed, 13 May 2026 10:11:47 +0200
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
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Message-ID: <20260513081147.GB5477@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 29, 2026 at 04:25:48PM +0100, Pavel Begunkov wrote:
> Introduce a new iterator type for dmabuf maps. The map in an opaque
> object with internals and format specific to the subsystem / driver, and
> only it can use that subsystem / driver for issuing IO. The task of the
> middle layers is to pass the map / iterator further down, maybe doing
> basic splitting and length checking. The iterator can only be used by
> operations of the file the associated map was created for.

Nice, this ended up way simpler than what I would have imagined.

Reviewed-by: Christoph Hellwig <hch@lst.de>
