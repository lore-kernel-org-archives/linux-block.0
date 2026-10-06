Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE04A1DE4
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306951; cv=none; b=FqIcPAGHlxASpirAF0qTbGuYh1qsBhHMaUroCkGXCowdM5EpMIHH3eOevzPHtoOnZ7zlp/cpEiB+7qKau21khHs3i5Z255SJf22uWbzFknJytZWfP5Z6WnwZX/EYWZBWiKyMKfEemsWvf9Un0XaH0PjXJA0VGqKFcxUqCqMh8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306951; c=relaxed/simple;
	bh=pMTh8OILP/knIia4xXbccXzUqmnVlKecVpWNIRB94To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDmySj87dTl+jyvoG8rlwkMCsS9McdwGJlCU8oIX6QhyKKxwUznVi5MGmRX/1YjVrndNLqs4RE4jRUJThhFEU+wl4RFnfVE+6Ih6/wJMHC+uv6cL+JGdX0cpm4fOQumj0I7yWb15mngKUt5D7h3Jd9ybUkoTbAWvBagq6Vg5NQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=t+uU8+aF; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="t+uU8+aF"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hzjZX5Jfhz1XM4Tl;
	Tue,  6 Oct 2026 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791306942; x=1793898943; bh=GG0ZOgRygc5B20PrWaq1zT2P
	RT7ThIZd6hHYSh5aOKU=; b=t+uU8+aFC/vV7kaI8EY4qFGi1ZC9S4dTeC9aCTaD
	qAhVwO7zFIJoYb0e1N59P33k8ZSOyqO8MUQBBoYoMB+0uxwy/FbkyqhJB60KoTIH
	7ueWF0YY9QdEhgob+UvjurAw/Sd+TGau8+pHIimdZqYUIRdFy3DAjrQuAZD0AQOO
	bWXjY/B/3eEjuWobzlprHP/3XveXTVWeHApHkyub3Z4eOZZPpwh1YKy0nNVkDbHd
	ruG1T/Hg7lhs4QwK12RiZMPzFoQMMLIituP4DDKaKdFI7h5Kp2PrMZO0UeMUg41y
	E5gbfljBRdTlrQZGPfe9HbqRifYZyNCClmc+v4v9pYhIfg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7nZmg3Khj2D1; Tue,  6 Oct 2026 17:15:42 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:c218:dfd1:de79:d1ff] (unknown [104.135.182.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hzjZM60pNz1XM4TB;
	Tue,  6 Oct 2026 17:15:39 +0000 (UTC)
Message-ID: <dd6ef42b-cf9f-495f-b813-a3bdeaee5a1b@acm.org>
Date: Tue, 6 Oct 2026 10:15:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] loop: Wait for I/O completion in __loop_clr_fd()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Nilay Shroff <nilay@linux.ibm.com>, Edward Adam Davis <eadavis@qq.com>,
 Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
 Jens Axboe <axboe@kernel.dk>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
 <5026bd9c-c6cc-4179-8703-13d2843b5ae7@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5026bd9c-c6cc-4179-8703-13d2843b5ae7@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 5:01 AM, Tetsuo Handa wrote:
> On 2026/10/06 6:06, Bart Van Assche wrote:
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>
>> Syzbot reports a NULL pointer dereference in lo_rw_aio(). This crash
>> probably happens because commit b15e4310633f ("jfs: Set the lbmDONE flag at
>> the end of lbmIODone"), merged in the 7.1 merge window, lets the JFS log
>> code report a write as finished while it is still in flight. JFS then tears
>> down and releases the loop device with that write still sitting in the loop
>> workqueue.
>>
>> Although the root cause is in JFS, improve the loop driver by waiting in
>> __loop_clr_fd() for ongoing I/O. Release &disk->open_mutex temporarily
>> because otherwise a deadlock would be triggered.
>>
>> This patch introduces a behavior change: openers racing with teardown now
>> get -ENXIO instead of waiting.
>>
> Are you sure that commit b15e4310633f ("jfs: Set the lbmDONE flag at the end of
> lbmIODone") is the root cause for JFS case? If yes, it is a step forward fixing
> this regression in JFS side.

I'm not completely sure. But all the console logs that I checked on the
Syzbot dashboard include JFS error messages. I think that's a strong
indication.

> Was your concern "releasing and reacquiring disk->open_mutex from __loop_clr_fd()
> seems risky to me"
> ( https://lkml.kernel.org/r/e5518546-701e-4d3c-a077-18e34aa8c188@I-love.SAKURA.ne.jp )
> dissolved?

After I wrote that comment I noticed that lo->lo_state == Lo_rundown
while __loop_clr_fd() releases disk->open_mutex. lo_open() fails if
lo->lo_state == Lo_rundown. Hence, bdev_open() will fail while
__loop_clr_fd() releases disk->open_mutex. This is a behavior change
but I hope that this is acceptable.

> sashiko commented at
> https://sashiko.dev/#/patchset/fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche%40acm.org
> that blk_mq_quiesce_queue() / flush_workqueue() are redundant if we call
> blk_mq_freeze_queue() first.

Sashiko is a great and very useful tool but in this case Sashiko is
wrong. From queue_zoned_qd1_writes_store():

	memflags = blk_mq_freeze_queue(q);
	blk_mq_quiesce_queue(q);
	[ ... ]
	blk_mq_unquiesce_queue(q);
	blk_mq_unfreeze_queue(q, memflags);

If calling blk_mq_quiesce_queue() after blk_mq_freeze_queue() would be
redundant, the blk_mq_quiesce_queue() call would never have been
introduced in that code path. There are more occurrences of the above
pattern in the block layer, e.g. in blk_throtl_init().

Calling flush_workqueue() is necessary because calling
blk_mq_quiesce_queue() doesn't guarantee that all queued work has
finished.

> Even without releasing and reacquiring disk->open_mutex, I think we can silence
> lockdep by removing synchronize_rcu() / drain_workqueue() because these are
> optional as long as we call blk_mq_freeze_queue(). But is calling
> blk_mq_freeze_queue() with disk->open_mutex held guaranteed to be safe?

My patch unlocks disk->open_mutex before blk_mq_freeze_queue() is
called, isn't it?

Thanks,

Bart.
