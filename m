Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433677;
	b=AddGW0s3RERxVJ1NXvBHkuafPlO9edN31o0UE3w41ew1q5GAgYJ4KlTL78PqJGPFulRL
	 yoE+vRvsJjIbp0cWEuTClMR4RECXHCENnhao6cDD2WRjcCxed9cImk+Cyu0A15UOILLtP
	 5OLqjp5JBvduC97VEY6/3ZxR4OtHRe5QrpfYeJPd/H321FVUSnZDOhHrweM7qKC0+w0Rd
	 CUyOx3cct5fDozUqvj48prp//BBNX2ZrqIk7Sc5CA5uzn/9fiRT/8KJZQ11n5n9L+oh/p
	 HCCZ/Dt/fYmhjJ1xeQtBiLWkpyPr+cPzAoRE5PB4D11NLknxjpOTXOBw//vH/QYOnGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433677;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0NW5PHzU8niu/Vyq4xWZ0l8rjf3Rlalc4LXyc2xQlwg=;
	b=LxY06H450KSqTKMo1F+uGsa+XpfwcXUYsqlk5tljcwFCs9EXRPH5yTPaam7zEhEPKElV
	 4SdSGzBiKFTKBhAB0C3z6Z20IwzIjLSEJA4NmyW/xPUmFp/Ct9kdrXVSbJO784pTue72n
	 GVvJRQ2Qs1IE7eY0+faz4CEUojUid9u5a4AbeAQvDchsecXdjXTge906ksCGIMGMudq9L
	 38cSr2BTMRRW4YYbVe9SVrrNaKydPzc7i32VcLWbWkMyXVZ5Hf6F+PNXrmdjMG+n8VGLE
	 mzBvwCvK8hw814caTC0q6HNV8LULwI5bex6lRHyy5uIfxSyK0JYmXoa3CuQQPkx87aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W1HjE5bz;
	arc=none smtp.remote-ip=91.218.175.66
Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB1606A31A
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 11:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1FB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W1HjE5bz
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oxaCqIVg13ImZ+B7nAeaMCiK0nlxtkXNZVdvJO0RIyc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795433675; v=1; x=1796038475;
 b=W1HjE5bzp1rH8OCW52+xWhhIRSJeMKRMn6cVUnk14tIyopR95KQN/KHY1nNoWzRztc76DvVY
 xYynpAaIyyjGRJG79CvDaaJ+qPr5uGvmc3IbYdYNoZwUZFtL3bYRR3iq1OAoqKgLdwSpLYf35yC
 Eurx2tzpGFpBw64JT8nIvJ+U=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 6f5034aee4cb3981;
	Mon, 23 Nov 2026 11:34:34 +0000
X-Mizu-Trace-ID: 6f5034aee4cb3981
X-Migadu-Flow: FLOW_OUT
Message-ID: <28200e68-464d-45b8-a7c8-c3f239b31841@linux.dev>
Date: Mon, 23 Nov 2026 11:34:32 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: fail short atomic bounce bios in
 bio_iov_iter_bounce_write()
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261120-gratwanderung-wickeln-mitkommen-1fa50bede59a@brauner>
 <20261120164309.GB32683@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261120164309.GB32683@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 16:43, Christoph Hellwig wrote:
> On Fri, Nov 20, 2026 at 10:04:37AM +0100, Christian Brauner wrote:
>> No objections per se, I just would like see Christoph take a look first.
> 
> No fucking idea.  As far a I can tell atomic writes are a mess and we
> should not have done them in the first place.  Ask the people who
> create this mess.

For this series, the 2nd patch just removes some duplicated code.

As for the first patch Re. bounce buffering atomic writes, it's a 
another similar check for creating multiple bios for a write. To me, any 
atomic write should be stable and userspace should ensure that. But 
whether bdev_stable_writes() should also check for atomic write 
capability, I am not sure.

> 
> ---end quoted text---

