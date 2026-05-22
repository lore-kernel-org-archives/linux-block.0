Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE373BB132
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443684; cv=none; b=f+t/k4d2ooUOwqwmKmBPayZbrVx201ZwnB4ZGY4tBHUAr/i8A2jW1ZzUqF7vi7amxKuq4KKaZ3FElttv42wou1h2PxtU+6kfpMo+RMTtWV8HWLVvnY4mdOhJXAmA3IQLREqhLl8GbLKW0TQtHeXwNaiqVf7yw22Z14K3udtBSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443684; c=relaxed/simple;
	bh=f3yXMh5YD627afpefDZXV/jQ73UUA9uaRUsm7Q53U20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuxUUTLrOGxLsBTjXrBeEXAwKrDKcaVKV7vdX2l05MdmFuuQeGiQB3+iM/PKSkZFD4Ytgru6QfgAWuqFV9XAn7exn3kIFC5paAX/TUyotqp91ksOVL4kHqKdz/8G+aV3BHUXJlxsgXLxd21YRHf+TijX9jPSYdkDytb4O6ZN9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64M9sdMD035551;
	Fri, 22 May 2026 18:54:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64M9sd79035548
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 May 2026 18:54:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3001ff83-b48c-47d0-aaf3-81a8d58a0a44@I-love.SAKURA.ne.jp>
Date: Fri, 22 May 2026 18:54:39 +0900
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
 <7ef76131-d077-4cfc-80ab-69720a214a5c@I-love.SAKURA.ne.jp>
 <ahAjBvh8IfPCreRG@fedora>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ahAjBvh8IfPCreRG@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/22 18:33, Ming Lei wrote:
> Please do take a look at the commit log of this one and commit 1fe0b1acb14d

My question is what commit broke "->release is only called after all outstanding
I/O has completed" in the patch description of commit 1fe0b1acb14d ("loop: only
freeze the queue in __loop_clr_fd when needed").

>>> Fixes: 1fe0b1acb14d ("loop: only freeze the queue in __loop_clr_fd when needed")
>>
>> The Fixes: for these reports should be the commit which made this problem visible.
>> Or, this patch will be needlessly backported to stable kernels.
> 
> Will add it in V2.

Commit 1fe0b1acb14d relies on commits before 1fe0b1acb14d. An not-yet-identified commit
which went to the merge window for 7.1 broke what commit 1fe0b1acb14d relies on.
"Fixes: 1fe0b1acb14d" is wrong, and "Fixes: not-yet-identified-commit which went to
the merge window for 7.1" is expected.

