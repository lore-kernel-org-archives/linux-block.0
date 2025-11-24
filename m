Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19F313277
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003547; cv=none; b=ZRGRyhfrJBaHhoMo+JDbLcG/V0pDyJkpI+T9K8wPq5/8JX/ECx4+8DmFzdbVuRpv4C8BkRzJulw3hF3JuKsJEfZU9+ssM4Dja5mWv2ixYTgx8c1KfJCxd/+WpwkNEjCrnZp99AJrxu8doTe9y24DS6uOQxLiey8yQPWGIpRJtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003547; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzSuakx3Qjth12/r2LwF07j5wRpYjJOjOicu5tCliVeFq9FuBUxYIArUER+BMg/rXg3CpyVXBVWk+4Tl+R3TcL04z0GLewxWudzWi5b+XamFSrWJNqBNl070ajWpYEb8o0HoBZixDV6oGCsY5kbL9+jYm+XRUJOCAkiJ+b39k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A19868B05; Mon, 24 Nov 2025 17:59:00 +0100 (CET)
Date: Mon, 24 Nov 2025 17:58:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251124165859.GA28866@lst.de>
References: <20251124161707.3491456-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124161707.3491456-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

