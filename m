Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8742982B
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122325; cv=none; b=rcxv7TeEZwk8hW5y+PR90wlv3mPAHpgUT6rwW1Cw2EbPeNPWMsRu10Ty27Rg0IsU8iqJuUyCXIhUxUIeuWzH0wECUY2qvQJZQlf/okLpwxu/7b5sA+lsNplGaq9EM2DpgpyxTfuEySBLt+fNHgr4TLII0oxyTWG+sbV+HjRTQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122325; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkyUhfTjGo1x4XW9mzq3FKWqJ5xYVJFd87HyV8jqbmCGISGejtRHN2MbPGlN/So7FGCOvXuzz8DEJQ+iJ69mto42/+q8WfooVD1yplVOSiXR/TSSNv2ycGTydjW44BrmpHAsbU28zDaD2czor4sJI6CCYt3e9Dkfj3AW3hpoZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=heQccSeD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="heQccSeD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=heQccSeDxyvzwfw+SFbOhvz77M
	8rWnI0apJFsKQSvkP/sAztlwvssfLBWuwmqRNRNtwIQalo0WG8xWcQNXpw8AS+PJ2CsmupdLKvTks
	xgMvPkOOpfXhH7gqP7ZziYUcd6uCg0ST8gmc3GzIjtNVyUsz6qUu5hxeZg8oLNPg6Rr4rQSu06ay/
	3gCxo+0v8nsnpHroX39fRWPVYqQsqH3v975l74VUPob5qr4aWdLP/SzHyHbtWO3gidVVBxvp4QPfj
	Oh+m/9iz0C379hzrCKpe1KaVj/WlyBoe7ZgDcJ9JetnC+1GRGJxgMGiZnxmCbMFeNSUXoUn6/j3Zk
	pFVUGrlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdy2-00000006hWq-2x2M;
	Thu, 26 Feb 2026 16:11:58 +0000
Date: Thu, 26 Feb 2026 08:11:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 3/7] block: remove disk_zone_is_full()
Message-ID: <aaBwzrcU9Nfikfen@infradead.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226041024.2154806-4-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

