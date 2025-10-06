Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536D2D594F
	for <linux-block@vger.kernel.org>; Mon,  6 Oct 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762354; cv=none; b=tT+kJvBCdpAJfmxYz9sct4LPx3hDllyINsfiDvTMJoqfqdbS58qA7rHB6QODptEaOjFzHxA2F3Ra8qzEb16VCNoptgrsfReIthwnu58pCo1BWiVTOme4m6Ys+rXSqRlNryFJgIIOJCBSCdmuxif10hUhTvuDSYAwKpZNxkxpko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762354; c=relaxed/simple;
	bh=mFLE8Eki8UEtgO9xXuNzCmZEcwPiCVe2BIsOrzsAxI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0ZXkVt8aEtEve8lA1TbkPuspNeDjEn9DeQT0EeMONsdx3UR0ys009y+eoL3px8yKlFSvOaPMHvcn4pY3RuwZ5d2FcySMMdF/bcfOBO5BGlYVHwms+Hb/vM1vIj1//DLpUy/qTMQ+0nRp/PwsxYvY769r+Rk8vyffyYNU8KFBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ie3bPBs+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ie3bPBs+"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42f7b17f9f7so2248005ab.1
        for <linux-block@vger.kernel.org>; Mon, 06 Oct 2025 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759762350; x=1760367150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlbR/hLzOsQLmDn5DZrzY4KfozQVDsskYfJwhYrKehw=;
        b=ie3bPBs+4Fa7794ZJfAp2oIetIIW4uxnr9Qpop5xqWwXwV8ym6iIZzBa/3UPx1PL0Q
         xvVPL926zDja24WyBGPzWQkScoWucSd2w79Xssjpe6IsJ5gbMVHXa/FFVmJ3BrcyuBDZ
         bYzBxhmGwK+7sgwvrC0zE/J2CsUt2A/LaMMY0PGJzOf+8Wm4WXGybaAkmeK3QQfpQaVS
         VwZqW/vF2JyGRTj/wzLQA5MtSJ4R1A/u4wzrATxOq0FXtBT+glJse+DxxkC0i+vKfk35
         RDBMECRyTRxeDw/SjpsmHrbFS/6l7pq2JyYWA45/KVfDvBBy2dx2yZ/P9QmApHEAPruj
         8gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762350; x=1760367150;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlbR/hLzOsQLmDn5DZrzY4KfozQVDsskYfJwhYrKehw=;
        b=SrqASUhcgnncDRXeaXrcCB0F6Fhvg8K6miW+g1HQPEnmNg2jdY/0wYaM2oysVrKPMc
         8eQlU5iLtVQdOzY9ou9qxQQLEEGw1fSmRbLjGP73oKAglNijxWqzFmJniHOGpoe73Oxz
         RH2wUzKW9rTUqk+Q2/g80BZWUByOFW1AspOe+WE3Dg8EVb7tgnanO/PCciK3zK05V1er
         1Kqli4jJSLNK8DLmFvHAXPLSy6CFWBL65kta7QTy679M/8oUI01DW4InrKrMBA8PDzTc
         YQMBBvhjpk79F2mYhvEHHHVeHimT25CcUzH6HaS9nJi3gdkKHmdszflza4YpZpBXj8WX
         h5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXNu+lYH+bjzA/3r/s42tvGIJl79rgvW9PlsRpI4NR0f1+5DVaJ4vl/fkvBpmgum9PtCFdKEHB0eQs3yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCCBr3HhnNWuErorm0WKP1FqdZlup/u1aLs+FWQ1IMc7nkbBcl
	txhkbfXL1pyB1KTQnkfE9pIbsv+NnKxYGnAZnPPYJ4KgjtrS2jCOQVh2/LwiSU38qwQ=
X-Gm-Gg: ASbGncu4E+SQ/BrLdb6qOOKTRPpm9I6q7gnjZncjfQ0OPTVLyGrRe5j1z53wAwnIZA2
	szOyMjFhnZxmIuQ5v7tSwqlknn1FaY8oDZ4w0EA8M4j5I3Orj+1R8bPGYqAeARQg9J09zKw+rJd
	OIJRdkbbDYoqu/CptNc1hLMsCMTHvP5VjgImEZ/yXbSjIi7AcJUZNJuiZFEwr3TCg2A5ZBrn7Na
	WwdY8aVoBMgD1iPULVK4oWtqdiXk1cCNTXs766HGE4ZkbbYHyi4a78OZMKJfDKizwfxnJwg0BnH
	imkKoeo6LWwLRHz6oh9ZleaR9hxcbdIm/dw7dzMwcKdUCOzP6NXmi1v79U1oIG3RthoVyo6nWX7
	2YBJFH0vTQ7H08pEWMMtLZWiMhzq5NcghTbptGFFi6wn3
X-Google-Smtp-Source: AGHT+IEJN7EykLM4II7Nc1RZBJ1wPHjey+isWsfIbGWEkw9SfJz+SZYeKca+xUOdqaMCUV6s4N14AA==
X-Received: by 2002:a05:6e02:1a0d:b0:42e:729a:4b0d with SMTP id e9e14a558f8ab-42e7ad6e802mr163997875ab.20.1759762350058;
        Mon, 06 Oct 2025 07:52:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5e9eb49fsm4975250173.1.2025.10.06.07.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:52:28 -0700 (PDT)
Message-ID: <24f8b266-f17c-4909-b43d-8ab05721c5d8@kernel.dk>
Date: Mon, 6 Oct 2025 08:52:27 -0600
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
 <d23fa119-c1df-4861-99e2-c35c1214baa1@kernel.dk>
 <576197870bdf21ea97559a1d84869fdcb9535156.camel@physik.fu-berlin.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <576197870bdf21ea97559a1d84869fdcb9535156.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 8:48 AM, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-10-06 at 08:27 -0600, Jens Axboe wrote:
>>>> But that's fine, it's not uncommon for drivers to miss things like that,
>>>> and then we fix them up when noticed. It was probably written by someone
>>>> not super familiar with the IO stack.
>>>
>>> FWIW, Oracle engineers actually made some significant changes to the
>>> driver that they never upstreamed, see:
>>>
>>> https://github.com/oracle/linux-uek/commits/uek4/qu7/drivers/block/sunvdc.c
>>>
>>> In particular, they added support for out-of-order execution:
>>>
>>> https://github.com/oracle/linux-uek/commit/68f7c9c17fb80d29cbc1e5110f6c021f8da8d610
>>>
>>> and they also changed the driver to use the BIO-based interface for
>>> VDC I/O requests:
>>>
>>> https://github.com/oracle/linux-uek/commit/4b725eb64cc10a4877f2af75ff3a776586f68eb7
>>>
>>> Could you review these two changes and tell me whether these would
>>> actually implement the changes you would want to see? I think the BIO
>>> layer is a generic interface of the block layer in the kernel, isn't
>>> it?
>>
>> Moving lower down the stack to use a bio directly is not a good idea,
>> it's in fact going the opposite direction of what we'd like to see in
>> the storage stack. And it would then mean you'd need to implement your
>> own internal requeueing and retrying.
> 
> I looked at the virtio_blk driver and that seems to confirm it. There is no
> use of the bio interface either, so I guess we should not pick up this
> patch.

I'd be very hesitant to pick anything up that hasn't been posted and
included upstream...

> What do you think about the out-of-order execution? Would that make sense
> to upstream it? Does it look reasonable?

I have no opinion on that, there's not even a description of why that
change makes any sense. Sorry but I'm not going to waste my time
reviewing out-of-tree code, it's just not a very useful thing to do. If
the changes get submitted upstream for review in a suitable fashion,
then they will get reviewed.

>> These are the kind of changes that happen when development is done and
>> changes aren't submitted upstream. It's unfortunate drift...
> 
> Well, the problem here is that Oracle stopped working on Linux for SPARC
> abruptly, so many of their improvements were never sent upstream and did
> not see any reviews which would have caught this.

And to be frank, the changes you referenced also look pretty incomplete
and would not pass upstream review. I guess they are dead in the water
at this point, unless someone else picks them up and polishes them into
something that can be sent upstream for review.

>>>>>>> For now, I would propose to pick up my patch to revert the previous
>>>>>>> change. I can then pick up your proposed change and deploy it for
>>>>>>> extensive testing and see if it has any side effects.
>>>>>>
>>>>>> Why not just test this one and see if it works? As far as I can tell,
>>>>>> it's been 6.5 years since this change went in, I can't imagine there's a
>>>>>> huge sense of urgency to fix it up that can't wait for testing a more
>>>>>> proper patch rather than a work-around?
>>>>>
>>>>> Well, the thing is that a lot of people have been running older kernels
>>>>> on SPARC because of issues like these and I have started working on trying
>>>>> to track down all of these issues now [2] for users to be able to run a
>>>>> current kernel. So, the 6.5 years existence of this change shouldn't
>>>>> be an argument I think.
>>>>
>>>> While I agree that the bug is unfortunate, it's also a chance to
>>>> properly fix it rather than just go back to busy looping. How difficult
>>>> is it to test an iteration of the patch? It'd be annoying to queue a
>>>> bandaid only to have to revert that again for a real fix. If this was a
>>>> regression from the last release or two then that'd be a different
>>>> story, but the fact that this has persisted for 6.5 years and is only
>>>> bubbling back up to mainstream now would seem to indicate that we should
>>>> spend a bit of extra time to just get it right the first time.
>>>
>>> We could do that for sure. But I would like to hear your opinion on
>>> the changes contributed by Oracle engineers first. Maybe their
>>> improvements are much better so that it might make sense to try to
>>> upstream them.
>>
>> Won't help this case, and it's actively going the wrong direction
>> imho...
> 
> OK, so your opinion is then to add the patch that you proposed on top
> of what's currently there in Linus' tree, meaning adding some code
> that will requeue requests once the retry limit has been reached?

Right, the patch I sent is against the normal upstream tree.

> Can you maybe post a proper patch then which I (and others) could test
> and then hopefully add their "Tested-by"?

Sure.

-- 
Jens Axboe
