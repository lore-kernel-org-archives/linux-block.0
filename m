Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F602E40E;
	Wed, 19 Nov 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547054; cv=none; b=r4CCWt9O5uyfLD9QgH0tgNwbm4lfuARU7moRGZU3MiSoJ1dgZ5w1dqNqhExV/KLGbMFEX8etWfknzPoe1LzhL11OCzmP3LenMeov26C1C0Cw1twhmv4KEeXAVqYw0bB5xlFdLpO2Sxw9k3Ub7lN2oAcPmdwOZ0I5xtomcG6bZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547054; c=relaxed/simple;
	bh=0IPxt6750T/8s9Y9QZ54pEvtJ6IvDdCX74hyulsFxnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u131f+c6L4gsQ1b7Uv5qD2b3Nw9XWGjVwJwms9WJHI9CFM/q1Z29ZNV2Y3KXWVl+84JBMlQF1/Z7tBLBxRUeUFN37MXqcZDwXrgxrYUmZGUFbqu1bzdxsrIdTqPD7Ba+hpsL1xpz2FYIVP4tvZUxniis8UKNeV5X6EUT89evSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C69168B05; Wed, 19 Nov 2025 11:10:48 +0100 (CET)
Date: Wed, 19 Nov 2025 11:10:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to
 handle larger sizes
Message-ID: <20251119101048.GA26266@lst.de>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com> <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com> <20251118050311.GA21569@lst.de> <20251119095516.GA13783@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119095516.GA13783@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 11:55:16AM +0200, Leon Romanovsky wrote:
> So what is the resolution? Should I drop this patch or not?

I think it should be dropped.  I don't think having to use one 96-bit
structure per 4GB worth of memory should be a deal breaker.


