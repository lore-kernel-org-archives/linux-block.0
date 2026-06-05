Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384C3C4163
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642197; cv=none; b=EG5c8r54CObpFT463E7DjpSHPVzTXKj7n2kiz8SmuLLMp+GCPM9fawR+DtFrPmfvIbZigno5RCoLzdVriERErKz5gxgppwpp56O5jN44fQiFERdy9vGDOCMWoLZaz25zNaCwuWeY2w5jQtiXCTt0UKWfJeEy8uhqNtBMsB+TZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642197; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm4kd+yOwXj6PoqhAtPfpLPymSSR2BAERIV4/h1FpH/AIHXI6jVJyvFPOvyBmYuyOhNOyHod2EG5c+cjtBrKd/PXyWZ4xLhxkJYI2a+epaoLqeYyoW/F7XxDvueoOGFHbFZNwrSp+EdW3jFOPoA9Ai+/SvpdG+IIyoNCcvAGs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A36668AFE; Fri,  5 Jun 2026 08:49:50 +0200 (CEST)
Date: Fri, 5 Jun 2026 08:49:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v6 09/14] block/blk-iocost: Split ioc_rqos_throttle()
Message-ID: <20260605064949.GC26230@lst.de>
References: <cover.1780419600.git.bvanassche@acm.org> <8037f3bb5f5ecbbd635ef48804a1a9ad2d2be2e0.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8037f3bb5f5ecbbd635ef48804a1a9ad2d2be2e0.1780419600.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

