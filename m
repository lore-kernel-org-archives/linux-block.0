Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AC1CC146;
	Tue, 19 Nov 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021731; cv=none; b=rDX9DFm6247N2zoAQqeHYByNoNBQfDfsingZ5HXexQLk2owmSVRIfDfuAyP9mJY/cSg9lVG5HUF77eX5U2ZkBZ7Iw8NPbHJku98SMnWp5568I6zYtew0lQmYUOUe49lJ6i40FvB6BFeUDjEzyfIefJBv4CHPYVNLfOzUbEkxy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021731; c=relaxed/simple;
	bh=6ehAUbUUjhIZVJ35ogPwTJG3IGZ0UL6+89trtt/2OF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljLFLNwj87pBmAbF2k0+WyKLRUrtkw148Jr3+G6KI2qlu3/ypWBmyiJtjRbZdD/qnRpz0TlYrCnLI6Wp8LaAE4xNI/LprEFM7Ao866F+aKO/2tvC2FA37U2+mkY1klTyEz6JPYVDlGGJLq4zHVeo8DUAG1Xah9H8b3XIlBM8PqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eO6YC1bE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eO6YC1bE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EoVHqUDRj1frTyLskYC2wpn1o7+VmyrnJEN/QQ3kFvs=; b=eO6YC1bErm2jTXCH7RJ62vhqTS
	PTPQmtHGC+UzYXskiamtZSN9E14lAxuGjhi2k3jMf3Xt6GWLEt2pcz07ndvVGa4L6IfLJxVTx4Llu
	fQh/pA6/4jXvk22mUfbuHx42c6PKPLuOqx6/kRc9jxNb9O6wWtqfsDdwXPKw6WiNbTvS7/2Bgt0We
	aG5KloXBFBdUfxyZ0yyDEcAzvMvAvffV1d7ykFbTIZ3F4E1RfpY8RGhXXYelrdQ2EDnjfbQw8k3Xg
	oiAjUv3lK95R9ocbIz+Er97pFA6HiyIJM2SHmznfV/19CedWha67/qfY+pYz3wEzgElcHmHCNvWdN
	v0myQlwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNyK-0000000CSxP-1yiR;
	Tue, 19 Nov 2024 13:08:48 +0000
Date: Tue, 19 Nov 2024 05:08:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"terrelln@fb.com" <terrelln@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 3/3] zram: introduce crypto-api backend
Message-ID: <ZzyN4O2kE1LstLG5@infradead.org>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
 <20241119122713.3294173-4-avromanov@salutedevices.com>
 <ZzyF7PAoII0E5Vf5@infradead.org>
 <20241119130438.3vkopcmnmmwgmxha@cab-wsm-0029881>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119130438.3vkopcmnmmwgmxha@cab-wsm-0029881>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 01:04:44PM +0000, Alexey Romanov wrote:
> Should I create backend_*.c file for every compression algo driver?

No.

> Okay, there aren't many of them now. But what will do, for example,
> when there will be 250 such compression drivers?

Why would there?

> 
> And also your approach doesn't allow working with loadable modules.
> For example, we may have only binary module (without sources) from
> vendor SDK that provieds a driver for data compression. 

Well, maybe just piss off instead of sneaking in hooks for your
illegal binary modules.

