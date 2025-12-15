Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443032AAA5
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784653; cv=none; b=HaKo8nm2mekWgyAutFPcq2TGL0jyFMVd1zv2lXtHh/qJAlJrpZ31jSBYaKGyFy2kFCvzdd4EqDGFxBkwS/W203a2PlCqMrscOwv5vzx2WI8yzemkFPDaYpp5cwv9i4GjICb+AnKWSJSVMbQm0szTCngzzeiCpuPKRcuShQZMIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784653; c=relaxed/simple;
	bh=Ha2VgtNWPjoUsWeW6wPd6TMdaKevaV+ehx6hPL4DZQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mq/KsbSorURu6kl0ojpVawCuEseMlt+kVJ0nzpOjSlreT1tMZQt6+tepCZx8aQaOu6HNaLNcHerpGZnLzCh5qBtLVSR8eK9bP/iw7oJvjp7je9izxjcLTVwrNmJnVRE6ps9wcAxBB42iKcJ2fsp1durHlQkHyxm8QYbQaNWM/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOuHVoug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOuHVoug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A9AC4CEF5;
	Mon, 15 Dec 2025 07:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784652;
	bh=Ha2VgtNWPjoUsWeW6wPd6TMdaKevaV+ehx6hPL4DZQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fOuHVoug9t3cG4HXdbfVjF3kkT6Ci6UKuHO38Bpy03iyW20wiWhOfHCHu+inI3icv
	 poA23wPQvpBsnN7eOgMPsxtfWN4ru0ml9hra9oyV18EUnmsysfhbh6zKn25qwmKtL3
	 B551MFKvl5QqnFH1djwxhQKGcJgSDUXBpgq3nnJKRE/6UNlb4bCCgGKqnq5ErPryQ9
	 cRs8741lWkFE1Xae2+6MMWd1vOjBoSH+RTpgVPhT8LWSRuRYO2ZsT1E85E8SCmfLpr
	 y5TkXK8Qloo00aR2gvLeMisvKCwRZxiVG6xyUUw999uYdnnjAIfoNfeXeePuuGBRtz
	 pzYnrODibwOLQ==
Message-ID: <caa412f0-b4f4-4269-a584-288ad3fbbe3e@kernel.org>
Date: Mon, 15 Dec 2025 16:44:09 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] loop: convert lo_state to atomic_t type to ensure
 atomic state checks in queue_rq path
To: Yongpeng Yang <yangyongpeng.storage@outlook.com>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251215065458.1452317-2-yangyongpeng.storage@gmail.com>
 <66ae3b25-7d82-445c-b125-bc017d299c85@kernel.org>
 <SEZPR02MB55202AF5E15D574D7E157A9799ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <SEZPR02MB55202AF5E15D574D7E157A9799ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/25 16:34, Yongpeng Yang wrote:
> 
> On 12/15/25 15:12, Damien Le Moal wrote:
>> On 12/15/25 15:54, Yongpeng Yang wrote:
>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>
>>> lo_state is currently defined as an int, which does not guarantee
>>> atomicity for state checks. In the queue_rq path, ensuring correct state
>>> checks requires holding lo->lo_mutex, which may increase I/O submission
>>> latency. This patch converts lo_state to atomic_t type. The main changes
>>> are:
>>> 1. Updates to lo_state still require holding lo->lo_mutex, since the
>>> state must be validated before modification, and the lock ensures that
>>> no concurrent operation can change the state.
>>> 2. Read-only accesses to lo_state no longer require holding lo->lo_mutex.
>>>
>>> This allows atomic state checks in the queue_rq fast path while avoiding
>>> unnecessary locking overhead.
>>
>> Code like:
>>
>> if (loop_device_get_state(lo) != Lo_bound)
>>
>> is absolutely *not* atomic, since the state can change in between the atomic
>> read and the comparison instruction. So this is not about atomicity, it is about
>> not reading garbage from the state field if there is a load and a store
>> concurrently executed on different CPUs (that happening depends on the CPU
>> architecture though).
> 
> Yes, I hadn’t considered that before.
> 
>>
>> As Christoph suggested, using "data_race()" may be enough to silence code
>> checkers. Or use READ_ONCE() WRITE_ONCE() for the state.
> 
> Considering the earlier point that the queue_rq check of lo->lo_state is
> just an optimization, using READ_ONCE() seems more appropriate. As noted
> in the comment for data_race(), for accesses without locking, would
> data_race(READ_ONCE(lo->lo_state)) make more sense here?

Yes, I think it is OK.


-- 
Damien Le Moal
Western Digital Research
