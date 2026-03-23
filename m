Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31E3BAD9F
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286072; cv=none; b=q7E3zM1IlIihKbZrSOWfOxdyR1viwXnIZFQNIzHiSt1HIhrBMx+juPzTKIlKj84oL2smFQruigIQ0Q71801Wzz/GEib9q7riEoiiT2Gb2SYGQ6EQNzpdIyMDeY7xj9H/omEe0sxjsQ57gKvAxp/i1Nw5suT53UOV3X9/ja/cQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286072; c=relaxed/simple;
	bh=I/qSQaozGXrZlHdyzXhwZHgKOxPyB9GnZ4kQluj1SDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoivaohT4PwVBP9x2sklVUlIDZcBCpYmZcYyTRTlasL/XpIT05tGYDXD+Z1+18iKyDGGbM+11XNvZOaVoVyRXZYFEJfQDQMsYMhaDCNxJrnXE8NvzR16iu4ulQouT2GUmuKSu52rgFEUqxCD7TCHYxWr1yr7ID7z6XvSVFfWIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=piieToKL; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="piieToKL"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d75371d873so3445871a34.3
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774286065; x=1774890865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gt3tiwXQqbcpGblSARIdt8M/J50COaA/YPu4aB7JY0=;
        b=piieToKL2TDDCOzQ8KuUWtMzua92OudU2ppuA5rQX1N8EpXutwB10KB4uQRhm8tDMz
         JLMip5Az9ChqwpWDVwQxyrCH19sEHOfzilxjM7tg7uth6xSdWsuF5htxwphCTb/h8j3y
         falNnxhyiPpGkFqIGwQtIAr8siNkCEKe0xKD33GkDBKtZAJFgtTqw8EPz1Xk54wLBN7u
         392DeJPNhmfHaQFa2wbr0kM/tHdsjgdVh6rxT+qqijHLItpxX1fHlXfke3Z1FP6dojfR
         jK/7I9xPgGiIl/y+B9mCHwcNNyzFYvZKtHCE1R/TrNkxdAjtrD8VRJKMuYfj53FldRDc
         4PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286065; x=1774890865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gt3tiwXQqbcpGblSARIdt8M/J50COaA/YPu4aB7JY0=;
        b=h+7DtVjrWCEfXebWlOD8fF65zxg709IEW08Wmoh98/zQkkTV9mAWVgw2qOXmLTQGYW
         lcS78BsIIYXTmH8J7WEaJgdVQTtbDLp4bH6uXEF3WXmjSFkmg934WWgcMlCgxIm9Lm9n
         pJbOAWkMy6FwrWByaVui6P3Uqqh8atAaU4H6RDRs1srhVynVNI/+rNDl+X2zOVM2l9lr
         DmybuB1B8rUcU1Nj7EVxwhQmSCKORZJ/51X+kboApRPDAxapQaK4md18UFXHPuTghF55
         XOqVMPFoBhtWyXWYPYGuZgxPzDebkBZQY/OXRvqDeONrnnU9ylpW0MlcJn8yI19daPex
         EaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPmdjyocANQN3P4/epTjOIKyr0KE0z4gfSYr2QdWr+Gh2HPD9BatG8ySKxKDee0j4Rl5Z30qkadc4iYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1d8Q+7ViNgyA6wuWfmEXUBvRJTE9NxxPtp3BBOqE1V2zhQtQ
	0JUvlmjDTU+x/zV8KhDmWQv2LPQd9rZtHKguhoqrOFKC6Wh310ssdIJxnPYZbRFAsDQ=
X-Gm-Gg: ATEYQzwmJakqYq09TqerVFYB7YgpaVU9Cs3GOLCY75UNbjwGYEWgztDAHovI45ORqoE
	me0zaCwLegR6OyE/S05LMgpk1a/Hhh+f394cIO/t7bzpU7o2mPHfxBnB7eDEOZ9CbfAKF3WsMaj
	D8x0YganEcqWTdYp+TNM8XnTIo3Gccb0lM9LRon5MHrnRWtUer091qaeDT4jvT69B5u7idawPTI
	Xs4NkSWl1md8Vl/JQFApsKV/jkstf2njtIVWAY5wEk9DU+7+4UC/SWzTwtKcmGgoFopt3zdgePR
	+ooCG2Y4fpXbrM26bJtD5b0VPedlP5kEnTIaco2Uli8akhgn2DHl4Q0yxxycSyvHIXZNRS4Gy80
	yy37jRYoxshm9E9mEkyiBksiVxiQpzr+nAdiEBW0yzRua2UywaSxSyxg1p4W/KOsjdAzZ7ELJvV
	cZMh/O4Ld69felnbzgL5mfXJRGAyD22qNWsehvuW065gQLJLfkHBi/crGGYad6x7oQhlBG/ehpP
	7SRFThrN9P8XkdhcsI=
X-Received: by 2002:a05:6830:6f86:b0:7d8:7d95:fa56 with SMTP id 46e09a7af769-7d87d960e38mr5636892a34.0.1774286064759;
        Mon, 23 Mar 2026 10:14:24 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae1c959sm9679753a34.23.2026.03.23.10.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:14:24 -0700 (PDT)
Message-ID: <f348e3ae-1def-4728-b8c5-1b32e1e980c0@kernel.dk>
Date: Mon, 23 Mar 2026 11:14:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists-infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@meta.com>, hch@lst.de, martin.petersen@oracle.com,
 csander@purestorage.com
References: <20260313144701.1221652-1-kbusch@meta.com>
 <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>
 <acF0aJa-GXGYPqS0@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acF0aJa-GXGYPqS0@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 11:12 AM, Keith Busch wrote:
> On Sat, Mar 14, 2026 at 08:14:49AM -0600, Jens Axboe wrote:
>> On Fri, 13 Mar 2026 07:46:59 -0700, Keith Busch wrote:
>>> This is the rebased version of the flexible t10 alignment feature on top
>>> of block's for-7.1/block-integrity branch to apply atop Christoph's
>>> fs-integrity:
>>>
>>>   https://lore.kernel.org/linux-block/20260223132021.292832-1-hch@lst.de/
>>>
>>> The only change from the previous version is to incorporate the function
>>> name changes and verify's status code return type that were introduced
>>> in the file system integrity support patch set.
>>>
>>> [...]
>>
>> Applied, thanks!
> 
> Did you forget to 'git push' this branch?

I don't think so?

commit 203247c5cb972af5d46bdb7d41ef40078048810b
Author:     Keith Busch <kbusch@kernel.org>
AuthorDate: Fri Mar 13 07:47:00 2026 -0700
Commit:     Jens Axboe <axboe@kernel.dk>
CommitDate: Sat Mar 14 07:44:30 2026 -0600

    blk-integrity: support arbitrary buffer alignment

and

commit 5d540162059598c3f79e12f96064825cc91f0f9c
Author:     Caleb Sander Mateos <csander@purestorage.com>
AuthorDate: Fri Mar 13 07:47:01 2026 -0700
Commit:     Jens Axboe <axboe@kernel.dk>
CommitDate: Sat Mar 14 07:44:30 2026 -0600

    ublk: report BLK_SPLIT_INTERVAL_CAPABLE

in the tree since 9 days ago?

-- 
Jens Axboe

