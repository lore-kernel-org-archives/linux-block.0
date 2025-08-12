Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807F2F8BF1
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015887; cv=none; b=G7/D5PmGQNc44CZms/uMrkbC1TfEAd8mX96iSLxfiae2sUkvLsEu9SyKEmlb1wNbqyno2yIf6pL/hFnOS2CRWJ/dlokHNK0dH2Xgy4gyFbQ6ffECXtukklL583SNG8aCPuZxfDXuLdHfyzD17fwu6tKNRdJHzEFRDcEQUXepEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015887; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nV7b+BejCTtaviR6bE2x2Cz5o85vLw8jfw8L4hv36Gyv6Uk+W1AWaYBYrhq0cQ/fzzqb/echvU85pYWo8ggXmumQl8uFp23hwAOROhPQNHtnPQbns8mD/K0j4e7ckq9WfgFXW5xvPTc0lHf6ZdikYlseQo2r0nZCiHXCBzHxEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44C1A68BEB; Tue, 12 Aug 2025 18:24:32 +0200 (CEST)
Date: Tue, 12 Aug 2025 18:24:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv6 1/8] blk-mq-dma: create blk_map_iter type
Message-ID: <20250812162431.GA18150@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

