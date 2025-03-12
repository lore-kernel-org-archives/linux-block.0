Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB741E1C09;
	Wed, 12 Mar 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759201; cv=none; b=pu2MiYpvlxGERQgoDSh8kZeKe4g7C4nwUIMJcNVpMJDRlP4AVpsaL7Q5bKNeTBBfH2xzSIAloEiYfOySO545KDuDtKOfJ97odN7JdAwDJ1zrr97eLTZsv1MOtxKFpCwAjn7OHqgS+kTrCFkN19n++FRpv6goA83UN4S2HKHBKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759201; c=relaxed/simple;
	bh=w2bWWcvUWJL51NtS1GMZcwVGuTpZ9zHBGMLxwaUwCZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ8ij6fUWcspCqGd/pRl+yF9Uf39IJFeeXFRWTcUWe0KyLK8ttOQbvFRxcZgtT68F+nDksWtCYZZe6VosZ0VKYQVzfaTNLOPV/psFL8Ur++Jz+WYHT9/yUNZOIrHgs71Ib7H9rT0QUtyaquY7hhRR8lrJ1EsLZelH2dQdEo0KMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U/1nE9hn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/1nE9hn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QcXOYRCH0+rzrtF5eKJ9mNGNA8kBZEbH+ucO4R4KXyE=; b=U/1nE9hnYPBulm4i10QfSh0WL+
	Q33SCEtiLE/AuUap1bJrCFr9azMjGbdVTgK2EsHSQnnwVD+CqINw3ncjoIP7TMbi7Eg28PbxgSNzj
	8S5tvAVeCLPbgLe2yQhJK7mXRNejQmHhrftJd7g83LQpbRYva2KoOu/CwnZEv63K1rAqWkiitg0oh
	dAWhSuDF+Zt0rop+r9wOOc3Qjb6ewyeg9CSH4073KS9jXBLOFxkX4iAXSR7coZuI4k9nODUEOffc8
	nRttjjhWwc80c/H73E5lTpcwG4V8/4DT1NnoS2QOj6iVy/xwWza/AUSip+ujFCjN7goF26oTYJPTN
	Umc6FxOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsF8E-00000007YHO-3CIm;
	Wed, 12 Mar 2025 05:59:54 +0000
Date: Tue, 11 Mar 2025 22:59:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>,
	virtualization@lists.linux.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 2/2] block: change blk_mq_add_to_batch() third
 argument type to bool
Message-ID: <Z9Ei2t7z_7QbEWXW@infradead.org>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
 <20250311104359.1767728-3-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311104359.1767728-3-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 07:43:59PM +0900, Shin'ichiro Kawasaki wrote:
>  /*
>   * Batched completions only work when there is no I/O error and no special
>   * ->end_io handler.
> + *
> + * @req: The request to add to batch
> + * @iob: The batch to add the request
> + * @is_error: Specify true if the request failed with an error
> + * @io_comp_batch: The completaion handler for the request
>   */

This needs more work to be a proper kerneldoc comment, i.e. start with
"/*8", mention the function name, etc.

The logic changes themselves look good.
