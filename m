Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6612F747C
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015900; cv=none; b=EakSJadMFGeRX9qp4yNRembHz4NYAaQbEoemqWjmC/M4UNkRh2BtNReF4acmXU147i6UG6va6F6hvgIkwd8jeZ9dmBGbjAX/1jvdlp5wM8s/XFteWgmj0EuLDi/gsQA4qd0py04yEyBHpJC0Akwexoq0y23P05EViNos+BH7Y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015900; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaaAdNQMiB6cXjeCZMthUeW6DTFJae06NEBteSzhoMHAcaB3biYiw8C4SyWrgxa5f4PMOAn4mtGRg8RsKncT6bpstE7ptNFaa/ncJ0Kyi3cNIk0WyPQ/xIv3gFaSIofhem32p5V2ZNdk4gVO5Hy3G1oIOBoyTc1degphhYdTfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D2BEF68BFE; Tue, 12 Aug 2025 18:24:52 +0200 (CEST)
Date: Tue, 12 Aug 2025 18:24:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv6 2/8] blk-mq-dma: provide the bio_vec array being
 iterated
Message-ID: <20250812162452.GB18150@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

