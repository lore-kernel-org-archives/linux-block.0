Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEA1C6F6C
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706750; cv=none; b=APdtw202S5jDiWg1kDHRFDvNQrDsPCCUGxnr9W2He4xIxMQv3LscfAupFUYa7R2x1ZjPvOv4ufc2tqvL2brGO3JEuQougaZVpnhDhr0Gr84H9kBL75PVk7egG7LoW37KIDf20XPOF2gPl/HmDqonqR3da3bioLo6xTgYH7rqvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706750; c=relaxed/simple;
	bh=oEaDo2kybVFDzi/NhFITXzCPo8uFtJlRzA+ZM08Hg9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wp277NcrOLPtV9cgDmhHAslMjTN6bfBbxIXmf7+5rtWco2X/VJ5cTglB6wO+UrefXy9BjgRwrHnIo46n2JDWoPmWxbCgyI5BUmt3c8SpDTLbL1jHfal39de1yI8AA7mJZmxOYL4R4p2HNaSCgU3qWIfvutEBI95x0sZtCFb9ZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XU0VKADX; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XU0VKADX"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XYcRJ0G9dz6ClY9V;
	Wed, 23 Oct 2024 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729706746; x=1732298747; bh=X1imJyw1koIR/tmRgV6cPQ5D
	eMZfvhrj1ANBWcZYcMc=; b=XU0VKADXfJMCD9pO4sj3em4k5yoh0t0acTqppapn
	bPGMPrP5g3jfSQ5W1z3DnfjTjBcCJkJln6W08hNgoY1Z58mUShFZfk0e17skiA4s
	txIkahx5CN/m8igXoR/6Q/W+GdnlNym7FOj3bdsCFOsWs1tnEwlHPIFkYVahbCHQ
	etcGyl2H6pAkup0depMEWmHBeilt3yjJoX5NlonxNsB6QHRK5S/zROZXng3pFaqJ
	yqrwcHprsch4rN2fEoqSnv/qBP0E5m+hZMteL/t9uj6tIn4nNVZ2H88LYUMpN8NK
	ug938pPQduT3kXXVLGofQ/9YixxNRV5qth5va79ggNlyoA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GE5pV_St0w6g; Wed, 23 Oct 2024 18:05:46 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XYcRG07crz6ClY9S;
	Wed, 23 Oct 2024 18:05:45 +0000 (UTC)
Message-ID: <25c20682-9f37-411a-9a1d-a8009fc96909@acm.org>
Date: Wed, 23 Oct 2024 11:05:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for supporting
 lockdep
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
 <ed9a22b7-64b7-4b83-a6c9-1269129e89d1@acm.org> <Zxis2vQgXENELBAr@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zxis2vQgXENELBAr@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 12:59 AM, Ming Lei wrote:
> On Tue, Oct 22, 2024 at 08:05:32AM -0700, Bart Van Assche wrote:
>> On 10/17/24 6:35 PM, Ming Lei wrote:
>>>                  -> #1 (q->q_usage_counter){++++}-{0:0}:
>>
>> What code in the upstream kernel associates lockdep information
>> with a *counter*? I haven't found it. Did I perhaps overlook something?
> 
> Please look fs/kernfs/dir.c, and there should be more in linux kernel.

 From block/blk-core.c:

	error = percpu_ref_init(&q->q_usage_counter,
				blk_queue_usage_counter_release,
				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);

The per-cpu ref implementation occurs in the following source files: 
include/linux/percpu-refcount.h and lib/percpu-refcount.c. It is not
clear to me how fs/kernfs/dir.c is related to q->q_usage_counter?

Thanks,

Bart.
