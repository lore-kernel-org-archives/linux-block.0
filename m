Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFC3C13E5;
	Tue, 26 May 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779776952; cv=none; b=ZzTbn6DLoa3j6Fwm8Ml6HRpzWQyMWFCItSdcZr9xkuKbXyippKBnYjUYIbt4liFGeUF6j6RnEe3cRYgAMZMhSPjdH6JVfz0/7h65ke8eBdsopXd0vrmsqOPm9gLtOQv9vov7osKbyWcFhZYwkIx89zmoe7jqY0nJ5gpFdp7bkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779776952; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETjUfFVgSCm9XSMGyWWC/LFJe0G9esPEKlb/1of6meysRmq7RIPn3PGj2BTIwDfbvglYoc3OSngHBUfW3dLX2pmidArdGl6+Kz8nJK1B7f0SmLRBkIOoo1K7TOl1DENkH6d8T2TcZ0NmFEAOy9MNefA7dqMF0r7AgIwlJ5gKRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XAWpwWNR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XAWpwWNR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XAWpwWNRMWMeycj2jQU9BV0pba
	oCEBIa0m1CjvyuRIV137NrXEGlMyjMv1S4DmjRavannlqiiTiBiEZfMp105rx/l911H1nmeGsFVOj
	bAyyJnw4Jgu7EzUGVBsw2o+0SsNK6kL9ZHn0i8YDccz6SSh7kT21elwS28BUAE5jC5Tcop8Zuvzzk
	hfHtYtKw/K228Cy2BbVsF329X/+IuqnYIhX/BSeCVfaLkSxwj6cscnaq6DdFiq5dGHtS2cKkU2SYQ
	+neT/UcIL/pLA1BQLd2mhdB4ENrUszGi/mglkRy1W85lDGXJXFLWtV1XTtyIGFRwJx1+EF4EgVFUg
	5wAmf7ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlHn-00000001ARz-2qYu;
	Tue, 26 May 2026 06:29:07 +0000
Date: Mon, 25 May 2026 23:29:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: remove blkdev_write_begin() and blkdev_write_end()
Message-ID: <ahU9s9AV1t7X_Jdk@infradead.org>
References: <20260525-blk-write-cleanup-v1-1-391c073e3831@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-blk-write-cleanup-v1-1-391c073e3831@columbia.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

