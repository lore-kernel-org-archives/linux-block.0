Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53141F513
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845192; cv=none; b=YGkb5Z9z4EheexmLFVWK21+lRFPpM4WgI8r7hHjMHruEiAoO0qXWeTKtc84uJvY9XmcBH70xYPwZSB6DmEfex+lzqw04lTzWS6qbnJNw42aewAQZQrLv7RdEvz39qcAySiARopH7G9wsHGwI8K1xZnGPyDs1ZbTQv/4qAenuFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845192; c=relaxed/simple;
	bh=gCqe7z8l68Vc70gRTJgpCR1oPvegacLLJlALpORFlns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgVHLrvw8tkYOcjGyF78eVViu0fob0ZnCgR4+Euk69rleqOhw/fwOzRtp2tbNg1pQUcReWc8FAYScAGBFBApD6iWIpo1HKXETSrRX0hxuZeQf4Hn3Blqv2hIQK7sZdaWy+kc/m9cG0a1CX4LWOVUseEKodUINaHDlrHDkWbExIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXHGISRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXHGISRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1248EC113D0;
	Tue, 11 Nov 2025 07:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845187;
	bh=gCqe7z8l68Vc70gRTJgpCR1oPvegacLLJlALpORFlns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CXHGISRbE6j1CFkrYuscMQmXRKITnKkOi5SySKMiOjNVeHXRe/DqB35wzlNx5vhUy
	 1rf0D6i0m3laXxLLAyVfv0qrmk3K2zE7uHFOAsudHFd44MZfwdIJ9OYN19UCQfooaX
	 knZBFVN4R/scjE7/l9J7VKeySSINxNPOAKcjFzTme/7YYd4JEFjLog6t1RiU36C5XO
	 LCam6wfPfcJFpXoR6rGLDhv7J6oWp3ge5zMg2NlI4gJpo590xhjlJ3tlTwdYfa2Yge
	 9+Eb1K9io6dhP1jHUD88/8VaPLPDN6ZvnD2fV4HxPJv+FhQe8hLsYoq/3r+cTev/jf
	 NveVqnKDaKVMQ==
Message-ID: <5c264096-2bc1-42b7-91af-739f4ca1916b@kernel.org>
Date: Tue, 11 Nov 2025 16:09:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] blk-zoned: Split an if-statement
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-4-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251110223003.2900613-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 7:30 AM, Bart Van Assche wrote:
> Split an if-statement and also the comment above that if-statement. This
> patch makes the code slightly easier to read. No functionality has been
> changed.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Though it feels like this should be squashed with patch 4/4.


-- 
Damien Le Moal
Western Digital Research
