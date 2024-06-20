Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C682110F;
	Thu, 20 Jun 2024 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718857331; cv=none; b=HnKs9qOe59YABFuUhxyNNzbLBenh7RCpk+GU9GwH4Ykj8vphD0WnixIAYaPPEAGDb2OHqZKjSynJ8vi+wgkFwgblku4Ut2AwEflwfuozq/a9NoVKN/oHA9vZvS8XgEFmWbURaU+zFtbZHRG5Dv7BDtUMdHpJC1zGoFVY5abkFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718857331; c=relaxed/simple;
	bh=QcA5twefDH5u1r8yBJ8x+UMsKFhR+LPypqNFi0AfdSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2Q2iVHs19oKD74FVZE0ftAWiE0KsSwKjDTYy/nJ7JCyrovsvh4GEmcMsrXwimn8b1/kCIhHqwwDEz9V6X0449ujQUTyGHdpYsNm41HZN9FckmIrSZzVnNFdAdciTN5K2XCZSuXIhPCTFfQ0BqUe8hDVKLllP4pJYhkO3LFRA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e/WsT2CS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e/WsT2CS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QcA5twefDH5u1r8yBJ8x+UMsKFhR+LPypqNFi0AfdSo=; b=e/WsT2CSbOYOOV5AZxkONLdNOl
	e1sga3+wPJ+7p1zlotokLpNPImyRnFj4gORU7yKCblY/UJmzHy0JTToBAhNWMvFnd/Zp6QJkXJ+TY
	OoXLXRAHwRBTH2fVToDcuSFdErJqvQ11LCoAMZQJlGbzZIAG4G8FYRGEKW2ND7dQn3jZ24indz1No
	ljOM+jWIuAmxrsP+AGDrhhVgeasuNihdpI1lyZ9gShNiCwoRKCcWmLTKw0uRcuoPTFKuRowyLjlFq
	3QkEL/W5lJlhkZ+HTpukQ+CVKcdN3d5jbUAkQRYdE9PTka1JWn60NvgsfVugB2BuIbK+e8k4C1Oq5
	AsSeY3GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK9JJ-00000003Z8s-0JX0;
	Thu, 20 Jun 2024 04:22:09 +0000
Date: Wed, 19 Jun 2024 21:22:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Ye Bin <yebin10@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnOucQM5ic6I3iE0@infradead.org>
References: <20240620030631.3114026-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620030631.3114026-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Module the q argument mess I'll just fix up when I get to it this
looks fine.

