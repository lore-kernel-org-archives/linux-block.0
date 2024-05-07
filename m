Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479216EB64;
	Tue,  7 May 2024 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061820; cv=none; b=iUqTEegnrONlooXn2Vi5PCbEid//aab2DGADS0WYFKiXe/3hj8Tn3vtu+oyVyy8PadH9r0C5BmjetYcMDEqLYo8BE+chK2Q2OKqCIkICk0dB3EwlA4pqXKwRCtKxraGbIOjsFJpSMtVCsGn9pVnQ4lBjTR8elcwzKGi9UmEejEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061820; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYCyutxXwAvw4K2b/qGNTAsD3wgcs+3dFHAY8bNqi5xz6xe989xX97QXPBPIXfbKzdCcjDzRL4yFpKtzd91/Gp2saNalZaAwN4j7QTNGhAmSCSAlNcHJyHY6xK0VzY7NEtX7RNVeJA2XGDoCiHlykxcbQYibMNxu5IgSLgrBXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uryey6GD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uryey6GD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Uryey6GD11lPVH6uKp2mvVDXCU
	ebXu+gisRG/OtIzlS61flD5X11KVvB2XE1kWBdTr4S20z6fEWjVDA3r3EEKy0VWQpmtGPJzk0jviA
	eRfAIWi4sT6hwMTx0OFpPRC7wzkKhWIjOrfpNeuuyZBRYXPPNLIhmJvbPrEWI07ZAVnGiRFlfghbv
	ULoaSL5/QRw7Kv+6cFLC5cn0j5nJuYMTCM2KOCmw4JeUVworGeSAzOOFO/mfSJ5KFkJnBY65MbukD
	4VTXK2d7v807eKrz+VuCDON3ui0nUlnrUx85R4jobCa+Z43jZRvR8n2PzWak4Kb60eMr+LSRjyX49
	lZpOMyTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4DvN-00000009lxv-2YkQ;
	Tue, 07 May 2024 06:03:37 +0000
Date: Mon, 6 May 2024 23:03:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] block/ioctl: prefer different overflow check
Message-ID: <ZjnEOW78CuIeUdin@infradead.org>
References: <20240507-b4-sio-block-ioctl-v3-1-ba0c2b32275e@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-b4-sio-block-ioctl-v3-1-ba0c2b32275e@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

