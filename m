Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E719D07A;
	Mon, 14 Apr 2025 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744612370; cv=none; b=XILIZuLgvwFXf/t+4XLAin7d8wPQk4kUz8O7N53iv4fpzxSsr4r2YS+W6FKJtm+amvzcrdLFVPZLqnPrytbD2T/kVcZpicgUMyG4Rjdrk6KU753QGctZudWUVmC2R9Wm85VPp6Dy141u37te1wTRS3M6Otzfd2dcrz/gwy59OW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744612370; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy+gAHR5cvmyfPqCUpqvzbUmyyBHJRpKHoos10GyremfjATMyVdQs7qH5qVb0xG1UOSrNH7YHAjjOT8DfW8dwpaQz4K8BgeDrUEaua/aUBBHwDlzHX4ekxfIFoed5wHF/RAUPod52hSW6tgEzy7z5gY2BJHFtYVnuNvnDD8cD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jcu2vzrk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jcu2vzrk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jcu2vzrk9cWpqrN+IFQSjh1Ruf
	MHs1mnecz9e0ATOhLAnqRjvqO16TCMK+tsPoFi7nMEsWAiJJloHc9qXhqyMLCYDTrd62tFT2BzQEC
	4xHZTexVIvwnB0Bp8pvBS3scHWVb1hvmHfcgucLXuIS/OPjOOpg+u7sFk01HcIU91XtWmOY+3o/bW
	5i7pAdqHRh5BmUJaH3w1E/9/wVH1qYkn93BD6ITTsIIVyZNZZYgYGq3oIgoWtPGB/5Kcy8unmn0JA
	Xt8w9Z/Lx8+5fC2PiJuqwVPAz19gLps4K78xG7m47ti6UUHQTy2ro5LkZJsSgEmLrXpvUKadBahpp
	/2PNEViA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4DNB-00000000oUD-0SN9;
	Mon, 14 Apr 2025 06:32:49 +0000
Date: Sun, 13 Apr 2025 23:32:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: add SPDX header line to blk-throttle.h
Message-ID: <Z_ysEW3dUtv_qLuh@infradead.org>
References: <MW5PR13MB5632EE4645BCA24ED111EC0EFDB62@MW5PR13MB5632.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR13MB5632EE4645BCA24ED111EC0EFDB62@MW5PR13MB5632.namprd13.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

