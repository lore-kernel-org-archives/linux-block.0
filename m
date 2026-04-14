Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5B3BD25D
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158976; cv=none; b=RIxLKMhzf4fN/SJ8HwalvxnrVIExLNwvwvp4e4snwtHJsCfNHrCWJjjXmrnByehJ7HpI7GxmFzcN0YASIhm84XvjY/lCNV96sl/NM+6sbsog2f5qzWi1bQQQmy9NuAU8GxxTpSaBavUrZ2RG9VGgG7P0kshTh+jrkSCEROpPudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158976; c=relaxed/simple;
	bh=sE7XVq5KjbMugN1VMCrK4bCFxzGxLAr840395Z3BHY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eb9kiU93Hw1ON/tPQL6L3a9mqEdEesbQObp2baQasavV15RE7bjBj41aNDVN60HU49954/X3bINpHMiQvYsC/Ju7czeyMxz4eRPxOQcxXSlf91JfsiWkLp5f7YAOkPicfPDiSwdWuXTVqaJAkW3kDgJTdqOv4Udpd799YwPf8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxFbhANw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxFbhANw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB631C19425;
	Tue, 14 Apr 2026 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158975;
	bh=sE7XVq5KjbMugN1VMCrK4bCFxzGxLAr840395Z3BHY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CxFbhANwZSRTIKwshweNOUQ3X7KgAOlcsejqwxxxp5ClTOkmS67/hNQ8m9Gwgz+vX
	 f4Iq3MOsqQ41/2cw381LDjWRPc58KJEiRmwICHAX+Ke7ApM2urbX/xK5s2InF5nE91
	 gVMV368/8TN768DhddAcxAkNyuc372upyKr1KIiBHDMpjdq2mBaTT4v+iL2F9iwUl5
	 SDq3X6FWBuVz7kHunMBBoLxgAG+reu4Ynvlo2AM2aURnzar5Ph/N9gPMqvfbKYeQ/w
	 4GPTcOd0CB/cFUK217llcy2CI2rMAWnQ1w08Hvsa6yX0Ghb+IIDvLzd1D7o2Uc9KKA
	 hG2QzOw1Jac6g==
Message-ID: <cf9a452c-b01d-4d93-afb9-aecc32adefdb@kernel.org>
Date: Tue, 14 Apr 2026 11:29:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] zloop: factor out zloop_mark_{full,empty} helpers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260414081811.549755-1-hch@lst.de>
 <20260414081811.549755-6-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260414081811.549755-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 10:17, Christoph Hellwig wrote:
> Move a few chunks of duplicated code into helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
