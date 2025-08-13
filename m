Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DE2C08CC
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067946; cv=none; b=cAOUd67SYHumLMjyKNAf3akvVbglUyToWrTd1+XdR+qs+zCEUenkXyVgyTpIVrMxYGqD/YSd0Ao7yYilL+2e6+8DKBG79Z58SH9JzdW1izNJsuDZBKl722yoNfGDNmPuvz8Cq8LZBDOCwLTLxLJsAT/hmFrADpjY2v0bnVHKdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067946; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOM2PRmYV3DbRhY4Y63zIvVOadAm/KeuGpPtC6pgBlsbf7E+WHl3jEmnbvnCPgUriHDs3faWCMkH8OeKeCGIQbQoF5BkCD5WLsDOK+aehdOS7pGWBy5Hel3+8ym1eLW7FaEXCAaycqhG1O0ZGBwzvTFAZiWX/WirPTaEli/Au4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F15AA227A87; Wed, 13 Aug 2025 08:52:20 +0200 (CEST)
Date: Wed, 13 Aug 2025 08:52:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv6 8/8] nvme-pci: convert metadata mapping to dma iter
Message-ID: <20250813065220.GB12473@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-9-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-9-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

