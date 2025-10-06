Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D372D543A
	for <linux-block@vger.kernel.org>; Mon,  6 Oct 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760882; cv=none; b=rG8KFK4eQbXhg/lPHVj89Ld8mnAnGvr7JREmBNq32CwsZRG4zVC8DGhXsAQpM3puNlDDOhF2hl1g/VYp+6VW2DDtqxAWn9p3oHawtSq1oaYvkW0aNTnDEDQv2aK7ShJnAbRFsjyRfyqf6hlr90wbVXMdW9kUVafNtPhHepYnLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760882; c=relaxed/simple;
	bh=EHxWT32YymNsXpB9p3S6BjTZeoLPvi+pHdnXIyHTHFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifChuzgaPNcnJjSk6iOTJQTTnWm8FvLvFviOxU24o86qggFEVTcD177Cu8zAHDTYZ+rSBF+LUMXhOurCkYBHKIS12Gwftl3mf6KgsQbVnCnuHVwgd5g9XZ5lfRWyiux5WBJwaruPUdBldyklzrGxlovfBNed52JwK/ldICIkRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HQ+UF+gs; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HQ+UF+gs"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-92cebee95a8so224912839f.0
        for <linux-block@vger.kernel.org>; Mon, 06 Oct 2025 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759760878; x=1760365678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qej3wWBL+FUIrH9L2ourIRG5geQ59K2a1PUZ1/C7pZs=;
        b=HQ+UF+gs8ssJgQSNT2G7uL6VhAJhZv+vgtUW0DyO7jyEoez9NS7t6U/W/CGIOs1aC9
         6MnfJJl62si5Czg4LDW/Mf6P/RpvW6dHCMnnxdZXhnfOdP+0SvHdkJoT+sCgWghUtUbE
         WsdJj8EKYRmLEDC5fdbfFXYwufUXR+OB1KZhPA2HraaOt/cDl55v5oa+cFwdu8zqAAwP
         V0PTiuYismL5lmiYz703Tmyui4Fj0UYapwDAIQYVHoK/IQUgQn8Xhcp+v5HZ2SJlIBfu
         /fv9V6Mhk4rotU/gKz8u4zLxmfOJz6AI6R5+NjVfm3mT02o/ts8UVHWpgE8tZ526YRxa
         Ns3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760878; x=1760365678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qej3wWBL+FUIrH9L2ourIRG5geQ59K2a1PUZ1/C7pZs=;
        b=umVxw3EIzPhAymnNBcbFEehmtHt+cd+ceaAD1ETI+6X9qhSjUIxH/R8F2IqtnfdvbL
         9hxWwU77Qrk15ftW+Cgx0Ce6RpcHehLezwMyjySYSpwNgjDFX9EOiVNSDDg9xO3VADjT
         k9RNYOfa24G/8YlqNKtlODAhGLgFzFXFUWGiDOw/2EzTFdiSiRWgTkHaKE4Qnk5jqjnZ
         U+OUzIoIPP5/T6aUM8VNAIyOMQpz8euVw1nBCdLD3SB43zkPfkC/kuTwe+fcL6MKiWGL
         M0XCBkGxB3gkIRDikH+7gCtxW6AX8dfj7iygW3bidafn1r+bRxCHgYpR1XZLKamQNyDw
         ML4A==
X-Forwarded-Encrypted: i=1; AJvYcCUayf7iEGF1q4UV+cckIaY7vFnOQc8tHw3U5tGTuW4LSkWL/EOf9WkD63UG6G/bnVgY+5vS4kwHA22zdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxObmC1TKLw6d7UizdGlMvKUcQY+QpsUup2tUodILmKQbHp9GPW
	h0m1w1fnTmBAp0qTODBGyl52lOTVHcL5ARL75VFdaLDbiwoGxsqBE1BCyNw/QtcrnR4=
X-Gm-Gg: ASbGncvWYgaTbfzuxZBJ2N5SIIR3mYZUNk1rMmK+/V9jXbwc2HBVcJ1j/J9/5gqJqD/
	mGy2axqP58MfTLUBXwmzjk+9uESs2HNgVI0kWO9PVAgKgSLOsuD0a0qIIMQc0UfsTB7mTboUHtk
	v1WAEI476KoWJnHkImXBd53wVQVst1eCRK2HYEuSBUGfimyq1/4tiMFp/dCI2BYzZ0zXJ64idai
	aMOjpEKXftIEywCyK9iXhCiWAZZCBMF86P+clfN5Tez+5XDZqecq2Qg8fy2g+GGCcA9a7DuxF4T
	V2F9A0reS9ex6yDZT6R+ye7xyio+REdjQvhofOg786f4p8hk8+bXwwAWRurjNXGFsHRa/BL3fTa
	45wGU0rzw1w7xmB3WU2VZu1/4aA1i8Shv+PLxRDOyQNc8
X-Google-Smtp-Source: AGHT+IEWreHZclFRliJ16PSZcdV1rDGjySecvtqwp6tYvpa+GiYIMV7QH0kygTLh9fY3CyZCr8D8zQ==
X-Received: by 2002:a05:6602:14d3:b0:90a:ce21:ae1e with SMTP id ca18e2360f4ac-93b9696026fmr1773971039f.5.1759760877800;
        Mon, 06 Oct 2025 07:27:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87cad2cesm480918539f.14.2025.10.06.07.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:27:56 -0700 (PDT)
Message-ID: <d23fa119-c1df-4861-99e2-c35c1214baa1@kernel.dk>
Date: Mon, 6 Oct 2025 08:27:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>,
 "David S . Miller" <davem@davemloft.net>,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 sparclinux@vger.kernel.org
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
 <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
 <e6a7e68ff9e23aee448003ee1a279a4ab13192c0.camel@physik.fu-berlin.de>
 <cef07e8f-a919-4aa1-9904-84b16dfa8fe6@kernel.dk>
 <5b3caa0e218dd473c8871c1b1f09a8dc1c356f1e.camel@physik.fu-berlin.de>
 <ecb74c6c-8de6-4774-8159-2ec118437c57@kernel.dk>
 <6ed7112cb4f338ba02d9ab67c14e7a3af4afbca0.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6ed7112cb4f338ba02d9ab67c14e7a3af4afbca0.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 8:12 AM, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-10-06 at 08:03 -0600, Jens Axboe wrote:
>>> To be fair, the sunvdc driver is fairly old and I'm not sure whether these
>>> tools already existed back then. FWIW, Oracle engineers did actually work
>>> on the Linux for SPARC code for a while and it might be possible that their
>>> UEK kernel tree [1] contains some improvements in this regard.
>>
>> Requeueing and retry has always been available on the block side. It's
>> not an uncommon thing for a driver to need, in case of resource
>> starvation. And sometimes those resources can be unrelated to the IO, eg
>> iommu shortages. Or this busy condition.
> 
> I see. Makes sense.
> 
>> But that's fine, it's not uncommon for drivers to miss things like that,
>> and then we fix them up when noticed. It was probably written by someone
>> not super familiar with the IO stack.
> 
> FWIW, Oracle engineers actually made some significant changes to the
> driver that they never upstreamed, see:
> 
> https://github.com/oracle/linux-uek/commits/uek4/qu7/drivers/block/sunvdc.c
> 
> In particular, they added support for out-of-order execution:
> 
> https://github.com/oracle/linux-uek/commit/68f7c9c17fb80d29cbc1e5110f6c021f8da8d610
> 
> and they also changed the driver to use the BIO-based interface for
> VDC I/O requests:
> 
> https://github.com/oracle/linux-uek/commit/4b725eb64cc10a4877f2af75ff3a776586f68eb7
> 
> Could you review these two changes and tell me whether these would
> actually implement the changes you would want to see? I think the BIO
> layer is a generic interface of the block layer in the kernel, isn't
> it?

Moving lower down the stack to use a bio directly is not a good idea,
it's in fact going the opposite direction of what we'd like to see in
the storage stack. And it would then mean you'd need to implement your
own internal requeueing and retrying.

These are the kind of changes that happen when development is done and
changes aren't submitted upstream. It's unfortunate drift...

>>>>> For now, I would propose to pick up my patch to revert the previous
>>>>> change. I can then pick up your proposed change and deploy it for
>>>>> extensive testing and see if it has any side effects.
>>>>
>>>> Why not just test this one and see if it works? As far as I can tell,
>>>> it's been 6.5 years since this change went in, I can't imagine there's a
>>>> huge sense of urgency to fix it up that can't wait for testing a more
>>>> proper patch rather than a work-around?
>>>
>>> Well, the thing is that a lot of people have been running older kernels
>>> on SPARC because of issues like these and I have started working on trying
>>> to track down all of these issues now [2] for users to be able to run a
>>> current kernel. So, the 6.5 years existence of this change shouldn't
>>> be an argument I think.
>>
>> While I agree that the bug is unfortunate, it's also a chance to
>> properly fix it rather than just go back to busy looping. How difficult
>> is it to test an iteration of the patch? It'd be annoying to queue a
>> bandaid only to have to revert that again for a real fix. If this was a
>> regression from the last release or two then that'd be a different
>> story, but the fact that this has persisted for 6.5 years and is only
>> bubbling back up to mainstream now would seem to indicate that we should
>> spend a bit of extra time to just get it right the first time.
> 
> We could do that for sure. But I would like to hear your opinion on
> the changes contributed by Oracle engineers first. Maybe their
> improvements are much better so that it might make sense to try to
> upstream them.

Won't help this case, and it's actively going the wrong direction
imho...

-- 
Jens Axboe
