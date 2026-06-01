Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25034753F
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299745; cv=none; b=jLygYTXJluQhqYae3WHqExax+N7GnWJu0Al1cIv8LtRgx468axzJ6+YFtz0Pzl73TTtMKp/aGMPHkHIQA7brsdS7u/eBrumRzogz0xBMLRBY5M2z9m5zbNaUDxl2mBLRO0WKF+QcArhqJkU3XAOj8kt+aEBxMWwNVt1D3ahuQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299745; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZpk7qepRlJ2m7rJqcF12uaX9tC3jftHeIlIrbFSG1eMUR64NDhggwTY6fPI3f0ReEduKn0/TcNI+NfSL9nlJBUPEhZ76+Hu1o6LBJ+RmokyM/aIqapBcV8z93YderP5GnYEofUu1teHweL17QcYSxFUcfc9NkxP2zzzoUZo3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iX3H2Vn7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iX3H2Vn7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iX3H2Vn75laFHRhLfI2Za4rpoe
	qQJpihwIr3FQ0VD/xd5sukuTAiVtdaEASpJ4n803Qxlyb42pXdOfeItTuNAIuXmG7zNVClm4s4hJg
	OVXjhzIh4RvI7bE2Whof+HIhmVTvy7D4YaUQNRZEvJ70xDDcPioj2uj4VQ1Q5tSXrN/0/pbXbEWwB
	r54PlAzTMK3pTUIUWvHNLmuIRMtlrCOLRyKl21RcaP3dAhV46XWdK3R7fSBEpeVwX36eNVC8NN3b1
	8AVoV2xCukZ8KsZEoPttua6CCsHZfyJme7724Aw3yRoscP0pjV4u01U6AbFcLoscajw1Vs+q4TP48
	mVAWfjmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTxHy-0000000AJYa-19C1;
	Mon, 01 Jun 2026 07:42:22 +0000
Date: Mon, 1 Jun 2026 00:42:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: dayou5941@163.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, liyouhong@kylinos.cn
Subject: Re: [PATCH] block: use blk_validate_byte_range() for BLKZEROOUT and
 BLKSECDISCARD
Message-ID: <ah033gO9mMlbCwKn@infradead.org>
References: <20260529065618.3091286-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529065618.3091286-1-dayou5941@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

