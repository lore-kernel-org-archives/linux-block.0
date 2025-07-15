Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC944C83
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600504; cv=none; b=oz/KxYPzMEsPnMZ8XuOjaeFSbiUACbrvKxi99tWRO5Y3wEzahDW/OMSzCLQRM1z6/ljEP5HHiEwJXBC5Ig4jywtmFKBtKdoYqcz+Ald9RojazhgSlF8/oICGo/GOh20VI9eblJy7NIX+htg+h+8qybCRGSsqrs3q+bjD1E+YHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600504; c=relaxed/simple;
	bh=eKEGk9mBpPPt6UrJSd4a/Yz0NCpPkJ5S8adMZCSdark=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heDOeb7BGXe7V1pjiX0qo9gibvHT7QvPRIACf8L37BQ2hVFVP3IUww7MIyOsvo/HkxJ/Aggqw84xD2s34DZIBwTRZXERkBfK+CPEU9n0uK4BAUcG5zmvHBEJPQw5Nb1NDvWrufusKwFwMfcCRyk0ccuoHzZlIQVlq0x29ZRNgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUKr3R+e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUKr3R+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DE5C4CEE3;
	Tue, 15 Jul 2025 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752600504;
	bh=eKEGk9mBpPPt6UrJSd4a/Yz0NCpPkJ5S8adMZCSdark=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUKr3R+eD6yEFRn703+5VR4m8i78qves3W8LDrh0W6QoBkWd8RhAQ0eStsFM9m0zA
	 2DvvIG4dQZNzNd/xNNGlkeksI7XrHPxZLyvzGa0c0n22PvzxGwowzLBgb/ZGLS2htO
	 ipZgzLhr/9FRh4bU+uPowTj5lE9UGfJDdw4a1Wp+ybbETlaXSLBnME9D/mVkzl72X3
	 VvEZ5AnuWNQ7S7yACnHQTQGWpLcBCQPopJGjGo2LQBef3UWc0d8Ogp9bZwuolBFyMA
	 sJ+e43huN4HoP++/2xB22CrVKyap5qC9evgOlCsp3n8X1DyUzwO0a8uW3zY4Cw96+X
	 dr5guMDV7Bxog==
Date: Tue, 15 Jul 2025 11:28:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Coly Li <colyli@kernel.org>
Cc: hch@lst.de, linux-block@vger.kernel.org
Subject: Re: Improper io_opt setting for md raid5
Message-ID: <aHaPtuTYTGXyd77c@kbusch-mbp>
References: <ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2dzisd@f5ikoyo3sfq5>
 <aHaHLKp7-RrYUeJW@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHaHLKp7-RrYUeJW@kbusch-mbp>

On Tue, Jul 15, 2025 at 10:51:56AM -0600, Keith Busch wrote:
> > Then in drivers/scsi/sd.c, inside sd_revalidate_disk() from the following coce,
> > 3785         /*
> > 3786          * Limit default to SCSI host optimal sector limit if set. There may be
> > 3787          * an impact on performance for when the size of a request exceeds this
> > 3788          * host limit.
> > 3789          */
> > 3790         lim.io_opt = sdp->host->opt_sectors << SECTOR_SHIFT;
> 
> Checking where "opt_sectors" was introduced, 608128d391fa5c9 says it was
> to provide the host optimal sectors, but the io_opt limit is supposed to
> be the device's. Seems to be a mistmatch in usage here, as "opt_sectors"
> should only be the upper limit for "io_opt" rather than the starting
> value.

Oh, 'opt_sectors' does turn into an upper limit if sdkp->opt_xfer_blocks
is valid, so I guess either that value is either unusable or a larger
value than you're expecting.
