Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED71798E
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170368; cv=none; b=fJ03S3RZCxSzGTH7zp0rANQ9g/Bp6EukAMjY60HSQVjpMtTQCmLzrFzssc8UGrfKlA7YP4bFXm1cUjo3iQ6tNONqMMaONJGHZQN2B+jhpmV5RtrXN6mvF12T3DsNp6sUm/vfThpkLWUy/uORv/JXX+hV9bo6ivOzQaF/vX1wM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170368; c=relaxed/simple;
	bh=JHajpceFzHoTbGSNu9ZMffB0spVARgiyUbz9orV/PGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hohCBOaRpgNJUV2u7/wt1Sdo0WYrGr06ycXtzWoP0LJQ73RsFToBF/sm52SXHckAzhdqwwdrwU0jrEb2xGZj1dxQFkxoq88uZksoXbB0wZTCxsWc64+R5Kl3gtceaSvfe3Ii+oTjiGQSFS5c0gbQ5xkp9zn3IGlj9+dihzQNi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FB1D67373; Thu, 25 Jan 2024 09:12:42 +0100 (CET)
Date: Thu, 25 Jan 2024 09:12:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Message-ID: <20240125081242.GB21006@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-6-hch@lst.de> <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com> <20240122183857.GA7029@lst.de> <ZbEwUDrmTlWTfK75@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbEwUDrmTlWTfK75@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 08:44:16AM -0700, Keith Busch wrote:
> > > > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > > > +			     q->limits.max_user_discard_sectors);
> > > 
> > > Shouldn't writing 0 disable discards?
> > 
> > I mirror the max_user_sectors behavior here, where 0 disables the
> > user limiting.  But yes, that would be a behavior change.
> 
> But a user should be able to disable discards, right? Unless you really
> want to match max_user_sectors, I think you could default the user
> setting here to UINT_MAX and use "min" instead of "min_not_zero".

Not a fan of having different semantics for the different attributes,
but given that we've had this or 9 years we better stick to it, so
I'll change it.
