Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988D2139B5;
	Tue, 29 Apr 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929492; cv=none; b=oNypvrdh8SeqeFrrTPtDgC1IFOlVCMm6pAyXQhbrX16xKwvw+VnWgL9uhiAOUjiZspS/Sc1X0m2hQJ7GaoGZs2jf3njkchs8pUANsqk4wNdLmFKX5ogYol7BL0YEI1NQQXHuybEyiRp/fO10N68469WsN4Otf4fzg9c7cfZKJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929492; c=relaxed/simple;
	bh=xk3oWXeWy8YInw8Vmi9C4eBVHDic5ghHnBrU5n9xG7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoHhJ2t3/9I4oqs9+85VgGItN2Y95cWGSjcHvXtGuP1pROGWUiRhCkelLANAIn0mgVvxzOUH0XQIr9DUK7nd7FZ+izRgV7XfF7pxPREFibC6oKA77ZjKn3d798yiTWy3W3BYoJbsUXbNjqu2XQPV5Nby2dDES9RDreQ0orPcKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs+Pgt6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs+Pgt6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E1AC4CEE3;
	Tue, 29 Apr 2025 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745929491;
	bh=xk3oWXeWy8YInw8Vmi9C4eBVHDic5ghHnBrU5n9xG7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cs+Pgt6M0b0If0PrRtZ/To65yN0SomC1yTAArH9VCGFnoH68SmG7Z3968JJq1T/oE
	 sv33PFyFwCiXFKaKVplc4IUaZg9DSxZbqJtluokFuxyK8Bu0ntT7sliFeg+JedyzgS
	 O6ntkaXhRvr1AoHXXPG1Xq6OwaWn9QCslmFS/K1sjLP3MkqrazH/tEx03EW5kyBDQb
	 JuK4dtibSC+11lT2eG1xcrBqjsxZnqrmBhEbR/Q4dIWIjWG4DftwxyLzufLIjjguE/
	 qZ9KQzxp2E6c+UKa/v3nieKV/g1AjUTIyOq1EP6HbJrbatP8QbJh5ECQ4yP+f0hk3g
	 kKgxm6b/VCdsg==
Message-ID: <65ed2ba5-3f29-4cfc-8181-29d45edf935a@kernel.org>
Date: Tue, 29 Apr 2025 21:24:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] block: remove test of io priority level
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kexin Wei <ys.weikexin@h3c.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429082934.GA3896701@bytedance>
 <adca39d3-04fc-45f5-8e34-0d06714f0ff9@kernel.org>
 <20250429114428.GB3896701@bytedance>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250429114428.GB3896701@bytedance>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 20:44, Aaron Lu wrote:
> On Tue, Apr 29, 2025 at 07:50:11PM +0900, Damien Le Moal wrote:
>> On 4/29/25 17:29, Aaron Lu wrote:
>>> Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
>>> definition"), the io priority level is masked and can no longer be larger
>>> than IOPRIO_NR_LEVELS so remove this now useless test.
>>>
>>> The actual test of io prio level is done in ioprio_value() where any
>>> invalid input of class/level/hint will result in an invalid class being
>>> passed to the syscall, this is introduced in commit 01584c1e2337("scsi: 
>>> block: Improve ioprio value validity checks").
>>>
>>> Reported-by: Kexin Wei <ys.weikexin@h3c.com>
>>> Cc: Damien Le Moal <dlemoal@kernel.org>
>>> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
>>> ---
>>> Kexin reported a LTP/ioprio_set03 case failure, where the test would
>>> pass IOPRIO_CLASS_BE with priority level 8 and see if kernel would
>>> return error. Turned out she is using an old kernel header where the
>>> change introduced in commit 01584c1e2337("scsi: block: Improve ioprio
>>> value validity checks") isn't available. During troubleshooting, I find
>>> this priority level test confusing and misleading so I think it should
>>> be removed.
>>
>> What is confusing and misleading about the fact that we support only 8 priority
>> levels (0 to 7) and should check for it ?
> 
> I meant when I'm troubleshooting this LTP issue, I looked at this level
> test and had no idea why it didn't work.

OK. I understand the "confusing" now :)

>> With that said, the test is indeed redundant for the BE and RT class because we
>> have:
>>
>> int ioprio_check_cap(int ioprio)
>> {
>> 	int class = IOPRIO_PRIO_CLASS(ioprio);
>> 	int level = IOPRIO_PRIO_LEVEL(ioprio);
>>
>> And the macro IOPRIO_PRIO_LEVEL() will mask the level value to something between
>> 0 and 7, always. So necessarily, level will always be lower than
>> IOPRIO_NR_LEVELS. So please reword your commit message to explain that rather
>> than describe what a user may or may not use when setting an ioprio field.
> 
> No problem. Does something below look OK to you?
> 
> "
> Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
> definition"), the macro IOPRIO_PRIO_LEVEL() will mask the level value to
> something between 0 and 7 so necessarily, level will always be lower than
> IOPRIO_NR_LEVELS.
> 
> Remove this obsolete check.
> "

Yes, looks much better !


-- 
Damien Le Moal
Western Digital Research
