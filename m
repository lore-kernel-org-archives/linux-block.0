Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812E2943E
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIRFxuZj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=UIRFxuZjIkl+/RvG7pJkA6jK0b
	nTPGwjTsiigICm/YhvHBhU//7vrq9qaGfT2zU3sTdbpBMc4kCXZQGjXk73p3Aw0tNAzCAvRpHJedC
	qF83Fwuf1DUrMEAREVWMLuWMQiq50x0zALoTsBGbMgxDi2cltPbIHYcN0Cm1EkAgTbibJ4om2KZXd
	OznvolipAUgpoQZ9n3UiUuF9LXSgC+9nSgQp0Iyb7UCaA+tDa38JQOaIJQpNV55rKSdh9PXsQCLKp
	Id+30VdtRiqDXzI4q4GG6XgsZjoXqil3j2geUpPgEF7fJ6AVJcgnpwhzTYiiYyXGGTiEtWKNe6/j6
	irQDCTMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNxYF-000Wy9-1F;
	Thu, 11 Jan 2024 16:05:03 +0000
Date: Thu, 11 Jan 2024 08:05:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/3] block/integrity: make profile optional
Message-ID: <ZaARr+WmdzJBFGqv@infradead.org>
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111160226.1936351-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
