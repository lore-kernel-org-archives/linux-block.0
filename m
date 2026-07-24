Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F0292B4B
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897157; cv=none; b=kdCgQR3cwKh7RWLWyNuvQgxn5g4GWRE2qix1XSlQg2VUu8I5qDRmeEqLivsZ0VawpLqvTcKXurEj2f61XzVfYMANos3aiV3vEvscu1LqD/j0uYEkrWlDDHECe+y8zQFbYx0a8vQwN1dhi4ak5bSWUeRocoGpT02US+V6h7DDuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897157; c=relaxed/simple;
	bh=dZ+4MBE//ChtnA6tIRG9AnZqzA6Zx9zmGDYDyiAzPJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HylELvRQ1420KPypE4/+wC7+vHeUCChs3KXxNguym1MHzxHHBz1qH7In08hQPXCAEmJ4+Qhgt0iX2QIv6dbNqfysy2c54wOzilHsICCb4p9nmzWxX74M1wOUoOMIfcHu3CwHpmgT9amZEdmsgQvicGZC2yYZGDtR4QnVTtVcbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW1LGXub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW1LGXub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40BD1F000E9;
	Fri, 24 Jul 2026 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784897156;
	bh=NdIIWNJ3ERJGsJjiN9AEhl+dFqQlbhp2u6CVyCyiXJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aW1LGXubKWmZ7lNn4RAQkojiORE442GPtMZOnI+ff9putpeT4OLQArHbUv+Z3m2t/
	 sTZe3vn3/ZJLnMLrzGTfsCaZfmH7m+ABSiKImPhyYFoEW+rZpoI7Bcy+UM98M/p167
	 HMnlvyXKaj6cAfPHq3eNsfsBUVJR3tl0A0hNuZbcB+lchr4vUg70/dBf2g981DWeg3
	 WctRX3oUyoARZeD8xVcg/cm8pEJpc2PLl6noZZAgK4odMxP5ICpnsnYLIyNNecu4AC
	 c4+zx3tP4oLcG/Y9PDFLM7mYuupMcuUrNh+rlcT3XzXgR3Fjgb7jdotTLpVBIFF4wF
	 +1b29CjCDk+7Q==
Date: Fri, 24 Jul 2026 06:45:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Message-ID: <amNegPEvRX99EvPN@kbusch-mbp>
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>

On Fri, Jul 24, 2026 at 08:09:51AM +0100, John Garry wrote:
> On 24/07/2026 06:01, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2026 at 11: 45: 53AM +0000, John Garry wrote: > Setting as an
> > RFC as adding this extra bio field is not acceptable, but I > can't see how to
> > lookup the original partition. In general it is not, but you should mark this a
> > 
> > 
> > On Tue, Jul 21, 2026 at 11:45:53AM +0000, John Garry wrote:
> > > Setting as an RFC as adding this extra bio field is not acceptable, but I
> > > can't see how to lookup the original partition.
> > 
> > In general it is not, but you should mark this a block patch so that
> > Jens can better cream at you :)
> > 
> > I'm also not sure that supporting per-partition diskstats on a multipath
> > device makes too much sense, but then again there's a lot of setups
> > that are crazy and actually used..
> > 
> 
> It just seems to me that we should have same behaviour as if it were not
> multipath.
> 
> So we can't use bi_private as that can be set by original bio submitter. I
> was thinking that this bdev pointer could be temp stashed in bi_next (as it
> should be originally NULL), but that it dodgy and maybe won't even work.

Failover is corner case to consider here. We always reset the bio bdev
to the part0, so your stats will be incorrect when that happens. I think
you can quickly fix that in your proposal with the "bi_orig", though.

Can we just thread through partitions for the bio's block_device instead
of assuming part0? I know the hidden path devices skip partition
scanning, but maybe if we let it happen, then those will have the same
partition setup as the head gendisk. Then we can go right to the
disk->part_tbl for what we provide to bio_set_dev() for both submission
and failover, and everything should work out from there.
