Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FC3955EC
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138511; cv=none; b=qr/y4UvhnY9DA8dYcVgxVwtMJ0sgaEET0ZAkB1qmv4Ai01ASALMM0DJx1yyPd5g8Lwi1RSy0HcFetxtMHjzzCljmP6W11JQE+qEz3jp0aaY1FQuym3VtuZihYGEyRBfB62N3j9fpt/N6gFoYl6ZL0bxITyEOPWQeJ1CNyzh4aDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138511; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q79mcbqYgmtSH/7MVVm0tnOcYE5h4vj6g/tf7J0rPAWx2q0osSVyWmEYyW15jEJf2dkXGKoUmi1oO9JcSHWJx9bVf8YIf3jyQlUwwWSX5k1neAjJRYvyI4JtFVFVF2Wi5OX+WvdmKQPw8rSTv2SGlMiJyqyZ+iZwCkFPyLof3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19CB768BFE; Wed, 23 Sep 2026 06:41:43 +0200 (CEST)
Date: Wed, 23 Sep 2026 06:41:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hare@kernel.org,
	Keith Busch <kbusch@kernel.org>, Henry Hu <huhai@kylinos.cn>
Subject: Re: [PATCHv2 1/2] blk-mq: set RQF_USE_SCHED when the operation is
 known
Message-ID: <20260923044142.GA26178@lst.de>
References: <20260922172711.1573186-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922172711.1573186-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
