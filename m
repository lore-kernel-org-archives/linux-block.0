Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209257;
	b=r08REJkgv/Ha5AlL0sPl7+OLZzb0RT+BFozYuFK1VcWccG5rXut0ND5o7w8J3wEsJorr
	 tt985hi9xYQEEuJ1PLReXRNruNya0MUoNkiM7VunL5oBh/f+JCIkJD65QN8kWNWSmk3lO
	 /t0ja+ZJdnlFFeEftCq7rdYYJKiI8AL9BCUgnN10KyBo7crV/jdfIVDz/Btc5+LQ3tJLD
	 ke+w1Oaybw5jxMydPx/A1y8QTAekkWagro/84IXr343QC8gw0B7Se27R519+LBVdIZrZt
	 ClCTAiOy5MEhU7TBPGqbJztYbUCoQHuWhc8+iMo+f3im2sjoASmJIZiWZVCyAceh+/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209257;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5S+/1olC9YQ0x2Kzx2NQXfaYJMkaoCSjr0KTnPBvGPM=;
	b=ISCgNFyWxciVq6RyszbutAtF3NLcrS2e3z4ekwNDemhhqqonWOIv5m6DMzVAZhp8rZSm
	 5iP+PlBDl5XXsZ7vVz6JGh+N049adQu/ZMY1CxKKy6XMNB8+dANb127I1IvqVDqeQmn2W
	 pBUHlYO2jj7WUM/ytyFbOxVQU+/L5967cZ/BPXP6MLltzwNiV6loBhMswlxq0QHTL2SCU
	 Ijc8A0FGpkELNp8P1BRSTrPNZ8In69jFToc2jC+g13KnwHuBnfh6m4gUzTNFX75gmuoXW
	 s3eI7dnmcwhNmnid4mG8MB8aVxFfqmzAz7mPVUktChsyw139yK3SaZq2syE+KV5BTdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mst2lHqB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80874606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mst2lHqB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64881F01825;
	Wed, 28 Oct 2026 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793209257;
	bh=5S+/1olC9YQ0x2Kzx2NQXfaYJMkaoCSjr0KTnPBvGPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mst2lHqB+EBovbnA3pkeMFLpSPgN0ZgS9OEHF4WREB43PfieiQpPlJZ0N3S5NCquD
	 ud+1ov1ylGoKfeEGS7VE6NVsogX+7e7QlOAjCsO/T9lhz5u12M+sckJ2XjLI90SwTk
	 cSwb9YUPjweHlYhjZFCZRuKGf5/pES33y2baXlRPNAgI88f0g6ITZHo9rHrABF6tHA
	 OnKCYAZ6d/xvk0mtVQbbCr8SiH6B84SQm3/jkUNub+dhCwRmVfeSEcicILc+N8hl43
	 H+R4Ek5u8/Mq4o6JrUsXbate2YyqrJPI4IJYzpHGvWs28IJvxKFYGVSgsSaor/MuKh
	 D+/O+gPETy/XQ==
Date: Wed, 28 Oct 2026 11:40:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 47/98] nvme: refuse metadata sizes above 255 bytes
Message-ID: <auIzpyLrIUIdkZxS@kbusch-mbp>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-48-axboe@kernel.dk>
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
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-48-axboe@kernel.dk>

On Wed, Oct 28, 2026 at 10:41:50AM -0600, Jens Axboe wrote:
> +	/* struct blk_integrity has eight bits for the metadata size. */
> +	if (head->ms > U8_MAX)
> +		return false;

I've never seen a device with 256 or greater metadata, but if the specs
allow it, should the block layer accomodate? It's just the queue_limits,
so widening the type isn't a big deal; it fits in the existing padding
anyway so the struct doesn't even have to grow.

There's potential issues with logical_block_metadata_cap, but that's
just user space reporting and doesn't affect the kernel behavior. Seems
better than throttling the capacity to 0 for an unsupported format that
we can totally support.
