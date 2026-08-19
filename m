Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70933CEA8
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148287; cv=none; b=J8U28nJkB6WWXuaMhwvcEqmh8GzAFJIL3GiYoOsNlFwV0H4czmrEIi7HUARmm1CYVxvE7zhlov6paPN2YbQAaitwL01pEGw+FLUW/5Y9Ab6Ue1GrtArzGdOT+OSfqW9Ss2bDjuVBSz1g5uK7BIYqZG9b7OnPo0vyIWTpy89GyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148287; c=relaxed/simple;
	bh=DpXCO9TgpyS7qD/JYFGPi02o7jcRb5ZOtvlzM/uyTjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rorhvm9Ajgi9iPQ+HOQmiNfx0Wfrw7fczw2guVJpWFFAKDYE3TuBNHZy7SBZoSGB6XokYmIzAAAD7PEMJRD6uRlYGVe33GOQsmgUkM8b1WbIt9w3sYArUcpv3+CNNXMh/pv/X4WfcU2XJrILuTY0DFCae47PUhzVe7sBZ9+gy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meobArC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meobArC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB31F000E9;
	Wed, 19 Aug 2026 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787148285;
	bh=Xre6WSIXs36OtLDfnvzOIapJmCc9E93GcdYZ/ey5aXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=meobArC2bCJrxpY9GuhdNhzTvaSbXctJeTmTCTSkaU3U7Y7j8Xe251ySv93cCB3O8
	 NguNAyN1Dn7SCwmclP+cccpNhwHKYOfqBx7EBlL3Al293kJvC7Kg0ylP3Xaoasv1lY
	 QVwSOkfrqaFxE+gSR1DPHqvSNXfy7I9DF3u+xVPYgxgc9nEmmkWMiZM1hPJuU7DT47
	 kSEAptNp9eSps0e/XSYqPhbzfhc4PID9N15u/fkUDwlYsqYm08iXBL13SgqenO5Egf
	 shDwyGLL6RwuWuoB6lc0Hcr3YOSsrk7zEbnslnJXRPONFiFiH/aC23NYtcc+SsYD5a
	 GDg13+ghPr8rQ==
Date: Wed, 19 Aug 2026 08:04:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, Eric Auger <eauger@redhat.com>
Subject: Re: [PATCH] block: save page offset gaps in cloned bio
Message-ID: <aoW3-6U0XkrHudpy@kbusch-mbp>
References: <20260817165908.137682-1-kbusch@meta.com>
 <20260819052306.GA32364@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819052306.GA32364@lst.de>

On Wed, Aug 19, 2026 at 07:23:06AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2026 at 09:59:08AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The cloned bio needs to inherit the accumulated gaps between vectors so
> > that we can know if this bio can subscribe to the iova coalescing
> > optimization.
> 
> Makes sense.
> 
> > The split remainder meanwhile can reset its gaps to 0
> > since it advanced beyond it and will start accounting from there.
> 
> I don't really understand this part, though.  As in I don't even
> understand what you mean here..

The accounting for the vector gaps happens at the same time we consider
a bio for splitting. When we do split, the gap value applies only to the
front bio because that's as far as been processed. The remaining split
bio should reset its gap value to 0, and it will be recalculated when it
continues through the split consideration.
