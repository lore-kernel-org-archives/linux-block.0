Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CCA1D5175;
	Thu, 20 Feb 2025 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031650; cv=none; b=DG+wo39OtwX5WGn1+LEnhiGwxio46zcYhTIp0ZLgdSSWbOqvumKjgHaB8hCG0ij1TAH5MlIGg1eYn0iItM4yy0Piovx5jBJS5v0JzcIDDL9RVmZO1/TKReuC0vffn1vN78Dgm68RejYN3Y+xokXCJLdV4lXMqPEkckt8a4YsAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031650; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0FwsAgDz/P6coYQCMAXPXbxQdavLso0hW0O9ONw3qHJx0qjs2oH9UhNO9FGSkLp5IDh7LZhsxI/4MbEnrq9jbAOMghLZPpD7XDW7+XwmN7eCma+W+DQocsIWKOcc7gi68GJAH07RWHRSnkN6lYKkgmJlcdM39A0HZW7WBaEOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mvjJDtUx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mvjJDtUx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mvjJDtUxWDGvr98Sw7BjYPzbgU
	lkIGcRqyvO6XXmHY7bSIrZbNQQXV9JRDo5/Ycl3TvrAxc4izvaassEEEdK1d1dPnrCog4DDOX8uFg
	Lijl5gW8VSM2HnmH2iFoJpe2l7GZumytORytc14DFnVQOK8HnIczDO8nPZMvNrVBvKsG1JlivLXSm
	JN36Nl1PsJqAzGRrED9TQ9JPHW6mIXTYiALinocLf3iwJK6enNPvlpdwqU7rxJR6E0IkMHTHZKhvv
	sc7sehKnWcQOBKb33SGzYeikPAlTjfwgxwjXps1DqR1nKA+8Mil9tBD/x90IFsUWXG5XZRwKTU4VE
	Q7qdBlaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkziZ-0000000Gsj3-0sF9;
	Thu, 20 Feb 2025 06:07:27 +0000
Date: Wed, 19 Feb 2025 22:07:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Remove commented out code
Message-ID: <Z7bGn37QGPOd6TzF@infradead.org>
References: <20250219205328.28462-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219205328.28462-2-thorsten.blum@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

