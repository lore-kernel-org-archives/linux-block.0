Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC614D6F6
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478569; cv=none; b=Xf9n9ArD5Z6/Nik00817WjnqaBFJpbEM6Z68u1ryTPpjJ/adyBDiIxWcjVBYqt8urfCksFHNSgZJnGV1vnKep2sh52dKOoZt1G+y7OULvwXpqvbv2xWgJKFjWcCIR4lLJ4PkFn7n7OEmpHP/NGjT+ItjwWbMC225WlVo7lwZZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478569; c=relaxed/simple;
	bh=5YSOiXqnMKmHRsUb5rF6O3kDJUKqV2swSpSQ0hyR2a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jq9IP397z9YB95aUQggQ8jOs/yjWrfs/JVV9JUArDsZss242K7OqBZqEWwhq+SH/6sCpc8TF7X1YTJPFVLV201VFMQE0CpgMi3TZqFtU9AkEYs+C/m0O4t+OTalP7fU3VO83i8dg3NCUx7dpHowgz7uHnm8xXMFw4h+MFxROpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neH84RaY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neH84RaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AC0C4CED3;
	Tue, 17 Dec 2024 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734478568;
	bh=5YSOiXqnMKmHRsUb5rF6O3kDJUKqV2swSpSQ0hyR2a0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=neH84RaYHAQstBjubkwdNiH9FMM+wgAHs2FPnlug/NKK3T9EKpcYsoIXELonXd3KZ
	 4x7zQzLlnXDAau80q+ZkG0sY6IWN6XhiYlsF4fXMTJDcoI/5FjUQL1JTvcSGDg11EL
	 dptYADhrDckDMbB0wGaUIn41HJwbvIQbifcbte+4NHN5JjlVynNS8wrP3EiwqW/V2B
	 P57me+KwWJLKnSyczc4jNC9Lpl22HUlzRVyiYHzRyNlyMLT7uJej4dSnw0sN/FI+P9
	 cBEQXc8Zt9BV8jYum7zN82A3yk4oXeZ2YhPBqQAUwnqkbG5CIk/QMDzWA9hhCfxamb
	 srRyVpjtneHKQ==
Message-ID: <791f68de-3636-48ad-b35c-fca9bf88f1e9@kernel.org>
Date: Tue, 17 Dec 2024 15:36:08 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block: Optimize blk_mq_submit_bio() for the cache
 hit scenario
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241217223809.683035-1-bvanassche@acm.org>
 <20241217223809.683035-2-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217223809.683035-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 14:38, Bart Van Assche wrote:
> Help the CPU branch predictor in case of a cache hit by handling the cache
> hit scenario first.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
