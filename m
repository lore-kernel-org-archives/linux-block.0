Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACB1F666A
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447965; cv=none; b=aFmMEP4RD67PiYGIYrNw0dl7GHXiSbbujWjl93RCEjFGlGBvd089C9fLhdGCLyMzaqgEmhtlwR9jbofUhHC2eI8LIr9oSUlZnnkTgq8AEHd4/bBE4rXFa0sxf9z6KfdmymNAT+Egj9KUC6HjykCa/B18GXZfzGmN5b5kIo1gh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447965; c=relaxed/simple;
	bh=z20Z8TCXbZbxwO1UVBBJHVDmFljnFsMRRApxz5PIw/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6Fy7KyQjE3mMTdeiDzKWfz+r4W7DhNB3Nnu4z0UDsNZ3pkT+jBUnqShZDLpykNnagrqt3107NzMW8NOwWeltLp3jU7MJbMlPCajYiUUKT/9BOqpSoIHEyyCJhvrBP3uVT22oHVXjW2eC//0sJFruGKb5X3Ste6p0t4iO9xwCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En+72lcz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En+72lcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E206C4CED4;
	Tue, 17 Dec 2024 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447965;
	bh=z20Z8TCXbZbxwO1UVBBJHVDmFljnFsMRRApxz5PIw/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=En+72lcz852KR0Vq6bfsb8o3DfuWOiF5Il19yqDu14iWTRdj386MqoGZZPHkIM1nY
	 X2ZxWWrcz/rc0/8zHJ0955FgtYC110r9qV7qNP9lVbq9EIFQKNqd1Eh9IjFcJCHTBQ
	 0NQRzIGlgWh6FI80FU+1NMhmN4xiBrdU726CHFhOTnGuTwZ7vuiFr//2G+hW1Gvjxr
	 i31ADPAF0K2bzVp7EAxGKExWl6uVDU0sq9wwzwfU9C4qqdqlhcbXGGBQnntFnjDfyT
	 pRdigSWZXodq0zKSV6pOv5PO2559x2AhXXPmA92iT70y6Wf2sNDYRA3wWqqoMUKzw6
	 AqWWgPm8sLRfg==
Message-ID: <10bcab69-990c-424e-b39d-7c9369cf3223@kernel.org>
Date: Tue, 17 Dec 2024 07:06:04 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] blk-zoned: Split queue_zone_wplugs_show()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org>
 <20241216210244.2687662-7-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241216210244.2687662-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 13:02, Bart Van Assche wrote:
> Reduce the indentation level of the code in queue_zone_wplugs_show() by
> moving the body of the loop in that function into a new function.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
