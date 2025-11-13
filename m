Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0719067C
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055196; cv=none; b=rhqGjY2WE5ZOldS6dFAMGJF1gHcIo1nNzFL10hurfZOeOmjqRYpE+hxPKOfoQERHOv1zD4GF+XPIUSmylsidKGuGQszHk7HLB19MbI6GBlzxJqSMpC1PEZodlXvjpBWqlL+xl9Us1oWch+I6TivKXBXD2WjISt9O3mVNZCuLJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055196; c=relaxed/simple;
	bh=Xayte8FMpulFs2Y35MtfK7HmXzGXzaR1sqPvLqIDq+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHba9esnvwEL6dJJeb+ZV45ZxbLiJ05bEvOoLSE4oUuQ88Bw5Tz0mXOTuFYMdyXTv2j9cLP31WZi5esRSQzM9oFmcVFaRTeco15yCnZCCdlmSHXNJkZu4J75iUdZS0qffWH6PpP5MKErwnVQBZIQxd/7Dbyf5aQXBr5YTrdDS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1VwGM+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1VwGM+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F94C4CEF7;
	Thu, 13 Nov 2025 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763055196;
	bh=Xayte8FMpulFs2Y35MtfK7HmXzGXzaR1sqPvLqIDq+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1VwGM+TrWjkouqbcsDF9jv6bi6Zc/NyZ9k7rtY4fr0TNgJlK5PBEUkDF1jxDEzYQ
	 YNi4Kw4JgoBimecqE4w6yXvmYyYYgtbTdaGO25v9fVzOU23vNEX+MAgehTgb7msLeU
	 Fe4pLd3gvCurdinoQ563XOxHe9s42p96JdeDLDvwtGnCWW1z4Y6/sb+8yO6qtoWO41
	 5uMIFUgtPeY5jUIVPRWDQNCVbUVLIznaVw/YxI9cnjccwFcYqjoItzoNpLC03nYu2n
	 Hi40Xu+rENgMBLanTJaCbEdU1THLNrn7OMMT3yNOngI1gqE/MfM3BM1td06T8CUchE
	 NQ13GBsRXCaJA==
Date: Thu, 13 Nov 2025 09:31:35 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251113173135.GD1792@sol>
References: <20251113152621.2183637-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113152621.2183637-1-kbusch@meta.com>

On Thu, Nov 13, 2025 at 07:26:21AM -0800, Keith Busch wrote:
> +static void blk_set_ip_pi(struct t10_pi_tuple *pi,
> +			  struct blk_integrity_iter *iter)
>  {
> -	u8 offset = bi->pi_offset;
> -	unsigned int i;
> -
> -	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
> -		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
> +	__be16 csum = (__force __be16)~(lower_16_bits(iter->crc));

This just throws away half of the checksum instead of properly combining
the two halves.  How is this being tested?

> +	__put_unaligned_t(__be16, csum, &pi->guard_tag);

This can just use put_unaligned().

- Eric
