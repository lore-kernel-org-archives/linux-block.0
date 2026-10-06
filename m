Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E53EB0F2
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288102; cv=none; b=J1NiEzQYtCNhKt5wKASBE4lCh3U5G02YfqTi4kD+pU2F+PUhgK4zx84hOVnR05qFigrgerW41EEUh2dlr+TFxJphazGFAR1lCooeUVCi6UvthQQPokp0CSbnuG+2YQAKJ8Sf4VcXPHqsqaGT1EaS2PGLe6uifN7b8s15Cll0IGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288102; c=relaxed/simple;
	bh=PbTc9zVxyG98vDiYvlbm9ND3T8uXtfdYff1hqXqXeS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvAXwNeUfCMMLF129XObXFHnDWm6ZhHP9VzbQp1xdLARUcZ44gD6mWE47uNg6mhSnoapVeA9zyM/HpeD4+439eGpWbyr3r0/sOj3lnQiQGdEim/s/Fb9UpmyJQhbZFrNOlwjE35nn0AUsliG3HI6DmV3Rp83st7SjIg5GE93cxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 696C1aSn043934;
	Tue, 6 Oct 2026 21:01:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 696C1a9l043931
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Oct 2026 21:01:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5026bd9c-c6cc-4179-8703-13d2843b5ae7@I-love.SAKURA.ne.jp>
Date: Tue, 6 Oct 2026 21:01:33 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] loop: Wait for I/O completion in __loop_clr_fd()
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nilay Shroff <nilay@linux.ibm.com>, Edward Adam Davis <eadavis@qq.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, Jens Axboe <axboe@kernel.dk>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav112.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/10/06 6:06, Bart Van Assche wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Syzbot reports a NULL pointer dereference in lo_rw_aio(). This crash
> probably happens because commit b15e4310633f ("jfs: Set the lbmDONE flag at
> the end of lbmIODone"), merged in the 7.1 merge window, lets the JFS log
> code report a write as finished while it is still in flight. JFS then tears
> down and releases the loop device with that write still sitting in the loop
> workqueue.
> 
> Although the root cause is in JFS, improve the loop driver by waiting in
> __loop_clr_fd() for ongoing I/O. Release &disk->open_mutex temporarily
> because otherwise a deadlock would be triggered.
> 
> This patch introduces a behavior change: openers racing with teardown now
> get -ENXIO instead of waiting.
> 
Are you sure that commit b15e4310633f ("jfs: Set the lbmDONE flag at the end of
lbmIODone") is the root cause for JFS case? If yes, it is a step forward fixing
this regression in JFS side.

Was your concern "releasing and reacquiring disk->open_mutex from __loop_clr_fd()
seems risky to me"
( https://lkml.kernel.org/r/e5518546-701e-4d3c-a077-18e34aa8c188@I-love.SAKURA.ne.jp )
dissolved?

sashiko commented at
https://sashiko.dev/#/patchset/fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche%40acm.org
that blk_mq_quiesce_queue() / flush_workqueue() are redundant if we call
blk_mq_freeze_queue() first.

Even without releasing and reacquiring disk->open_mutex, I think we can silence
lockdep by removing synchronize_rcu() / drain_workqueue() because these are
optional as long as we call blk_mq_freeze_queue(). But is calling
blk_mq_freeze_queue() with disk->open_mutex held guaranteed to be safe?

