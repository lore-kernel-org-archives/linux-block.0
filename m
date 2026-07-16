Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023024B28;
	Thu, 16 Jul 2026 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204473; cv=none; b=JxZtQp6HylAWUJ1ksZZfpPhg659ynFRce5ivY34n9KCC1Rkn9zlsGAUdBqgnTFrdyztXkSzH93adyqIBUbRK+15IB87fegVJ3nWMeTtbCUG+NugBBRWKmAFgStBd7pn1pVgMv3akDp9BOwyWy9bS2EZXvodmh/xdl9tE15q9We4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204473; c=relaxed/simple;
	bh=puEx/fKfcFdO9RF6Dqzr1XhCr9Q1wRIQEqcwfOEIArk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chmtes9cZ6AXTbSwWMzpKg55XayXElq0LBo1HKYBBzvFL4Z5oMufhXUSKVSosXf8v2jEX3wClcIlEcdpCxDpRtmzKypO3pZGhjZL4K3ezuAqVcJ5+E6u5GkK8Coe4OLXta5QuKexOLWJVzXG9G4MbRKTduF8jLD06o+YA7h3pJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D99C68AFE; Thu, 16 Jul 2026 14:21:08 +0200 (CEST)
Date: Thu, 16 Jul 2026 14:21:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise
 BLK_EXPECTED_REF_TAG_CAPABLE
Message-ID: <20260716122108.GA30437@lst.de>
References: <20260627061933.2187447-1-csander@purestorage.com> <20260627061933.2187447-3-csander@purestorage.com> <20260714135310.GB714@lst.de> <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com> <aleu49e4GxG-Z7B6@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aleu49e4GxG-Z7B6@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 15, 2026 at 10:01:39AM -0600, Keith Busch wrote:
> > I mentioned this in the cover letter (and that's why I marked these
> > patches "RFC"). Unless you have a clever idea, it does seem like an
> > insurmountable obstacle here.
> 
> We had a similar problem when we enabled PI at the end of the metadata
> rather than just at the beginning. This left machines unbootable after
> upgrading the kernel, so we have a module parameter to turn off support
> for the feature. It's an unpleasant solution as there's no upgrade path
> to ever turn on the feature without a format first.

We could opt into not faking up type 1 PI with a REQ_ or BIP_ flag.
But we'd really need a user that actually wants it first.
