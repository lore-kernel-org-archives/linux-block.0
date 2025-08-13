Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62980285CA3
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100438; cv=none; b=jLNpfMA2U9UTPll1+hJnuP2ZRauEcMR/7GXt/AJ2qqi+J9kOESFhmfQb72p4kO2PBSUL+Z3rp0xqWFAVvTStVihwHbBzftTrKickxSqXU4pGFAsmDSkO4wDVG69veZtc8zxjaw+fya72hk5kx3/GR9RuuOCYAIeBv0dVvDlTMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100438; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8l5FJiPYUUZtA3XJKWPJYtdacdH04huVjR8O80SAlARc1WDE7ER2q4wIVcvL3EPRmXwxZS4u0pJ7EX7+OOoNRnViSHJJxJpdi0VTHdtYLnzfx2vNFat43wCa+ve6TKfBSBOb51xen/zQSrA1SUGg+dlpCN7PTtfGot0k6+B9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4E18227AA8; Wed, 13 Aug 2025 17:53:52 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:53:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 5/9] blk-mq-dma: move common dma start code to a
 helper
Message-ID: <20250813155352.GC14188@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

