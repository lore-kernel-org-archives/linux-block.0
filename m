Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BAE4FC8FE
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458159; cv=none; b=Ld/VRiBeLwLNwdYKos9w5xDNetdCiH9ijGPyy/N1p3dOrCqcQMrapbOXI1dZcc779+ADiwbJK7IKPAPqWufjfW5cTuEdSqIYhTEFkljUZ2+FtNjwtI2jDHrkyPoG169gRWQqD/DGxxSnFazdZH2B44aSlwI/zrG3xH/bHSsmzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458159; c=relaxed/simple;
	bh=+/vdALL36/krbJ/Fz8sB30NP9fON5U+Ym+U7XcCHOvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVf4xXl39wJcDAqciEfjtVRulqGWUH+04GMQeCkgv4b+5cTCEUhgSfkTa5PNo39jxXmQVzrrpNxXwybLWsb+fhtlSTFs1JrW0FV/0zSQT6/2pDA4UR5BIQJi10OT8UydO8UD8BXiEsxpCW92C8+CDXnsmeIUGPZj5dsOEzu0cdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/EBwKLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/EBwKLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C121F00A3E;
	Thu,  3 Sep 2026 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788458156;
	bh=PoFoOqmpiDtBiRtEsJMYrTCrakZ9n9DUzB4p2nxzGug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y/EBwKLFaKEshxxL6s3+v1AUdkrR9XBFsGuzHsHCgNdWm9/LiSfQJExZUTwod6b10
	 dezH7X3RpQ872Y/WuwavLwXSVDDLcR+gBPHZj7ngO5NPr/wwy/PAEeCaOxlWTWUXFd
	 Gh9EgJvOKQmK/XOecZeIHU9wLElDGJm86GM49L8d1uU50EGR9cNK9taGPBCN5X0ptc
	 RJoQr063L/HR4waSjXCO+Qg5FSkbAgTewhuNIfQ1Z9tUwMiNB2cJfZVX6Y89rx+/vp
	 wzM9m3m1K9OxVN+PO8v+6LcdwZ44omChOJDCrwdYQPyCXTueuSL7X/62bD4ieHI80B
	 24Hce3LP/X14g==
Date: Thu, 3 Sep 2026 11:55:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maks <mi9992828@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: block: zero logical block size leads to infinite loop in
 set_init_blocksize()
Message-ID: <apm0q8sNDooT53jU@kbusch-mbp>
References: <20260903174124.51009-1-mi9992828@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903174124.51009-1-mi9992828@gmail.com>

On Thu, Sep 03, 2026 at 08:41:24PM +0300, Maks wrote:
> Hi,
> 
> I hit a soft lockup in set_init_blocksize() with a block device whose
> logical_block_size was zero.
> 
> I understand that logical_block_size == 0 violates the block layer
> contract and that the driver which allowed this value needs to be fixed.
> 
> However, the generic block code currently turns this invariant violation
> into a non-terminating loop:
> 
> while (bsize < PAGE_SIZE) {
>     if (size & bsize)
>         break;
>     bsize <<= 1;
> }
> 
> With bsize == 0, the value never changes.

How did you manage to get a block_device created, but bypassed the check
and override for a zero logical block size in blk_validate_limits()? Is
your driver writing over the limits outside the API's update path?
