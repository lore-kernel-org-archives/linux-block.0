Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051BEEDE
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901204; cv=none; b=cGUSSMbptDJB5naiNH4AHXlAwi4Ey5m69Y8xYeB3AziDxmwCS+SxafeheEGXXxzxKk0VdjfO4m8xj0rvdCOfRpO+NmtLGF95o9QyCkSixtmhyUNc361du7vf8xFb9hj+DorQ2O13ZdGkvS7zmiOoc6ecQvqiCZfNji1JIDRs5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901204; c=relaxed/simple;
	bh=mp5jA2iGXeOxyKviqtC+9eLHu4JEDEMD2R4myXHhrwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9OYLN6K6vtnqBAZbdDiLd+yOWnp9om2DV6EyN68ltPPre/BJ0D7XZ085zc+WnxxJvDIMdkqSVZ6foA6NqYt6DIIAIpX04QZA181i9kqYZyNTyvxhD/xxBP1KPmEefz2X5dK6y+Dz649FY0Hehe3sj5QF/99BbG+2ro+A36qcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+b1QmqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+b1QmqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1BDC4CEE3;
	Mon,  7 Jul 2025 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751901203;
	bh=mp5jA2iGXeOxyKviqtC+9eLHu4JEDEMD2R4myXHhrwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+b1QmqVimJOFoZZvhcYArSv3nlj5kxA68W9/fsXU6fS592pTkTnmkoA3iXe5BzWZ
	 QSaGqVs7jiQwNbp1fWb+Q02MaBkiGosgZphh+ds8f6K4fzvZWKP7FwvwDAXM55cbES
	 eFEJ4J26Tma/3D1CWRGgLjR9E6WqAJYb8rQd5F5f4gqAIckQoIqkhNRUs1B8kedEMv
	 zzpSEPlKKMzbZtRaJrGqSM5tG4k7ETDvEQhWi8CVInISO3L1mO3Jl+steqKBW8uuUs
	 /azbyYPIMViesARI26/azAq3uNGVMLoo8ZvV0HyGhfiZYuPLGrU0+RA5dbcJzCb6VI
	 sMC++qo5tvYdQ==
Date: Mon, 7 Jul 2025 09:13:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, ben.copeland@linaro.org,
	leon@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <aGvkEcvMykZkx3MB@kbusch-mbp>
References: <20250707125223.3022531-1-hch@lst.de>
 <aGvZ5Xk5L66sNWJL@kbusch-mbp>
 <20250707150116.GA1939@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707150116.GA1939@lst.de>

On Mon, Jul 07, 2025 at 05:01:16PM +0200, Christoph Hellwig wrote:
> This looks a lot less complex than I feared.  I still don't think having
> to allocate DMA memory for storing the ranges is all that great, mostly
> because this is exactly the path we're going to hit for non-coherent
> attachment where the DMA coherent memory will have a performance impact
> because it is marked uncachable.

Okay. I was hoping to avoid bringing back a mempool, but yes, I can see
how abusing the dma pool allocation to hold the driver's sgl (that won't
be DMA'd) may be harmful on non-coherent machines. Let's go with your
patch now; we can always continue improving on this if needed later.
