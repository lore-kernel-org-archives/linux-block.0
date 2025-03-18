Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D0204F81
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284123; cv=none; b=RJjZbGQoIIJTlfVkYCPZsh/ZNAAOC+vr/EqOvBsUhO5IDIZ/iVYDTf6H0H3R8uZRMRJbKSEt52b68wafdpbvOE+ZZkaXCLTzWT9iNZlkcannP1AHBIxWu1Eyct8bVIvH48Ln8jUGB3bcj6i1QRVKIjaGpEs3BxSkSf3eF29sBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284123; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGnK34yXBwLU1eBoCaI+kKnPow5CuUmAiFTPhruNYfhLheM3s7crbqPKapaCs5XpAC0CxLz5JeIXT5Musii/oV63DK8/hRMJjsfmdrUGDt4fMES1F289SMEE1uZcSEfb86tLZT7LnzsNm3ynEVAC5VAWYPwTwMGZgTKrbTCeKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jy/x672Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jy/x672Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jy/x672Z8tgnLRc9qbxkbviZAQ
	ES4XXoAxdqDDJVYixy0EKWBNRA7ZM3dqRifYkeIJicR8tXKtu8JpfXTeVSdC+BTptZ0L4Jc1m4r1/
	1DW1+nJmWhXnPOq7hzlpAlSCBdCaJVF71wLC/13ftHWaKPe/kv/5nUSQXL1ZXp4Ynz8BR/oMbwrEX
	yGiVWPYoTdznGiui2YpUZ8chXTJ8rYSSdxkqnGWHveqpVurOfqEGMaDgOJ3hrpS05mg3yY3Rd+xXh
	AKe8HapedfMOd/lmeIzCfMKo8ZP4afFpwooUfljQVc/iASrncKtO5K9lTmLP5o4AMwqAKajZcy9P6
	mYsMEdnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRgm-000000051p6-0rrw;
	Tue, 18 Mar 2025 07:48:40 +0000
Date: Tue, 18 Mar 2025 00:48:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH V3] loop: move vfs_fsync() out of loop_update_dio()
Message-ID: <Z9klWP5C70CBbaPv@infradead.org>
References: <20250318072955.3893805-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318072955.3893805-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

