Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA151586FE
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463242; cv=none; b=hGr7oTL4E1ygMbxl5wxhyYV6hkUay9GqP9EPqAaV0YzoP/xtR+PpQTD3a58/aZYloxlh5JhMGEtyZGl1xz+4myhuBUx3UTI+dfgh+NTnUHiHUvmB1QLI52MlcxqP3PklJTBkeA+dJOhTJY090Zd70crC9xy6klYlNPowlwhiglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463242; c=relaxed/simple;
	bh=gfZyNyUjnzWPQK0viZ96FTQ+tr1HhTN5RN1dDpo3I1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIAEFvo50TtMjL8qKw8tEZuvTb+mVCK7W6K1KTT96i5ii+IExS8I4TFZ07oNSGvbKKS0GY4oCywfX7Ic6F3fg8msJAXScS4fG17MZZlO3oW4hZWAKPCpn/KbL3ER909Ouz2uAQ15eHXB1wptdvd2m7nPodkv72QAV211SJue0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUB+5SKJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUB+5SKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F4EC4CED3;
	Tue, 17 Dec 2024 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734463242;
	bh=gfZyNyUjnzWPQK0viZ96FTQ+tr1HhTN5RN1dDpo3I1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uUB+5SKJOcsPwgH1NpyqBQ62IJbRduRbXhQ/SC+fNDCYNOlIto/yyGBxjz4Of4YCB
	 IFRfYefaYC6p/1jmaHs9jNfPFDE+C7F/BVC2TwktDnPx9R3B8VEqtBXMS0rXxp9bkn
	 dyX0H2RIvqHrsBLKnN3EfGXg98PBzhPkC5QksXXDq4dGRTefDl9anOjy9lBr340Pqa
	 TB3mS+RPMCfz84DmJy4Uo217LECDkau1+i1RcVn04xXY55SxtS+yKehAd0FxwxSeba
	 JABUXwIKcLrSAzyYgJ1XrGT3MfE0qix24ZJtFyWQngsZ6LCxoPWaGDyBXouiBNwKDe
	 WSp+My5DPtKjw==
Message-ID: <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
Date: Tue, 17 Dec 2024 11:20:41 -0800
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
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 11:07, Jens Axboe wrote:
> On 12/17/24 11:51 AM, Damien Le Moal wrote:
>> On 2024/12/17 10:46, Jens Axboe wrote:
>>>> Of note about io_uring: if writes are submitted from multiple jobs to
>>>> multiple queues, then you will see unaligned write errors, but the
>>>> same test with libaio will work just fine. The reason is that io_uring
>>>> fio engine IO submission only adds write requests to the io rings,
>>>> which will then be submitted by the kernel ring handling later. But at
>>>> that time, the ordering information is lost and if the rings are
>>>> processed in the wrong order, you'll get unaligned errors.
>>>
>>> Sorry, but this is woefully incorrect.
>>>
>>> Submissions are always in order, I suspect the main difference here is
>>> that some submissions would block, and that will certainly cause the
>>> effective issue point to be reordered, as the initial issue will get
>>> -EAGAIN. This isn't a problem on libaio as it simply blocks on
>>> submission instead. Because the actual issue is the same, and the kernel
>>> will absolutely see the submissions in order when io_uring_enter() is
>>> called, just like it would when io_submit() is called.
>>
>> I did not mean to say that the processing of requests in each
>> queue/ring is done out of order. They are not. What I meant to say is
>> that multiple queues/rings may be processed in parallel, so if
>> sequential writes are submitted to different queues, the BIOs for
>> these write IOs may endup being issued out of order to the zone. Is
>> that an incorrect assumption ? Reading the io_uring code, I think
>> there is one work item per ring and these are not synchronized.
> 
> Sure, if you have multiple rings, there's no synchronization between
> them. Within each ring, reordering in terms of issue can only happen if
> the target response with -EAGAIN to a REQ_NOWAIT request, as they are
> always issued in order. If that doesn't happen, there should be no
> difference to what the issue looks like with multiple rings or contexts
> for io_uring or libaio - any kind of ordering could be observed.

Yes. The fixes that went into rc3 addressed the REQ_NOWAIT issue. So we are good
on this front.

> Unsure of which queues you are talking about here, are these the block
> level queues?

My bad. I was talking about the io_uring rings. Not the block layer queues.

> And ditto on the io_uring question, which work items are we talking
> about? There can be any number of requests for any given ring, inflight.

I was talking about the work that gets IOs submitted by the user from the rings
and turn them into BIOs for submission. My understanding is that these are not
synchronized. For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X
> 1, the fio level synchronization will serialize the calls to io_submit() for
libaio, thus delivering the BIOs to a zone in order in the kernel. With io_uring
as the I/O engine, the same fio level synchronization happens but is only around
the IO getting in the ring. The IOs being turned into BIOs and submitted will be
done outside of the fio serialization and can thus can endup being issued out of
order if multiple rings are used. At least, that is my understanding of
io_uring... Am I getting this wrong ?


-- 
Damien Le Moal
Western Digital Research
