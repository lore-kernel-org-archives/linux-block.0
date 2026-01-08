Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84B431B5F
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880184; cv=none; b=L9bILf2JuoGwOS11sKSeJUNvcYMdkF2jgFGrAnmRFaLnrfaHsKE2tBrhTX9Xq6USS0AgVfEB69fNBUrmDjKJ3EIJPwKLRhH4rIC1a67xIFNsF/erSXSPpwYEddQg6TJj/jVD5ZJRBRtL9S8K4o30aelYqh5H7j66jtCBlngISZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880184; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1gTeuWV91C+ioxgfQCn2cxbHXvs0da72Cis+3amOIYp2aejLXda49INt7Z1aOCIFAmpwHHDNeLpLlbxuckWmQWvjpcOuiTC1GM8Cxh3XTKk4OwUnhCYK8n1mUS4vMaixZSoKICT+nulQPXEaP7Ok/NMqQDobyh2P61I1HS0nMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x1hcOxJT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x1hcOxJT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=x1hcOxJTPEQx+XqrTpeU4RXlbE
	Fx2xEhLIFf8Sefy0BKeWmzr4hekyib8wjE76RrssfBh8jeKJz/kn0Tjxbq0s3AjJIh6D6pklUvmPJ
	lbutgKEN2H2pwi7J5JVegd3yhao0L+UZUOaWWWMs83yi3fI/40E9yfxBddcCYRrBf7m77+R14uAfK
	w9eOvrJHuve61W9b6R657tHbMFfQfNYDwqGbeYwDZYP417bN4S6s1i6/brcv56dbtT/4trhtNARF/
	3YpAvanhG3yumHo3PyIYw7nzWR2uFHP6poktCAXySwX1iWpXBOapywhH6hzQ+Htx+JWNPPsxNWKrq
	4bPHocww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqOP-0000000HEFS-3zHu;
	Thu, 08 Jan 2026 13:49:37 +0000
Date: Thu, 8 Jan 2026 05:49:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: improve blk_op_str() comment
Message-ID: <aV-18Qcn8A0tUBsT@infradead.org>
References: <20260106070057.1364551-1-dlemoal@kernel.org>
 <20260106070057.1364551-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106070057.1364551-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

