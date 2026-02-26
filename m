Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBC385539
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122617; cv=none; b=S+TiIWUj3Y0dhu0MaTRc5DpLKBtyQ1fks2kJWFyMJILa+KSrGFoBzfanVMCCqKUg2fvdai2iOnzo8prcgETjZRhwPpWLdLW/qo2Z2IvW0DQlas7yYhBbPFF/g4rwGOWTUhYKh4MQbhy0Skq7E0IfjhxU1ZUamklkCIYACFqF5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122617; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpN3dNOB8rZAL4JbGybQjBl5dnRQZfhNJnOsQ4cForsvD47g1dNdj6L04TowzkugIurvfuTEropWkQlJwE9KZg/y27ncGIcA9gu++jdBsOHH3yCC/WoVd/locqSBeT1e8hvQKFpffUXwwgFM6L0SF+peXGPC/aWH60lS+ylVS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n4gdl914; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n4gdl914"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=n4gdl914ClbHzbdSXE/TJ820a6
	Bsx83ewNlUa+MxJhwZ19OuWGhEYhLxLKOCqGO4nBGeJBV1EO2yJPZqCDZeUB6z9nBVYvpHISx6v1i
	BJDiBXK4gOoX203BaGJL0fRUnuWUe56OzmZvXi1XRiu8g59pkpnEt0ZXLZKSVvjS2xlYcBgoCstBr
	dF4itBIWZIk6KMFEFuz7M785FogPXwPI8FG1PSphi/h0EhR/Pxjne0z/cjSuFc+jMVCMAYxL97VI5
	ts4ZZ33v5saSkO8PCXO1Y9A+tYZ8TKnkyN2mLlij815zvv/Ytjf1EDPler9h9zQSLMfvQlD+MgtMy
	FiyVk25w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vve2p-00000006iLB-2x9u;
	Thu, 26 Feb 2026 16:16:55 +0000
Date: Thu, 26 Feb 2026 08:16:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 6/7] block: default to QD=1 writes for blk-mq
 rotational zoned devices
Message-ID: <aaBx9xzxxnWI3Ns9@infradead.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226041024.2154806-7-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

