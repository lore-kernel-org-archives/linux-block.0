Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F446426D2B;
	Mon, 10 Aug 2026 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379693; cv=none; b=nyaPITvp2eFvd0H6wwfE/D3HWgpmZuc85I529aK2Y0dVtvmeJVGnXbsZIymLBV8W2RmcrxBEOjA+0y3oY3jR8m71YkJKUZS/5DQeiXOVjv3JfXI32EElHQ68SnZdc2HMYkEm2/B0G1Tf+JPnKNtr+EzxqJzwPS57wK12SrOlLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379693; c=relaxed/simple;
	bh=1n5weGA3xtEKw6UG7igLss/eE5+zLKS9ArDekgYueoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiy0FWKnDKQNlLIwnJEodK6xQl8HW/buJGHVM1IHj/ePoGfxshK8KuzWr4uRukRctQkj9XfwJEKa8tCJlqHYvpTn+o4k0tdiUO3R2nPSVH0NoEGulam3aTruMxHqqJiPK+gjDmc6wTU2KWoSN1DhFJTYNmRRSz2cUF6bYi9TXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wuedhpCe; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wuedhpCe"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hJgMT3mvLz1XM30j;
	Mon, 10 Aug 2026 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786379677; x=1788971678; bh=GA+WLiTlvjArbsYCWEM0t+Rl
	0HCxi12K1ZGpQe+GWcs=; b=wuedhpCelYOQX8TPOIHXkV5XLSVA1UJyIgx33s5G
	5lryYVaJasvQZFr5DJRF4ipPBcwUQnCnA3r48yAA1QGh3FRvUGX7j0QBAx42zeJ6
	TloGPaoDshk2iyFKL8yWCAT47Sst0fLEV5LKKQpc2xaF99DBA0tuQvNSlT0QqL/x
	WyB+VnkUwOIHwz79BGCUVJynMCK76wCGRkiPhgNOYnQsF0mD6GiMvLdeAUU+3S9v
	qdopmSEe1npfMEOQhjLGtEEogYPxMLRAyR+IxoczkjSg2qWzBwa1bk3ySusLkBI1
	AFtjcUEygrtdZcIdKwwvZivpC+Q7OPp4O3WI6Z/oyHHJVg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sk6PZJJKqySN; Mon, 10 Aug 2026 16:34:37 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e3b:8:bf02:1d5:26f3:7213] (unknown [104.135.204.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hJgMG2MbTz1XM30h;
	Mon, 10 Aug 2026 16:34:34 +0000 (UTC)
Message-ID: <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
Date: Mon, 10 Aug 2026 09:34:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system suspend
 using PM notifier
To: Christoph Hellwig <hch@infradead.org>, Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
References: <20260806170108.2100312-1-daeho43@gmail.com>
 <ann0OPPglToV_hjs@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ann0OPPglToV_hjs@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 8:54 AM, Christoph Hellwig wrote:
> On Thu, Aug 06, 2026 at 10:01:08AM -0700, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> During system suspend, a race condition can cause f2fs_gc and f2fs_discard
>> threads to call submit_bio() while the underlying block device (e.g., UFS)
>> is in Runtime PM suspend. Because Runtime PM worker threads are already
>> frozen during task freezing, the threads become trapped in
>> __bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
>> timeout.
> 
> That does sound like a general issue with our block device / threading
> handling.

Daeho's description above mixes up unrelated topics. A runtime suspended 
UFS device is resumed automatically by the block layer if necessary. The
issue Daeho is trying to solve is unrelated to runtime suspend according
to my understanding.

>> To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPENDING
>> during PM_SUSPEND_PREPARE. Background GC and discard threads check this
>> flag and immediately stop issuing new bios, allowing them to enter a
>> freezable sleep state cleanly before process freezing begins.
>>
>> In addition, check freezing() as a fast path to stop issuing new I/O
>> when non-PM freezing (e.g. dm-snapshot or cgroup freezer) is requested.
> 
> .. which means that we really sould have all the relevant parties
> invited into figuring out whast is happening here, rather than
> band-aiding something that looks like a horrible hack inside a
> file system.
> 
> Unfortunately I see this a lot with f2fs.  Please reach out to all
> relevant maintainers for something that does not look strictly local
> to f2fs.

This information was shared earlier with Daeho 
(https://b.corp.google.com/issues/515470309#comment45): [ ... ]
Register a Freezable Kernel Thread (Recommended) [ ... ]
Why this works: During suspend, freezer stops freezable kernel threads 
before devices and block queues enter their PM suspend phases. When the 
queue freezes later, your thread is already safely sleeping in 
try_to_freeze() and will not attempt submit_bio(). [ ... ]

PS: I'm no longer subscribed to the f2fs-devel mailing list.

Bart.
