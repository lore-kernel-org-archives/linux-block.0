Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67A147C76;
	Fri,  5 Jul 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177118; cv=none; b=WtmEM9Esodl/i2ArQFCgyk4Wlzwr/Yj7Xs/8+lSPUpdPfXToNd6Jz6P0LBqdiT8FZjuMFRvTe1A4X4r4O4WVoWFY4chKPN/6cUuM3Pj9qQO8spy7SWOO7z73/ddJyu+/FW0A4YCjvrZ+h8Zy2d2DlmZXMP0pKe8RwD6VkjNY+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177118; c=relaxed/simple;
	bh=ThH7VyxQBzVsWzr1OMwDIchNgG0E9g1V+IBpmoHjpPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ihxgxuWNXP/Yg3tJTdG+zPxE131M5+W7DajIE4NxeDztzRKscC/PdDnT/20s6VRrrXtEMrI61Bc4Y+7mL5yAuUlni4H6FvJm8wJMMvWAy2UFLaC6tzfTWX/vPR6Rx52IgRc+H2OHJXeZ++IMPBHpdwZAsUrrMFaJqEn3hzJHCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WduAYMVO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WduAYMVO"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe785b234so15941011fa.1;
        Fri, 05 Jul 2024 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720177115; x=1720781915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5cYX7h/5q71cUj5uhgTYIT1TEl0rvDXujc5QHDmSrY=;
        b=WduAYMVO3gtI17IgcPkt5OEeX+j03yNQSRDZIPhrp5AEx1KgaNTKNVLChePQa4wm/f
         Z/iYjNPeX+9zHhft4vLCdKHWmUqSruhEF4aP5W3whfGkoYi7hj2QRc+JqkYLnqSlcArt
         ESSw00cWd/1UGcXRiIBjuQ980i7uxYiA72fLfXXuzdwTkmnUMu7j86+fFAzsawmpzGct
         L1AxKk3+An9VcvqP9a7vDjzoa8fi7lTGgyCSGFoea0wqfOI+0zQcCnZBnjq9HayaK3Dp
         v1XvfvuJzGApBYCrzy2DxXpLv2c1VSiLGP+yb00cm/3+8aRfWsszFmYU2hvYjlYsicjZ
         bCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177115; x=1720781915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5cYX7h/5q71cUj5uhgTYIT1TEl0rvDXujc5QHDmSrY=;
        b=j/oJKFVKdXW1MRZDsLSozxRCHthw7HSedvvV9LX3VjO7yyb9P6DP65eangv2Q4gGb8
         l9tmzEZvqeTxziA/TNiq72QykITR8lxBKVqRVTLZ3lQdsJtGSF1AkGwa+k0DO2t9MOcH
         gx00YKu7MVPfk3jjOlP6ngp9d9j6zJhKNLLJy9el70HSFmK3DrHjnbN1LpTxjSCeaF4d
         QoV5Jq3bD24A/34td3EDq3jmQ78q8LqAy6DVN/E3GW9IqIITHuNEr7a1EvaK+u+AJa5a
         WkgUxOaCt6FQKoip8JOCze8QOUF6T5j8ZY/ksWo5eO/9Txe4B/f0VQAR+39ZEEXhbSuo
         BOwA==
X-Forwarded-Encrypted: i=1; AJvYcCXgjLkCB4PArwjYDqoERt9xhPqnLqhpDCq2p3vVAWP16+Sanw/abt+8TMf/nuklmHp++WT78RvpKyCuwU5HJN2CbhPbTl4R28SfCFrbFeYE6an+F5HkFAz4mkUsmVeyy2XvUAe2Jgsj83I=
X-Gm-Message-State: AOJu0YzAF6ngBYiDQr5+yNjSCwllaoSA+AkaYslSrAzI38phe95OU46H
	V9xiqMKV+3c8ho3suNeGk0615iAk/jiB6hCjbLTJ0an1Q3AojaiF
X-Google-Smtp-Source: AGHT+IFcXNXrmZ46tuMkBOojgdrbsn++FiKIpXhilESW/oPoaYDY9JJAz6wSAjrdDU9KYXOlPPVHrA==
X-Received: by 2002:a2e:a23c:0:b0:2ee:7d37:49bd with SMTP id 38308e7fff4ca-2ee8ed5aa4emr27855711fa.22.1720177114446;
        Fri, 05 Jul 2024 03:58:34 -0700 (PDT)
Received: from [192.168.42.202] (82-132-220-130.dab.02.net. [82.132.220.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679f9783d0sm3449906f8f.9.2024.07.05.03.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 03:58:34 -0700 (PDT)
Message-ID: <2ee7600f-f09c-41f3-87eb-15bc68734b29@gmail.com>
Date: Fri, 5 Jul 2024 11:58:42 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: YangYang <yang.yang@vivo.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240703022807.642115-1-yang.yang@vivo.com>
 <fbd3bebc-db09-4224-bdf9-b44304bf55b8@gmail.com>
 <59c125f5-ff40-4a36-b095-b0dbf1a0a3fd@vivo.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <59c125f5-ff40-4a36-b095-b0dbf1a0a3fd@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 13:28, YangYang wrote:
> On 2024/7/3 19:55, Pavel Begunkov wrote:
>> On 7/3/24 03:28, Yang Yang wrote:
>>> Configuration for sbq:
>>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>>
>>> 1. There are 64 requests in progress:
>>>    map->word = 0xFFFFFFFFFFFFFFFF
>>> 2. After all the 64 requests complete, and no more requests come:
>>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>> 3. Now two tasks try to allocate requests:
>>>    T1:                                       T2:
>>>    __blk_mq_get_tag                          .
>>>    __sbitmap_queue_get                       .
>>>    sbitmap_get                               .
>>>    sbitmap_find_bit                          .
>>>    sbitmap_find_bit_in_word                  .
>>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>        return false;                         __sbitmap_get_word -> nr=-1
>>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>      atomic_long_andnot()                    /* map->cleared=0 */
>>>                                                if (!(map->cleared))
>>>                                                  return false;
>>>                                       /*
>>>                                        * map->cleared is cleared by T1
>>>                                        * T2 fail to acquire the tag
>>>                                        */
>>>
>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>> will wait here indefinitely.
>>>
>>> This patch achieves two purposes:
>>> 1. Check on ->cleared and update on both ->cleared and ->word need to
>>> be done atomically, and using spinlock could be the simplest solution.
>>> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
>>> may cause potential race.
>>>
>>> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
>>> ->word has free bits.
>>>
>>> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
>>
>> Is it blamed right? Considering that the revert alone doesn't fix
>> the problem, it sounds like the 2nd step might need to be ported
>> to kernels even without the blamed commit.
>>
> 
> Got it. How would you feel about removing
> "Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")" and modifying
> the commit message as follows?

We need a fixes tag, which commit caused it? Can it happen prior
to ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")?


> This patch achieves two purposes:
> 1. Check on ->cleared and update on both ->cleared and ->word need to
> be done atomically, and using spinlock could be the simplest solution.
> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
> ->word has free bits.
> 
> Thanks.

-- 
Pavel Begunkov
