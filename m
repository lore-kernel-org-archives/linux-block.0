Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A01E8852
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297167; cv=none; b=gLQqQAUawavtOF80kWFSRSI58jHnnmGviA2Mka6ri8M7CTj0JNjHH2VKDNKckLZNTLZkW+pNBDZ+VwQgUFGkc3SouEBc7VqtJuiw56+nsHrLH+fd7Bxw1AcilF8zqDgkbFGc8nKfr2U4ZwFJOTOBJMrdYNthqXUyMLOrAlo0IVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297167; c=relaxed/simple;
	bh=LayOEp7PIaxEFenKikZcJGmKC/G1LdQ9CnPPng8AOt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXvDdhoo01KnT1yIgZ1+8X2WKMHsE4f4hirUb1MYUIM6uFJmnlEJeJ13Z6R50PRLO1w3wN3DXu9B3Y1f4zDBapX4kivW+DiNJ+ZumlkRMrE00qI/mbm1ilnntExLMf+Gkl93rt92W0imIWPjcGFu++NLsvzw44gEPPBjyECgK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3F13227AAE; Wed, 30 Oct 2024 15:06:01 +0100 (CET)
Date: Wed, 30 Oct 2024 15:06:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: Use bdev limit helpers for configuring discard
Message-ID: <20241030140601.GA29107@lst.de>
References: <20241030111900.3981223-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030111900.3981223-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 11:19:00AM +0000, John Garry wrote:
> +		granularity = bdev_discard_granularity(bdev) ?:
> +			bdev_physical_block_size(bdev);

The discard granularity is always set to at least the physical block
size, so this can be simplified to:

		granularity = bdev_discard_granularity(bdev);

