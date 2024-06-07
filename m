Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8C18C330;
	Fri,  7 Jun 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717765148; cv=none; b=qgrpI8Cjli93yjxf7pSj3OpXqchTPALH1EvqH0GLlDBNPyZz0e2IAxb9X+rasnBdlHXBvHV1R3djOSqYJtSLzhR9vFXMnL7zhlKHKiUC7Iij2XZxUWcK0uHazRgB6J1yfIx53vAxlUt8YZFww4WFDpDbooOF1Gtov/WKNkq7Pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717765148; c=relaxed/simple;
	bh=vjt1+QeSp5Sb/mevIOfvfW6Aev/mE5JAlBBwzVe8frA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4Ea+kqRqIu4oep/KvsBXfyxNZ+pwrWeyYG2Cpultwt0VHJYzYLyVm84pJXQQeB2tbfAUzRIQv49yoCzgbKkDw23KE9VUMhceaDk2cMtkuetGUI+nJLldQqzQuzbOSVr8MMYsmxC008eySqUmZf18OxD19olFPiCdOrqhmAcKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co5j6d96; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co5j6d96"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso2460604a12.1;
        Fri, 07 Jun 2024 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717765145; x=1718369945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwNu32j4Qgs9o4RZx2A4i2wz9FLKQtp05joxe1btFUA=;
        b=Co5j6d96t47/fcPM5PsIf0vPJelgRLIcDkgwGgqW+tE0M8C0OcR1sM7phA7QSbXPa+
         PuhSgwQZKTcnMWEHesMso8IElm+D1nTuwHvsj8vgaAqmZ9/cNpSLwR35avqqT4aOCJrR
         ZfbT4cBfEd1rw1cH/qyK2ZHfSjZMygTJn2OIK5OK7pSTX9gXGSbjxsaEGiYbiP0D+nJL
         G662WKWILaPYQQTSqkIVQftYSvVFPiGPFuPFllEihQedSc1aXdH4U5dV/4DyM7K7fjUa
         0RdKkRhoP+8QCjn9PSROBWboKwXcNKQSAowhGCxL5FDWDHesj6R1LsNuWpje22hkW1tG
         0z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717765145; x=1718369945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwNu32j4Qgs9o4RZx2A4i2wz9FLKQtp05joxe1btFUA=;
        b=WfmHUb6hNIczdB2arpSpMMV6JvQYMMGgtxv/0FBfjRSiQ88rrv9mS9F9ZqwuL7lONF
         uJYf4ntiJSB9fv6kCmPu6Mo+H0MRIqAeWXNEm7is3d0RP73rqRnwD7FcwpNihrlqZfCx
         c11ltShrX5wCy7vwfOKe12H9RuJ4tVTTJcmmbcXp875qje3unMZp4mlE9XpS4RS/ozz+
         UsoJNafDn1kNWH+7YA8Od3OC78AeVAkDt2MyGlZ2arw2zSpbEpDV34dHoOyj2yC8WSDy
         QVBhN4nZMfuMgBialARyX9YKp4DIa6y/96TIvBW6V2vImzyeg3z1KMI8Azex/UdnxQCO
         jMQw==
X-Forwarded-Encrypted: i=1; AJvYcCWYuZRdM2lyuwmqke4dPlBeMrIfHceAX5ZlZJn0ql9GRqnmGzqF4KeqPmQyhgjmAIcgcSUaWdRtS+DjEUPdF5Zz5DfGlya+16jt27xWxIEgFvHkDktXkVx/rULi3//viBqgHNYo6vsyo/s=
X-Gm-Message-State: AOJu0YzNutazsNI2ucExzTeXzbbU+3fWUpEz04sD+vtD3cgRtLbL8cLu
	8aHnay1/EWMGB111DkAY7FpV45L0iVzUEZdYpdJUauqsp5oAFKJQ
X-Google-Smtp-Source: AGHT+IERA8GW/ndoCYphHW5kfMnR0SWWaANqPC3SnpUYwkOtyDcZn7YAFq06omRL5dyJc8UdYz6Sgg==
X-Received: by 2002:a50:cdc2:0:b0:574:ebf4:f786 with SMTP id 4fb4d7f45d1cf-57c4e3f5be7mr2219873a12.16.1717765144630;
        Fri, 07 Jun 2024 05:59:04 -0700 (PDT)
Received: from [192.168.42.79] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae229712sm2726504a12.81.2024.06.07.05.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 05:59:04 -0700 (PDT)
Message-ID: <cf8bb1db-b601-4f54-bafc-d6c58f6ce946@gmail.com>
Date: Fri, 7 Jun 2024 13:59:07 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: YangYang <yang.yang@vivo.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <e1cdf579-007b-415f-9e4d-3fadd6f97b36@vivo.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <e1cdf579-007b-415f-9e4d-3fadd6f97b36@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/24 08:03, YangYang wrote:
> On 2024/6/4 14:12, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/06/04 11:25, Ming Lei 写道:
>>> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>>>
>>>> Configuration for sbq:
>>>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>>>
>>>> 1. There are 64 requests in progress:
>>>>    map->word = 0xFFFFFFFFFFFFFFFF
>>>> 2. After all the 64 requests complete, and no more requests come:
>>>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>>> 3. Now two tasks try to allocate requests:
>>>>    T1:                                       T2:
>>>>    __blk_mq_get_tag                          .
>>>>    __sbitmap_queue_get                       .
>>>>    sbitmap_get                               .
>>>>    sbitmap_find_bit                          .
>>>>    sbitmap_find_bit_in_word                  .
>>>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>>        return false;                         __sbitmap_get_word -> nr=-1
>>>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>>      atomic_long_andnot()                    /* map->cleared=0 */
>>>>                                                if (!(map->cleared))
>>>>                                                  return false;
>>>>                                       /*
>>>>                                        * map->cleared is cleared by T1
>>>>                                        * T2 fail to acquire the tag
>>>>                                        */
>>>>
>>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>>> will wait here indefinitely.
>>>>
>>>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>>>> remove swap_lock"), which causes this issue.
>>>
>>> I'd suggest to add the following words in commit log:
>>>
>>> Check on ->cleared and update on both ->cleared and ->word need to be
>>> done atomically, and using spinlock could be the simplest solution.
>>>
>>> Otherwise, the patch looks fine for me.
>>
>> Maybe I'm noob, but I'm confused how can this fix the problem, looks
>> like the race condition doesn't change.
>>
>> In sbitmap_find_bit_in_word:
>>
>> 1) __sbitmap_get_word read word;
>> 2) sbitmap_deferred_clear clear cleared;
>> 3) sbitmap_deferred_clear update word;
>>
>> 2) and 3) are done atomically while 1) can still concurrent with 3):
>>
>> t1:
>> sbitmap_find_bit_in_word
>>   __sbitmap_get_word
>>   -> read old word, return -1 >          t2:
>>          sbitmap_find_bit_in_word
>>           __sbitmap_get_word
>>           -> read old word, return -1
>>   sbitmap_deferred_clear
>>   -> clear cleared and update word
>>          sbitmap_deferred_clear
>>          -> cleared is cleared, fail
> 
> Yes, you are right, this patch cannot fix this issue.

One other alternative is to kill ->cleared. It's not
immediately clear how important it is. Do we have any
numbers?


>> BYW, I still think it's fine to fix this problem by trying the
>> __sbitmap_get_word() at least one more time if __sbitmap_get_word()
>> failed.
> 
> Err, after trying one more time __sbitmap_get_word() may still fail.

-- 
Pavel Begunkov
