Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C735203C
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003245; cv=none; b=UELKs0M3poN71z8A2JMjP1IExDx4/BCUGMJjeD1lDicdhIXcB97QcgDLQfgJHyHu2NJeYgfS2oUU851anSeuylnm/iMtJ6wgZzu11FYvO9DaUTDmDrlq0ZQyNyubpYhPsWRByxkmYbUMl50V9mmyWM3VMQVDKyEaq70ufXpOYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003245; c=relaxed/simple;
	bh=A94/tG6lKwQbFmTIH4sDEme76FVU1xOwfrmbZsKbPC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIysQ5kef/mbDtM2f1XIN3jj0Nj4rdiAwJnSw0feT5nyeVAVHIqwWNwAGipdrME/ynIx1wvew02sGHx1B3ZfmsAsUvQ6fiMr58C1tyCUkCTf/x2s7kzhCYGmdDahjWf6kS8IafJJKwwvy6fhLTcjEP4dcMG0CDNWqdkjaufENFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=U0xapiU0; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="U0xapiU0"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6969c864c89so7279055eaf.2
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780003242; x=1780608042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REoNE1HfXaVLqrZcttqszE/nOIthQd3PR5HKi6IwFgI=;
        b=U0xapiU0YMyockxdy40A6yiBs5y98rBhsm7KOzgP2z54qLQzrRsxz9GcwlasBHHU42
         WivFvQTIPomIou7Mgrm0+ugQJRKFTzHy7Y4iVZcuhcSviUgoriizCwwOlR+wyW21zj1j
         5WJoF27loXVx34OcWAkAL4DDkUNXIy66LBSZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003242; x=1780608042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REoNE1HfXaVLqrZcttqszE/nOIthQd3PR5HKi6IwFgI=;
        b=afI10rDo8fl0o99VeK/0maRkW9XvA/FkSidOm2Zp4Qdu+SmkOQ+LqPIE2MAQC+tGZm
         p19Is2htCY972Vb1mkqY2SC+qt+fLU4I4NQVFBhQBMIRzPT28XAWur7rqs674ViXeJK4
         YFLJQJcCCpMmJwU/8SwOD8xbea/nJ6nR4n9I5Tc4ryokGV5Q7RnS32IxZ6i5cDbAe76f
         VHjLdaFwdwYfFFcoHToDFuL4v2T8wEERQd2ToIT0IvI9TSALS0ij3zp5Kxs93xnGOnSq
         lLhYyQdM1gDvrQr/ouEjYREfOjsWL/asVgub2RcmSRasW5YTkr1wXVNtXndvpOUXAzib
         zkLQ==
X-Gm-Message-State: AOJu0YxarPumrDwfm6mTxA1D97IrR7pe3cIwUIXOi9GTl5oiJLXREI2h
	1xvtB/sO9qJ2fohU6FpMyWFEinhTVejX3cust60v5As4m31An4llzZzIYBwS/PUEPw==
X-Gm-Gg: Acq92OHL95ZGHj9h2/w6LLRMdDqF+kT3w4Ku96J/N9GZe0ZtbwJP1OU8/w/N1J07aqu
	zvJCwO8T4fki+ns7dpPtKe09Odx1/S0aYwcHO8JaQLJpBdNE8aZFo6AlZlHyuOLsljRxlnO1DCx
	bsjWyXe5lVPDO/6AVrmAddIlHqGCA8NR3zAMraHr22vPeA+RQI4DpmfLmaAhI3n42J8Vf9Sv4mf
	uJDPaDOxxsJwf1pNU6SFQhjuANPpHB/fIye9yBrVKQFCeIRzVb/tZLOZeL/HVHVjgfDpQqs+huA
	a9mOOXSUJsoraNTyYUhpqF3BARVtFwd4zcfGgxQMtFjarWCVRzIYyxN8/UhUEF/41aXZ8SAZauP
	9A5mHLeVHHTq9IgsYtz1jq0BgKL0N+Kqh73gpQdRXJru+fi10IuNDqIc1CQ2cNIoZUNUA3nbBfT
	uh0HJo1ArHqdyFN1R6fxtGQdKD2kXY
X-Received: by 2002:a05:6820:4dc3:b0:69d:fe44:b399 with SMTP id 006d021491bc7-69e03eff921mr174988eaf.19.1780003242288;
        Thu, 28 May 2026 14:20:42 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69e040ce50fsm118638eaf.2.2026.05.28.14.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 14:20:41 -0700 (PDT)
Message-ID: <01625bb3-1a91-4d2a-bfc8-7d34ce4b5e5b@ieee.org>
Date: Thu, 28 May 2026 16:20:39 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rbd: cast snap_count to size_t to avoid tautological
 comparison warning
To: David Laight <david.laight.linux@gmail.com>,
 Rosen Penev <rosenp@gmail.com>
Cc: linux-block@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "open list:RADOS BLOCK DEVICE (RBD)" <ceph-devel@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260528202151.136274-1-rosenp@gmail.com>
 <20260528220505.73eac71a@pumpkin>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260528220505.73eac71a@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 4:05 PM, David Laight wrote:
> On Thu, 28 May 2026 13:21:51 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
> 
>> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
>> (~2^61 on 64-bit), which clang flags as always false with
>> -Wtautological-constant-out-of-range-compare. Cast to size_t so the
>> comparison is done in the correct width.
> 
> If that warning makes any sense then the cast shouldn't make any difference.
> 
> Why not check against RBD_MAX_SNAP_COUNT - the buffer isn't big enough
> to hold any more than that.

I like that better.  Please do that instead (despite my
Reviewed-by provided earlier).

					-Alex

> 
> -- David
> 
>>
>> Assisted-by: Opencode:Big-pickle
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   drivers/block/rbd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 94709466ad19..b4ba51db9a28 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>>   	 * make sure the computed size of the snapshot context we
>>   	 * allocate is representable in a size_t.
>>   	 */
>> -	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>> +	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>>   				 / sizeof (u64)) {
>>   		ret = -EINVAL;
>>   		goto out;
> 
> 

