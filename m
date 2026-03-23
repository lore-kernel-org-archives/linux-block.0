Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDE3C8723
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286809; cv=none; b=eY+6E38ZR6yn7eWKUct7FY5dY9YwTNzoeSN/8gNPex0M/Oyh1mM1wJavSfaK/rI4+phmRzlJPfypp0znwTXduddY3CqzUa8SsL2qOhL50XSf9gTaNBnCTwEtWbNrfRC823uaGlTrgOqBMk8c7nJO/SFkZMMyUQKgpmIvn4RH4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286809; c=relaxed/simple;
	bh=0PwIvUHk9buc7lhbkVncy+hI8JOGaFE6RoxoUArs+3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaBHVj1CGJFY+r47fWWQUvKhKe26dYjv9MlUHb6kSqZ9ghuK4/CUZIVPkJbPQ2ZjgTRQDcDz1nv3QW/Aiirw0+guzj/oxSdhBwCoWLGBsILEV9GABLYzolgFctLuzjiqgZSF0opx1Z/i2tVmC8Q9vqNCugDJGrpDBpZY/6LTkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX1iJzkq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX1iJzkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E63C4CEF7;
	Mon, 23 Mar 2026 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286809;
	bh=0PwIvUHk9buc7lhbkVncy+hI8JOGaFE6RoxoUArs+3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GX1iJzkqMUrysonWQcR5WG0FZjSz69B5MXJiW4ad/0R7CldSjDyhzgHFM4APQvNYH
	 5YpsZCeOGmOtd40R2Ub+Jm9Suvmf3VBPRq2Xdgpd8yFtCP0vKyt69zzMKxBcO5xkt6
	 JSJlW23zgsJOQHc8R6DdkANkCDC1scczcvhzLOe/M0h3X9O2ZdwWoX4FEhV5c1gmze
	 FVZAJ6BjFHH8LKr+vCJ8d6YqA6zhx0C3u+58ZKHTtkAjP89nDQV8s2NWD5qN+rX/l0
	 1+nzEwltoMJD4dZOOf+Y3ddnJ/dHw1OHUqCxRfUKtg6K623pDraX8UMREwiyQT8gCo
	 H+DDSdvhxDaKw==
Date: Mon, 23 Mar 2026 11:26:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists-infradead.org, linux-block@vger.kernel.org,
	Keith Busch <kbusch@meta.com>, hch@lst.de,
	martin.petersen@oracle.com, csander@purestorage.com
Subject: Re: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
Message-ID: <acF31yX6TyTprnyY@kbusch-mbp>
References: <20260313144701.1221652-1-kbusch@meta.com>
 <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>
 <acF0aJa-GXGYPqS0@kbusch-mbp>
 <f348e3ae-1def-4728-b8c5-1b32e1e980c0@kernel.dk>
 <acF2l2coqz2K3j-V@kbusch-mbp>
 <f9c32e5a-ea3b-4a69-a269-ba1ebf474992@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c32e5a-ea3b-4a69-a269-ba1ebf474992@kernel.dk>

On Mon, Mar 23, 2026 at 11:23:35AM -0600, Jens Axboe wrote:
> 
> You're looking in the wrong place. It's not in that branch, that branch
> only exists to have a merge point with the VFS. If you check my for-next
> branch you'll see it, and it's in for-7.1/block as well (that's the
> origin).

Oh my bad. My local branch was pointing at the vfs one from the rebase,
and I assumed that was the destination. I'm making new stuff on top and
was confused about the divergence. Thanks, and sorry for the noise.
