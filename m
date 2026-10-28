Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217144;
	b=cZSSXFYpefu8QCDgAkMeYLJQxE417XvpLqgt1IQJbc2VJvM68NOE5VXtt2BPPAFzuUyJ
	 msYl0esYtoPshlha/r5DWgFc6oghXHan8zSotx6zfobVxWjjkLJFS5ERIi4NRhUMP9tM/
	 9dvqqAVMpfAV2rqR3nXJswLeKlbR/Jb4pmHiNb33GwkKaR987QUnuuEdge6bRUed7UUid
	 m66E6ZM9VVd+Gglr1d86DrYUnv4ebKfXes30d3yPbEd8pYXUh3i/rVGP5FqV1xRVvcH8y
	 z69bZ+z9EbQsKy+tumYgdjO5v2lPVszNcn9T6WjeJD+r7MMTpe6nrOlHlrve+q+rcsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217144;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zuo7tjjhAz9+9E+O474COWQ5uiJtSePck+XQMQSilHs=;
	b=kmKg2eo6Re/7s4Wdb1RCXwQHB/LF2tQrwzi1ViedompgeTrRAmu8fnmiCZWXhxFCZ7gU
	 IT7rAapU+lluEXsuGi65LVJIESGDKbqKIJU3QD8Qc67y50nzyMoJeDPfK7Up8FYOTKKAb
	 ks16BCKtrvIbX9W3u8qfQokMM9pRf5RBo2bKSdJcYUCvBKLlV5ddyAm0foc7V+ixoulh6
	 OkaDdrrv/yPuMLq1rlR0LLuQtklJLXqGEfimdOpuBVcZKRNXPFN9gR0qQj8tJVSjgk+yt
	 sjQ27Nxv+uujJ2hFeYhu2sdu2p30L9GhFWGpYvnCloz4Np/RiXDCelRLGW8F1FTNbEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOXneeyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F2606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOXneeyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B058C1F01825;
	Wed, 28 Oct 2026 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217143;
	bh=zuo7tjjhAz9+9E+O474COWQ5uiJtSePck+XQMQSilHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AOXneeyfUqYrNPQ+YEtrb2Pn5nv/7Cu1HWrcHGl6lIKf0h5zTZ7EFP5Hc0T/zz++W
	 pmf9A79mArEcluRT6N2NlA0j478b4mpf7m5KJXUoDN0TXgmLhWii5m0SoKn5wykBtq
	 uqIXowKUnQDHvW/8OVY6qAaAzLuykqL9lpnJm61aBVUA64Xi3CpFQ9BuQ9Vy9pmVlu
	 a51ujKuRtdkvAemo8VqG9qbesHsivI/GkTHynW5dhnKs4afSpIWOogoLBj0CpPhhSc
	 /Ai9LcUeHcCOIrYm4S+6W+A9UH3rfiNCoxEUMcV665cuZASbvLL/Ftx+VdTu+RaJle
	 3amdqMTGJIhZQ==
Date: Wed, 28 Oct 2026 09:52:23 -1000
Message-ID: <f7d81159a66057e1cd043894bccfc6dd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 26/98] blk-throttle: make blkio.reset_stats reset I/O counts
In-Reply-To: <20261028164415.1262013-27-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-27-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, Oct 28, 2026 at 10:41:29AM -0600, Jens Axboe wrote:
> blkio.throttle.io_service_bytes and io_serviced were reset by
> blkcg_reset_stats() while the counters were part of the blkg. Now that
> they live in the throtl_grp, add a pd_reset_stats_fn for them.
>
> Fixes: 7ca464383aec ("blk-throtl: stop using blkg->stat_bytes and ->stat_ios")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
