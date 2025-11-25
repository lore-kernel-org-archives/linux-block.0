Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2713AD26
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 03:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042984; cv=none; b=VktuoE28Ysayn8cgKtyqyP1u9XEMQtR1CtqFY87KWUh3D/2I+AWGDsQ3uL8kfb/4uT0hMR5CTkT97ZKSMjpOMPUh4GkLMbcpPjAwle7HkJ35twDZerIk8GHu7UNWSpGGkxE3pslbkwh2bOlvSMq/0VRuyS/ykWE724h+4uMqghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042984; c=relaxed/simple;
	bh=uNiSx/vzXhxVXFGaP8YHmN68rkv0rpH3Vw9jpqQ4U+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9To7UAzTaIsFrIA4GGzelgkBYopT8oS5UYhAFXNAWc1KRdH4UWuWtFKZ/y0W0OiIbn4ZvM/Dp9Np/5FIz/5px5F8wEaySqx8a9ocyiiebF7b1Ep+gh6pujaG/6XoSrRnTbt67y8EoZPo7DsLTknbnUl9I3+CwbrilrlwcB+Ls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e4EYIagT; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e4EYIagT"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9486696aafeso208263639f.3
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 19:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764042981; x=1764647781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4Lhmszpz2G1/wsjpQ2h4VF4MYBwTW2/kXm6Xq7f3pI=;
        b=e4EYIagTme0yavtSLnjB6sqrQOauKiMKi+DgI2idbx9pAAPMlBz1PIU/MWho3IWTMJ
         9wRzDhyDorUoTYkzhB6X1wTeBJmaR3WjOW9cqSdkAfdjJnZfkaFA58MmgZ82xSsMusgL
         djatTMSiTl4MbvL8FtvrQ0aKmPACJCIz97CLLEeIZsgN/0qA4e/YSeKidPCOVFlXf145
         1WpqJjbQMTEZ0y5rIDvBJT/eETd6vuI6JO+llkB7mivCYspcsWFf7tlgq3EUvYknJRbv
         jAQPehtqQZOteGeSnmnTXuAOxKHlsbIKeZMIYB4Qw2+UN1u5/H1XOzGABx7rUCe4HDuc
         kt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764042981; x=1764647781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4Lhmszpz2G1/wsjpQ2h4VF4MYBwTW2/kXm6Xq7f3pI=;
        b=AFOYZfU6+dFlgyYBr8vi5OrwECFW8oA40PgV0PHPPBaxLeMkB6z7ze0YS06zP3OfIQ
         aJR72lynWfYuU8V40EZBPGdLiuA4m2CCZyNuH0Dk9zx6UstBsmNshXv7+tqHn6VO3l7C
         vkK5l+N0EPv41auduEvt3rVaHh01ut925mrTIatLgpFte18SXdZb0/GWTR6KJT9JVz0V
         UZXF75RcKySXgoJe4iFBxK/7XoCyMDfAOc6nGgF7Egex7F/YrjvDLmsDjXI63KiczKHw
         QHYebObW2Yf+LhuAkxuq/cHSHOG6bS6xr8OIoLkuTlQa4yqERvVqk7fau1ZUw211MHy0
         FucQ==
X-Gm-Message-State: AOJu0YyuG4o80e8lsbMLIQRUfDpQsyylxIe17/jeHQrKfeiF5BLdFCya
	CmbPM5968ZOKm4LkHR3YnQGqbIWva5ZdPpeDI0TaFPkB4TFalbU7GwLcz9k1ZOaLWuw=
X-Gm-Gg: ASbGncubVHezRWNQQln7WmG4nPeRKmgFrCayJ5PDDUCe5CGMK/A9zXIDAmB1ahEBd8u
	kYJrIvEUWnUgC94IUr63g+R+fqofwuzji/fahP8fJDOanrUiCG2z4gPC47/KtGqj/sHTLR8G9Aw
	3rx1MTi5ZBQw+7C9QyBbOqX5nO0W7azSoeO1XqSe3t603vy3zcCJAnEg8Bv/DYa1aw35qtnzgAb
	2ksBWBjznuTXo0yOZSwWPoo/il9lNIuf5/1F99eQZsI8xjf7i9BeyVqzWc7D8LUaslLUTuvkztp
	nYoYbHY/QqxX8XFDjpWnJPghB9gRqmHspjjRG1UKOSBn7ak3DhX5mQ65MoL0eVln8mE9l6TR7MH
	Z4mP8M/3aDdP9cgi5F3bjy90nOm2HrBsqqswWO6mgwjJlRYcOfmxM7v2QRq6+QKZDBngvk04byn
	0rL13SzSBP
X-Google-Smtp-Source: AGHT+IGawpC+Z5/q6YxllckW16+unsUN3dJWW//JwKWwQ4EpRQwDXcjHj23hI6JnzFZjAqSZr/GROw==
X-Received: by 2002:a05:6e02:2613:b0:434:96ea:ff7f with SMTP id e9e14a558f8ab-435b8e787d3mr123760145ab.39.1764042980790;
        Mon, 24 Nov 2025 19:56:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48b75sm6469751173.48.2025.11.24.19.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 19:56:20 -0800 (PST)
Message-ID: <f7af84e7-93c7-4e0a-b86b-46e69cb8b6a7@kernel.dk>
Date: Mon, 24 Nov 2025 20:56:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org> <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org> <aSUbsDjHnQl0jZde@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aSUbsDjHnQl0jZde@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 8:00 PM, Ming Lei wrote:
> On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
>> On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
>>> On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
>>>> FYI, with this series I'm seeing somewhat frequent stack overflows when
>>>> using loop on top of XFS on top of stacked block devices.
>>>
>>> Can you share your setting?
>>>
>>> BTW, there are one followup fix:
>>>
>>> https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
>>>
>>> I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
>>> not see stack overflow with the above fix against -next.
>>
>> This was with a development tree with lots of local code.  So the
>> messages aren't applicable (and probably a hint I need to reduce my
>> stack usage).  The observations is that we now stack through from block
>> submission context into the file system write path, which is bad for a
>> lot of reasons.  journal_info being the most obvious one.
>>
>>>> In other words:  I don't think issuing file system I/O from the
>>>> submission thread in loop can work, and we should drop this again.
>>>
>>> I don't object to drop it one more time.
>>>
>>> However, can we confirm if it is really a stack overflow because of
>>> calling into FS from ->queue_rq()?
>>
>> Yes.
>>
>>> If yes, it could be dead end to improve loop in this way, then I can give up.
>>
>> I think calling directly into the lower file system without a context
>> switch is very problematic, so IMHO yes, it is a dead end.
> 
> Hi Jens,
> 
> Can you drop or revert the patchset of "loop: improve loop aio perf by IOCB_NOWAIT"
> from for-6.19/block?

Done

-- 
Jens Axboe

