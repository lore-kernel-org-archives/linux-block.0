Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D0839E9
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703862; cv=none; b=FanDKGc7M0+eKqwrG77DB4EZ9360VJ5aN+n05RaUsAc3HdE7g9dzMnVPcFCsB2zp+bT3v2bs2W8mW1JHl+4EViUZJ8STa898qLRJnd/h3N4pWrREfev/xVu7tTMcICs2wabvsPe9VE51f2I8bIJgaWyBhs53PKxxbBBDiZGIueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703862; c=relaxed/simple;
	bh=UkuW3GKwQPUEdXFp4qdklUmaWZIvolcwCVmPyj1unG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqkUyAxmnKB2l/X5jKgCVOOLJBz1lRjgl/EP9VyfvjarKmlTta0FnmBbU28DTteOTrWn77E7WTncEalBWZA7LsB/zLEm+GMsReCtIe5uAVAqPPbe8eEWIIAd1S8F7mlE/GfVFPunc79Fey7ZScWk7r0NAPWawGZHpK4jPG9MFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzrR32Rx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzrR32Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA038C43390;
	Fri, 23 Feb 2024 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703862;
	bh=UkuW3GKwQPUEdXFp4qdklUmaWZIvolcwCVmPyj1unG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzrR32RxDgRx+Deco3gPQYvCmLk9yo4xSHaXfV8hNmk2sDwr1Lx7/hIP2ZKOUiDEq
	 ZUoNXaPEOIaq8YOY8aB8ORWY7YNlya91r8wOPtPqIySjP9aqy93JLlM9aE6YAJx7Ep
	 P5xJa4wOVgK8uKPTwebfVsoe29mW8DbXHSaGalhopsByDQ0kZj5ptlfzWmh7adcf35
	 fE/FKsy7OF+OJyc+5YcBulCCUeiQMsnpWexCs/TQ2P+MUVHGwnP/kUb8cebjV5AHvA
	 lD6Zr3pmKuvJy9dvL3bgSYSEDkt9kgH1B8kyHRlhf5Rbm2xrAKhVbBSGrK5usCWiAS
	 Uijwkb3qa+0Ow==
Date: Fri, 23 Feb 2024 08:57:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.org, ming.lei@redhat.com, chaitanyak@nvidia.com
Subject: Re: [PATCHv3 0/4] block: make long runnint operations killable
Message-ID: <ZdjAc1xger-FglHt@kbusch-mbp>
References: <20240222191922.2130580-1-kbusch@meta.com>
 <a17a6587-7565-46ee-a321-2ffce9ce7d86@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17a6587-7565-46ee-a321-2ffce9ce7d86@linux.ibm.com>

On Fri, Feb 23, 2024 at 04:55:51PM +0530, Nilay Shroff wrote:
> I tried applying patchset using "git am" but it failed to apply. Was the patchset 
> created against the latest v6.8-rc5? Latter I applied the patchet manually. 

Patchset was created from linux-block tree's for-6.9/block branch:

  https://git.kernel.dk/cgit/linux-block/log/?h=for-6.9/block
