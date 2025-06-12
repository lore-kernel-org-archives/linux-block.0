Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6D2376FD
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728963; cv=none; b=eXpuccV/St7nVEaeMDEmg9Rx6Vl6MWgevEZu5qC9E7g2lZRhZheq6S45Z3mqtlOhL3KGCzlXVHJK72Y3/5rViyqpuIZYVG6KuRFklhMtKpIS3CBB87QJX3HMm7LTaoHUJXLBFFJNtE764n+KVHG9Mn+tiQARkQ0gQwtqcKAEk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728963; c=relaxed/simple;
	bh=4aACmAThOHY2o0B5dT/H1K7V6L7HlrFv1VnArYNh7e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHn8+mF54hlA2vDbhBP1a7O8J4T6mezRamhhO3W3CK9YhFIRv8UFSRyjBrCdvDLq1uiGJ1aE6Rz/dk1lIHzDy1S1N/iqS9yDViSpiPou9VCmwIb9zz/OIhC1F0sHCYuATf86kP33+JwAzJctc8+S80IcK/+/uJV6Bs+lYO1BvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2CDyQ+9X; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2CDyQ+9X"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso3311965ab.3
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749728958; x=1750333758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCDRRhl1aTxRB+4WG/aUj18mGIyTgj7I7CqokNc9ljI=;
        b=2CDyQ+9XKuOojI83lGb1CBdpIwS5BjNi6kdBWOt4VyPBZMkTKGS61gKFovIxpuiYEZ
         YcYXRXkgK4qP/GGsX0zpf/SiE3YvLR6LYMEfCha8vLQxCsxLQZAHPCnQX43UxiRes2cf
         9cQHZVPizFTLrDsVo/F2snvoSLqKAW9p7Q5TPY9chQSGmO+QabMmnKRh50+nrZezyMDu
         ii/ZMWYHZZsLZtTZS573WcWsJ8DRHToWK+wEjrhLrLp+5D3humMJqs4hstwmeJNreF4+
         7lqKUkDXqm178kQONj45ylUpGTPTNSBfyQAqwY8HQ5pgh+4rnLhmP5kyzMzZEDW6bFpW
         kM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728958; x=1750333758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCDRRhl1aTxRB+4WG/aUj18mGIyTgj7I7CqokNc9ljI=;
        b=XI3FrZ66EE38foBT1PB+mtClbCPS3sMSerIJ5W28phHl7SC7D699TsXNkqVz0VfzJJ
         9AefiO5f/x8uxlglmkoct99yssawgf7+UthW5S9nDXx798fszIGGp0kAMBoUFNjL7jD0
         ap0MA/IubNDmVEIqkVCIi0nHuxabSioVeGpLR8COdtG4urO39MukGDRQKkMaty0E7+pv
         qSJnF0dDWVEb50bBUxaLI/N7GsZqsHRymOOi8UzTUVGQQ5+zwN70eIc41vU7oDO3fQTL
         B6aI2EcRQFv6CSS1I5B6Mc5IoouY7p+3LZXSMnsBvIMvR1c3ZbP0bUwpuAwx6Lx7f7RB
         wbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPbRPkYGk7sup216AOSNuiW92Wg9wTBvPxTV2inN1oIobTcZrk2ue4ZQ/dcpwsricc8J4O/CyzFCZNow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNS5W0XGK5YFGCoyNkOYWwxMSMNoBsVKxwI3fZL8JeOG/zKfD
	M37a0GrWrdeqrz5x15aUrP+Q+Q5t9exZk4FenTRxEZJX2EVYZCyy8Nx+ZeU+y8POluS0GhZ6cNK
	lBobJ
X-Gm-Gg: ASbGncuBViX1tWHnfhsFhgpGmSTqcwojleDw1Kp7CLfDVkYanZ0MB2ATmZPJliBHSEm
	g7MM3+CxiP63nCebjiN6vhv3BXn18CrNuzX+IOKr3e+7tT/ssa75x5XUGYcnjWH34dzixxq8m+s
	03ROaxBuMAXH6XRkyfGSlu35V2yrhPjKjTIwNBGCVDYxYREFk7VBNcArTjN3BLDp4d9fSuTbMOZ
	TEvzSumdq5GarHsefY9912veFMYPTj9juLkkjYjN9ZItRNMccWIf1SwAZs+PGxGPt26E6+fPbKM
	uoYhnlmKrWWRV94UoJ+dXMMmZ4cllq/bkKPezbp+PrODS8A2W8+k+CWto1A=
X-Google-Smtp-Source: AGHT+IHcjAz+GIG8l9QKvVCz5PPBTVZbJ8bC2zc9cS2nUWyS0irJBr+JJbtTuQ0eZpC0cvq+bk/IDA==
X-Received: by 2002:a92:ca48:0:b0:3dd:ebb5:6382 with SMTP id e9e14a558f8ab-3ddfb57a7camr25792145ab.4.1749728957946;
        Thu, 12 Jun 2025 04:49:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5013b8fc729sm247414173.125.2025.06.12.04.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:49:17 -0700 (PDT)
Message-ID: <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
Date: Thu, 12 Jun 2025 05:49:16 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aEpkIxvuTWgY5BnO@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 11:22 PM, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 11:53:07AM -0600, Jens Axboe wrote:
>> Yes we can't revert it, and honestly I would not want to even if that
>> was an option. If the multi-queue case is particularly important, you
>> could just do something ala the below - keep scanning until you a merge
>> _could_ have happened but didn't. Ideally we'd want to iterate the plug
>> list backwards and then we could keep the same single shot logic, where
>> you only attempt one request that has a matching queue. And obviously we
>> could just doubly link the requests, there's space in the request
>> linkage code to do that. But that'd add overhead in general, I think
>> it's better to shove a bit of that overhead to the multi-queue case.
> 
> Maybe byte the bullet and just make the request lists doubly linked?
> Unlike the bio memory usage for request should not be quite as
> critical.  Right now in my config the las cacheline in struct request
> only has a single 8 byte field anyway, so in practive we won't even
> bloat it.

The space isn't a concern, as you found as well. It's the fact that
doubly linked lists suck in terms of needing to touch both prev
and next for removal.

-- 
Jens Axboe

