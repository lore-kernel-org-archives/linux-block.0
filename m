Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51C3B5F50
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958385; cv=none; b=nXgGPFIb5qMwBH9Iw+6L5Y9AthgLndPJApqjTKvLpvcRet08m54Uy+NlD3VMKBcpvXYe6+wlWT9u3freJt1Bn21xx1hFsjxY/DWNehxmL4aLC7uZcukTicc7DFFWIoZ6GtlBaNzjIMPIHD1+VzgYnF4rcPvtkyxXZVerQCr1viU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958385; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQu2ThNkPMFZXnZRG0AbbAbBc1WfiCxawpGbgOs1atJZAuFbyfNhMSFYuwnD2fSZkPCFExaZeJ5roFx0SDhix4ep4rxz3LzaSkXyXfZqxg47AjueMIdP2vf1/bjNX7Fgtc3J91MYQU4Q/QxR+GbOM+Ki2dsRYzOqD60yPVVkkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K3sjiQiq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3sjiQiq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=K3sjiQiqMbu0K9QPJFnew/aKE6
	hZZrg0wfy05eRgUQ8KUd5p5Bv03pDnyCJ5MAOul1MCOc2xrl3gT1NytLKadeR68f3doslyW371dYq
	9rOdbkZN70xMnp7oPmO/1SU0HEuC9M2yBtQS7NUblgsb6BUZLI3hAGZU1T6TMPp8kkAGAErkXk0I/
	95Hzs57S9l2Cn0myjRRKka+DGTwkyTY2ym/U0n22cCOoxV2ob9TivDcwExZP8ulTKS4bie0mXAdNV
	F1DTJar667YMvW8ad5YySyuD3MyZii7UhKJY0yFiRlq52q/UGClMlBXKRzQ8jFxZG97gW+hDwxIMX
	F+PWnbqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtVO-00000005nXj-0Uk2;
	Mon, 17 Aug 2026 09:19:42 +0000
Date: Mon, 17 Aug 2026 02:19:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhenxian Ma <mzx199711@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: Re: [PATCH v2 1/2] block: skip redundant flush for O_DSYNC direct
 writes
Message-ID: <aoLSLvofsmvlXi39@infradead.org>
References: <20260812130335.60354-1-mzx199711@gmail.com>
 <cover.1786782832.git.mzx199711@gmail.com>
 <f847707d772a9225460406b5aecba030d7209b05.1786782832.git.mzx199711@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f847707d772a9225460406b5aecba030d7209b05.1786782832.git.mzx199711@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

