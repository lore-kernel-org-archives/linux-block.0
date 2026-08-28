Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094D3E95B3
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906306; cv=none; b=D4u5EWqerp67YHrWsPXgIiXj2b3muWif9xi+Uxrv4IvZmjhggb+Es+TqoczYlARBhC6ehYkn9kOH3F94+8M50YVJUr299qhhXOK028wjtVJ9zMkMw9zlMLtVe5qIp8Iz2b0d8x5GupyuMhwejeNlplGL0SqNqXdx7iAyv2vuJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906306; c=relaxed/simple;
	bh=EhykqiPJLq47BZjoeaxdikIclxj7Y5+ukgWZVwOFnkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xu5KiliScsu0yadmVrUsli7F6BjDPCnXNJo2YVy1IGE2Qr3zPI+R0sWagea8ZpGoWG7cYCh6ileaugv6UNOSJRfVEstkWo8CoL2OlAh86qr+EeYIfABWK4NKVNXI6ccqgMWpEDSXr/NFw3TMV+RObLlIQ69+Pd0irlcbcRQ10w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=advSsF6F; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="advSsF6F"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d71e253c90so7172465ad.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906304; x=1788511104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fR5H0F/Ck8m7YL57qzikpM3HgEJcl+V81mzJ0tARUcA=;
        b=advSsF6FPsjoIWWLauCXCMld/EDUHWEyVP1WVajZ7P0Yr4VAN+0Yiwi9mI+v6QEEWP
         Go9VyktEazvpIHx2FQDYEYqrCqeCVy3+qMjSYxwWD3EjDWRdCZWle5ZADSA6j5ET2mPk
         x/zmPY2Gpd3Su7msKW433OMUYT8tRRbVAirbSQzgVGCBlZtnrfZr2G7Zjbn8eEn+FgoB
         XVSXojF9BPpUu2158Ne50QylMI5gbai+d8ItBViR81ift83b3ELO4FCfco2yQcHx2Jnd
         c6v9F0smXmQdAhYX8IirU8krtAhWECLWLQav5XuvaponaVoV+MPdFyOUt/XJDlq4741r
         EnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906304; x=1788511104;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fR5H0F/Ck8m7YL57qzikpM3HgEJcl+V81mzJ0tARUcA=;
        b=S/KO+JMBEtAsCEILtLyzD3ZqW9UXO/o/HJLqovEe0l8/NKVRLRH3TAatDcU0nszHlO
         zRWsZakLlz7tbAB3+zfTWk8xvZZ4FEPjfN987hKtHBuQGgm0czRdMSl6eF+uwtVQ23lB
         TukmZnSf3nWb04b4opJShbJMF98rxiwo75W4b9RXH9r2QEEt0yfYdr62xyAQl3U7NAiP
         PuCH1mXDHIvNOH6Ou2X1DS2+qT8OQXWXS/zVCTEpjk797eOMy4LTLN5rJGd9Lv0fQHnc
         KFbL7vKW5dLBrMTKcdXY7unMpeUsiBEhzjSLa4+nGPry2bUy98uiccgb80YOKYbTo+MH
         OMpw==
X-Forwarded-Encrypted: i=1; AHgh+RqKaOqgHoWbfGiLR48iQL7jgHgQ7qdXY+pYT39HYgupzK715SynzF3xLQe4YGiMz9ne11Gy+dk5dPcXxg==@vger.kernel.org
X-Gm-Message-State: AFuF++mpMZ8Wq0xtQ7dA+FTa9UqzSerKGwAoG4xnIN17Xe8Qgdg3Kp/Y
	CvMYyshSJQrNvXzgnOzc/HmWmH9n2/grUqUanlSssNRDHZv9VKG/AUiz
X-Gm-Gg: AR+sD12C9ie3d7FolaJ0mU9Dq2iY7qff3R33TvHt7xwoXwBTXpyByievhOiyfjj35Iu
	rPlLLjGbaRDEheJahav+A7aghlOlJnzfC9qwS4H5Zx0gJa11zoQwLuM4FLYEIz/tb6Suh5Ep5B7
	uzrA/xmQVlJoPgaNE+H4b5C08hVV/Mb4ZSMR4VWoBURotrE/o7MCoQzXv50SM8AP2tlDpXAwGFQ
	72WRmKgjCOUw5oRyEhRoZUHIVgDQCaFyb/qISYk5jDPU+djKoSYsGwmWPMJJjL1F7RurlX3ejp/
	dEchLGCcxYA+YZWf159+WQtNOMSqXAz44/JprYrnWqW46nE+4WhzU9T0onx5/7965PTBDDB6kk9
	IAM3KiEAy9DNbrMmGDcZw0XvQxcr7CIwZXZxzW5PLpSogHX/hUgDOWVfcre3mek0bRISyljrLAP
	8gqjdzU4evE08ceuwIXp/XBRC/IeFsmfUPsarzTEOQL95XRMkgAnduFLbrMdDmKNqxACFRadwR9
	mB17tE=
X-Received: by 2002:a17:902:a518:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d74e0b1e52mr71919505ad.10.1787906304395;
        Fri, 28 Aug 2026 01:38:24 -0700 (PDT)
Received: from [10.125.192.78] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75963fc5csm3306965ad.33.2026.08.28.01.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 01:38:23 -0700 (PDT)
Message-ID: <55c09f16-4b0d-58a8-9413-f88279ed69fe@gmail.com>
Date: Fri, 28 Aug 2026 16:38:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] zram: fix idle age_sec underflow in idle_store()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Brian Geffon <bgeffon@google.com>,
 minchan@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20260825092316.69658-1-jiahao.kernel@gmail.com>
 <apEK-yRTQR8VdT3e@google.com> <apEkQSC5PLQAsrqj@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <apEkQSC5PLQAsrqj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/8/28 14:02, Sergey Senozhatsky wrote:
> On (26/08/28 13:23), Sergey Senozhatsky wrote:
>> On (26/08/25 17:23), Hao Jia wrote:
>>> After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
>>> idle_store() computes the idle cutoff as follows:
>>>
>>> 	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);
>>>
>>> Because the left operand is cast to a 32-bit unsigned integer, when
>>> age_sec exceeds the current uptime, the subtraction wraps modulo 2^32
>>> and the huge result is zero-extended into the s64 cutoff.  mark_idle()
>>> subsequently marks every entry as idle instead of matching nothing,
>>> breaking the intended semantics of /sys/block/zramX/idle.  For instance,
>>> running echo 86400 > idle on a machine up for only two minutes causes
>>> all newly written pages to be marked as idle and handed over to idle
>>> writeback and recompression.
>>>
>>> Drop the explicit cast to perform the subtraction in signed arithmetic
>>> again, restoring the previous behavior: an age_sec greater than uptime
>>> yields a negative cutoff, and one equal to uptime yields 0. Since a
>>> cutoff of 0 is now a valid computed value, it can no longer double as
>>> the "all" sentinel. Switch to KTIME_MIN instead, which no ac_time can
>>> be after.
>>
>> Can we instead just reject such cases?   It should be an error to
>> request writeback of pages that are 2y old on a system that has
>> uptime of 2d.
>>
>> Maybe something like this:
>>
>> +             time64_t uptime;
>>
>> -             if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
>> -                 !kstrtouint(buf, 0, &age_sec))
>> -                     cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
>> -                                        age_sec);
>> -             else
>> +             if (!IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) ||
>> +                 kstrtouint(buf, 0, &age_sec))
>>                        return -EINVAL;
>> +
>> +             /* No slot can be older than the system uptime */
>> +             uptime = ktime_get_boottime_seconds();
>> +             if (age_sec >= uptime)
>> +                     return -ERANGE;
> 
> Or perhaps, instead "return len" and make it a fast path out, w/o the
> need to iterate any slots, take locks, etc.

Thanks for the feedback! I've sent out v2 of the patch. Please take a 
look when you get a chance.

https://lore.kernel.org/all/20260828083149.45760-1-jiahao.kernel@gmail.com

Thanks,
Hao
> 
>> +
>> +             cutoff = uptime - age_sec;
>>        }
