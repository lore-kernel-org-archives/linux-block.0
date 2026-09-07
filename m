Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FB37F300
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772826; cv=none; b=gf7edwSuhQEt2MlpdMvuQMsXdmvCujAqxLIypxs1bv7xMxGPkiBMpYFBUZGta2pUwoZdKpGMiFfVKcD1PPt1y/bGZ7UUuvj7rWJkwWJgYHkXEYm6QbLLkFRv5V7SFawPgiSN6D2gPpomOCgPFJcDCt3umOTjbwwn5J1UlzohQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772826; c=relaxed/simple;
	bh=ybMTWC9H/A8W5KkE2argi4jh9MKl4LDBs1eh/rJcz0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tdhj8fZs4bEeGBXkBphMJAbayHxSCEFyw8VHecFod/qA5wNrUQn6ONOZP3XgwG/KpcnQzG6d1e2KprakL4wpDSxMh4W5mHcAD6pSaWKH9H2XyOQSdwEaRzI1GazrxyZuqy3OHng0YY35ZNNQggaAgtS3V1RvsTJy+7uO5r47w2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Op+sabGr; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Op+sabGr"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ybMTWC9H/A8W5KkE2argi4jh9MKl4LDBs1eh/rJcz0w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788772822; v=1; x=1789377622;
 b=Op+sabGrZ8yhZIZSxNrz2TjaRUkQaV/rl8aAbX7Opp2huj53evAOB3vnYNyh4xR4iqhdA9dt
 Zxv/PdVzmZXS7UvEHhKdAUieGGRYljQxC4l9Ioc/pKIz/xC6/Gnoarh+h9Ooo78yZ1JVHroveqU
 yxLEWfV7IUVenpMACOvucEvc=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f0a97c76ea9427da;
	Mon, 07 Sep 2026 09:20:03 +0000
X-Mizu-Trace-ID: f0a97c76ea9427da
X-Migadu-Flow: FLOW_OUT
Message-ID: <90f94bcd-813d-48f9-a62c-3c703c4a71e6@linux.dev>
Date: Mon, 7 Sep 2026 10:19:58 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org
References: <20260907074111.721054-1-hch@lst.de>
 <20260907074111.721054-3-hch@lst.de>
 <8c16f727-c840-4a8f-94a7-fbe09bc3735a@linux.dev>
 <20260907084621.GA7391@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260907084621.GA7391@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 09:46, Christoph Hellwig wrote:
> On Mon, Sep 07, 2026 at 09:09:47AM +0100, John Garry wrote:
>> On 9/7/26 08:40, Christoph Hellwig wrote:
>>> As Sashiko points out,
>>
>> Do you have a reference for that? I'm just curious, as we don't support
>> atomics for integrity writes. Well, for SCSI we don't... we impose this
>> restriction via sd_config_atomic(), I need to check for the same in NVMe...
> 
> https://sashiko.dev/#/patchset/20260831064010.2574896-1-hch%40lst.de
> 
> Search for "atomic".

cheers

So this mentions one issue which Tal addresses in "block: fail atomic 
writes instead of falling back to buffered I/O" and how we need to be 
wary of fragmented atomics.

As for atomics on disks with integrity support, we decided not to 
support SCSI WRITE ATOMIC (32) - this one is relevant to PI type 2.

But, overall, I'm not sure on this - should we always disable atomics 
for any disk PI? Is there a use case for the two together? Martin?
