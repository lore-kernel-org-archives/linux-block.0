Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BA2D9EF8;
	Sun, 26 Oct 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482290; cv=none; b=YpvpgqejPZjOP32p/jk2U3NlA0zjrcbwyX6rlee6RhAKTVs3iaVVqgZhmChO00wMEX/lpI3go1ywpnhv0tMn5dSyWXKPyyF+yTieDDO+UQyP4TgyA8qImwOnCYm63VfM4XL78pQSVcUtQSAQjmIvC7OPra6xvJkGcOuSoBauJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482290; c=relaxed/simple;
	bh=qw8/PAvD2816zMcT/W8BWmFh+apV2YWDBWzHohHc9Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESHBfPZF5eXeV97IRXS1qy6v9TMPFiZSWj7g51DLIyIuFmvhBuOIgtAP7w6F5joDdtmRCCDAOlrAyUP8w8WDrOZSIRE2gJJqPkI0xQ1yNFXrvN81TDPrbXOuaUCX3t+kTnjviJ59eiUXiZOXjFsmi1GxkqpswuxiUxRDHXzzmHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQkNk0St; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQkNk0St"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6923C4CEE7;
	Sun, 26 Oct 2025 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761482289;
	bh=qw8/PAvD2816zMcT/W8BWmFh+apV2YWDBWzHohHc9Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQkNk0Sta/L0r0qWJfiwMmnRcxJLqPTWe/65cQ3Pfpc0tJUxZYvyNDt5rE8LNhrwH
	 ggkYucPLXnNtjYQjAlu8w6qWbMQl7YVrXhkxMuFysWP3k3fxIhhYQZmDRktF2ySR9a
	 kc7oNCgEHxB/0wOT1YfEsl+0oH2Pl5pleG/MPqcicK2J94n794MkgfH8zsmvTvzVgM
	 c0ufi4zVyPp/rVKwUwJMljkndLo/iwp3RR3LY4yWDAVU3X151+3YKUTHwJ9YN8H4bN
	 tSbWQ6s5DqB0b0mgg0++GGAVkizOJJL6b+MXVvbr/Gb9OGqPe1cr4pXQIbDoy8ayvy
	 X9sOiqXbIGEdg==
Date: Sun, 26 Oct 2025 14:38:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251026123804.GD12554@unreal>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
 <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
 <20251022061418.GC4317@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022061418.GC4317@lst.de>

On Wed, Oct 22, 2025 at 08:14:18AM +0200, Christoph Hellwig wrote:
> This actually has block and nvme bits, so the subject line should
> say that.
> 
> > +	unsigned int attrs = 0;
> 
> attrs is always zero here, no need to start passing it for the
> map_phys conversion alone.
> 
> > +	unsigned int attrs = 0;
> 
> Same here.

It gave me more clean second patch where I only added new attribute, but
if it doesn't look right to you, let's change.

> 
> > +	unsigned int			attrs;
> 
> And this is also entirely unused as far as I can tell.

Right, it is used in second patch, will fix.

Thanks
