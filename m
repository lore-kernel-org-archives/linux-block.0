Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AB6F300
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784395; cv=none; b=O5gEbwjHJ7MxvuVoNh5+tGMuXtKvurz/qCoEgGSjlwlh/XI69VsRa1Hr5NdJnn+4yey0nFZ6YxNtD42ohNiX/oYnnm6ZkUUOfiUdgMhRp+NCBn+uztvjg03EgNFwQw9AS1mdWgYNfkcPOHmwdEoZo5VPbBem4zeMyJg3RmZIUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784395; c=relaxed/simple;
	bh=nOXpZKMasU3xNOQwVfjXg1xbvRy6hDfdw5liNR23g00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF7ZSsbY8dOmH2wCZgUQwPL81CJjOUNt9GUhOracYiT84I8Ive33W682ElUNu+lmPPOAa5NwDomnIIdiFYHNbHE0Btc4g/zfbrNjBYhWUV0lG+tXnM1BzVoVjZpgi40oBHthpPJvyaFILmj2llwFsge35yc3gY4E+aZNSHazSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YHetwMTE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YHetwMTE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zRZQB5ou3H5+2w2kqInAGwjvPyJUQyi4kmfuQzbxVE4=; b=YHetwMTEvbKCdGX6oAF9KgRGW2
	nE51Aml4S+gMGs8Ks0WxwvmqNeu0BEvwsolN7rE9L5faI4Pw/ykg3PGMWeqdzeFxKC3/+vj7w+Had
	BWtJ05g1YzZ3/PtaPipw4qOD2U8H/98x4u0bEy+72XK5IQoUbGQBJO0sE5pQleXD7zchrffW4p3NS
	tCAOyPD72DUskad2Qy4yyn4Z6sszb5rdIe6CsVZbAStiX317svCRS7GeVHfnPpgDbqE8j5oOxqo/b
	0N3mDlnD0P5q5wftscT3P2KE0FrmjeQ4PIdPoKIkksaG09xPluI8ZsAGya8Z/nCn1n+AF6UtlUJBj
	SWNr75Gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJqKu-00000000KJi-3gZB;
	Wed, 19 Jun 2024 08:06:32 +0000
Date: Wed, 19 Jun 2024 01:06:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKRiG0PKxPzQrcb@infradead.org>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
 <355cc36f-e771-4f00-bfb0-0095674d5d49@kernel.org>
 <ZnKJ3d-18rzl32j2@infradead.org>
 <ZnKPrYI72g2iT/rV@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKPrYI72g2iT/rV@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 03:58:37PM +0800, Ming Lei wrote:
> > > 	unsigned int bs_mask = queue_logical_block_size(q) - 1;
> > 
> > Please avoid use of the queue helpers.  This should be:
> > 
> > 	unsigned int bs_mask = bdev_logical_block_size(bio->bi_bdev);
>  
> It is one blk-mq internal helper, I think queue helper is more
> efficient since it is definitely in fast path.

Does it actually generate different code for you with all the inlining
modern compilers do?

