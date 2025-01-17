Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22A1AA1D1
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154075; cv=none; b=nsgNiRyYsJw7gEUA3FAnp0ygFWh2w+j//QrYqLXOavjt6Gb90T4ydoV75x5H1mWsT9x6LkrtO6gopnzolRZNQOSmedalEiaC3DmfgPD/NaFgjlpV/mFeIGqPkxwaZQMLEQItQvQQqBOQuZP5puWiZ4xO9ZlJR/P9AGI3odDlmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154075; c=relaxed/simple;
	bh=OH1Tl4SjM9YAF4DXkyoUpaWaZ5iQCl11GbGUnav9/aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqyoNJwRhhzXyqn5GJWmOn3ALd3LRL5pF1QinGTH/c5ZcnBW6K4K5+7vqc/S1ZwjVsfYA+ijA7umF0UeRHz+ywTU133Y4hL9JQAUjYu/nnoYJ0KN1Q3o5wjSZ0KbAJXNAWK9313+ei79wSKfGSdneAc/eNlYi5UDRhsiHoJLFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrTvn9Ji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrTvn9Ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3915EC4CEDD;
	Fri, 17 Jan 2025 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737154074;
	bh=OH1Tl4SjM9YAF4DXkyoUpaWaZ5iQCl11GbGUnav9/aQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PrTvn9JiwxJiRxcjqfPzXWmd/oA1Ujry4Qdz8jHeb+EjL448Y+f+eBveOvsoxGJEw
	 akmrDnMQe55ud+HaCFqlBMiCqFKz8Tip/V32zYSJ3YC6voRpJgA6NtZIaXN7VdBafN
	 RM6QXEsz7w2303LyK4Re30/JMqFkHBSgkp1skxkDHdtwoIZuSzyyQ7hPh6QZzBcEug
	 zbV/oLMVXCC5X9zwjYSn7NYWr+RHjUHRzDHRck0GEjo01kApgEjLDL1oj+fl7E0fwy
	 YG5Zv0WCezurvYaCX7WgOr/inBkRT6s3gQO9W63eOHQXes9g2sowTMk3kYiJkyxis5
	 L1M2P9Ss/i5NQ==
Message-ID: <c7fa1b34-3f0a-44db-91b7-6482a15e48f8@kernel.org>
Date: Sat, 18 Jan 2025 07:47:50 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/14] Improve write performance for zoned UFS devices
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250115224649.3973718-1-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250115224649.3973718-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 7:46 AM, Bart Van Assche wrote:
> Hi Damien and Christoph,
> 
> This patch series improves small write IOPS by a factor of four (+300%) for
> zoned UFS devices on my test setup. Please help with reviewing this patch
> series.

Bart,

Given that this is a set of 14 patches, giving a more detailed summary here of
what the entire patch set intends to do and how it does it would really help
with the review. I do not want to have to reverse engineer your line of thoughts
to see if the patch set is correctly organized.

Also, patch 14 puts back a lot of the code that was recently removed. Not nice,
and its commit message is also far too short given the size of the patch. Please
spend more time explaining what the patches do and how they do it to facilitate
review.

I also fail to see why you treat request requeue as errors if you actually
expect them to happen... I do not think you need error handling and tracking of
the completion wp position: when you get a requeue event, requeue all requests
in the plug and set the plug wp position to the lowest sector of all the
requeued requests. That is necessarily the current location of the write
pointer. No need for re-introducing all the error handling for that, no ?

I am going to wait for you to resend this with a better "big picture"
explanation of what you are trying to do so that I do not randomly comment on
things that I am not sure I completely understand. Thanks.

-- 
Damien Le Moal
Western Digital Research
