Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071B347C7;
	Fri, 13 Feb 2026 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950971; cv=none; b=CNcaztTN+eAVzIilmzqk8D6/s34g8rJK8d8yL9cnOg0bgD+KvMueKmzMSLKugYmc+iMPK23Gc2BZrVWmfKlwgVbbwuZPc1yRs0ppClcDJe0Hsn8FInBWCHpJXre67cmruBxX8TRtsfTLJcC9ETdRQ0uWUbxKKComx8zT/YHP66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950971; c=relaxed/simple;
	bh=F4kWUuS80KuJRjn1RgHVRsL/vhx75ULFBxaJq6dZNzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWnnXiU0phdi1/cCQE74ZWFdaLfQm0qY5wsbSS8bbmnr7x0Yi/DuWhgNYfeQPLbH8zZCgSCNXyJ256mmAiRTSNuzf3TnnTvmnzbEhsHYF0wYi+wH2VJp5gGLNf9zlrX+wAllffHSxJWzmkyLTty0KgVloijV3Qv3Pe+EvdYvpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ5bImmi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ5bImmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA80FC4CEF7;
	Fri, 13 Feb 2026 02:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770950971;
	bh=F4kWUuS80KuJRjn1RgHVRsL/vhx75ULFBxaJq6dZNzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZQ5bImmip+SsH0opjWcZi1te5c/mjoZ4ZWx/mLoXQYtaT7n8+XzmbRBgYOWkaCvJJ
	 04zUdAeIcTS2rNOfK0jXyIvLct93ZYoDsGDoZPc95WsQTyJs2GHmQt8uCTDgVTPsfH
	 rMZO3g/h5XQMFf/VFzjnvgp/h1zwbzdh/U/U6DGJBEIddPIanYLbANtlB7Y9XnwHE8
	 aM5cn6ogKhInFjesNbD/u9FIz9SZAWdIA2NASBzH9dt1HcdoK3HdoEckjpVcaQQJ9i
	 SstiPo/ZXJXEx8muLF75a2QUhz3gFSa76wN8ISgL1m+EUmPgGv7aUy1bdYLthD0GF/
	 wShZGBI3XVwYA==
Message-ID: <04d2df4e-b835-42e0-bcb5-7f15e9981ef4@kernel.org>
Date: Fri, 13 Feb 2026 11:49:29 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: update docs for bio and bvec_iter
To: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260212-bvec_iter-docs-v1-1-888607db0ddc@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260212-bvec_iter-docs-v1-1-888607db0ddc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/26 02:17, Andreas Hindborg wrote:
> The documentation for bio and bvec_iter refers to a vector named bvl_vec.
> This does not exis. Update the documentation comment with the correct name.

s/exis/exist

> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Other than the above nit,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
