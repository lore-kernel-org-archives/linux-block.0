Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F851FECBA;
	Sun, 27 Sep 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790488690; cv=none; b=r9gyTObM0I/+53U6x+0XSl1pj5EGOpHn2iZpU2Lniti3dkNFwwhWORsH0pqYt0IV804dOKREDmIVuZLVLsjIZZOZBc83dkJk0XMjxrki3GY1vrGGC90Hx0B3TBvIJpKA8VlOmvksYhtgfa2d71gekxveK+WlZNZAved909DO45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790488690; c=relaxed/simple;
	bh=MHXlgFNGXfMlqqNMN7q2hf6sq7E0XqwV6MaVUyCstC8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LPyKDHC/1k3JeUIUIo0rRXc04d66vJOUHoecCUZqW4spGLJEUY+MlijNWLX9djkKNN0dQaJHLYZq/7UJqZeKXLhH2445pTB7UNZqcH+fZf45b8Dqcqy0aMqzio12V0WRzEb3AoY38XFU7GWg93v0ScYOP7lV7l0KFPSu3p04oLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itnOLuHb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itnOLuHb"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 470877A0086;
	Sun, 27 Sep 2026 01:58:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 27 Sep 2026 01:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790488686; x=1790575086; bh=7UIdIYSTXxBqPgE9ZZHZU23trwPAzxhsT3b
	HRZIxTmk=; b=itnOLuHbzr/s5JzQvSMk7eRoRiL64jWHZikDpAjxvgZa+146xBg
	jr2g2FLh8XqLHPHOGVXnpUReuEpRNLV3DSpyWYhOk8lFH2vNU3nSlr1j1RJd7luM
	1hJHj5HxCGjAdRZ1M0lz+u4453NeozSm4TWEVnpqlbII9XByhgP7ImK2I53tmEYV
	mmquiPfZRLb/Fn2VzrRTzhTRm87E4vpJTrgXntj92nU1DVr6dgHMyHMTyRicl0Ww
	jP1SVqp01PjBP5pG2n/KOVpgvUVls2s3NfcUXN0qzm5voNn1ST/estQwJBsE0Sf6
	q2dm+l4ZglEkL0a3j1qyvO1G968T0LZkDsw==
X-ME-Sender: <xms:bbC4anUx1mxU3VRWgpZIxRFz-yHtLJjM0ibwS0oXHxBmVe9E3YAFiw>
    <xme:bbC4arkqNrZjBlwaJTewHeomGetsaAs78ltz9y6KJ-w7iKwDqaV96rXShp2mpqt83
    rTpbua-ZMMNvFuhJIdcCXXQ9BNu8wQDG5GeVaWPz2mma9y1Uolf5yI>
X-ME-Received: <xmr:bbC4alm3wZIQhFdFX5Vn46cuHGiJYdevHLnPGkq-lbqh29mBC19j7651scfD>
X-ME-Proxy-Cause: dmFkZTF5Q9nv+G+ovRAUCUecfX3b7qgsRDfMhnolwI8MngPQv0rDO017DFnkBrKdNUKJMJ
    smZms+qTSdxSnAPRqvBU7xvoxcosAk/cI0Jc+ihskpkIeeeiw7poYXbrQSe7mOALV4ypp7
    vT4bNVAGrdb5YZzSUx1DH/RaJIYUvrCDSZJoDBsQrB01eLj4NGdJMhtM5Mdl8hs3EM6d2u
    pIcCRQM6XyFEsqydw2rB/xlQHWDXupjpovRN8aMJeDHMyY6cJOWaU66HqKbLM1Fo7eDbIK
    J8XkZTjAkiAoTLo4ri7A35/FhktKzSydUeh4VPQQcvv3yd1U/TkOEOMI1KA64mpzkmUlhT
    Q3jx0u9OxiWz1g5GBjzemq0ieAkUJVgibyM260Nr+IxfU9RxNN5Aj6SkyOn9l8s81EQx4T
    c4ApdsqY5TjP0QcsTztAQNkRt+/+DYXS/wjuRKTe1MNgXZYUMxAlKeWGhlDKQxuvkGjIgM
    hfmzALnXZRXk/KAoQuRokm9FQrCn9py9qzlT+tJDIMhuQjFLc+lnq1DpAx+VNCHLbWmS4s
    frGBIlUTyn34utcPlTpFC3vTYJtyfUHP+AUo6sxLtIJaVabVUuhrLUcdzGpc5pbM+R6JW+
    wUT3XrhBUVSzFq5WA5RlYbMnp5E1jkupG8ii4e3kpmSslqDhKNCn+X+khmZQ
X-ME-Proxy: <xmx:bbC4ajbn9O1THAk-vICCEXUVHm0QnI7__lJiyESZv-xAuSb6sYgmDQ>
    <xmx:bbC4avTK5tnKbt7dhBuqXZrbu-xhFcxRJwIi2OykkEdkFeXUF1YVog>
    <xmx:bbC4altXGODSxYlo6ExIRwSJV-9U8pbFyr56hQlRS9Ub3BEEMl6n0Q>
    <xmx:bbC4apEjPTztWw9vE3xDMGCyGhGcmAISeIr1RSgwAYPCuRpU8zwqag>
    <xmx:brC4aiW0dHDOPWeD2wf0JJ6oiCnimU6itQGaB3rUkszLHtTP1ZUCvOY->
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 01:58:03 -0400 (EDT)
Date: Sun, 27 Sep 2026 15:58:05 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Jens Axboe <axboe@kernel.dk>
cc: Laurent Vivier <laurent@vivier.eu>, Stan Johnson <userm57@yahoo.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] swim, swim3: Fix FDEJECT ioctl for exclusive open
In-Reply-To: <418801832b878b9a3383aac4f7b9b9469ae494b0.1790408363.git.fthain@linux-m68k.org>
Message-ID: <e649cd04-ecd6-ed66-8c66-bedf41ea1d76@linux-m68k.org>
References: <cover.1790408363.git.fthain@linux-m68k.org> <418801832b878b9a3383aac4f7b9b9469ae494b0.1790408363.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


Please disregard this patch. When I re-read it, I noticed that the 
ref_count access should really be protected by the mutex. So I will fix 
that and re-submit.

On Sat, 26 Sep 2026, Finn Thain wrote:

> The eject command from the util-linux package does not work with swim3 or
> swim drivers: the drive doesn't eject anything and the command fails.
> Apparently, ioctl(fd, FDEJECT) returns -EBUSY when fd is opened O_EXCL.
> Fix this by checking ref_count for either 1 or -1. Either value means that
> the caller is the sole user of the disk.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  drivers/block/swim.c  | 2 +-
>  drivers/block/swim3.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 601b1ab1d32c..1552fee28eaa 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -696,7 +696,7 @@ static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
>  
>  	switch (cmd) {
>  	case FDEJECT:
> -		if (fs->ref_count != 1)
> +		if (fs->ref_count != -1 && fs->ref_count != 1)
>  			return -EBUSY;
>  		mutex_lock(&swim_mutex);
>  		err = floppy_eject(fs);
> diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
> index d4f0d43e0a72..aa27dfd2820e 100644
> --- a/drivers/block/swim3.c
> +++ b/drivers/block/swim3.c
> @@ -898,7 +898,7 @@ static int floppy_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  
>  	switch (cmd) {
>  	case FDEJECT:
> -		if (fs->ref_count != 1)
> +		if (fs->ref_count != -1 && fs->ref_count != 1)
>  			return -EBUSY;
>  		err = fd_eject(fs);
>  		return err;
> 
