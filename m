Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49437756E
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115456; cv=none; b=FBvWoiUzATGEhseh3BFOCZ1XkjVO//ARYh6srGzzzDTJbVWow4xg0LOSdBlhzy5WkfKCLtitHSXxQ0izyb0mC0YHGjvRyHUyuPq870l4n5WAaEOZ+2YykhEp4AGDAN0luUBYHCjOkIB8B7f3uvWzsiWBOQjmShDFwAZhNNyFRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115456; c=relaxed/simple;
	bh=Mvq0dyz7+LhMKDEBzqfovm72VI3JDrD6RnXnkmY2dII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asfyt3QS9efXm2To5tSAl1MGsqhF2eEE4s+X+rLrOFVMGRCnCMKk3H9HEgWRo33I2uKsYmg5xcCSr7/+0HNQ2gr9LgYJtduC16EW+3+Ap5uN7uqsGtcLMJULdbBY8CcGoRF6gL0EJ0IS/1kytASjrgDQK6/ZToVLSVdaVfMJ2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7Fzo4QA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7Fzo4QA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C8BC2BCB7;
	Mon, 18 May 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779115456;
	bh=Mvq0dyz7+LhMKDEBzqfovm72VI3JDrD6RnXnkmY2dII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7Fzo4QA3XaNk0U5L5f5R+Ne+3AKbyBJjnSv81NU8n/b/qcR4qCGcxFIwyVA10jZF
	 dx/l9rCunU4eBU6qHqKMpnw1clxJStuNfw3+5QsIMAUk+hDDo+Zm+85Dmk2nMI6MxL
	 Hq0jTu87ctjhxH3tqOJ8coBIKxGSRC17sr5y048dapG8HbODtPkTV0QvHqlnEb+B51
	 DgsBWuwIxj1nbaeFueTxQFBJbHy8EODiUhumhtiwxijXy7AyBBWgFotc57+Vnv+auP
	 F+ZBQ8huMA0bMYe110j1PUYZJwz6+2uX/DDiC7LK2YllQD7POgkR7XDJcK6kZgRmnM
	 acSZw5REI8eGQ==
Date: Mon, 18 May 2026 08:44:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCHv2] blk-mq: check for stale cached request in
 blk_mq_submit_bio
Message-ID: <agslvk4DLD0OOVLR@kbusch-mbp>
References: <20260501174120.403960-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501174120.403960-1-kbusch@meta.com>

On Fri, May 01, 2026 at 10:41:19AM -0700, Keith Busch wrote:
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug. Fix this by ensuring the cached_rqs still contains
> our peeked request, and retry the bio submission without it if the
> request had been freed.

Any thoughts on this one? I know it's an old bug, but I've only recently
started seeing it happen for some reason.
