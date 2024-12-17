Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C813D891
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461466; cv=none; b=JZgkGCErK9Ga08kwGrHRgN3lcd0LOh/lYMW/PbwN+KR+Ojkr83m/vYphh/dUXbYAKI1LyeosYtMQbi8x5KKIDUSORkBB7QkmsbJUwsPUBOulmm2ciKTFbzvS8pg3HOa1kr0/uKf5RSlxOuT7pbnMUVw2+M6Ycr+Di9mNunzAzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461466; c=relaxed/simple;
	bh=9kyrpiGiFPwoz10lpPdIDGCKGfZCuWfQCK1npdzgm78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJVp4lRHgltoPnVhq+YagayS0LeqASKGWSicvC30fJglPPnRSfiTiqZvosbe1xE8da+FpjbO35JCwOLYUgKydN2yMDp9B0lD5P0eebpvZRkhhtPeBPOJPsRDj8D/RcWxY3MI5FvMOph+rcGLWZFdoZO5N3vd7QdjtI/20Iwa5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5s7NGuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5s7NGuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DB8C4CED3;
	Tue, 17 Dec 2024 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734461466;
	bh=9kyrpiGiFPwoz10lpPdIDGCKGfZCuWfQCK1npdzgm78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C5s7NGuVTz600KVGbXcLcjSzVDa6aBGzpSvpGqwCxESwpP7bnuR29NiwpEW2f3i0F
	 ctJ4XNY0+HwwCvarP9wzuUkM6aZsE6LISddjlzfLGD/KKIWxmNI7P3ahsc1qKEP3Kt
	 DCQz5U4j6ndWtUIzXd5pl5Ul9ghX8qUb7YX46rnZEXaWVDzEwSpgF/abRg9/UCvbVT
	 HWXwzhmO4EXb+JOLaB6YuJCsqt/5FJ/J8YOTf3bre3rl0p+fr2WZWhMfGP2+jMtkO4
	 wY92un0y2o29AZxI2tZjmC08KP8ZV72Punbv2SybahX31eOSckvDgFe8brRn9ALQZp
	 6qYBx7KodDGIg==
Message-ID: <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
Date: Tue, 17 Dec 2024 10:51:05 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 10:46, Jens Axboe wrote:
>> Of note about io_uring: if writes are submitted from multiple jobs to
>> multiple queues, then you will see unaligned write errors, but the
>> same test with libaio will work just fine. The reason is that io_uring
>> fio engine IO submission only adds write requests to the io rings,
>> which will then be submitted by the kernel ring handling later. But at
>> that time, the ordering information is lost and if the rings are
>> processed in the wrong order, you'll get unaligned errors.
> 
> Sorry, but this is woefully incorrect.
> 
> Submissions are always in order, I suspect the main difference here is
> that some submissions would block, and that will certainly cause the
> effective issue point to be reordered, as the initial issue will get
> -EAGAIN. This isn't a problem on libaio as it simply blocks on
> submission instead. Because the actual issue is the same, and the kernel
> will absolutely see the submissions in order when io_uring_enter() is
> called, just like it would when io_submit() is called.

I did not mean to say that the processing of requests in each queue/ring is done
out of order. They are not. What I meant to say is that multiple queues/rings
may be processed in parallel, so if sequential writes are submitted to different
queues, the BIOs for these write IOs may endup being issued out of order to the
zone. Is that an incorrect assumption ? Reading the io_uring code, I think there
is one work item per ring and these are not synchronized.

> 
> If you stay within the queue limits of the device, then there should be
> no reordering. Unless the kernel side prevents non-blocking issues for
> some reason.
> 
> It's either that, or something being broken with REQ_NOWAIT handling for
> zoned writes.
> 


-- 
Damien Le Moal
Western Digital Research
