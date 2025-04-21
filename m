Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CB33C9;
	Mon, 21 Apr 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745213261; cv=none; b=apuJ6h8dEvXsslPuUZOvPCUiR5dW6YF1QKOBjRZym4ECltgow3aivLc78n55g7vOusn9U6A7ub6CFhI4K83QHr5FHqJKCyDXZ5stAHZcqB694le0t9HI2+3rk0EuQ8XdEPAYmfU3IP6DOPf+kE6eM2+OPB9YpROtwcZMIxLq00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745213261; c=relaxed/simple;
	bh=vLOi9FL5PPOH6eZEN6CPFwm+DEVimKaK1kMkufQmtag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2Eb9b5gZLiE5nPobvTpaKVtw4fK/zo/MtrB8T0cm5ykxjJeIWcJ+FLE+dklG8demof/ka0VGcMkFvxbnlmx9sPwVX53OzFWaCuE7OIeCH2pcfDyzWigX7aTkpwFbKHXYI37pJxwEXjfbV6yVjl8em2CWG1lQuH1QCIEFCcYZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tcvPspyD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tcvPspyD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SmR7/4lO+w7rp6zemVyXyg1fORFvvsRR76ju+413l4o=; b=tcvPspyDZEQ8X4zMphFMOU1g96
	k+9Mu9wFeFApWoHYd3RCHH94H0VeBZ9fW7nX4Ngeru77HXPfJwNBEV8bxDEL8OCplYPq9v2zjG+N3
	stx9JeCrWCC8tFLVxv/qjQhrL+G6fkP+3A47dYpSURNwQEQmlmlaGAf8lqq+sKxHEEgP94uT4lMr7
	Xjjh96JyflfdQPXoE+1lqWzQRmkRSUONk9fNFK7MuhjYHlbbhG/Wsg+vuN6vI3kEl/KdmArmu90HH
	2S2VPMcstA9TpXbHYewxou8DwRk/mtQRl5dEQSw7/5zgOX2z+3FFTB+JA/zgJnTcZiWumSJt1MVt0
	zEYyvuEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6jgx-00000003d60-2S91;
	Mon, 21 Apr 2025 05:27:39 +0000
Date: Sun, 20 Apr 2025 22:27:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 5/5] brd: zero data for discard that is not aligned to
 page
Message-ID: <aAXXS1Xq5g2yLTTM@infradead.org>
References: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
 <20250418093826.3149293-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418093826.3149293-6-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 18, 2025 at 05:38:26PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently brd_do_discard() will just skip unaligned sectors, and in this
> case user will still get old data after discard. Fix this by writing
> zero data to unaligned sectors.

Which is perfectly fine with discard semantics and that of the
underlying primitives in storage standards.  If you need guaranteed
zeroing you need to implement the write zeroes operation.

