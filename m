Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217141;
	b=mSozU/QdGzOCK9Q/naN7ZZxkFvg3+qAXUmxM7WSFyauzYo1MTeh5vOTGTRZWC/rSywnl
	 aHRWKfFQe37RgPhyIdeZEHNKGGz2d9LjoAD+AxJtZkHrdVOkAPxfX343G6Bbh1x5Vb2q8
	 f7EloselcL1AmgWcLXN4SFE2J9YDWt0K0bEsM8tAXmI6Kx8MKKmL335sOaEXtGzB9tfc0
	 CQJJJ9M3FkDGGCCBeCP/0xuP35HngZX3tg/abXeshcZmyycg+gU9PhXxklqS6rUxWDRi8
	 BmB4qZSAYBMjRuCNO/iqo03i5OUBhopksCI6SDQkmPCAonxzYKmZFGTZ1dcBPUCTUCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217141;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hMRsj8eDLVNnyrbhkyfiZYVB0CfQDwaxpISF5sRzaAg=;
	b=CoNGygH89M/yJdKqI+MSlO8fzsobcSZgkH2COhock9FgxhVkc/P2mhvpi4Kp66laNDOW
	 PTytVwVoOXJu1jJpxwEMTYfkOfFupMWxFz5LJ+QhgODT3zm444rq3d2h/eWgZhZvpTHrh
	 2UKi9EyPVR56m7ZjAT12jP/CTru11CW5+uFO8hFJoh3kCDRTOqx1wcCN1DdBdLvzdjPqi
	 jxIjy3bwBiGeVvR1SZcFriN5esNw5GfFcKVxWZEoajLPiZ7FVCGmM6kMw4fRqwPOpIDR9
	 N+hKs0PhKziIVUJ0j7705dUcZC+Wx0xgg33VEN0sG0ExeMvkcPaBFKJkkcHAJe0ce2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0iLlemc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA70606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0iLlemc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8509B1F01829;
	Wed, 28 Oct 2026 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217140;
	bh=hMRsj8eDLVNnyrbhkyfiZYVB0CfQDwaxpISF5sRzaAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l0iLlemc5x9ERiFgrYPAzU7U0RJNXIW7j/+AD76V4ta3KrEeUxCWzbJi+KI+UHPyT
	 QGWW43Kgxb34CGIBWWXvRGUZ2G61AuH8CraHm2js0VBHxx5lPTTTq05YpA1Itf6NQk
	 MiBfVyswVQK+u1EbEvsdMbLDAbt+uMMUZnPgTnpiKgCS63wy/wYwsrllRQqC5cQGeG
	 FFo6Y1XBKiavTeS485CUAuxGkmnUgi1Y5/DKO5XgvKejJ/xnj5NlXczqgCN5Z4vQZP
	 ZJ/Qw1w056yLdjabtX2ZTRbXhR05McBjqko7SqGeRs9N06DiO5pUlNzKo2A4dYqbMm
	 cMPCLiBT69u1Q==
Date: Wed, 28 Oct 2026 09:52:19 -1000
Message-ID: <35ea3b62611f4b34f8ef33d56f8fcfb1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/98] blk-cgroup: fix root io.stat byte counts on 32-bit
In-Reply-To: <20261028164415.1262013-14-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-14-axboe@kernel.dk>
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

On Wed, Oct 28, 2026 at 10:41:16AM -0600, Jens Axboe wrote:
> blkcg_fill_root_iostats() shifts the unsigned long sector counts by 9
> before adding them to the u64 byte counts, so on 32-bit the contribution
> of a CPU wraps every 4GB. Widen before the shift.
>
> Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup io.stat")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
