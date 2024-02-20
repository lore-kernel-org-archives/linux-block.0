Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16E762D7
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444423; cv=none; b=cbPg7mmAkAq3AFDB5gnigcS6mAZU2svIAFxN4PdEIDjvjMZBrJcU+YIHTNdYADwO1ljiOMHFtUv8CMoi2Td2LrzUBRk9avekTthu0ANUeH28RhFmQ92NGh1yGWSXllo9fdNYyeU0gTNJybED6g6+LrCpjMp243NtEVloXd6RQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444423; c=relaxed/simple;
	bh=eGoXPfOvsKzQmL3IPx7I3jFpwjJ+obCxod9OR7vZMzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNlBpqxVxtyT2iNZkInHzkbD0E2MKhnJ2BnF9X44VWgooQaIdXX0cMJtLfLJyom3QMq7wDi1HOyiEqm5gbtPO6cN2JV7BwYRokRTzU8tL7S0W1DDTyhY5Kh8Wjis7cJa98yvzQhylETaeI/appWks290pVEoXL5ES7xe3KZcBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B777D68D07; Tue, 20 Feb 2024 16:53:36 +0100 (CET)
Date: Tue, 20 Feb 2024 16:53:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] xen-blkfront: atomically update queue limits
Message-ID: <20240220155336.GB17393@lst.de>
References: <20240220084935.3282351-1-hch@lst.de> <20240220084935.3282351-5-hch@lst.de> <ZdScey8AJvBykWa8@macbook>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdScey8AJvBykWa8@macbook>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 20, 2024 at 01:35:07PM +0100, Roger Pau Monné wrote:
> On Tue, Feb 20, 2024 at 09:49:35AM +0100, Christoph Hellwig wrote:
> > Pass the initial queue limits to blk_mq_alloc_disk and use the
> > blkif_set_queue_limits API to update the limits on reconnect.
> 
> Allocating queue_limits on the stack might be a bit risky, as I fear
> this struct is likely to grow?

It might grow a little bit, but it's not actually that large, epecially
in a simple probe context that isn't in memory reclaim or similar.

> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Just one addition while you are already modifying a line.
> 
> > ---
> >  drivers/block/xen-blkfront.c | 41 ++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > index 7664638a0abbfa..b77707ca2c5aa6 100644
> > --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -941,37 +941,35 @@ static const struct blk_mq_ops blkfront_mq_ops = {
> >  	.complete = blkif_complete_rq,
> >  };
> >  
> > -static void blkif_set_queue_limits(struct blkfront_info *info)
> > +static void blkif_set_queue_limits(struct blkfront_info *info,
> 
> While there, could you also constify info?

Sure.
