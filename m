Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F324E4A1
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261794; cv=none; b=FZjRPErVcO2CeSbA0gLBddxJ5SW70uIlp/R/Mq5VQlTeDjR9pISWcnhtlfPUb4bUmZ2bBaArQcCfDV88zhgJv/tlizNxprsQdKYnae2wfG4i8XC0PW3xI0tKSnEMFkYq0cDyiQJFN/xbgjyLVzqthp8Rpp9Nv6LPW7eQZK1nIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261794; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si9w3RLNwYXTgG7jyXbma31U0rgZV6WkoAtLFXj0PcuFLd+OO3O/7DQF14++a7V73RtIPbB1A17hu7VY9VvQns0RetJ3F9WCwZwo4KNzdJ1XiLVrv7QUqCrtm3Rqarb60SO3G6sShrp7yafcDDRpaI8T0EBujjbovfQ32FCgxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F179C68BFE; Wed, 20 May 2026 09:23:09 +0200 (CEST)
Date: Wed, 20 May 2026 09:23:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com,
	coshi036@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 2/5] block: fix invalid zone append status
Message-ID: <20260520072309.GB14937@lst.de>
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519172326.3462354-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

