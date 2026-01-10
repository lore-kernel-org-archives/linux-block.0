Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30363277C86
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066087; cv=none; b=RP2lEpvFv5glwntJ5ugZQcgxJhx/KPE0NK5usz2doB3swgub0jOPeGwlhYtN2zomicOCNWJLywHh1k48AY8p0XVuhnAVGZsOnrvfXjkEqWqLYUfr7TVcWGcaCAd+gsl2M8T5/VUOH/GTYsOk+RL5PgimuE802NVPzIUu9OtI0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066087; c=relaxed/simple;
	bh=Bm21lO7kzxFVEUxOrX69gehbqX1DwoPdd62omyuA5aE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bhz43CPEkFMo8rByl1rZWX90zT+B/MlpT/HrZ2LHItUX/23DfP31MLmtRJlw+Zkriae1CP77ltYs4QSefROQr/dpRS024UkEP0Qccv3qc/OSkzuaCt9qNGYHb0FT/xcolPsVtBd6f2IRltdti4wfPaMHvR2cnnne94w5H1b6tNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GAiFdiVy; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GAiFdiVy"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ce614de827so1632941a34.1
        for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 09:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768066084; x=1768670884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TXruW4vZ8ixZMvSdqPOKj/W54NefVRcJvx7qIpkFANo=;
        b=GAiFdiVyEDIso+JLWVtYNZjhTOjLxOrVOhRc927cG6v9x8kqA7L8ecLCmOyIxRViKg
         +CSGKWh0JFG5m/o01+27xcWYfi30NptbM8h6NTphWM8QkfE93GeWw88RWedXDReIvvvV
         /H4KYwWnySclUEzrGn7Ls7VigzrlZAgsirBdvvsPtJlxz1MQ0do9lFoMy1dXpG7Ga1Bb
         bgwvS18gSc2tx86aT7Ciqq+PRydKHlBOklOaavn+01Ohz2vU0ONLTksKjapx8+/G6/zS
         N81uI0BlwynGizerk3k5PoA8M0nVlRsczHzQLY7gnb9XKcDk/7AkPLV8QQsFWnjzVv10
         Ekpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768066084; x=1768670884;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXruW4vZ8ixZMvSdqPOKj/W54NefVRcJvx7qIpkFANo=;
        b=jv4z01sP5j//L8TCt6WVnV5UDiBodav7evY9ONBoEC0pF8vZXqbCGuzKyUD1bmgaOc
         IOLnBmpKJY4P/V+HfMGfeSIJcR9CaLh2OjwG2YNq5/44qQUknoezdW6srJakyToEAm9G
         PKF5FdlGJkqjjqzIvV/hCnyut2HEba4k0bkdCCyjh/l0CG+/s391kH4CDn64+zbAYlQf
         JIdv/wb3veiMCPWZqhX4zVtQg1RcBR4v6IVkMgh8EG18OKSzhKFIeYIcyCATz6XGjhng
         2z0hTxYV3MHRfP5Z9oRp8dECwRI87KbcdbA8jmPuUoU5X0Rq2DMvi01DGUbn116ipazZ
         905Q==
X-Gm-Message-State: AOJu0YwZeHgcsA06GcTPOtruonCXCDfePjXG0UsfZkmXCeYqtOXY/z7t
	aHmeEEP5e70BlIJVTJNuyAGayKbMFlnm7PVbeEur6pPG0tcvvDOh3Xw1yOS1fzY+XSQ=
X-Gm-Gg: AY/fxX4fap2i+Jns79a+ZFP/j045tVqZIjG0gNE42x7hi3fSYhwaeQytO0F95LV+AKD
	rZLQSap1P2m8nWOmLfOtiCyPvQUdOKWB5Jty9c/Mj7MyMatvZ4+IApPMRzkD/j9NlCNuU3xVOF7
	sGXT2rxKWS/mHfV86a41FwLs6+/Sr75qNUr6GQFDdRMXzCWIH3BJpdn1YsxDatMEs9s7PQYVrU8
	v6TJzgxCss2dtjvZSwHXO+g4f7BHygIrRdmqKqvIIde+6C93HKqY0P5/ZTC7E5tfAwCxqH4zgrP
	4DrieILhCx7L1OK1y1czUSuSIIET/65GUoWGE/dqDb1vl9eBY1hFhotaiBjeAe8MwoqQn/UY1aS
	a0ZPAVmvV1ihH/n3+qZ6h9xoBjQT/8iJfxp0z9cx/H9sFirURBaobvA0SfMn1xIU7fU6Hxq4Khk
	mZXEUSiv9q
X-Google-Smtp-Source: AGHT+IE3j4WuOvoW2sMO5AGZsgxxfm6j57157cp0sDKxph5B/9oRM7JR3Y0F3EFt1bIIVczxw4F4Ew==
X-Received: by 2002:a05:6830:3141:b0:7c6:ca62:e258 with SMTP id 46e09a7af769-7ce50a01f56mr7412873a34.21.1768066084124;
        Sat, 10 Jan 2026 09:28:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47801d63sm9443098a34.6.2026.01.10.09.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 09:28:03 -0800 (PST)
Message-ID: <cdbd634d-4f15-48c8-9c2f-812130605465@kernel.dk>
Date: Sat, 10 Jan 2026 10:28:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: zero non-PI portion of auto integrity
 buffer
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
References: <20260108172212.1402119-1-csander@purestorage.com>
 <176796707483.352942.3630670392140403614.b4-ty@kernel.dk>
 <CADUfDZoacSnJz5FOZQov50k4_nP0sxqxDHYOvDqp1_7KKD8z1A@mail.gmail.com>
 <cf37342e-c2dc-48c9-a63b-e62fe8e791e4@kernel.dk>
Content-Language: en-US
In-Reply-To: <cf37342e-c2dc-48c9-a63b-e62fe8e791e4@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/26 10:21 AM, Jens Axboe wrote:
> On 1/9/26 9:29 AM, Caleb Sander Mateos wrote:
>> On Fri, Jan 9, 2026 at 5:57?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>
>>> On Thu, 08 Jan 2026 10:22:09 -0700, Caleb Sander Mateos wrote:
>>>> For block devices capable of storing "opaque" metadata in addition to
>>>> protection information, ensure the opaque bytes are initialized by the
>>>> block layer's auto integrity generation. Otherwise, the contents of
>>>> kernel memory can be leaked via the storage device.
>>>> Two follow-on patches simplify the bio_integrity_prep() code a bit.
>>>>
>>>> v2:
>>>> - Clarify commit message (Christoph)
>>>> - Split gfp_t cleanup into separate patch (Christoph)
>>>> - Add patch simplifying bi_offload_capable()
>>>> - Add Reviewed-by tag
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/3] block: zero non-PI portion of auto integrity buffer
>>>       commit: eaa33937d509197cd53bfbcd14247d46492297a3
>>
>> Hi Jens,
>> I see the patches were applied to for-7.0/block. But I would argue the
>> first patch makes sense for 6.19, as being able to leak the contents
>> of kernel heap memory is pretty concerning. Block devices that support
>> metadata_size > pi_tuple_size aren't super widespread, but they do
>> exist (looking at a Samsung NVMe device that supports 64-byte metadata
>> right now).
> 
> Good point, let me see if I can reshuffle it a bit. In the future, would
> be nice with these split, particularly if they don't have any real
> dependencies. I'll shift 1/3 to block-6.19.

Done - 1/3 is now in block-6.19. I dropped 2/3 as it's mostly useless
and will now through a conflict in for-7.0/block. 3/3 still in there.

-- 
Jens Axboe
