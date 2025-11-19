Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D12E8B66
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571671; cv=none; b=sZG2JRYVXRjVfYJ+LZyNAXpoYCAEOtAnAbt5zyzPVZtHIHYZEcoQMcKIj8Y+EK9glKeRozQu9QXcWddRMXaLZLPBcwWBo9BTuc0AEGdKEm6JyigtxAKOcAkFhg9Y44qfFVwgajDzuTLDPOmAfEFQl9b5z1GY66jbtQeZ3nH3Coc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571671; c=relaxed/simple;
	bh=S+g2O7p94RosAqIDLahmLjRW/MydzsAFbfENsPa65W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaBibh+AoNDXQ9brV5cZ3p1CW9qsY4pD0WDHZgePWV1L6VepALwGlbVVwq+gBMkOnYUJObHCbF7bWYYcKly61ib93gGNmZ9L1yhYjgSwiiRHcHHhs19tsobwyjr6UrShA7wIVZTI2nEnBf05Q64q6PJukI6fhUm1+KEq23+u6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2J9ar4+b; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2J9ar4+b"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-94905c3e2a4so46061339f.1
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763571668; x=1764176468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPw9uCkFvNA6PQCNX1TL4ZbkMo01ysJzYJr/l6U8Vyk=;
        b=2J9ar4+bvL6JUu3IwzjT/+5nXBeigKRCJ/2Z0FigQH99srL8ApqOMZYkap+Eg6Gj/t
         KvBameeHCKeSwP8O0SOm8NHL/GhiWaB+GJOC6+ayH9G9V98KcvfFuQW/GSQ+kEgdT+mT
         UMdLMrV1xPPET5vTOHv27ezT4bUeaLSXU/ej6SfWAAXRN5MbqJumDD+0/y9ObnZl8ETG
         rNy3L73+/Yn/dwH2jdgzZiYSaChxMkwfFZ/TSrgclaUDqVenocJrs25K9A1hh8pMkkLS
         F2RFK6HEhKzUhyYmZSB/VMjM7WARShkuRabXM/uFCOcoTUJwGzNzFC2X1KdE2t3BFqKg
         /J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571668; x=1764176468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPw9uCkFvNA6PQCNX1TL4ZbkMo01ysJzYJr/l6U8Vyk=;
        b=UTJ6QnWjtMr57povfTUccVbGWvHR/L/c6RUbovlE3aQiPKHWX2MGmKQzoUtVLeP75b
         BwzUvPw0jZbSg/Yz+N/nHMuTezxnjWqNjH3k0nzxaPXcJT2weksa9WeTJavULU4TMczq
         CXheBnGh7Mk2Hl6/c203gEW9WZU4xqW0uGvbN5jbmXtbH+WoF3MJd7CtWPFcFjxkL2Bc
         Rfm4fi2qVpuSQhKZpSV30YpNQ1BQutH7TO9UKOupGdAzFRK4x+mT9Lx9mM16yzV/o4RX
         l/h73XcLUhb59w8MpclaeuHXPQ2L/FkqqVCQt3TCWLZ+yO8YnviSoukBVVrL6m2iIbNh
         A+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0+W0GE3YxZojf6Tpe3vDzKwJt1pfSjqOGh3RVzDs80u7sQRGyOeJ9WMN6RLBMm1bXUBtYho33nEoeqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHf20fgahBn1/epB6xKIBxNcM8TunGRR1M06LvnEvXi1PneBF
	T8HaAumTLDHoCdltoNrDcnm8Mco01pSJzb0U+RKXw3MdlmHtc7fCA8krwBwbiva4OXo=
X-Gm-Gg: ASbGncuubsBr0reW31+8GuOsvRrISUM28tmAa3Esi82r7j+HMJNmBxTWtEzQ8T3SUSp
	wZvbeDY1wN+Wnd7kFYOz1LNfdSrIkyHexXKHyN27uIexPUNtRnzh8zLnX591xWWcYjfC36vn349
	e/A6sAFDQ9aj8NKhk04O41gE9gNk9VGdhLxFmfFbWJnG1oyeEtyEq7GXI724RuIXAtqJxSHNevy
	2SSWt0l999WDkwnzlA9g0PeSCUdPXFdcqManKtQRj4puUXG9GHleWBe95IKBZoxCVBNP6c8ZdF2
	8Ubbk+MTr1bxKQTrRv7s56kLtCoE0yTCj4gxK24b++6wdh+f1asgp+Eh4zBXOsb/6zQlt0G4kFJ
	bbizPajbk6YeQbwgn5wTCwrRsy6Rj8n0Ys8UUv3lLhL5G8y+LamuEFCa6BiY+fviTzxKUA5zCbG
	rRCykDYPY=
X-Google-Smtp-Source: AGHT+IE2kxjS0yAG6GVYp2OCmpVNdv4loPq+aa5O9jQG6Qcw+IMJqxGOrGh2WjEVj74aOlxlbHQ9xw==
X-Received: by 2002:a05:6638:c1e8:b0:562:6587:e697 with SMTP id 8926c6da1cb9f-5b80c3bc4d6mr3251546173.2.1763571654771;
        Wed, 19 Nov 2025 09:00:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd32e141sm7591110173.44.2025.11.19.09.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 09:00:54 -0800 (PST)
Message-ID: <7cf8b8de-0ed9-4182-aa84-de29f16f37f0@kernel.dk>
Date: Wed, 19 Nov 2025 10:00:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add a flag to allow underordered zoned writes
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev
References: <20251118070321.2367097-1-hch@lst.de>
 <f385de59-5bef-4ddf-b363-edf76f88d855@acm.org>
 <20251119075800.GA23083@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251119075800.GA23083@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 12:58 AM, Christoph Hellwig wrote:
> On Tue, Nov 18, 2025 at 10:10:33PM -0800, Bart Van Assche wrote:
>> Is the following deadlock inherent to this approach?
>> - Several bios are present on zwplug->bio_list and these bios cannot be
>>   submitted because their starting offset is past the write pointer.
>> - No new bios can be allocated because all memory is in use.
>> - A deadlock occurs because none of the queued bios can be submitted
>>   and no new bio can be allocated.
> 
> This can if the number of in-flight bios is larger than bio mempool
> reserve.  Which is real, but we also have this in various other
> submitters that hold bios to submit in a list.  This suggests it is
> mostly theoretical, but I'd still love to address it for all these
> cases.

The default bio pool size is 2 entries, which is perfectly fine for the
"normal" alloc-and-submit cases. But yes if you're doing a bunch of
allocations before submitting, then it could certainly deadlock if the
normal allocation fails and we end up sleeping in the mempool waiting
for previous unsubmitted IO to finish.

It's certainly a bit tricky to handle... But definitely something we
should take a stab at, as it basically voids the forward progress
guarantee and is surely something that will cause production workload
deadlocks if REQ_ZWPLUG_UNORDERED is used.

-- 
Jens Axboe
