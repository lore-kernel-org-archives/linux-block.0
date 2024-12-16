Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026A1CF5EC
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380625; cv=none; b=ZIglSX1fq+r2PD8qxzDKFR4MVXDjLwn20Ic4rp1eKi9LIOB0hrC59LZhDf9ij3fQ7m3iy5sjxWA+RlMgi7tXpxdtolWT0VJ92Tjg9YVYsfEUFW5F1edpz1U9LBmC5YJz/psvAzkI95QeU5Ne7nZfDEwN4PBPfIyHQvnwSyrPTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380625; c=relaxed/simple;
	bh=INjBE9KdbQi5NUgOhG8cRt2hDhjjxgNSzs0WGH9KuhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzU+7PIbxqfMpQiMbbyadZ2iE3np7R5l/fNsoYrOL33ebKxcIVS/ihhZCRtL8PPhSZhFzt1cp1A1NFV0NNhIBQD/ustA1nBVC+SveAFiLN4Bo8Yk5R95Gl4+8r2M/wEzcVZ5TTTO1lSYg/TENMVvFaZFw5DSdMo0gRuHx54wph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu84etkV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu84etkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8027C4CED4;
	Mon, 16 Dec 2024 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734380625;
	bh=INjBE9KdbQi5NUgOhG8cRt2hDhjjxgNSzs0WGH9KuhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hu84etkVzoouYrFR52dT/NLphXLeVOjUvGqJbRnYzW5CWs11tSBXhdvQPjBKQW5D2
	 Y3k+glOWaGaYics4+jbaabWlVSaPmMh3BkZ48eAefopkaDHySRE/9fVQzGn4hPXNj7
	 3SdF0EuCMi0nS9KRyFSLyMYVoS9uBcR6J2sPUQlx5b4FJX4qn31zUAm6HxDILBckGV
	 6pqchGs/SUN1oO6W+j5pqmsCC4SSJKArufcp0/hSYewLn7MQ8J43DWnCqwhvWNKC3b
	 5akcxCNwYi09nQDd6cOJX+BY3bEewHKhFz/baWsDuY7x5XkusNghBzMl1uGcBz+czO
	 iPqIj8HLrJ3Zg==
Message-ID: <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
Date: Mon, 16 Dec 2024 12:23:44 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 11:24, Bart Van Assche wrote:
> 
> Hi Damien,
> 
> If 'qd=1' is changed into 'qd=2' in tests/zbd/012 then this test fails
> against all kernel versions I tried, including kernel version 6.9. Do
> you agree that this test should pass? If you agree with this, do you
> agree that the only solution is to postpone error handling of zoned
> writes until all pending zoned writes have completed and only to
> resubmit failed writes after all pending writes have completed?

Well, of course: if one write fails, the target zone write pointer will not
advance as it should have, so all writes for the same zone after the failed one
will be unaligned and fail. Is that what you are talking about ?

With the fixes applied to rc3, the automatic error recovery in the block layer
is gone. So it is up to the user (FS, DM or application) to do the right thing.


-- 
Damien Le Moal
Western Digital Research
