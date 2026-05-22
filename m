Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86838B131
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432904; cv=none; b=FwDbNDTfDeyPevnEVEIqL9KwjXxISMfxNnof5mm4bEMzPWV5aV6mmUZR892/pFJejIybdE+feFLJceyS79Pgmotp0ybB/+ez02i6xbyvUi18gY4TAAwQTaHSXXmT3mhg/SVvuKX53Zs5KDZZyM0pgTZm581/W/SRa0eiwf916sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432904; c=relaxed/simple;
	bh=J3+5OL5EhLqcxq/nt7CPYWw8xRqdSV4nBMp25MrOrT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOTjyngdnLhZXJINTxKsB1dqY4+rRYlbjox1ZRyOLZgItxrkiY05fs6/hlw7yps8Q3F5QY/m+M6MPbxdJmuyTWsovOKHHHRGogh/ugZJGz/R99N0Cgo+YGfNZImaYqm1Hjm5qJbAIqWa5R+mJ+9GJGXQMarLOD++xMlDAWayYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64M6swjV086528;
	Fri, 22 May 2026 15:54:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64M6swhR086525
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 May 2026 15:54:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7ef76131-d077-4cfc-80ab-69720a214a5c@I-love.SAKURA.ne.jp>
Date: Fri, 22 May 2026 15:54:54 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: add sync_blockdev() in __loop_clr_fd() to prevent
 UAF
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
        syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com,
        Hongling Zeng <zenghongling@kylinos.cn>,
        Bart Van Assche
 <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20260522025451.845068-1-tom.leiming@gmail.com>
 <e4deece5-d866-4a44-9097-eaa1e2727c0b@I-love.SAKURA.ne.jp>
 <ag_RZc908B64hTFG@fedora>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ag_RZc908B64hTFG@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp

On 2026/05/22 12:45, Ming Lei wrote:
> On Fri, May 22, 2026 at 12:28:34PM +0900, Tetsuo Handa wrote:
>> On 2026/05/22 11:54, Ming Lei wrote:
>>> Fix this by adding sync_blockdev() in __loop_clr_fd() to flush all
>>> pending writeback I/O before clearing lo->lo_backing_file. Since the
>>> loop disk is already closed at this point, no new I/O can be submitted
>>> — only writeback remains.
>>
>> Why can you assume that synchronize_rcu() + drain_workqueue(lo->workqueue)
>> is unnecessary? Since we don't know exact commit which is causing this
>> problem, we don't know what has changed.
> 
> When sync_blockdev() returns, there can't be any inflight IO:
> 
> - no one can open this loop disk
> - no dirty page cache any more
> 
> So why do you want to add rcu/drain_workqueue?

The fact that __loop_clr_fd() is called before lo_rw_aio() completes suggests that
some works queued before __loop_clr_fd() is called have not been completed.

I don't know what sync_blockdev() guarantees, but even if sync_blockdev() can guarantee
both "loop_queue_rq() is no longer running" and "all pending AIO requests issued by
lo_rw_aio() have been completed", I think that sync_blockdev() cannot determine whether
lo->lo_device has pending work or not.

Therefore, I guess that at least drain_workqueue() is needed before sync_blockdev().
If sync_blockdev() cannot guarantee "loop_queue_rq() is no longer running",
I guess that both synchronize_rcu() + drain_workqueue() are needed before sync_blockdev().

(And I don't know whether sync_blockdev() is appropriate because we don't know what change
made this problem visible. We didn't hit this problem until Linux 7.0.)

> 
> Fixes: 1fe0b1acb14d ("loop: only freeze the queue in __loop_clr_fd when needed")

The Fixes: for these reports should be the commit which made this problem visible.
Or, this patch will be needlessly backported to stable kernels.

