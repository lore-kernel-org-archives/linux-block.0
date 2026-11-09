Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249723;
	b=k93Ypu6M4z3OwFRLKsh/7ABpsHNuFRJ3eU7W2K2nLL6yFjzDnJRaQAlz/qCoJ2nvSx6+
	 OTFTZGTfpO+enTxdgBDOIAtBe1V8cqdZV7wxZbsqcftFvakNYj4V/pfcEEHmw7vP25Qj5
	 bwdtRnKyC2PYH0iM/FfZLq/J4GWZsV24oeR5PkrsL12hJxg0j2R3KMoP853Rv4BpOiZno
	 VAcZJvzaqSMxGyh6q1Kv90h7Q3Adnn1/mgxRD0OEz9Eg5klk3ocX9a80gMyiGNIAoptwM
	 ZuyLYoH+0wAORigW0j98QtqxAzm22w/r6x/52jTgMPqqLlqDdKviERP8n4u1ctekHaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249723;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZXH+YyMNiReqnmwo6eRN36nVICxrwgKNR+dw0oAxVeQ=;
	b=r38CQhhWCS+HGnYwPHvyelU/8s7fYK6JHAiuTjCJs7XfHAEi5SGgMO4MsfFbKWeaSR72
	 Kas5WdrfuDDqesxGPkqII1JBov3Hsto8/Lj1bnBwBNy/OXbJlNvgRBv6bOx56nGvwDe1V
	 0+v2TZZJDtYs7wk6fqQuycU+N/JQK1ZvILZQCtLQnDVDHEjNG8Tj8xrKe/o2V+WfhhY6C
	 rRh7jTBNYBQX88v7ZLCmX1U///gJKU0DwEgLw5nFc9yuChhFv0m5mETODapMXe/uDbeOZ
	 guD7grSG6Id93npQiJt9suXpSw5JPQDGv/6yzxJilDBuQ9vP30UI78ouFjYq0hHl3OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LE+9YW3t;
	arc=none smtp.remote-ip=95.215.58.206
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1E606A31C
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LE+9YW3t
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Fb3gh5FjtxZua2Zhsv160igC2ZyXSzhrVml7Sf5bIOE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794249719; v=1; x=1794854519;
 b=LE+9YW3ttsw0bySQ/Mr65ywIFrntYlV28SGL2AQxJ2RDoEhQnehyzswlQ2e66S9C5XOuRbUJ
 LKI3J3/44dNrUW4TzYj+Dy2W1ksN5YnxQ6OCJx83wKEDzLalD0qYFZUIUIjV73dWptPtulIsqpK
 4e1DyNjgftu8yUJlDOe5zQBA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ea1b837f0b4245a1;
	Mon, 09 Nov 2026 18:41:59 +0000
X-Mizu-Trace-ID: ea1b837f0b4245a1
X-Migadu-Flow: FLOW_OUT
Message-ID: <002d78a8-e344-45cc-9529-f2dd345a9ee4@linux.dev>
Date: Mon, 9 Nov 2026 18:41:58 +0000
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
Subject: Re: [PATCH 1/2] block: fail a short atomic bounce in
 bio_iov_iter_bounce_write()
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261107-blkdev-atomic-bounce-v1-1-f66344262096@columbia.edu>
 <6bc16c54-a9f1-4c51-ab68-b227eeecaf66@linux.dev>
 <74c7632e-52fa-4378-a15b-f90b492fe613@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <74c7632e-52fa-4378-a15b-f90b492fe613@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/26 18:27, Tal Zussman wrote:
>> This looks reasonable, as atomic stable writes are implied to be
>> supported from 3373503df025a ("xfs: use bounce buffering direct I/O when
>> the device requires stable pages"). I am wondering how to test and prove
>> this (change is good and maintained)?
>>
> I tested this with XFS on scsi_debug (dif=1 dix=1 atomic_wr=1), doing
> 1M RWF_ATOMIC direct writes and using fail_page_alloc to make the
> folio allocations in bio_alloc_bounce_folios() fail partway through.
> I had an LLM make it pretty precise and target bio_alloc_bounce_folios()
> using the stack filtering mechanism, so I don't think this necessarily
> makes sense as an xfstest if that's what you were thinking...
> 
> Without this patch, the write returns -EINVAL and hits the
> WARN_ON_ONCE() in iomap_dio_bio_iter_one(). With it, the write returns
> -EINVAL without the warning.
> 
> This also happened to turn up a scsi_debug bug: with dif=1 dix=1 it
> doesn't store the protection information for WRITE ATOMIC(16), so
> reading back an atomic write fails. I'll send a separate patch for that.

ok, I'll await the patch.

> 
> Does that answer your question/is that what you were getting at?

Yes, this is ok. I am really just getting at whether we can add a test 
for this scenario.

Thanks,
John
