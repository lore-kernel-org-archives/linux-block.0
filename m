Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7D299A84
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447784; cv=none; b=NNPcIDxQVN0zInMK7GM1j6el94akEkovPVgjeEn4uUUbW0V3DzeNVmFdgAt1RakE+iUe4eZWOUQI56QyRUT/MTrhdV1q0LOTASdV+PUMjs4tQtU6oF5qmQcs0+bF7wwyEkxEYZHsntbJgaHRnefSG2DVzI3eN8wL83BzgiaX3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447784; c=relaxed/simple;
	bh=+yw9XkR4YUCzapygPDUsasmYF+ib4giBFgY3261HR8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS322PY+KOUHMoSOI0Jf4SfSafkxjg2tgC2bPy0DSrZqhGUBT0UYoHYL6VoO9aBewBW/tsVK56SoJJv7ZVhY+Gc5OxXYn6I1gOkssrdyjx+i2dVeU3o467hsSFn6XFvMOjtGdCNjFF73tpAzwNM0b8kCB2dMUOL/GRqZshah8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66F5568B05; Fri, 26 Jun 2026 06:22:52 +0200 (CEST)
Date: Fri, 26 Jun 2026 06:22:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, Vitaly Vul <vitaly.vul@partner.samsung.com>
Subject: Re: [PATCH] mempool: optimize mempool resizing
Message-ID: <20260626042252.GA7997@lst.de>
References: <20260625194915.387663-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625194915.387663-1-vitaly.wool@konsulko.se>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 25, 2026 at 09:49:15PM +0200, Vitaly Wool wrote:
> From: Vitaly Vul <vitaly.vul@partner.samsung.com>
> 
> Resizing mempool to a bigger size currently requires a new allocation and a
> data copy to a new larger elements array which doesn't go well with the
> idea of having a fast and deadlock free memory allocations during exreme VM
> load.

mempool_resize already is a very rare operations, and none of the
existing callers knowns the upper bound.  

So what is the use case of doing this under predictable I/O load
where we can't stay at the old pool size?

And if you care about it, why don't you size the mempool to the max
from the start?
