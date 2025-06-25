Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98D367
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831633; cv=none; b=cSQGDkxI9juG2WGTfPF5k2D17wI0Gkhp23tx1htCP/uN04HSKukO3kI1vWAdf8pahUcMGY7a9htqZ3yWUYcY88I6f9EAf+7jxLUsOB6q2C7sxYqDaEgQ8h0YqbZnd0AD0M0KQSdSMM0v1+tdnbqO8l1pPiwedQHdMpuImi3zOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831633; c=relaxed/simple;
	bh=3xxGFe43jbz/8eazAD9uDxafkIfe3SwoU7bMbDxPHE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIVRZhKHmxYIteR/L46zOF/HvGnV2MBqsh1w/vgpWd8JX6PDiortEmi2lTdhss4x9XVNXgYoloo356CLbO32vuLM+KdGxueGZc085I8XMN0FAwxY9W1HULDJgyf1fDkb4n6JUDDu2HkJfBpdLE2Hs2eY1sq7cj4Afz4vMfbXgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13747227AAC; Wed, 25 Jun 2025 08:07:02 +0200 (CEST)
Date: Wed, 25 Jun 2025 08:07:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250625060701.GA9391@lst.de>
References: <20250623141259.76767-1-hch@lst.de> <20250623141259.76767-4-hch@lst.de> <aFlyYjALviyhQ-IE@kbusch-mbp> <20250624124625.GA19239@lst.de> <01319f89-2244-476a-be0f-ab0dd74169d3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01319f89-2244-476a-be0f-ab0dd74169d3@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 25, 2025 at 04:28:09AM +0000, Chaitanya Kulkarni wrote:
> Are you planning to send a V3 with a fix sg_threshold parameter ?

I'll send out a new version in a bit.

