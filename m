Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD791A58D;
	Fri, 10 Oct 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073395; cv=none; b=GsCrTMfVBh/U4Ysn4ac0906UUCHT8K/MlIa2GOlCNfHdPk7VxqbnbOci5s5sOtLR+JroiMVXN1BFgpl3BzHxbECbBIcp6T04pS7aqApoBsi5hS31eKEfPoHZ/XxUOiDsgs25bRsH4bJg+p5iU743FG3TF5ewAJNWO06KVxS4NMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073395; c=relaxed/simple;
	bh=tlGkaZi9TU7+xWd2v7EZav7T1tY41k41pnXLAy9TVXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2paFGHksy8UL3/e8cD45ntW6RYg1L1cfMdyaZQuQR6cAk4Beqa4z8OG5FR2yqq8+3dCdvHX+hONH0RAd1m9f0tnKwFGwaCDknwPZE7hNIzT0oMzUsS1/nFoAvBc5A6QRq7ibFz4tYPeQ1X5FqiQKa8Khy5oebK327fYnJJnRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHQhNdVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHQhNdVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5C5C4CEF1;
	Fri, 10 Oct 2025 05:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760073395;
	bh=tlGkaZi9TU7+xWd2v7EZav7T1tY41k41pnXLAy9TVXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IHQhNdVBuYnZBlnpaSY3B2/XLKzT06fK/4nCzYSB2vH0LmLKEK/l+ws8svdpRE1Wk
	 TB979SGESje7/2CxTGDKWq991Kvk9qQBLZ2Jn1WFPPbL+sXCfzuxKa85ZD3nccqXEr
	 6kIgI4swODdflhUp0ALHGZj9nhy1sPluFm0STuXlmEMyiGVYgRLyObzzrrnhO6oUEw
	 vaDiepHQxUNHavzyJ9n3S3w7ZNssOeIlDGaPyW+yePXPsHlZXGK2Y0CfAwyzC8STby
	 IqbFjbw29fUAAcA04wghJDPNwSYphjfg9umPawMgy14ZxReILo1MwQkAnuYf1UVYeT
	 X/Nf66aW4H6dA==
Message-ID: <57db4b09-b44c-4899-8229-e3e71cd70f14@kernel.org>
Date: Fri, 10 Oct 2025 14:16:32 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/mq-deadline: adjust the timeout period of the
 per_prio->dispatch
To: Bart Van Assche <bvanassche@acm.org>, chengkaitao <pilgrimtao@gmail.com>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chengkaitao <chengkaitao@kylinos.cn>
References: <20251009155253.14611-1-pilgrimtao@gmail.com>
 <db87a85d-e433-4daf-97c7-d5156849db0f@acm.org>
 <bb362d12-b942-48f3-8414-e859cebb8862@kernel.org>
 <8406f13d-d8be-4957-b1ec-6996f19d32e9@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <8406f13d-d8be-4957-b1ec-6996f19d32e9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/10 8:40, Bart Van Assche wrote:
> 
> On 10/9/25 1:21 PM, Damien Le Moal wrote:
>> There is still something bothering me with this: the request is added to the
>> dispatch list, and *NOT* to the fifo/sort list. So this should be considered as
>> a scheduling decision in itself, and __dd_dispatch_request() reflects that as
>> the first thing it does is pick the requests that are in the dispatch list
>> already. However, __dd_dispatch_request() also has the check:
>>
>> 		if (started_after(dd, rq, latest_start))
>>                          return NULL;
>>
>> for requests that are already in the dispatch list. That is what does not make
>> sense to me. Why ? There is no comment describing this. And I do not understand
>> why we should bother with any time for requests that are in the dispatch list
>> already. These should be sent to the drive first, always.
>>
>> This patch seems to be fixing a problem that is introduced by the above check.
>> But why this check ? What am I missing here ?
> 
> Is my conclusion from the above correct that there is agreement that the 
> I/O priority should be ignored for AT HEAD requests and that AT HEAD
> requests should always be dispatched first? If so, how about merging the
> three per I/O priority dispatch lists into a single dispatch list and
> not to call started_after() at all for the dispatch list?

More generally speaking, I think we really should have a single dispatch list:
the scheduling policy (per prio with aging, and either lba or fifo ordered)
decides on what request should be sent by adding them to the dispatch list. If
we reschedule again requests that are in the dispatch list, we end up with a
very complicated and hard to debug scheduling policy. Kaitao's patch is proof of
that...

And for the at-head requests, it is indeed debatable what to do. We could be a
little intelligent about them and do a sorted insert in the dispatch list based
on the requests priorities so that we do not have priority inversions. But that
feels like an optimization. I think that the most common case for at-head
insertion is (rare) requeue, no ? Have not checked.

So I feel like Kaitao's problem can be fixed exactly like you said: use a single
dispatch queue and drop the started_after() check in __dd_dispatch_request() for
the dispatch queue.

-- 
Damien Le Moal
Western Digital Research
