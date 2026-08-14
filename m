Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF32F7F07;
	Fri, 14 Aug 2026 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689680; cv=none; b=OdXAQgfmnKR8bsppv5eieYBTbdIyM+enH3adRx3OTtZFdA4bxkqXoIcmPF1O6ELPLkztsihHuqThZ9SB/liGz72mWZxdWm02X0kI07YLS7RjxvhaEb2Llzzdml3okUkBCY0bQJKPNpR1GduhGMF2TUJxpULKTHkMCiZ7U4BtHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689680; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT9E6p0vsbTSqBhCpAlcpEjEGWl0OIBHZ/shL2p5+TLwDiMN40Rcnc251nJVLw5ag1MaFC2KklDVVveCbxFS2JvpsJjiZJU44jTyUhTKJUWAcRgQ31czipi1KYAv9iv8pMeAtPIN4biVb+VeTiUt+tothCl8nSWtCDAOTbmcPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c+0pwY+l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c+0pwY+l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=c+0pwY+lms9xohJnV0nj87NEn2
	uJThaSTyyaEsUScYIM9pOxmrCvC4GH6VzsaKsTmvsLtfF1nJOCJlnfqxnnwXRXeerreoTVKloEVe/
	qfTAVm4a137aOH5Jx31/BM+7PB3rYEtzdiIRSVuDxYoULM9kBAtjzZCNZw9OpRMRWmGzRFFDz8ZW2
	dFCuRCqk1SnEOfJjvMOg1sVAQpMXOi0XZwUzHAViQOUoxTULjhPs9UbMaqNcVMqH0dvQwnUv+It8r
	+Ad+hNWi13YMYp4wRGcgkvvEl0/XfXbJU7w/Yds2xUkj1IN00GtKGTkn8+KF6rfw217eEfCH+tlGu
	X1AQYNVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulbS-000000023EX-1smE;
	Fri, 14 Aug 2026 06:41:18 +0000
Date: Thu, 13 Aug 2026 23:41:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "hare@suse.de" <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] block: set QUEUE_FLAG_DYING unconditionally in
 blk_mark_disk_dead()
Message-ID: <an64jtYfA5UuSisP@infradead.org>
References: <PUZPR06MB62247E82E66A3ED46CC3E6C7D2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR06MB62247E82E66A3ED46CC3E6C7D2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

