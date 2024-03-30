Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984571C0DEE
	for <linux-block@vger.kernel.org>; Sat, 30 Mar 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711777805; cv=none; b=aTFHp319KQbE5NfOgB9351bDPpmUNQGlNqWts2B4Z9nqOAZtyVRFIjhbPejKm3RtlHlTpoqCm0yzuDrRFDVG3RhaUwy5P2z039XvXqYsxjbmCU1zNmMWJbz8rZW2I+jwpnRacVAxnSWI8v/SUjdm5FxN/+7oItNId4FjETItrjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711777805; c=relaxed/simple;
	bh=TiEFBVC1hsQl4ljLke/vWsIT0yJ/FG9iA/f2kSdAbu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCKRzqpjqSaXDqWqtutJwAi0teB3bqbui8jygcvugV9+WAlkmnLSvAKd5phA5aGSvR7GUOALTKUygHVcOcAIsjkGlWhYlTn8q68169NwzHdJRc25QGLnAyO9V9x9x+Iv0D2sRyT/WUpQsYjRQwQGKF0r+cESCYA49F8qmyMATYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9165568B05; Sat, 30 Mar 2024 06:49:53 +0100 (CET)
Date: Sat, 30 Mar 2024 06:49:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nullblk: Fix cleanup order in null_add_dev() error path
Message-ID: <20240330054953.GA24646@lst.de>
References: <20240330005300.1503252-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330005300.1503252-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Mar 30, 2024 at 09:53:00AM +0900, Damien Le Moal wrote:
> In null_add_dev(), if an error happen after initializing the resources
> for a zoned null block device, we must free these resources before
> exiting the function. To ensure this, move the out_cleanup_zone label
> after out_cleanup_disk as we jump to this latter label if an error
> happens after calling null_init_zoned_dev().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
