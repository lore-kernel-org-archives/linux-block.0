Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DAB2BDC20
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741775; cv=none; b=YtcYIg26bvOZsCKDB3jgGx0qsFXnTM/e4905JYfpst7EsJju+8jLdze0AEmiiU7FE+NiduGarw83i3paCmLlnFSUN1e1vko7RMOSZj0kzsjzn8SpL2972WO+b8ayuP+CWq5jkmBzgWd2X5exXkMVThB45PxLpQWdOQJoJ5zMINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741775; c=relaxed/simple;
	bh=+sDY/w3zXmY9jH8pUktfX6KG3yPMIOa5BSFS2DKeJ60=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=iOo/+QbjeXNFb8Dmn8sy70MRr4h942+9YORfU6Exv/oj6DGmyZP92/EfkqzZyLHYLeypdyUCDbx4xwjI341kB/U5dCFvcCjkKidAgK7CoIGnyqXYFo2dF7CnYdeJkJqUkf75tAeZx65HlWPyXp7fYmq1ipj5EAAWWBWwuH5xamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=lM0aviSP; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="lM0aviSP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=c+K6uqnEnh6Br+k901/fecPb5ywoda8Yr23qdCBijhI=; b=lM0aviSPeCdRLUr+6RLCHjKdSL
	swQfaURCp/51nds1zd4o8MPNa1odfL+TrqOBqepA7lUEK6XxZxZ/M9sHqnDvhLBQH9yJe3Av8LZkt
	vw31/mRVfmYjR5xGnOyinQX2QXhq7D4ASdl3uPALNLNvmTl6OTftjPkHi5dgGigeLFGL0lep0TGY0
	sr32EPDixO7oIlMLxqqZ6qv3sIbg3QXcor0tXHZ0pM1wZOBXAbMGmi39N+ladhKP6pu3Lv3BZrM8E
	Rz8pd1u6drzyOtnA4YAzZvULmBWDrei4pKcLdh9rYJ9tr6uijLT/oTC714OQ8T6KTuR193ZXv12Ab
	w/aZXrqg==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uPjlN-008S23-1v;
	Thu, 12 Jun 2025 09:22:44 -0600
Message-ID: <022b3644-549e-450f-9d36-5c516765ebf0@deltatee.com>
Date: Thu, 12 Jun 2025 09:22:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: hch@lst.de, axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com, joshi.k@samsung.com, leon@kernel.org, nj.shetty@samsung.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-06-09 23:06, Christoph Hellwig wrote:
> To get out of the DMA mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.
> 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
