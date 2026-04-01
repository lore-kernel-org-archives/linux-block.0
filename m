Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF9280CD5
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074782; cv=none; b=iEkIa51V9ky6wQNdoeqs0H0cw+Jp1ftL9nKGGcavSA18/yJvqlddDqltH6RjwN1OWRhN1VLZF/p5GuDQ6ZcghbzCaqG3qOeTTLHFLMsTmVGLdJgelZvOKgilcuCh3vUCV4y8sG6bTBARf6cjIV9+sNEEwb7NUKnWrJh1IGvANPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074782; c=relaxed/simple;
	bh=LxP5GBRWZUzvAAlMCUThQDBt9ko/e7GeYI0kp519v44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePgUTitJTyNW2AvBlIXfYNdGCBKKt35Hv0Pvha158hgCiyTK9TfqWuL/uv8Sd2IOsHAt2AX15LaSajV3LfnpHyt+WEQLOGgfWD4Y1maatcU5/qv0hkGv92t8l634zneNb1tLtXs0Pz8o9aWJVe6rlcTmvzYB1Dji3r64ghIGZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VixI7NzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VixI7NzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D6C4CEF7;
	Wed,  1 Apr 2026 20:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775074781;
	bh=LxP5GBRWZUzvAAlMCUThQDBt9ko/e7GeYI0kp519v44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VixI7NzOardUDoro3vAdPDe6MyQLowj5KXhpMC6QtLaobyJlLeS3ufJtTMajBBZuB
	 hP6of02PUwkBDlBuj9/W0FOS30jSR+5K5RIruAL+wYrvY4pKxHeKFY17g+h4He6T+8
	 C0Zfx/mEjs8hfaxggxeRADVYok5TeLh78J5Lrcm5Z4y7e4iTT37lw1rD/4vaT3GHHl
	 /xDLfz8vZbPSqpYGK689iCQywZfXqub4HBfRnlNlpKVgizSo8aibV239vls1+KTBvL
	 pa+cXMCfpqnerACEmkw+uFVrlyPXaA8OJQK/7Io1yvI2fi/ReD8gClidMD+HGRUdYJ
	 JOWatC7nQT8XQ==
Date: Wed, 1 Apr 2026 13:19:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-crypto: fix name of the bio completion callback
Message-ID: <20260401201939.GC2466@quark>
References: <20260401135854.125109-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401135854.125109-1-hch@lst.de>

On Wed, Apr 01, 2026 at 03:58:51PM +0200, Christoph Hellwig wrote:
> Fix a simple naming issue in the documentation: the completion
> routine is called bi_end_io and not bi_complete.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/block/inline-encryption.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
