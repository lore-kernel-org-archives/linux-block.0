Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D32FD665
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694346; cv=none; b=Al7Lql/6ofyRvKB6a6LpDlAe0Dsn0cxAqir1/Qdyh0pf1ezi9d+B5QaaJi8pc7he76S0JOaCBBGBar+JgYiwyJZTrA9t3TsHp5jULxqmfgxYn50ml8yMw/QF5VRTy0nunAags4SEgWXja284TIv6Snib/ysM3X6Ug11WDDzxwJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694346; c=relaxed/simple;
	bh=AT4d1l7oArwE4J6lNWbsMCP+kahaNdra0i2X50yoYvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgkR0L8bjy+gcyFZnfuC1rHLtsSrnH/NB76ajrfyC8VGP820FMhBgciOAwUZ4YwuRiBmHrG472kJqlsA0l41Tdp5aRu0Mi2Lot8Tz57tnqef2jR5Sd9a3WBReVFlCEUCSSeJ+y1bqBy24KNOfLXjnj8nLX3905r9NRo5H23FmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CAE8768B05; Mon, 25 May 2026 09:32:19 +0200 (CEST)
Date: Mon, 25 May 2026 09:32:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
Message-ID: <20260525073219.GA5305@lst.de>
References: <20260522151537.1509784-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522151537.1509784-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 22, 2026 at 08:15:37AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> So stacking drivers can also report passthrough workloads through
> iostat.

Except that this patch also wires it up in nvme.  So please split
it and write proper commit messages for both parts.

> +static inline bool blk_rq_passthrough_stats(struct request *req)
> +{

And maybe add a kerneldoc comment now that this is public.

