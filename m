Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6AD37B01E
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956955; cv=none; b=I4GNyako4SXRWms6iqm/P6PLN8loc9QqHSt4JW6H8XJns+Ppk0YSPzow20GWg5kMc5wqR+0Ow6JzisWCUHrKTaKT3Dk8pcLULxJ51KdTvc5tcNi0sP+fgpVwzLZxDhnkPlAc6MTV2FJ6ivY9BXs8RQ85C8TlFMQuoHZF2KOOLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956955; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSM/bHcuPiV7vUb+h8KhJT1EThDvP4HUuTV8rVp3WIjrLGsDYJR7hqZslSuMLfP4LvYwibz6LdcObrtHUG9s855oZMq/pHxuO40IsAiJ2HQP3jhl444D8roz1/0SerUF1J5/ClrE1UMAwTbuGhiI/mSE3FHJMD0hFcQOKl0OlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 511A668B05; Thu, 28 May 2026 10:29:10 +0200 (CEST)
Date: Thu, 28 May 2026 10:29:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCHv3 1/2] block: export passthrough stats enabled
Message-ID: <20260528082910.GB6893@lst.de>
References: <20260528010041.1533124-1-kbusch@meta.com> <20260528010041.1533124-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528010041.1533124-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
