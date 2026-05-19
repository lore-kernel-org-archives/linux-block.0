Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2193EFFDB;
	Tue, 19 May 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217859; cv=none; b=PBgidtvmHDQ2tAR6MWU3bWSl3WUCMlXL+rRqS7RwI4VBcEFcyBxsK5chRoS61gzPOFfqGvNpZszFoiDdpkH7sYkdH60Dz1P8KDwAiM3/6ON2FKJzVXcCXyyuD7wCwuVzxAzvrEb8B3Jcc3xfWvQIlJMH0r+4jGfYOWEg4K81Dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217859; c=relaxed/simple;
	bh=lOS4FERTMq4vPG4lfTuFavSqzq0sytE+5bCfPQw4rKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWHFxgtdBCDc5G+7YKZzMzWAfM1pIjvixhReH48+rjhyoSVzOUJ00AjMx800QiOwcg9UBnU3S8uJEXJzj6JxVY6rGGDpGnT6V2tp5qHMoesO9lWO4I2mbbGxD1E4BMTnPuqW0dGdmXjE5sHmVCNOFakV0PRGexdWFiFiwzjB5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOYL5y6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOYL5y6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CE91F000E9;
	Tue, 19 May 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217858;
	bh=JMCmbCNvC+HxXHksRWStC4bWizUWQNjAyE1M9dKurnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOYL5y6dMjqhCVTAWrzmYzrPfz71i1htMxoZ3O7JB/WuzmFa/T/jNfYwtWzIDl3Gq
	 hBzVN69nn/jE2ik+W7jOtsJzkwPyeIe09HnxZ+JiGJXb1HU85akKOOPwpy0w1gLOmM
	 SpQQRkHsHMcP19ixT5yJGODy9ByFs44ruPdoEXi0PSPQ3MrVoya3jFIawIGKJ/J1w+
	 2SNkqO/c3/Vx4DL9Gwl89uB+R1uR9/lbJ2jdc1FcB4lCtD8XXowFhKAP7EDfBSu/eM
	 Un8ukWILQ5iEO36qIjpFMXS1rYY0t8WAQ/eTNvhPeVgejQj2r6BoIujvrfjzdBlpXW
	 dmxTjtX/5Jh8w==
Date: Tue, 19 May 2026 13:10:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <agy1wPm5QEqVf3RV@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <agtnJb5a5uIqH-65@kbusch-mbp>
 <20260519065303.GA7918@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519065303.GA7918@lst.de>

On Tue, May 19, 2026 at 08:53:03AM +0200, hch@lst.de wrote:
> On Mon, May 18, 2026 at 01:23:17PM -0600, Keith Busch wrote:
> > 
> > Any reason nvme multipath can't call submit_bio_noacct_nocheck()
> > directly instead? If it's safe to skip the eod check here, then it
> > looks safe to skip everything else too.
> 
> We really shouldn't expose that, and it doesn't quite to the
> right checks here.
> 
> But I think the proper fix is to stop using bio_set_dev entirely.
> We do not want to associate the bio with a new blkg as those are
> basically not going to exist for the underlying devices.  I'm also
> not sure we want to allow another round of BPF throttling either.

Simply dropping the bio_set_dev usage doesn't really fix the problem
here. Sure, bio_set_dev clears the BIO_REMAPPED flag, but it's not
guaranteed that flag was set in the first place.

I have an alternate proposal that's part of a larger series. This can
notify the driver of an early error so it can decide how to deal with
the bio:

  https://lore.kernel.org/linux-block/20260519172326.3462354-6-kbusch@meta.com/
