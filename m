Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D9F9C0
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131062; cv=none; b=ZVhhul9xcjgOAUUlhFSpSJGWyWiUraHji4gmPKX96V8E9Q7At+oZxXQjccsWY6cWIGySUrw1tvE7JKPGycyhXjylSNum05VdtpT32YtsfGitf/7dnDuDLBS10n+IY+FIg9a4TKadP/T5uLDls/BYHiKB9OicPEuofJVoe4ydR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131062; c=relaxed/simple;
	bh=Z7wWWcnxT2uOxXD0U6r8x+76FAleykG61JmLTKTwi3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES+lOXDUyQ+yV1wa5YjwOawK6kDx7/KXwB9vMIVIL1+ttdmdwh4NOMIPawGMX0RdeHVKwVWawVtxrKtLgqNkSuN3+PEmC+54NHL1/5+S41a6f5A/s2Exs2EhWzJs15NzBusJyrmvYqEVVPHCAVbYYQKk5uGVORGUx51Q/Awdhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk1opP7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk1opP7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140DAC4CEF4;
	Mon, 25 Aug 2025 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756131061;
	bh=Z7wWWcnxT2uOxXD0U6r8x+76FAleykG61JmLTKTwi3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hk1opP7qyW9Cc6Sl2HnpulmnvVdwaL9tQkwISY6Jv9tUBFXtZKBJ+VMywGbvcE0Rl
	 Hvj3tpwriGnzl08hw3l8RlDcTA4ILcaJ8sivFKCDAjvqDvyZD0UBtmxEhu3dYm7b/m
	 KpoPtCWx7RSyaF+paFYRXx3mY48KXtggRI+6NhtPEo33WDj8ExEy2ccn6A/oM8X4T3
	 SSwAWYmHagXmm08fm0bBOCh6kMRjNFZdMYqZStQg3PPOvQvXyORrjb0lpFHr0pm14G
	 suUgh+MMb4G2ipsh5QH0i4gzHQJu2jux7nxxkZiXe++Uyoxfg9z2HN99YTZZkb4TF6
	 n5hpvG8Sv15Qg==
Date: Mon, 25 Aug 2025 08:10:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aKxu83upEBhf5gT7@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxpSorluMXgOFEI@infradead.org>

On Mon, Aug 25, 2025 at 06:46:50AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 21, 2025 at 01:44:19PM -0700, Keith Busch wrote:
> 
> Also use the chance to document why all this is PAGE_SIZE based and
> not based on either the iommu granule size or the virt boundary.

This is a good opportunity to double check my assumptions:

PAGE_SIZEs, iommu granules, and virt boundaries are all power-of-two
values, and PAGE_SIZE is always the largest (or tied for largest) of
these.

If that's accurate, storing the lowest page offset is sufficient to
cover all the boundary masks.

If that's not accurate, then this kind of falls apart. I didn't find
anything enforcing this assumption, but I can't imagine it would make
sense for a device to require the virtual boundary be larger than the
page size. It'd be difficult to do IO to that. I also know the iommu
granule may be differant than PAGE_SIZE too, but it's always the smaller
of the two if they are not the same.
