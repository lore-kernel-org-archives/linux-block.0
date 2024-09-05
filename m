Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6B172BDF;
	Thu,  5 Sep 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576138; cv=none; b=WP8/M1GTg9nwsjOXCxLpGPP+NBAHcmZJ0DgRHr5RA/CXLz4CH3WKUchFNuc7spMSO5KMsiNEM/fQk232IupCRt3O5uCNpT2Y8ICBJA4/5AJ+iimfGcDqmKHklwDUBSEevbpllJMk15j47Jw2088nCiz4BWXWA5Sr/VXjXQjEmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576138; c=relaxed/simple;
	bh=ko5WShKQj27YD3J0AZLold2aoeCBwAumIuRKuxF1D4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGUp+PzDKed0AQkRjs+3SmIOJkdlUaj2jfveAizHeEgNHeYaCjw61vyX0yO4SDBBBHeCR6nAejZPjM9Key+5ozmOnCUgDIP9x00KviGzfT9/pN6zju/cKdXDVlHvhwmMDcnZpqrRGPFI/jtwckLG6tGbtw8gNb9/ZIbekOEuc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=uter.be; dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b=Lv0fHl/a; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uter.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b="Lv0fHl/a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
	s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jM70IaqB9BGHYnrOZoKLUhqPTN3IEuxRbg88d5FNPPY=; b=Lv0fHl/a5D5K+IfJJMIUdUPH1T
	iL2NxSkhrzIq5xWEJC0Npme9vpGttHO9tSrsdvR1MuqdDkssYSVYkZrnNoijFMKtJzKnkmLTHeahM
	pP7Ipf11/8Af7uY1fFTwDRnv/QGrLMXNXSsDSIYRON9CdkbJZxbK8LJlXtfDrTZycgceW17RDp0ug
	JPLutyQyP5w8yCfzErw17la1TXy/FpW+SS0Lut/ziWsloADxCUoCBA+bUNnEMducQNls0LoqYltnp
	aJkhgqFjyVh4yq44EyGw95vy+EYuVfJCZBdCdxlI9/34CFPQaPm1cA73PDyAuWj1lW/7/mkquo1re
	gtUJAWwA==;
Received: from [102.39.140.57] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <w@uter.be>)
	id 1smKXA-00CRS7-0H;
	Fri, 06 Sep 2024 00:00:56 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <w@uter.be>)
	id 1smKX2-000000003EE-0qNM;
	Fri, 06 Sep 2024 00:00:48 +0200
Date: Fri, 6 Sep 2024 00:00:47 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: Eric Blake <eblake@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] nbd: WRITE_ZEROES and a few fixes
Message-ID: <ZtoqD0ObBsZJQEKy@pc220518.home.grep.be>
References: <20240812133032.115134-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812133032.115134-1-w@uter.be>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none

Hi Jens,

Has been a few weeks since I sent this. Friendly ping?

On Mon, Aug 12, 2024 at 03:20:35PM +0200, Wouter Verhelst wrote:
> Implement the WRITE_ZEROES command for the NBD kernel driver. While
> here, add NBD_FLAG_ROTATIONAL to the function that decodes our flags for
> debugfs.
> 
> ---
> v2: Divide UINT_MAX by blksize for the maximum number of sectors
> supported by trim/discard and write_zeroes commands, as NBD uses 32-bit
> values for byte lengths, and otherwise that wouldn't fit.
> v3: Use the SECTOR_SHIFT value as a right-shift operand, rather than the
> blksize value, to get the correct operand.
> v4: Fix commit messages to use correct style. Thanks, Jens.
> ---
>  drivers/block/nbd.c      |   12 +++++++++++-
>  include/uapi/linux/nbd.h |    5 ++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> 

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}

I will have a Tin-Actinium-Potassium mixture, thanks.
