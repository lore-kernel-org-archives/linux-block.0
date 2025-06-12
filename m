Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CF218E9F
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731331; cv=none; b=EvSUDJB4VDJaykIwmXIfJ0a0Yg7sytzx89J+JUK3ziQXErb7aTU+WhLDWHkMmVK0YzbP2kVRbHmD568g7TfOHbS62lpf5M2tuDbSTZfvZNFme09cDHTUHPCbv2OPl+XG05XILlBNn93HkCTz6WJAO9BwdvQh2da4y2desvpi4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731331; c=relaxed/simple;
	bh=LKWu0A9zcTmfDPWAQ/ocK7Rl7FIrHKCadlCszRPsuzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGVJzKS5xZTKtd6I/goK+jnL1zT3NscRSer54wGCMKoOANY2JrVYFz4oARgeFyshdYWZs9gVaiJU8Vh3gcShuGgjJ/+SFQKwssFkqAtuNOgefzkYasQJ+Mz+i5aKsqi2teO9H1iZ0sHW8powe+koxd95sA8vpU/NOuMb7IC+Th4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AGLuhTyE; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AGLuhTyE"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3dc6f6530c5so7812135ab.3
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749731328; x=1750336128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UImZZoXMl6EH/HjzqcIe4x4dgx13eahuhyrGyyVP2dM=;
        b=AGLuhTyE17KkqkSjLsX8eKG//D6/ffcYwHJndB6XDcjGuxvqHbae8c+nuuPwbRbFeg
         szTmodZ3cN3pLmvPSeB7NlZGdxmlG5ss6p1GSlW0EzpHYvK5iSt8J80VcjrC6QkZGQoM
         tNJ7jYqiT1ePDD9GOb57M+rOe8oxZtZfSfuifJE+nvz1SFP8x8dqo9t8qxdLtrCMIgD6
         LwepuwedqdOO7J94e95VenUBtE8edUr2gnTtupfSIdc2l1nvnmuSSECHK0GgQq/duiN4
         ZIlNEb5uCy6M4yaAw2OrPG9Acz2w5MR/YtH0epfeEID0fiiW2CTGxhpGdVpIWAcF7y9r
         tKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749731328; x=1750336128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UImZZoXMl6EH/HjzqcIe4x4dgx13eahuhyrGyyVP2dM=;
        b=pZKxtAo4/UcLudZk8K142W1AOKmywfQq/YTuRQtVQOyyt7P0oj0n4XvXmaUjjfmB5X
         xIkhL3uZaqnzTUfOn4pNZgrh5L/I63exkfNbSsF/+/ShfcVV9FeHnW1W2rVU6N8CQv5e
         t74MQDkrcbb+zrJB1zfWzO87uaUT9n/Qu8zE+FYP24IEYqF/qJ+ocQp7o8hYJm4UZdI6
         wP1FItf6m7Eq5tfYN7ybw9IRBIgTm00fWo/FoAoaxdeSTogqQi2BxkoaOxMcu/nfWA2n
         Jsgq6dxYJ8Vp2oCinMThmTw9zXC5TSMKyrxcHfS3pCTf4lVeEjpdCYRSQ319IWy/Wyfh
         kcFA==
X-Forwarded-Encrypted: i=1; AJvYcCX1jcoxSFsM39Hh36nQYbUhXrArC7KD5AGPklV3/ATCWKvucfrrDxLcYZ0SZtT5jO2KgCWRKv4WhB7+DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVeywMReZ++L0THnZhItTlWXGieHyugeZHf6a7ysNa8Uolclse
	x0sNU5zvQJcqQU3lIdS0mlyMilsVnVROVDsm8VBjSZbdQH2Fd2M8uYqodHXFieFgOs0=
X-Gm-Gg: ASbGncsnrTs1jPRo/EA+InEM3bgdU7/dUXC/NrYqf7wct3zsUKLYb870jHxqbDyUVdG
	mTEmy5Nw5KPwLDI4j04W/VI5/hEfzB1ikZNqdE97s0Smn43XvNmtSbTz0dMaZIMC/A6Q8OBNCMy
	Ghiskilb5qR02aTV1mQswhNRR3dx7ucsESMSvgBdEeNzM6wBgpUEwEkydAcB1nD3zVx2RXb34T3
	4+iCq95+LWa1p5AidKIoW6rNsB6QUMHDEPIgNDuFxGDBl7S8TPF4cQ83VjJmylqNipZAh0n0rVu
	ms7YFX/HkvBQl/x4tAHGQe8cCbERl6x27LwRkontVXVVSGFQ2BBefuUbmdE=
X-Google-Smtp-Source: AGHT+IFkBhSvZIx1vTcq+k3YA7sUCU2iiR0CIQdLiCvZ4z6pvMgM8nNsfnKa/k0Wou/bu0ArxoY+cA==
X-Received: by 2002:a05:6e02:1525:b0:3dc:87c7:a5b5 with SMTP id e9e14a558f8ab-3ddf42261cbmr82655865ab.3.1749731328149;
        Thu, 12 Jun 2025 05:28:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5013b758323sm269650173.11.2025.06.12.05.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 05:28:47 -0700 (PDT)
Message-ID: <2de604b5-0f57-4f41-84a1-aa6f3130d7c8@kernel.dk>
Date: Thu, 12 Jun 2025 06:28:47 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
To: Christoph Hellwig <hch@infradead.org>
Cc: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
 <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
 <aErAYSg6f10p_WJK@infradead.org>
 <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
 <aErGpBWAMPyT2un9@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aErGpBWAMPyT2un9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 6:23 AM, Christoph Hellwig wrote:
> On Thu, Jun 12, 2025 at 06:21:14AM -0600, Jens Axboe wrote:
>> It's certainly going to make the cached handling more expensive, as the
>> doubly linked behavior there is just pointless. Generally LIFO behavior
>> there is preferable. I'd strongly suggest we use the doubly linked side
>> for dispatch, and retain singly linked for cached + completion. If not
>> I'm 100% sure we're going to be revisiting this again down the line, and
>> redo those parts yet again.
> 
> Yeah.  For cached requests and completions it might even make sense
> to have a simple fixed size array FIFO buffer..

I did ponder that in the past too, as that's clearly better.
Experimentally we need ~32 slots in there though, which is 256b of
storage. Pretty sure I have patches laying around somewhere that did
that, but didn't like the plug and batch size growth on the stack. Maybe
overthinking that part...

But ideally we'd have that, and just a plain doubly linked list on the
queue/dispatch side. Which makes the list handling there much easier to
follow, as per your patch.

-- 
Jens Axboe
