Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EE1F666A
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448026; cv=none; b=HG3tdF+Xv2FreY0yA3aRKyBQLMGjAA/4zhePPwBnkPm8VOt6CeqNbt28he/s9O/G1P4oUbZQNFmEkkuby4Y3ZYCQZ+o2JfBPnI7Uwsqu6hNXuZJAOb7YIuiKeBdGQJIiJ8entAmjnY6Dd629We1rfoELpdpPi1aZqUZkDMjpm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448026; c=relaxed/simple;
	bh=1SM/2OuMzLUx6umxQKKRch4+IwOmxKMo6AvhI5nBHlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AECnA8CBILeQ5JrEo7pRCU/WwHkq3wJYiotCyWUwuUK/1nmlVvo9onRckorAuMfCkvB2wPa3+K/NmenRMKWC8/EZywzQUk0aJbIkdykqUCQQ21p+5njG3U2gIcEvyK9GJu97NvjxdAGNUnyBIMujMOLy9S2rxcmijqeAufs6wLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBbFvjZe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBbFvjZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C635CC4CED4;
	Tue, 17 Dec 2024 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448025;
	bh=1SM/2OuMzLUx6umxQKKRch4+IwOmxKMo6AvhI5nBHlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vBbFvjZeEw4p5QUWnro3kZj+zi2DDBOxzSA7Gj00A5LoiD/8fC9XJUBsKatDnP5PG
	 0x+YQRAmanWgJI681qo4ZSYIE7gP+wxuLhmYFF/QqkidLmDyl67kxmSOreAhzCUvcT
	 rYZkRJYbI9+bgvIetHCVqqidm5FAYCe0wtyYuH30LKgGLgY1fy5MrnDpczmEZgFnUK
	 5h9Jy9PQl0l3H+SmYSBsDrOiC+hj1qMMnVEnZrhEBAjoB+xX2KhOY3Uz6mNIWi+A+T
	 n12WOqp0HaJUZADq93hk9oZKywPkVO5E1EC2tydEF2kMvog1BFn6K74ZbMcLvaskAu
	 fDqzvosP0OEpA==
Message-ID: <a5190b7b-04d0-4359-b7f5-40520d7849c7@kernel.org>
Date: Tue, 17 Dec 2024 07:07:05 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] blk-zoned: Improve the queue reference count strategy
 documentation
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org>
 <20241216210244.2687662-5-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241216210244.2687662-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 13:02, Bart Van Assche wrote:
> For the blk_queue_exit() calls, document where the corresponding code can
> be found that increases q->q_usage_counter.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
