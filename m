Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FC3AC1C
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492188; cv=none; b=GBmW0JSRu21CLIpOf4W9SckXkozWbYAJvLblBqXD/4EH7ba4l3F/tnY07sUn7rKUHA7007iDTa+5MDKD8do0I0+6OV7O2pJmcJnPi+A0T2iMH810XbEEOKUZ/ODhr7XxVX60rVuTvAbW3cQpZ3MdXthHO8iI3JkO4DpWwzostUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492188; c=relaxed/simple;
	bh=0DCoDTj5yN/pX53IMgkyi2j9h2NmphPMoE9XsfbDMVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7bbhY8IOtDxU91S0Q7QSaG0Vr6yNvIrAEn6GfCrcH+7CTsXkp/poAnbRwFG25Vo40AInY+wNfCOoaaN5k64FNHFdZ82eJpg66YKCORk2dmcJJwbavOEl3r8wviRChmPfY7QzyXEvSna/Q/BALE2U2PK2pkeK5wU6eKPVEfwvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F14C8227A8E; Wed,  6 Aug 2025 16:56:21 +0200 (CEST)
Date: Wed, 6 Aug 2025 16:56:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250806145621.GC20102@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805195608.2379107-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> index 0a29b20939d17..d0ed28d40fe02 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -264,6 +264,8 @@ struct bio {
>  
>  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
>  
> +	unsigned int		page_gaps;	/* a mask of all the vector gaps */

Bloating the bio for the gaps, especially as the bio is otherwise not
built to hardware limits at all seems like an odd tradeoff.

