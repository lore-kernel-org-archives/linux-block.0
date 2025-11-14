Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0E340A69
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141967; cv=none; b=g280Tr4dQcfIKW5G2p0myx6h/3L1naPR/0WPVsGXCmUj54fon4PGdZThRTWkv5ekRj+pzfAQNkmJMEqVZmVs+LhD5/Po31oY8K2u98lmDVSCmyRMst+asrgkqkf1ZgzR2RDYUJbtxIGaOuJJNLbRua+45iNIbOySXlruPTlnIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141967; c=relaxed/simple;
	bh=Klq++H1zq3wWnDMreuLQ9vTxkpMORqg0J7GlRnDFKpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+fgdxD9j/lcU0/EOsBQJ/J1VCGPEvvcDEG+lFUo5J3gNC9MafvjbEGqVsKLfm8jv5jIUuh8FL58HOGf31dyt6eRGWX0lq8qe9cP0LMKGuNeBE7sKG4jWtrCGidqrFCCzhzvRRkz0iesh2yXDPdETjRUM44FkVO37ddTjoHr6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bZKDCn5L; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bZKDCn5L"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9486248f01bso79689339f.0
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763141963; x=1763746763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZaaDarMi0uZmQYGpNnbLmsBdRPS9KXQOUgY8RY+ykY=;
        b=bZKDCn5L0TbYLnGoZCeotvJFScQbDVpr7R4SpQWJGnBGZWM1hIFRNGl3Z5rgT95n0O
         HbirAJctoll1lpo7RBFz+lIDWgOyQ5k1dlJVyrmyEl6Vs28jpWwLgU4TTmVUAhsG9sS8
         5nKVkUYx43K+YqZNBNg/xMIe+Qh1wGgwNzOMggcrsytqEq6URInmq/xdbaL2bKZdlhJA
         VmC3Nu1Mm3MmKSgLhIVVy/LQpSetkjECrQ2tWTq2t9L/mloDFlrrhTGeEY/MbY3VOBUh
         q3EXuZecEaIDxpv3wawZhYCWXdtRWMVcuds1vR9VChBqGdkHe6RvHUr/vNy1DsZKa1Td
         3GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141963; x=1763746763;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZaaDarMi0uZmQYGpNnbLmsBdRPS9KXQOUgY8RY+ykY=;
        b=opnGWOQ/JWAjRdlBOFTUo9mzS/pu+66zSjVfmzL6yS1uXPvxJiXxypxc6YHN8XBdau
         0Cj9aylqZhuv4bQPEL16CSxNAyFeVjY03U1+FRrQGzxnzte7sS8jlTTg/yoP+bAY9GWg
         MDJst/U6aeUPRigdNiTb4EoEKxUxTkm6lU2tuA7vtj/3AKo03yBTjdvbL5OzrLO3q9qL
         lYvxkYJkItWTLsIiom7qKyiWJPUoW0zD2enCd+J/CGwB83CKNlE1PaAvWN3tn9Aeu8Ti
         p2R1G6Y7QJX8MAySdDa00J/SO1LbzaQBWkjNOxPjtB0kwdXJ1J8trJIWOpS9tZ3D3NvN
         YQ+A==
X-Gm-Message-State: AOJu0YzHA+xTIPba2VreZTu/O8ZTRntiL7ARXE4dXgpjAmVGAhH7gY+p
	gnGm4QZ4dPWV8nuE37xXytwZ85U8mcrbJ2o1cLXaaUs6WKX7vehgnRiyRzeLtz/WJeRZj9XFzpX
	OUyPa
X-Gm-Gg: ASbGncvn8AH28yK0gaIny9b1A82h1lNyie5ANmm9XRDm1C1ssydwULyz+aqrmjihXHd
	abH3se7dPlMf7MgYEeILMNP/6NlD8cpT+HY+1yTznlLPwHmaG+c2rd82moFdgQm33M3HrzttP2w
	+I1CgEOQ2UV1eG4ZO2OSjGkg1DCxysK2uRXDI5RdKHrfXIj5xPhrwG2t8rW+echE9OVs+Ztk+a6
	LWlBSBtsMEHo8n3MAvs90vp6M8fHZNHXOPmTfIp8MTb0SCsvqNmh0eTyF7KfUpruIT4Xz6uOsHO
	XxNZAKxB63+yaXd17CZmXyPQtYWokj19h6JOQEpd+u4Xfn6mkTvkmxxBD3SuRR7PAbaEM23T++N
	KElKki73BgZNmlOUfxqbhh3P8zsn73HNkboit/Lcc7HWaS16by32NWU8KEvULpCFHiky6nh/rrJ
	KDBxkMllA=
X-Google-Smtp-Source: AGHT+IEjcZzHdGktbTOeAvLIuYkdqP8emkJEPDTbPxihjchGZYlR3EBTZoHoVOIlFQFJfLry0Ohr7A==
X-Received: by 2002:a05:6e02:1a21:b0:433:771e:3dd6 with SMTP id e9e14a558f8ab-4348c87a9f4mr58244765ab.6.1763141963425;
        Fri, 14 Nov 2025 09:39:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839badb6sm28987385ab.27.2025.11.14.09.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 09:39:22 -0800 (PST)
Message-ID: <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
Date: Fri, 14 Nov 2025 10:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-block@vger.kernel.org, efremov@linux.com
References: <20251114.144127.170518024415947073.rene@exactco.de>
 <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251114.172543.20704181754788128.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 9:25 AM, Ren? Rebe wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
>> On 11/14/25 6:41 AM, Rene Rebe wrote:
>>> For years I wondered why the floppy driver does not just work on
>>> sparc64, e.g:
>>>
>>> root@SUNW_375_0066:# disktype /dev/fd0
>>> --- /dev/fd0
>>> disktype: Can't open /dev/fd0: No such device or address
>>>
>>> [  525.341906] disktype: attempt to access beyond end of device
>>>                fd0: rw=0, sector=0, nr_sectors = 16 limit=8
>>> [  525.341991] floppy: error 10 while reading block 0
>>>
>>> Turns out floppy.c __floppy_read_block_0 tries to read one page for
>>> the first test read to determine the disk size and thus fails if that
>>> is greater than 4k. Adjust minimum MAX_DISK_SIZE to PAGE_SIZE to fix
>>> floppy on sparc64 and likely all other PAGE_SIZE != 4KB configs.
>>
>> 16k seem like a lot to read from a floppy, no? Why isn't it just
>> reading a single 512b sector? Or just cap it at 4k rather than do
>> a full page, at least?
> 
> Well, on my sparc64.config it is just 8k and I did not feel like
> changing this vintage code more than was necessiary to write a floppy
> for a Firmware update of another systems while my Ultra10 was the only
> system with a floppy drive in my office. But even 16k or 64k is not
> that much of a 1.44mb disk.

64k is 4% of a floppy disk! But I hear you, works for you.

> But if someone wants to refactor this code some more, ... I'm happy to
> test it, too ;-)

I don't think refactoring would be required here, it's probably just
capping that probe read to something constant irrespective of hardware
page sizes.

-- 
Jens Axboe
