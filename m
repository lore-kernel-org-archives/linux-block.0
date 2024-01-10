Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833C8C1A
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UO7Q3X6r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g31p+SweFFjXTaK+eNIqZKM6p+AqhGrx27S7YZr7Yvk=; b=UO7Q3X6rR8ovdRWw9SSx+bEBOj
	/2dHOAICe29RkxAldXQB6dSeFgY+lQRLwxC229heLkS7oWFnMb5SrcrhPRkbydK8DFv0mCBs+2KlR
	Jw7treTsW6T5+jNbqlmiprh94t3qCSA5asMsOAiJi64TGaY39plEADff0JvZNbLMr7toFNtHjde1Q
	djprxFJPtRAOEW3L1F8P0uyGTvdMPLpD5C41ogqdQ5ZeBrMsO5N3vkE3RwsXYdII4sel5IZxMn5T+
	iPivZFZMUj32MemcUj0tjZc2U2QGcWdWCecHf1qnqHoAWI1yUQJ9294RQ0/Cw084yrr1Or/wWV7US
	lM/Mh5Kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNRlT-00ASF2-20;
	Wed, 10 Jan 2024 06:08:35 +0000
Date: Tue, 9 Jan 2024 22:08:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix partial zone append completion handling in
 req_bio_endio()
Message-ID: <ZZ40YzBnZ639Zttm@infradead.org>
References: <20240110051559.223436-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110051559.223436-1-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 10, 2024 at 02:15:59PM +0900, Damien Le Moal wrote:
> Partial completions of zone append request is not allowed but if a zone
> append completion indicates a number of completed bytes different from
> the original BIO size, only the BIO status is set to error. This leads
> to bio_advance() not setting the BIO size to 0 and thus to not call
> bio_endio() at the end of req_bio_endio().
> 
> Make sure a partially completed zone append is failed and completed
> immediately by forcing the completed number of bytes (nbytes) to be
> equal to the BIO sizei, thus ensuring that bio_endio() is called.

This really is a should not ever happen case.  But if it does happen
anyway for some reason, this is the right way to deal with it, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
