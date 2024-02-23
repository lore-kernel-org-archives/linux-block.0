Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098812B6A
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670509; cv=none; b=NSRdK9cK1zJitEoA6mus6TCdvYS29eMjktkpRydDvNophQngmfsDoiJSWd803mxlZg2Vf2Od4aTLF3VDlV/aMf5Z55su3n/cTKN8ZWnjjMlAYPpwUT+07L9PMBqbFworKmXL3esnPwzi0IdFN4oOY87dCQnx1Adxf0I/JQCO7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670509; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzErzNFhTFhP3xRrNqEeyTy0ORwWM52J73mF3qCVl1cNxxUqUCj6eG9r3OWpV7IJTiWzPhSbNcwpOBhlo92jPmbwALPi9UfnFgSQpnC+ARDW9KRH1XORAleo3StyPTAMIWiELHnF24p0Lj9dedqn11fnNyhe6nsokZN+kVCwyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XiOzaoVu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XiOzaoVu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XiOzaoVu1dqwsseCVpBKxQluXN
	qGunT9BEtuHCB07QvMUZMaroT52jl8k/I8zGp5bIDd+vPRlH36jlZ+ZyivLHxk9I1wpNv1Scz21AN
	zN0HC+sF8FN6QX/QBBYPc5AZOHMpQdGYN5nYYPJ4wWkTEWb0Byp3VQRqRzwO/a4BfQ/pPdNw7ctyn
	MGev93HOrw9UIlOHsQWU9wcJ1wYsYuIAssXHdFqNgT0ewu2OGHBmh06nqc1JO6zBRt+hlWTSvTBR7
	DjPQRkFT445uCkQuN7RcAp5jVjHvFIvRbV81qX45BSMrR3sDITcPF/fAXdk8GRx4ZP0ZYFeCSkRMp
	uOt5g5Wg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPFi-00000008D0i-44zP;
	Fri, 23 Feb 2024 06:41:46 +0000
Date: Thu, 22 Feb 2024 22:41:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, ming.lei@redhat.com,
	nilay@linux.ibm.com, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/4] block: blkdev_issue_secure_erase loop style
Message-ID: <Zdg-KlOdNU2mTKVe@infradead.org>
References: <20240222191922.2130580-1-kbusch@meta.com>
 <20240222191922.2130580-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222191922.2130580-2-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
