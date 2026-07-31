Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CB41D4EA
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520936; cv=none; b=mGE317Bp2y+hoLkSR8/7Hs/Crmi6OTXY/27wjtT4rbjrl1hJYD6ItGr8Y8GfnjcgbkF7h9PIS+ARR1nLSVwIqOFhDBxeT2BMD0FWF4yUVfrIM7nA/jtr29MWvwbn8WwV9ZFowIG65dI7KXnNl9hb2PlWVydd1hQGNFNf47sJMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520936; c=relaxed/simple;
	bh=xPA43HzwxkY7Qxq/d6k8D+fGgmC2gCB7xqunE1rqOOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXBuwMkGnD90vl/9+22Onn+8RvU2SbeAf3mBRWCE5LeFjmKHtPk/Z09FqhMkLQlplPiMMWn4fU904+V+OjnjMEfVQkTAt/BoS1830hpzsDioUBOJfbWtmoq/7Oz/jqW0Si9Vugb6SSwcwc09RvRi649ULHnZsKecDDmk2ypWpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag32Jnop; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag32Jnop"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e7109321dso809816a91.3
        for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785520934; x=1786125734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L97dPN/g4t42zl5T+o5UNRmW4jMUJKmjh27KUg9Ytxw=;
        b=ag32Jnop9Qx9/hRbwVHCUg4ojVPFlQL4Q8MXzyGlOCd+rcUhZzmmlgEO3hieyU0hfP
         jW7BQBGqRXobDixXQB6od5MX6cIWVLKjXYdvAW0BnLoPO10V/QSy9G+imGE8ijCUjkEQ
         JDLrf5OrX0O2wq97/9GCJLd2DZk/UT9X18Vvm1Mc5u3OgDVh4ixlvGM+riWQ/jR7w5EC
         0qN6bewhvHevowTsCi4LIMklmL7sozrswuxMtKUw0bLr821b2vVzqD+q9+DLUTa8jnjl
         OPzTRz90Zo6shQJxc7BbVFbBMlfP5kKzsfDJGTU67IpmCV0Bixm9XHkKaqM53W6BQa/c
         MKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520934; x=1786125734;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L97dPN/g4t42zl5T+o5UNRmW4jMUJKmjh27KUg9Ytxw=;
        b=FPm/bISyO7giWKbqsWz2IdTHjroPcrwZcRFzKt+Xz+f9JcyLPGvvobRGMotuudbCIt
         LbAm0AoiBM+7MTqI2PqG6ll+GxVTE3rmLtHE2De3D9xXCqUIuRm5AVozMbQX6rDY3pPV
         DW2gaix6ph29aKFE+TWfdOYyqH1rtYNmaXJL5B/i1QKpdPyEX2cNZFJnAfAGU03eTviW
         Jsgon4sChnzHq1YyurOfGhfBnAZgbkhwI4FZIIbIwl3SG8TYe5S9xPtAYHTrxNLxtlcp
         XRnrQWZKthaR/RjHOEn5wUQHMdLFfupucP3+VhQlEvh2weRI1RI4Rmmv4hpTGGfoArfI
         fdbQ==
X-Gm-Message-State: AOJu0YxKQ3S6eWBQs78bk80xv+QIyTaDToPpPI/JR4MqP4Lq9x2gg/d/
	JvGlnPubt73CA85DN3ztAEXZHV6RhPm+zf9TTfyhtZ3LB6yqfEC+yT2lkDAlShaviok=
X-Gm-Gg: AR+sD11Z1p3efDpqydvw+OSdgAzmv5jU4C47qLJAnXLqCm7M3UVYtlUXvnxqO4JxqhA
	VAkWK5/zyalxWsF5yfHgr9vMEDbZFEj8cN/m/ULbQNr91SUpl1FxcuKe7eNHOFvUt+iQEFV79mQ
	qi6lL6F9sr3okHqAEgTphGXNCKRjmKuGitcz5mvnofIMBkdqnVvpm5GbPdJPRi3AZvVLBRVNel9
	RzIXl0Tv6SSp86ADU+SXrvZojlIDVt7g268wV/yi5DUKFp0gl1aA8BVcwhtxVZFyr9zupjTzjoF
	aJCIqotJXItm+ex1DBp8MNqNPSkih7aJaG7wycDXmqZbI9jWScHg2rDfQFjfhra31PKGU5tGV6g
	FdFO8uQckjSZ2mI8f3HEFaIns3hls94fBzGUoPFRhjxrIvB8GaXVyB5K7noSnZ8Evj/HAedu1m/
	1NrTrkVJqKB4hFch0SQHYrl4zgcZ0t/WdFBjCywUR8UOpaIYuhel7sPuu53W6hdRuy4R6SEeoEL
	sB9iJYHkVeZIqVtc6cX/oCdp4q8JyHLkWluYBLfHuCTJoQFTkuUWA2JfA==
X-Received: by 2002:a17:90b:4a42:b0:38e:3a8:2374 with SMTP id 98e67ed59e1d1-38fbc51610emr632152a91.30.1785520934322;
        Fri, 31 Jul 2026 11:02:14 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:f2:8f2c:d78f:adf4? ([2400:79e0:1203:64b0:f2:8f2c:d78f:adf4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b0f82csm570584a91.2.2026.07.31.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 11:02:13 -0700 (PDT)
Message-ID: <b8047ecc-6cbc-47ab-94a7-0c2ce777d100@gmail.com>
Date: Sat, 1 Aug 2026 02:02:10 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-wbt: Always change enable_state to MANUAL when
 setting latency
To: yukuai@fygo.io, Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk,
 guzebing1612@gmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260717125021.88825-1-yizhou.tang@shopee.com>
 <2c695292-2fa6-45c1-86e9-d4bf0100debb@fygo.io>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <2c695292-2fa6-45c1-86e9-d4bf0100debb@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/7/26 2:51 pm, yu kuai wrote:
> 在 2026/7/17 20:50, Tang Yizhou 写道:
> 
>> From: Tang Yizhou<yizhou.tang@shopee.com>
>>
>> Commit 1e56f30a73f3 ("block: Make WBT latency writes honor enable
>> state") compares only the boolean enabled state in the no-op check.
>> Writing the current latency value while WBT is in WBT_STATE_ON_DEFAULT
>> is therefore still skipped, and enable_state is not changed to
>> WBT_STATE_ON_MANUAL. A subsequent elevator switch to BFQ then disables
>> WBT through wbt_disable_default(), silently discarding the explicit
>> sysfs setting:
>>
>>    # enable_state = WBT_STATE_ON_DEFAULT, min_lat_nsec = 2000000
>>    echo 2000 > /sys/block/nullb0/queue/wbt_lat_usec  # skipped as a no-op
>>    echo bfq > /sys/block/nullb0/queue/scheduler
>>    cat /sys/block/nullb0/queue/wbt_lat_usec          # 0, WBT disabled
>>
>> Skip the update only if the stored latency matches and enable_state
>> already equals the exact target state: WBT_STATE_ON_MANUAL for a
>> non-zero value, WBT_STATE_OFF_MANUAL for zero.
>>
>> A write that passes the check then reaches wbt_set_min_lat(), which
>> performs the actual transition to the MANUAL state.
>>
>> Rename the helper to wbt_lat_changed() to improve readability.
>>
>> Fixes: 1e56f30a73f3 ("block: Make WBT latency writes honor enable state")
>> Signed-off-by: Tang Yizhou<yizhou.tang@shopee.com>
>> ---
>>   block/blk-wbt.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
> Reviewed-by: Yu Kuai <yukuai@fygo.io>
> 

Hi Jens, if there are no further objections, could this patch be merged?

-- 
Best Regards,
Yi

