Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26333610C;
	Sat,  8 Jun 2024 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717824036; cv=none; b=a3yrfmU0z7g0fx8/+hGqET3iKLP3NZ05SRVpZ7p9hJe23VssggcFlJtHGQUAWLHyuAzw0kl0pX/jeWlL2uP0LZaKpmbczM4QtJ89LgpDriBE36vXH+3igdwvxn220cgtFNnwLJh+nBnXEYOP2R0s0/zHGRBQgwljhnuY/2HlYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717824036; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbSkPs69UZM0LE0w2ZQ0BItPtnZvHnBQ4l4+JLzy3qV4rc3MU0ycl6uTo3L7fs/xQEwAlFgNno2dmurGPWMJE+hvOfOrvBsmze8QgAuH544ly+K4bNqYdFsUFGZyC42Lz6QpTZwNSQw3CRu7WydgPEJqNpFr00EUnSpF53wbUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BDB568AFE; Sat,  8 Jun 2024 07:20:31 +0200 (CEST)
Date: Sat, 8 Jun 2024 07:20:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240608052031.GA24100@lst.de>
References: <20240607190607.17705-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607190607.17705-1-gulam.mohamed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
