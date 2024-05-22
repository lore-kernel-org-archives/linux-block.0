Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490A3716D
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401640; cv=none; b=SLB+Wfcc5n5Gx265aoIjjFxDha6wS+6W4IB5E4tt3vQUdNCaS+2ws7VIFZ0EbH2Nn5jEwWX+ckPbgxwJTTKiFz5CprWdc99Weyo5dLn9SnGEauf+XH2jdwUuLeINjmUuUt0brcKVECXscSIjEFpq4jdc7XdQ3oTYa46vOt1PqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401640; c=relaxed/simple;
	bh=5NMsDfY6VTABrDzPgIWhs/3DIYKZtHGT8JJUJOlXrjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbD5KPdCj/jtTQQLH2C9oZVcW4I14i2Y1GiAkRJathpqeYW+kzjCP6vpI1GDXboJ2WP6QOCgeWsz1RCICbzekkpOjVnfWTfYR0hV8viipoC5bJMnVpLE9jrG6wSAU9sKLOmsvIwyIWYprOAgBrRn3qKTHtS0NBHALmxfduj7BC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sDFdTlS8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sDFdTlS8"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d9d591e660so15480739f.2
        for <linux-block@vger.kernel.org>; Wed, 22 May 2024 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716401636; x=1717006436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGhFk+6Mn+aFTeEhhRU2V2oXQp27/bTpuMCUZ0uMfqc=;
        b=sDFdTlS8EOzGAOHHLTGwbBbK8QPgMUI1LZJ/aFXTmJNHuh4Dhj0rEeTGzYW723BxQl
         jgVZS00+3VaDoeFk3sCytEgvFrDBeqo8PntiCMXpDT+ybg0X3SGpO414j1ejYz5KX7es
         6ZG+NisAD20kc4hPuuA+F9f4tHIkPDwHEH1yWpRfd6wKhjp4xjLs1E4MjtVnzsMd6L38
         z2Pk6QaNvnWl/69X1IRe+Iuj+oLH5uNbp7saNfsltDLwIMgcYfjG4dMX9/hCrHmClCAB
         NK1yG/BKHJipV3iu6HuPf5EeANiqFALYgLQp2mO6sXR2nZQ3YrsHnfqh5/M7uCyRhu97
         Sbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716401636; x=1717006436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGhFk+6Mn+aFTeEhhRU2V2oXQp27/bTpuMCUZ0uMfqc=;
        b=RTZ2L3K4cqITMflVQ3Wv9enix+8IYCzXlR+WCd6+uoFXxpkMkFol6Sg21v7oicQ/7M
         S+zb0BM/RMhgXyVs77X2pze99izO1mKJgoB3S+tPxAEMt6Ria2LwQXoSNkAFFUQBm+Gr
         w0zqB3KYSTUd/s/w/BcWiqFZrSA7nE09Wk2xWysVCUGjPbt2DBFiYIVEF5U2Ni8861B2
         q8gq3oHPTrFl3Y49j4HzGIM4ymIHoQNAGW7syVgYZaWve8K9tyfPfforg9EqbUuBlnf/
         o/RJxJmPbxr7e+DoPYNWuBJcvrrhHG8xblJH63OOOuT2fYGh6FC+3bI2BoHySvwzxTKG
         0txw==
X-Gm-Message-State: AOJu0YwrBtd7yD/wC2NQ0AFgh2a6WtfWfoygUC7dkk1gIpWzD1lJcLAT
	hlYp8uOFQ/jJbU10lQvCw49Enj/cF7kNXaXhTIv7CEOgyOmtQXbo8xI6HlEHMPM=
X-Google-Smtp-Source: AGHT+IG5ECb2ChN21OliaANFfuAG3aNrPryJwmc8jxQsxZ2EjfcJpXARxHMFz1c3VkuESsX03wb0sQ==
X-Received: by 2002:a5e:cb03:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e38b2004fbmr306212539f.2.1716401636350;
        Wed, 22 May 2024 11:13:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376dc51esm7796324173.122.2024.05.22.11.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:13:55 -0700 (PDT)
Message-ID: <d9795483-ef64-4fd6-be71-a3946ae8fb3e@kernel.dk>
Date: Wed, 22 May 2024 12:13:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Bart Van Assche <bvanassche@acm.org>,
 Yunlong Xing <yunlong.xing@unisoc.com>, yunlongxing23@gmail.com,
 niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
 <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/24 12:12 PM, Bart Van Assche wrote:
> On 5/22/24 10:57, Jens Axboe wrote:
>> On 5/22/24 11:38 AM, Bart Van Assche wrote:
>>> On 5/22/24 00:48, Yunlong Xing wrote:
>>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>>>>            set_active_memcg(old_memcg);
>>>>            css_put(cmd_memcg_css);
>>>>        }
>>>> +
>>>> +    if (ori_ioprio != cmd_ioprio)
>>>> +        set_task_ioprio(current, ori_ioprio);
>>>> +
>>>>     failed:
>>>>        /* complete non-aio request */
>>>>        if (!use_aio || ret) {
>>>
>>> Does adding this call in the hot path have a measurable performance impact?
>>
>> It's loop, I would not be concerned with overhead. But it does look pretty
>> bogus to modify the task ioprio from here.
> 
> Hi Jens,
> 
> Maybe Yunlong uses that call to pass the I/O priority to the I/O submitter?
> 
> I think that it is easy to pass the I/O priority to the kiocb submitted by
> lo_rw_aio() without calling set_task_ioprio().

Yeah that was my point, it's both the completely wrong way to do it, nor
is it a sane way to do it. If the current stack off that doesn't allow
priority to be passed, then that work would need to be done first.

-- 
Jens Axboe

