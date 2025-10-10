Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BA34BA3A
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105229; cv=none; b=s2YHQQaAmYpByuFkDiqZtRHaJp9ftpJwdAbQ/HFGZXIdSE1N8GrcYvRYsQmijsvNlHwv5DCRwBbvJQIB9e5iIrXOpH7zX1vE7j8MqtwDfPvvlmjgygBU7RKS/Jzf2zHcORmOCuPMd/pP50Lb5JYz31SpmvAMCcmkTrB2wRpYXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105229; c=relaxed/simple;
	bh=2FH7B9J39IEZJ7B0gBB/2BJwg2RhQJsW/Xxlcu1F31Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovISuSZVmWoNlIKTKWq7Wih6sURZSoUYK+NnDgYz//GQyRfNAik4iPxzlAIIP4kgxm32nYvjX50WGaTWvGLx/smwvWR6gzcKuYfVnkXS/JdLfJTLe5LieMyijfu2mugMA194phbrK+I4JuG7OFCYAO1y5IRtHANSBj6NwMvLnwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn4lY3/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn4lY3/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D6DC4CEF1;
	Fri, 10 Oct 2025 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760105229;
	bh=2FH7B9J39IEZJ7B0gBB/2BJwg2RhQJsW/Xxlcu1F31Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kn4lY3/8JEbELvtWejv+sb38MKaxZHzDlTbGIO55DQKuvJDaA0ElTPpZnkSx9BgP+
	 3aN1eKDbpLMOjpu0rAsbiUnbBDlZCG6i11w1B0/MHF1gUeJeA49et145xvkzjTTwbJ
	 8i6xawU2btp/0ZFlrDTUZhY8ZYMVGVUGhPRtcRENquDLqcxGEesXdOaaNO9Ooxnd3q
	 GuFRJidmGxLX0Vx+qSFtomcHBqfGo19FmGR8kk887QYrCHetPj0vhLu3zWfkY4+owx
	 brgPcOyt9bAWmvrWVLurIRxw3gXGu9iFwk7qmHWRUzOt0JMIM/uFMM2pmPuotrRk2h
	 cP3X7K8Di2v6w==
Date: Fri, 10 Oct 2025 08:07:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: cleanup and optimize bvec_gap_to_prev
Message-ID: <aOkTC4R7R51NuqGr@kbusch-mbp>
References: <20251010110729.3875213-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010110729.3875213-1-hch@lst.de>

On Fri, Oct 10, 2025 at 08:07:29PM +0900, Christoph Hellwig wrote:
> Micro-optimize the code in bvec_gap_to_prev using two tricks:
> 
>  - OR the offset and previous length + offset so that there is no need
>    for a branch to check both with separate logical and checks.
>  - Always OR in the virtual boundary mask, as the instruction for that
>    is cheaper than the branch to check for a 0 value.
> 
> This together then removes the need for the separate __-handler as
> skipping the branch for the 0 check is gone.

Looks good

Reviewed-by: Keith Busch <kbusch@kernel.org>
