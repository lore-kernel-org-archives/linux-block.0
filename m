Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217642;
	b=UqBeOCP0ZfnfmTvShg+g5uJkNQvXRyHhalpD+KoTqX8obkgYV87Qc94P7BfudUf4dyVB
	 6i3KYXmaVpbatyYzYSL8TVKFHkc1OMgLsAH6EYPV5/D18KeiWss903ZrKGX1wUzBPW7l6
	 8oNk4LtqijtBLMF6cfqt0EphPrrdX2Hy47hwzazklqsRdxQvdzaYdkUhxYYUQiWLa45db
	 wIc42mBWHtSr99lcNY89LMn5GhScG4Mvik+xqPXsgt1HG1aDzxOZzEasx9xeTlyo6pI2W
	 +rDk56eTDgXzT76eUQ/1F4rh3KYfomlJ4fBvHKmeKeHtrEwkY+9PP+mJXI5ho1KOR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217642;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=drgo7RVLuwDNwvEP45TqLcKzzcSPsrrIwy+hvmvM17A=;
	b=A/No79Ddrg+j1KQSguMykeO1+OTQ8pn8P6p0qKGb73DrFQrk350GIsVUD2QXlyFRujgu
	 KzPwNMxzY3hFmP2x0IIklqmHv/FqHyuHUHorq51Ijeze3mSmVhApFQQ0FH8+ZPMjpNJna
	 ktfebjyNfTm+R32Fp+Ag0gAxYkMkMx0IWQFc93NQw9Y/JIkiSR+LzU4lk177+H+zVg5Aj
	 xrL/v8UhEaR9zMrRueHGCcqW5hW5AxWFJJ2zhfm2pRmweUJIXDTI+0I4EJUNk7QR4s7jK
	 scrdea6iy0YjXHzJ1qOspsNeS4MK1C8gpQ2usLsIdKXgZw1SDQBh/I6QBvq8TGhiF3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoXBEPX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8C606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoXBEPX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4C31F01828;
	Wed, 28 Oct 2026 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217642;
	bh=drgo7RVLuwDNwvEP45TqLcKzzcSPsrrIwy+hvmvM17A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hoXBEPX+XhUxSB8S02p/f9r/8z+UR1bBBwMU+3O2Mkh/nnwbSLgTubw5TBWcXFbhV
	 yMsmRPOzgYbuOfxod6J2qIjxK0wHq97nLdgV7e+ROzHICtjX4vBulhflU9QsWRwP/H
	 WHvh2m3EO369hngwIoDTbFUfFIH5ewdWkNoMRma76qUqNzxHdnUkcKj85GCwzfp5PM
	 rEWXBB+n1snl1f8PU0hJvKe26rEXTr5M9wW+eM6ZesCtkwIy1jAPCyFfc3xAMsg9Oi
	 ljDe7zzoDSW0eLqAAuCmitkAtKvYfpJqD9h96Ajykf9+FLlKFhvuhEUqdj9d25DqZx
	 i+43D3rF2RQdw==
Date: Wed, 28 Oct 2026 10:00:41 -1000
Message-ID: <feca13b82b6a5a068b72c83b06c5ace5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/98] blk-throttle: don't truncate the cgroup v1 iops limits
In-Reply-To: <20261028164415.1262013-4-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-4-axboe@kernel.dk>
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

On Wed, Oct 28, 2026 at 10:41:06AM -0600, Jens Axboe wrote:
> tg_set_conf() parses the limit into a u64 and stores the iops ones
> through an unsigned int, so anything above UINT_MAX is truncated and a
> multiple of 2^32 becomes a limit of 0. The next IO of the group then
> divides by it in tg_within_iops_limit().
>
> Clamp to UINT_MAX, which means no limit, like tg_set_limit() does on the
> default hierarchy.
>
> Fixes: af133ceb2610 ("blkcg: move blkio_group_conf->iops and ->bps to blk-throttle")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
