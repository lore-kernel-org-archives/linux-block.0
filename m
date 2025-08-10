Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6F1E1DF0
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835043; cv=none; b=MxEn2QnQ3ZqVRRY+0/Lz4KZC7NCxGxFobW7yLMUJWKdmcWK6d7dyZbufGPSDC+bMm8n+D23tJfTIhzYYOjZ1hoXn5DwqGSzKojFBrEWffUPRC1zr3UK27mhBZOM/u65xgcbWy/VX5kH6zQwFweJbwWFcO5K/ZFD/zbsnXsiRUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835043; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBLkXusPICrScqCuQ0653Sn2NobLPHLNJ2di9c73t9aDWzfNgqCmlaXbSuTm8UXiRsxN9dFVtyEguMsPZTFqO9Uvm4VWwRDcfbHlYB7MnO4d2RtyuXdyY/EjoN3c2ABMyO6UBlBGsRC8sl8KIoCO0W7z9IaRzjka9rGsO2MTXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D1499227A88; Sun, 10 Aug 2025 16:10:36 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:10:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 5/8] blk-mq-dma: move common dma start code to a
 helper
Message-ID: <20250810141036.GF4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

