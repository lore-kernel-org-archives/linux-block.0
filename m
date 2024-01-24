Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8A17BD6
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088502; cv=none; b=mW0iVlufc7y342l5K7BH4kn4oaQaJY0akGqNsF9M3387YRXn7WtztMFUJGQyvMkf6cumFlZsXmGnLTmvvdAUaITCnbwc2uNpH879YVgRuUeQOBrVERjgz1T63o7jjAVuubhBlF8qlQNjwMGrwha+DHoBJvcqn9MxsMuDy+sp/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088502; c=relaxed/simple;
	bh=JcjanfcQRsQHq1Xx9zISzw4nrZrtMy5iTpG6UNYZ2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuL5u8BbarHllZDB/9j/SKr6hI1UbjiRpWfQ8wb6WdsT1FoGaFvjks5fkMMaVAVveszKsynAiQtEOB2tay9NXviyf2mVO0bAmmoBQ3hVKEBm2zf60iVm53sTx7hae/y488lLUnV8QTEsYv5hXCaOJp7290r4sKHEngMzIDB3UpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oki+/PQx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oki+/PQx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=frUNv0MrI14bGhEVlovgA0n9R3BWQom62zAlgjR1BKo=; b=Oki+/PQx0cnixQkPxpBCCe2dpj
	I4g/o3O3m7eoqB9tkYa/qR06bWemVYI0wEhRXleRJiAKb+OoNpH6ydKi9k29MdixqqGNrSDdOsxRn
	eVsRpgawDWpbTLcjUr/CLmT9o2nJ/Aj6Q0VcBGasaZdGIEwwgECoG+oO9X8E/twhIPzh45ayj1VGu
	JZx7me/ZiOncwamQKh8P+YjhQjViT4GhaVs9LnDModXh9wOLrFZtx9Jjb71+dYPwQyiPTCnNCuNA0
	Kl79bZmovyg6gz+RWreZbFlbtOiDoCAAPZavRnKaRc1luUghun61NsUWwUE8tAUtkyPZE6czGeCTh
	/7xbLa0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZYS-002EqV-1X;
	Wed, 24 Jan 2024 09:28:20 +0000
Date: Wed, 24 Jan 2024 01:28:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/6] block: add blk_time_get_ns() and blk_time_get()
 helpers
Message-ID: <ZbDYNPsbwQo11Fgv@infradead.org>
References: <20240123173310.1966157-1-axboe@kernel.dk>
 <20240123173310.1966157-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123173310.1966157-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 23, 2024 at 10:30:34AM -0700, Jens Axboe wrote:
> Convert any user of ktime_get_ns() to use blk_time_get_ns(), and
> ktime_get() to blk_time_get(), so we have a unified API for querying the
> current time in nanoseconds or as ktime.
> 
> No functional changes intended, this patch just wraps ktime_get_ns()
> and ktime_get() with a block helper.

Given that the helper only is (and only should be) used in the
block layer code, any reason not to keep it private in block/ ?

