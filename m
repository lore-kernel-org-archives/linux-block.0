Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE83C2F
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503864; cv=none; b=aMGbF+kS5ml4NHeUT0BLI5lyjK+vj6CTDQXvzSQOBahETHJ32s18TlpYpbZvNzyWJbcT4+eWpdHQ5E9xZD6nOYY5o96Fn6zSWXqRuM+ni66kz1nYdNC4UB4nuM9reDc55gfW3E9hMN97MYP1V0+nUF0JS3uBmLZ4Ra0aC1IrVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503864; c=relaxed/simple;
	bh=vFXVBds+ExTQhIs+PmmUXFvYmCj5XOYRGV2cCmLfqsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjAJbqZnHP7w8YTH9PsImrhvcGzKyLRwklc4sMksGnXO066NsFEs5jXj9q9pPGhhsCikHoUjv8KSe2c2k1JGoZqnMdRXvttQ8JkMstAX2Mymdoow7anYzvNqa/oGfzaL3nJwcdFhrxpm5DYONYLS/pSYod+btZ/roLNZVsQIdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHMVDoQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHMVDoQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9303C4AF0A;
	Tue,  9 Jul 2024 05:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720503863;
	bh=vFXVBds+ExTQhIs+PmmUXFvYmCj5XOYRGV2cCmLfqsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SHMVDoQ0aVse8mVarNIrz+PTTYzKLnAVNS/sBza6Oo2gP8fO/9B7cn/+8ZPne/P6j
	 Om7YFPn8oLCe9pa6DaQp+IPka2Bcxaae8BffuviYFV92KjaRrVWtI9G93eXgLFiogZ
	 swm5mFnJJO3EULhqLF6hWqrR32Y9zC2DrG5kFNgZQEp+ICexFruHmmAF9bAVvgu2or
	 H5wd4sgoO9gIXQLwyhAJd6XvYnOBsBfSCpHab6K2DANKLBGhx3p2sDVQrQzaPo5Zyn
	 VaGi7YvAdDnECJAbtYPbcosgO9v7nAQ0UK09WBZv3ywSuLkXXxJAjlkXZY9Ig1GIQP
	 oZwltyGnkeNKA==
Message-ID: <9d58d0ad-4afc-4cd8-ae2d-96bf8708a14c@kernel.org>
Date: Tue, 9 Jul 2024 14:44:22 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix get_max_segment_size() warning
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de
References: <20240709045432.8688-1-kch@nvidia.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240709045432.8688-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/24 13:54, Chaitanya Kulkarni wrote:
> Correct the parameter name in the comment of get_max_segment_size()
> to fix following warning:-
> 
> block/blk-merge.c:220: warning: Function parameter or struct member 'len' not described in 'get_max_segment_size'
> block/blk-merge.c:220: warning: Excess function parameter 'max_len' description in 'get_max_segment_size'
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

