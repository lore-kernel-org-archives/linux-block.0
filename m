Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133C20110B
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665042; cv=none; b=fPsMSoMq539O4gpFawQsC7Xrk/Y17cKa2cI6+A7IS86ZvBecmCPwmO8JoJcBRPto/vXP5ICeMDkuwHLNj+mDwmu3ZUe7XmZiEiHCA8SfvNwom026ZwFIHRfB58L5S3FxPz6w+pqKE/hQyDmhnkZ259yxvi4tkx+xJlVTT7Jtesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665042; c=relaxed/simple;
	bh=nfPNVNy8OTMM/JMvHXTnDiCXXt9BL8D31D82EXDAhuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWRW5blqTSrvZ4c9uz3YAXtxcn2lAmYgjfp7ljmVt/t9n5MHu84wcCzu2O9nAXkp8JVaykyEG+IEUPmMvtXAeLip5COXhy4/6ESnZAOTByPfH0URQ+d3DbVswc36CdQLMyIj6uxhxNMRwGJRwB1dUo1iZm5//HaWcG8NBL7OClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18E3468B05; Wed, 16 Jul 2025 13:23:55 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:23:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 16/17] zram: fix synchronous reads
Message-ID: <20250716112354.GA30581@lst.de>
References: <20230411171459.567614-1-hch@lst.de> <20230411171459.567614-17-hch@lst.de> <rjq6lrsq2mflcry4vtks7wth63cgpjzngcbjxy65z7ucupin3q@owvyk5befvpt> <sbqfktl3qwfizfg3b5mkmme26ks5xkazeh7y45yoo4bpbr65kb@ya4eepk7jprz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sbqfktl3qwfizfg3b5mkmme26ks5xkazeh7y45yoo4bpbr65kb@ya4eepk7jprz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 16, 2025 at 06:44:13PM +0900, Sergey Senozhatsky wrote:
> Ah, wait, I think I see it now.
> Synchronous reads seem to be only for partial IO:
> 
> zram_bvec_read()
>   zram_bvec_read_partial()
>     zram_read_page(NULL)
>       read_from_bdev(NULL)
>         read_from_bdev(NULL)
>           if (!parent)
>             read_from_bdev_sync()

Exactly.  (Not that I'm really an expert on this code)
