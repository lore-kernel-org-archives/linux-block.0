Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99016EC0C;
	Wed,  3 Jul 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007752; cv=none; b=ky+EM5FRDSGux/iPFHam3nhNQg0V2xFe9rmE8Rn9QWuWMCT3g8HS8lVBpm1Zd/UelIR0M5yH51b3CBNf7B/x2J2zLMt4g8q/X70ZXm9kD9iu8t4l1J6sslHnKei/l85vV/hSRlSvlciv8nXzeqmBVTvcumUrygVWpilgFnM7QRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007752; c=relaxed/simple;
	bh=0oJeoGG81bzehMG51mi88GXA8pDGoGhbepv1IZLVz7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E802mGdzKgNEyXcy3/G+fu6ev05kO1kKbgPMDFM8h2Yt6MhogAgv4MGOKlHsvPUMJGvDgAyMS2WnoOkh+zUMJSqyrHowrGtNw9xy16VQ9q800wULWw3Iip/4oxnXi85Z9aVnyEWAaX4MSPef+TioZ3pFkSMvWL2drJSOJZStHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK1xEVv+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK1xEVv+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so2977371a12.2;
        Wed, 03 Jul 2024 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720007749; x=1720612549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTSQnqgsaxj4ShNaVAyout8ROilJlVNHANanPFm1Bp8=;
        b=AK1xEVv+J8q6sJVSSp1xomuU6rNLWe9gaVCbvrmret/HSYxor7M3pvppC7X8Od71eK
         tJBPJlK8iNiXeG5KGkdRfCKBN/Yp4aC9+f6Lxb7h85CBMQ0WuNf/dZAGt7ST0AlQlqtC
         MGJ4K/GFgCvX46lJNX2KNG201IUg3Yus0ekcd1em2q8nb0/hC4K/lXe7Y1gh2v13dOZM
         0+aErfGL+TKs4j9BS40Obs/ufQU/n3o7IElv31SQ3N5r1Kf+o+UVD8EATY1oKL1jGh2t
         XAGfpfsJQeqpDTDMU7HPPvSv7StcvxcY4UACou9mRcs2J5W9U8nz4aR67upOYX3AlaOj
         uJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720007749; x=1720612549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTSQnqgsaxj4ShNaVAyout8ROilJlVNHANanPFm1Bp8=;
        b=SjkcBXd2d8kgxI9RW4plzqTfV7e+bqAlejTr2tIrDs3RIm4jRVpw1O0rYqtVzdDppZ
         MfpHiOgZuxOt4pm5AcfumYTvfDf2l04tI2GZGQAxk9aYgRmns5I3GHEUwL4LqfGK6fjT
         s0SbdVoZfs80Vui1irw91Z6YBCgXHj5Q1SmlbjVOkhzOsPxsHWO1hKhKF0qko6LZTzWD
         Ls5kNzVOB1dvyVb9U9FgHw/Q0fAMecVrfzd1qhQUB5BoRz9FIbCsYX+7m3+N2RA2ZCUP
         Rw0X53YIh6KjujtdRNdsvBCr0n1SPb/hC8q/Mqkz8w3HlUBcxfqmqAhSa5fGzE7YPM6C
         L0pw==
X-Forwarded-Encrypted: i=1; AJvYcCV3+DPkrCW8FvItqgLtAzo/5/s2xqelaulmDgB2rGqZ0SMTFirrSCYgYkOH+yqt/WC2iGbw2IFPOcsRacKPBIXTo2rYrkHHGdUcSl2ISFNz7tvrTMB2NxXZpmzmBVBRwBf9ucbsd2clOAU=
X-Gm-Message-State: AOJu0Yyy2ts3YmnidQXr2zF43838M5eIf2fXobVaW8wMMe+nWElN7DJq
	E0rD8c6QHl639S5PBOMwZnuRiD0M4XQ9HVf8db8rD6VjWx+RTWwO
X-Google-Smtp-Source: AGHT+IHaPlJYig52nHAvcAkSxel6Q87BW6mueSa8QLn+Gow9q8XpeYxS+0PKkttq3s7IBzQ/asjqpw==
X-Received: by 2002:a17:906:6c9:b0:a74:5b82:7f28 with SMTP id a640c23a62f3a-a75144301efmr720652566b.23.1720007748897;
        Wed, 03 Jul 2024 04:55:48 -0700 (PDT)
Received: from [192.168.42.235] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1ba77sm500748966b.33.2024.07.03.04.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 04:55:48 -0700 (PDT)
Message-ID: <fbd3bebc-db09-4224-bdf9-b44304bf55b8@gmail.com>
Date: Wed, 3 Jul 2024 12:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240703022807.642115-1-yang.yang@vivo.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240703022807.642115-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 03:28, Yang Yang wrote:
> Configuration for sbq:
>    depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>    map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>    T1:                                       T2:
>    __blk_mq_get_tag                          .
>    __sbitmap_queue_get                       .
>    sbitmap_get                               .
>    sbitmap_find_bit                          .
>    sbitmap_find_bit_in_word                  .
>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>    sbitmap_deferred_clear                    __sbitmap_queue_get
>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>        return false;                         __sbitmap_get_word -> nr=-1
>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>      atomic_long_andnot()                    /* map->cleared=0 */
>                                                if (!(map->cleared))
>                                                  return false;
>                                       /*
>                                        * map->cleared is cleared by T1
>                                        * T2 fail to acquire the tag
>                                        */
> 
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
> 
> This patch achieves two purposes:
> 1. Check on ->cleared and update on both ->cleared and ->word need to
> be done atomically, and using spinlock could be the simplest solution.
> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
> may cause potential race.
> 
> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
> ->word has free bits.
> 
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")

Is it blamed right? Considering that the revert alone doesn't fix
the problem, it sounds like the 2nd step might need to be ported
to kernels even without the blamed commit.

-- 
Pavel Begunkov
