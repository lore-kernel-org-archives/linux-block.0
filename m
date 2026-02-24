Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40B23EA99
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898998; cv=none; b=CPfXlH7Q4cjmtVVaq9fAZuE/LNhc3DFgbroD8Ik/1oYsEFO2PYAXOUY4SjFvRDepaVVg8ZKEuUFHIDHS6udRiB5sFOWrMXDwYFY6KHtOmWolXz+udSR9zd1FxcyaP2Ca8NaN+VWwje7K46RBuAsxEN8ytsZmpyFUhA4pbiEs0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898998; c=relaxed/simple;
	bh=U0fb+dZnBsuWlG2O02xs2MsxookMOuf10kc0oTrYYAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hIpsQOZgzak64XDujSYihNJdzovQANff9ooLs9zj/f3JydHThKVQBvQqg7YzfBwtgWqbPzl2cvqxQVaz/I64cxmLGCvwhgSLM4cvN9I/DlGtya2gVuCs3tRYe8fsDiuNEJuRBPCy2GtB3GGVKFimVySWEzjDgV4i8tRjs4AOCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCSA53w7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCSA53w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7488AC116D0;
	Tue, 24 Feb 2026 02:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771898997;
	bh=U0fb+dZnBsuWlG2O02xs2MsxookMOuf10kc0oTrYYAA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LCSA53w7CeA3aiQvhIwxGRj/zOcLWLFmX3mOQSjeJjN1rcXKOxShjJBk8rII5iiJx
	 EssP7ta4RNtkNi6Rl6Ydnejx6ank0NRYxSn32v8jL76oh/1NJLW9Ix10bc3YbdtTLd
	 f81easSFVNdWB7x2VswYoKNEFaEJOlkjd52jB/MYdodjjdY/NG8PbKgBWVmviwrD2b
	 sGfatDMKr/WgKxL4b3TCy2fa5do0pk628yBQyWz5ZXaVHgx0vI5ILvBfNGLfVmV/DI
	 LPp/d5m5imQQxeusjqqJY9vidD29YjYvEKzz/RhBVMcIGowv+6WMrtnbGbf4Bohvlu
	 I+RERZfYV5+xA==
Message-ID: <4e63325e-4793-400f-a4fc-dd3c0d6bf04d@kernel.org>
Date: Tue, 24 Feb 2026 11:04:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block: remove BLK_ZONE_WPLUG_UNHASHED
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-3-dlemoal@kernel.org>
 <65ac9a0d-6b9a-4591-9bf8-c513d3073d28@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <65ac9a0d-6b9a-4591-9bf8-c513d3073d28@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/23/26 8:48 PM, Hannes Reinecke wrote:
>> @@ -603,14 +595,14 @@ static inline bool disk_should_remove_zone_wplug(struct
>> gendisk *disk,
>>   {
>>       lockdep_assert_held(&zwplug->lock);
>>   -    /* If the zone write plug was already removed, we are done. */
>> -    if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
>> -        return false;
>> -
>>       /* If the zone write plug is still plugged, it cannot be removed. */
>>       if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
>>           return false;
>>   +    /* If the zone write plug was already removed, we have nothing to do. */
>> +    if (hlist_unhashed(&zwplug->node))
>> +        return false;
>> +
>>       /*
>>        * Completions of BIOs with blk_zone_write_plug_bio_endio() may
>>        * happen after handling a request completion with
> The order of the checks have changed here; not sure if that matters,
> but as it stands it's not a 1:1 conversion.
> Maybe move this check up.

Will do.

-- 
Damien Le Moal
Western Digital Research
