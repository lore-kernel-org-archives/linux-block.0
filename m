Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A629AB
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 04:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719809692; cv=none; b=dkbkZnbnscv79EUWe03AEg1TTT566qZyY+tnYTgT8rDb/X5/AB9LBv4sQMfvj7UlDbSko0UIIOlTH70eQSESYACX8yN3al876X1pcImGJenuC1XI0yJQ0SLSqS0om1otmrF9mYuio5D3OfbFVLXnNo6yyXKXzGbtun2FFKcWd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719809692; c=relaxed/simple;
	bh=7aEwUl86HxRiM8YAAefjFfidNNyb2y0q13YinyhWp9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/qcKi8Muupvs9Rxmlm+QO8QhOSMj0ixPl0MEPxM+bDUa6DtMBvMTad/DkXk3w0sIwgcC6jhKXU6732qmSSct7nCgGUUOOGdU2Ru8iPDiJdYwL1RL+UgM1CDig9phVjGWxMtrRpUpMNLW7AEiHlzdCiyjbo/UwxdppWghO6UtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB4D768BEB; Mon,  1 Jul 2024 06:54:46 +0200 (CEST)
Date: Mon, 1 Jul 2024 06:54:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to
 blk_mq_alloc_disk
Message-ID: <20240701045446.GA26763@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-13-hch@lst.de> <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com> <20240629051958.GA15371@lst.de> <2455c846-e232-4e6e-8ba0-cd9de0cc7b03@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2455c846-e232-4e6e-8ba0-cd9de0cc7b03@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jun 30, 2024 at 10:55:12AM +0100, John Garry wrote:
> According to the comment on virtio_cread_feature, it is conditional (which 
> I read as optional) and that function can only fail with -ENOENT. So I 
> don't think that the probe should fail. virtio people?

Oh well..

> I think that it would need to be:
> 		blk_size = lim->logical_block_size = SECTOR_SIZE;
>
> Which is a big ugly, so maybe:
>
> 	if (err)
> 		blk_size = SECTOR_SIZE;
> 	lim->logical_block_size = SECTOR_SIZE;
>
> or, alternatively, set bsize to SECTOR_SIZE when declared.

Maybe just set up logical_block_size at lim declaration time as in
your patch that started this, and then kill the blk_size variable
entirely and just use lim->logical_block_size.

