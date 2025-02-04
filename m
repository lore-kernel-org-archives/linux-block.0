Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2174CB5B
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630617; cv=none; b=JXFGdfiByN7x6rNKqz6uYOafXb7E1v+DNUwBZAisekkQGeyr3cxzrX9hAF4SDpHCjuc4A+3kXdjupPB9ar2Q9N773a9LMJaePpXgZMtW8xLvoXtpfUm8j4akS/PAgtYzVLAAD6iPGAAnq3El2LKxddiIvjEuj2bY4qV6CXlGuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630617; c=relaxed/simple;
	bh=Qnqo5nhq11pDBObhLPBCUB5cMjqnvJQa1lbWtzcYyRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOl7mbTjI3o+K5ZP2NMHMpguKvHLnwdKlt6uqQ1p2qvLC/VAVQQZF893+yMTeW5pZkJrtF/aHCEP0xfZ/gxOJRy1u+q/LSkGV1r52MjBb55e/7A8JNGyirVV+tsc2vUgwNe/ou/L5LV3xsks2CMVa2P1L/naOIDU4XJAl9gNGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up/pFdwn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up/pFdwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62644C4CEE0;
	Tue,  4 Feb 2025 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738630616;
	bh=Qnqo5nhq11pDBObhLPBCUB5cMjqnvJQa1lbWtzcYyRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=up/pFdwnspTZeJTPRh5ONf377NUKtHhDdLhXfRHM10rP2yfxqLnU0uCOymjmRpXHH
	 DlzKTzq5cvR1geYDZPoDYr8pxv1dxd7MtCeo4bt1x/DJDb9Ppss3qsgrszdLdG/sRJ
	 xJa3SLKixGRihZRbYyIO6xoLDKc6wC+WtvObpkkJBcI/6KeOwlHgjfEmGVZbnaj8CW
	 uyWT9BoAgDRuQymIlmW+Ktc3CvpKpFp8JA5fBLvAz53KiX6iAkWyRDrEIQvvfPM/65
	 5otkf8lVUsqvaUDOIeOhqyMMgKHt3mhdNuoQEIxBBn/pSUEaqJPSJE7Rq+GqjyFIN4
	 UqSlsOny3n/UA==
Message-ID: <abb66f57-d30d-42d8-a464-5060d6277af4@kernel.org>
Date: Tue, 4 Feb 2025 09:56:55 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] loop: check in LO_FLAGS_DIRECT_IO in
 loop_default_blocksize
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250131120120.1315125-1-hch@lst.de>
 <20250131120120.1315125-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250131120120.1315125-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/25 21:00, Christoph Hellwig wrote:
> We can't go below the minimum direct I/O size no matter if direct I/O is
> enabled by passing in an O_DIRECT file descriptor or due to the explicit
> flag.  Now that LO_FLAGS_DIRECT_IO is set earlier after assigning a
> backing file, loop_default_blocksize can check it instead of the
> O_DIRECT flag to handle both conditions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
