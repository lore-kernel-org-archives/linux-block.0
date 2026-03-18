Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE1368277
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817470; cv=none; b=ahkpN6djRB1df22+aYwZgSw7fUeByb5lmYQ/usjNxnlJSFMpFvMhA3OXwJv4uvNACsXjAbxTN3wWibUsqyLxzI/sIeIe9RhboB6+CfUPvBoK8NsUIUh9rJGQdz3+OeyIbr0v9IDYhvyVKLIR+prY9ZyQ+5/Z3RNsjp5YDA2f7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817470; c=relaxed/simple;
	bh=zC5w/ecLZJl7LKD88kl8H907qOGZ9rjJh6RC+BSMfok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiTH9jjQaAE7FDJAxqUHpAPizWLkzY6y8z8PhyG2gCChaoIgoMeUJpQREc1XosHsXEWugEwK2akWAlnNamOLySpWL5ILUxeTpGtGqpIniOiONzIQL1RXlxeyGLbg3lUeqnaCI7S3tjTlRTCAJr4OPv+NsiCJ584WntiCou1DApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFm7uvkB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFm7uvkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759A7C2BC87;
	Wed, 18 Mar 2026 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773817469;
	bh=zC5w/ecLZJl7LKD88kl8H907qOGZ9rjJh6RC+BSMfok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XFm7uvkBGXTY+suDiYdNBvmmKAylxO22d1g1yzvF3PdDD7zziZ2MwLCsmglWiiru/
	 1oWn0gx9aAAogQ9Z9eaToslZ/c0lUR06ISXDOcK/dDi780DoBr4dwrVI3kVfQkA15Y
	 0mOeREwHl5JxmTRObEkSxzeOWyNAlQdA5YqaTgi3m+ZKb/i4U761wj8TugY3dO4yQh
	 ktAdsf9T+uvqdNS3HP/9rYScZtCgNbBCQGS7ZXZxmVZJPTFys9PlNv9j/s8C//+2us
	 miz+12khtYVF82w1/WH8z+9G/G2sIeE5tqEl4XBcvuUYaqn07vtMOnoV1JPYYoXLDk
	 72iDJqVwgS7uQ==
Message-ID: <55abcaf5-4e8f-4ffb-9aeb-2ca2efe46ce8@kernel.org>
Date: Wed, 18 Mar 2026 15:58:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] zloop: refactor zloop_rw
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260318055331.1824108-1-hch@lst.de>
 <20260318055331.1824108-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260318055331.1824108-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 2:53 PM, Christoph Hellwig wrote:
> Split out two helpers functions to make the function more readable and
> to avoid conditional locking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
