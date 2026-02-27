Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B52032D
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200119; cv=none; b=TwSuExPaQ7majHBthuiu15ppWbBeukTh5/NuSrE1irVO+PEorOBb6/OcbbeeHJ4b0EwAJo6Ctmy/1ACep7jXUdsYmf7z90Jtrh8gtxh6EquTYA6J6oknJGiTY0978REuEW7psbeWOsMcQWkAqhKJUq9/J/TbLGWireZsA/pFyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200119; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMt0wWzyQCdn0GKqHslHpkMKffmoGc+PshbUyqYqj9+NahDl59vr8gxLgUbZ+Num6X5vCV04N6BaOQdQVBfpd6PN+dCfwtMc9QNj2PEs7kzCsvjUom9brF5Rv6VPIxOup84/0OmFiuFV/QrYsxeJaLrLvMKQ69cvD946sts/ibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jehsiA1R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jehsiA1R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jehsiA1RGTl4++P3ZKNL4t19P4
	I65WlIPfSLjNtjz4wLVMpSzj0+CbE0Ft36GBhjPq3tOFCncUc+CjUWBggdMdpdvxwX5I+G80V5RyD
	WcM1y6aQtRgs/Iy0B2GxkrVYN8v60qj1nYUev31k9cRwduryyM6bDhIoQiKkBWQxaAUTXbgYz0sXI
	8slE/Dg3OJvM9k/Xqb3TL9UeEXa38ttN/gPRiZrpC4sqQ7CD2FQVzOeQ4zJ3afoZTv73jht6fnQX/
	v+/8NsinraTwTHNNwEWm6JGileC6a5eBOMsuDS5tqJAVy07tCLxBIc7AP6RJKSEuNHAj4uaYLl0eE
	g+bz2oGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyCr-00000008Oyn-2lfF;
	Fri, 27 Feb 2026 13:48:37 +0000
Date: Fri, 27 Feb 2026 05:48:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 3/8] block: rename and simplify
 disk_get_and_lock_zone_wplug()
Message-ID: <aaGgtZ6NMKUR6Vay@infradead.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227014951.2327711-4-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

