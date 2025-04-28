Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49A20968E;
	Mon, 28 Apr 2025 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845836; cv=none; b=PtShQm+BCh1/Iz3Lh5pG1sOk0uph57iTHmecRYoryiG+pj6Rrx6befE1alBknfUcRMRjJoiQsnmje+q+g1qbPcJFwvAKt3BZfOtfI/zIZLyq3uevhgvqeoQ1RS30WeCDiGs+KqXnWx1ek0Zr4ujLSPI6tM+mXCJ8zQzcRRl91aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845836; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqsk92R3ytNKiUi0SiOtD9+8hU8MdPieflOyDkSsBOSvNqcdwDFt6ejXd6b0MS0T4RoIfLIuZ1zUvl5JGa+X1IMBq+4IQHmm2+uCsx4HBhggNJar60ii309LW89HdLjYpNxOZ6OalFPLtcJ6d3soEnpZKPnnae0GmhfhPimQ5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vanpe45v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vanpe45v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vanpe45vYGpkGDhmDgo937Kygs
	mx8qE24WYcQVxjfLnQVowVkoWqiJPziqHqgdTstoAGtH6v5TGAawxv4ivZAsIigZLAIN6vRANL8YR
	2KJtCpS876fMwLOvrsyISilOX1MaLZA1Hk9w+GqNTH4wmOkweg64CN9wGM1j1K+UST277tCjWmVAH
	Oev5vFcC3uev3PeFPOzuyU3kbnryoCnySwPNZ8esG6t/OcuStrkSu8TJYU0bDzvAWiOBRqV10WlDe
	3qeX5VwDbJ2IVD3GDUlmoPUIv5IoPQN2cUdM6/bXpoHnqTuGcU1WgbVjWatKmjA+vTLuc8cbH6afM
	9A6YNPYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9OFm-00000006PMB-2kGH;
	Mon, 28 Apr 2025 13:10:34 +0000
Date: Mon, 28 Apr 2025 06:10:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] block: avoid hctx spinlock for plug with multiple
 queues
Message-ID: <aA9-SoyMvZvv9D9_@infradead.org>
References: <20250426011728.4189119-1-csander@purestorage.com>
 <20250426011728.4189119-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426011728.4189119-4-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

