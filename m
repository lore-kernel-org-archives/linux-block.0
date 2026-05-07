Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFC3E6DFA;
	Thu,  7 May 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150526; cv=none; b=Fn8C6N9o2lRI76BdZQg/ldnlO5yR5nBtEa7EnYL2sFAm8uLJFpgseusqmkGtI3rGkKCKzWkfmuqnxuhvUgft8fcPB1UV8DNC4bHnXQjQI5qdn6d8SRDM0qlItmdzETgYRyB/hJOx2bWfCq36N+dUsYNln0s16FtVJAwD5cZGsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150526; c=relaxed/simple;
	bh=LUMEAJ3VR0Zf6O2vnqS6y0SiY8nPZA1ghjHwZEQlhU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGyPPZwBsIaPE7A6fGvXEbIKc4dEaX0rWdyNjuwNwWIo9E6itZNqeJx5kY4I+E/4gGfWFK5WD8ebeFgCIL8GFjDFZ8p7J3iSUuJ2//B/GXWjStQ0cnBC8O+HQJilPu0GM3n8NJBSIOEaL0PHaJpDV3sPnF+2PmrfZq/3hiXqgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IzIP4+kv; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IzIP4+kv"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gB82G6xCjz1XM6J6;
	Thu,  7 May 2026 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778150509; x=1780742510; bh=xWpn++S5e4f4RtwpISkvTC6M
	f7JtyR3gfj0F5b4gwio=; b=IzIP4+kv6qkYBVYTuaKJKfVmR7pTzkm+EraCN0ba
	aO98+al1SVhHx1keqwCDetjXxfCMKVRVh0NLMZnRo0steSmVHz2+rvYhyt397bX6
	oj2+If4MhUmZ+tBv8jJmY+H5buvkqFR29q7sReBBUExsQ/4zxatjKZ/KHfNctq+h
	rWWuTXuQ0mXOCzzOWbVQDwSEuMbvNO7uDZfAJUh9HnE72nmgNNsAHO98p6neXbMw
	qiF9qCFGyNXrIlZFLskKFsfdkA9m3gC6BxxNM2Bk/oyJ4TXRpgSCyATYotIhCPAb
	yBLcZ0u+4/QKkrrJ1FOJznBCSVwKWOpQViorANdId1tmvA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wHuYM0-9RYZ6; Thu,  7 May 2026 10:41:49 +0000 (UTC)
Received: from [10.231.136.254] (46-253-189-47.dynamic.monzoon.net [46.253.189.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gB81x5GcBz1XM5jn;
	Thu,  7 May 2026 10:41:41 +0000 (UTC)
Message-ID: <c189c126-163a-41a7-b872-96568b33c1a8@acm.org>
Date: Thu, 7 May 2026 12:41:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, clrkwllms@kernel.org,
 rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
 mkhalfella@purestorage.com, chris.friesen@windriver.com,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
 ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <cover.1778048987.git.ionut.nechita@windriver.com>
 <406f424c0a718bf492d40c206983e355e600945a.1778048987.git.ionut.nechita@windriver.com>
 <50187fa5-03a9-4ca3-bcaf-a36ed75bda2c@acm.org>
 <20260506074758.8zEg1ZBh@linutronix.de>
 <713ba2ae-e322-4e56-b0b8-89766f7f65c1@acm.org>
 <20260507074502.cFMtH9BB@linutronix.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260507074502.cFMtH9BB@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/26 9:45 AM, Sebastian Andrzej Siewior wrote:
> On 2026-05-06 11:43:32 [+0200], Bart Van Assche wrote:
>> On 5/6/26 9:47 AM, Sebastian Andrzej Siewior wrote:
>>> On 2026-05-06 09:14:33 [+0200], Bart Van Assche wrote:
>>>> If the atomic_inc() in blk_mq_quiesce_queue_nowait() is protected by
>>>> hctx->queue->queue_lock then the above code doesn't have to be modified.
>>>
>>> But wouldn't the atomic_inc + barrier avoid the need to have the lock?
>>> Isn't this a normal pattern? If the lock is kept, we could use
>>> non-atomic ops here then. But this avoids having the lock.
>>
>> I strongly prefer a spinlock + non-atomic variables rather than using an
>> atomic variable and barriers because algorithms that use a spinlock are
>> easier to verify.
> 
> Hmmm. If we keep the lock, then there is no need for the atomic and we
> keep int counter. Then we are where we are right now with the lock
> synchronizing everything.
> Isn't this also improving the performance for the !RT case or is it
> simply not that visible here?

Agreed that not obtaining the queue_lock from blk_mq_run_hw_queue() is 
an interesting improvement. But I'm not sure the new 
smp_mb__after_atomic() and smp_rmb() calls are needed. Block layer calls
of blk_mq_quiesce_queue_nowait() are followed by a 
blk_mq_wait_quiesce_done() call. The latter calls either 
synchronize_srcu() or synchronize_rcu(). Either is sufficient to 
guarantee global visibility of the change of the queue state to "quiesced".

This patch removes a spin_lock() call from
blk_mq_quiesce_queue_nowait(). That spin_lock() call guarantees that
other CPUs will observe the "quiesced" state after the store operations
that precede the blk_mq_quiesce_queue_nowait() call. I don't think that
any block layer code depends on this but I noticed that this change has
not been mentioned in the patch description. A similar comment applies
to the blk_mq_unquiesce_queue() changes: the ordering guarantees
provided by the removed spin_lock() call have not been preserved. There
is probably code in the block layer that depends on the "unquiesced"
state only being observed after prior stores performed by the same CPU
core.

Thanks,

Bart.
