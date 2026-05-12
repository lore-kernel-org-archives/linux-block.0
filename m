Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032F44BCBE
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566677; cv=none; b=VZMVX4gDLR/TK4aUcA7po4s4cLbLp2IjtOyDM4D9Ii1vI1xeQKZcjmjYeTZvHw9+xBQK1nJH80MGMVlbmfiofrAQ+4MZ2ho7WlArEr9UJaHrpgDcNvOCOoON7SBy8yqKqYO6V/0T1Orw0fu1G/568Au6ANjId4pxumsWoMZOvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566677; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUjzSgJ7L0cnIKRleh7M3EjoIBiEEPaIr7iOFvGQ8Vk4gtCesDGVAYNn7VwOjKmOArgiGjVHwL+CKXohYoUaEgTXseSi5B3/lS5X7p0So5C9t48qBUgEOQtApoZrd6Wom/ni2So4KjPtjc0V1LWOG7ebb0cxQXQosCCr3klm97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 84B4E6732A; Tue, 12 May 2026 08:17:37 +0200 (CEST)
Date: Tue, 12 May 2026 08:17:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Casey Chen <cachen@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [PATCH] block: recompute nr_integrity_segments in
 blk_insert_cloned_request
Message-ID: <20260512061737.GB30204@lst.de>
References: <20260511212230.27511-1-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511212230.27511-1-cachen@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

