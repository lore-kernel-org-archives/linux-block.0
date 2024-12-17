Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8110148850
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464934; cv=none; b=bsN+fBJhEPt7Gv0QmKm1KAL3G7K6f9JEMjn/LeXzfqsUo5HwJgFinrC98BCtmN4qWqmTLLt8QcXMzWyhNBRhFuse/OWcC1KfKA9rQ3+mWtrZFBqu8vx9X0TW0aT7CIUcEV097VyWjxSNbHOC0DCALedi1OjeR8os+ZyValeNX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464934; c=relaxed/simple;
	bh=ZnU5Hvzg6tqg8GM62I/RjulCEqdCaU/9/ClsSboQmYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKl9gvVR6/mpWMfQ9Ap2YW2BIFqbQJP2dwT8TCIQsV9dZPw2DDEzTuYOLzFwWLB1/hJ53VzlUzN3XScuIj8S/aKuzAJimUrS4AR1IzHNBRssivdVvoZMxRPPFsOFwd4xuwoKpcR3418XcA+mnYY8Y3EwP7bsQ843NkC9ZOK/7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK3ouh6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK3ouh6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61640C4CED3;
	Tue, 17 Dec 2024 19:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464933;
	bh=ZnU5Hvzg6tqg8GM62I/RjulCEqdCaU/9/ClsSboQmYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RK3ouh6fH5jfPTnUwBf6f/WiFRU7Y8ztB5yAvNVYp8EKqc7t8X5/EMxEuCTJMbsNA
	 kDOPw4+TS5SJcFGTHePUD2WJ4+aa2H9hFKibdiYptz/TzwD+jFakE6FyIPCgXQV3jb
	 8jQkxsH055ibobaCC6G1fQRE1e+emJYg7S7PjjnF8hPeLQL+LUIkHLy5UPgBQmuW9Z
	 APRE2ISZHMa1xOzX2VQrl+ajw/KMjmMcG8O2WUqAPjCTdLB4xKmQqXPkPQPmCmuOVx
	 726Gqivu7+rbTttG8l7WOm+mcIzv5IUvxdEyEYvS/W967btAYGeRrcAEOGfNKAsz4F
	 ZM5QSLYfHluuQ==
Message-ID: <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
Date: Tue, 17 Dec 2024 11:48:52 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 11:41, Jens Axboe wrote:
> On 12/17/24 12:37 PM, Damien Le Moal wrote:
>> On 2024/12/17 11:33, Jens Axboe wrote:
>>> On 12/17/24 12:28 PM, Damien Le Moal wrote:
>>>> On 2024/12/17 11:25, Bart Van Assche wrote:
>>>>> On 12/17/24 11:20 AM, Damien Le Moal wrote:
>>>>>> For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X > 1
>>>>>
>>>>> Please note that this e-mail thread started by discussing a testcase
>>>>> with --numjobs=1.
>>>>
>>>> I missed that. Then io_uring should be fine and behave the same way as libaio.
>>>> Since it seems to not be working, we may have a bug beyond the recently fixed
>>>> REQ_NOWAIT handling I think. That needs to be looked at.
>>>
>>> Inflight collision, yes that's what I was getting at - there seems to be
>>> another bug here, and misunderstandings on how io_uring works is causing
>>> it to be ignored and/or not understood.
>>
>> OK. Will dig into this because I definitely do not fully understand where the
>> issue is.
> 
> As per earlier replies, it's either -EAGAIN being mishandled, OR it's
> driving more IOs than the device supports. For the latter case, io_uring
> will NOT block, but libaio will. This means that libaio will sit there
> waiting on previous IO to complete, and then issue the next one.
> io_uring will punt that IO to io-wq, and then all bets are off in terms
> of ordering if you have multiple of these threads blocking on tags and
> doing issues. The test case looks like it's freezing the queue, which
> means you don't even need more than QD number of IOs inflight. When that
> happens, guess what libaio does? That's right, it blocks waiting on the
> queue, and io_uring will not block but rather punt those IOs to io-wq.
> If you have QD=2, then you now have 2 threads doing IO submission, and
> either of them could wake and submit before the other.

That sounds like a very good analysis :)

> Like Christoph alluded to in his first reply, driving more than 1
> request inflight is going to be trouble, potentially.

Yes. I think the confusion is with which "inflight" we are talking about.
Between the block layer and the device, zone write plugging prevents more than 1
write per zone, so things are OK (modulo bugs...). But between the application
and the block layer, that is not well managed and as your analysis above shows,
bad things can happen. I will look into it to see if we can do something
sensible. If not, we should at least warn the user, or just outright fail using
io_uring with zoned block devices to avoid bad surprises.


-- 
Damien Le Moal
Western Digital Research
