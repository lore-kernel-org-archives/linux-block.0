Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496835E1BC
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380179; cv=none; b=cggaHs7G1Qzknut37qKZoeV7HvxZL5H14W7m0n1CWCSxQ6tpILHKRhRq6hz3mDZFpqTVfoe0f54nlJCm+diHs+HysPi0H17WtNercEPWuv3DI1QEDa4mjZQNCOzZ7x43WM32eRrgC3M434NETc8z+sZC8DyNrYGuwgHRxZrTBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380179; c=relaxed/simple;
	bh=ETRHvYs4cdwdVUjJXotuVsY46P8swuGD+YBiFPLAyiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oU9RWbVWzCZlc73+tbM1NvFTNUrpbWt3onBQ2QJBoKu1mipAvhi9VMxqfOEcwTZOPF7nD5TQM3o7gfZ9yEYJNueBV5V5f8ML0mmgAyosPHtLbdgZ+2ayvodmOInZm4WHR/iqlRX0FRCv2eYlBgXzBoejcTF4OYzv5B5VwmJfj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 697DZwMS020642;
	Wed, 7 Oct 2026 22:35:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 697DZwCk020639
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 7 Oct 2026 22:35:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp>
Date: Wed, 7 Oct 2026 22:35:53 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] loop: Wait for I/O completion in __loop_clr_fd()
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
        Edward Adam Davis <eadavis@qq.com>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Bart Van Assche <bvanassche@acm.org>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
 <20261007130851.GA30117@lst.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20261007130851.GA30117@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav212.rs.sakura.ne.jp

On 2026/10/07 22:08, Christoph Hellwig wrote:
> On Mon, Oct 05, 2026 at 02:06:02PM -0700, Bart Van Assche wrote:
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>
>> Syzbot reports a NULL pointer dereference in lo_rw_aio(). This crash
>> probably happens because commit b15e4310633f ("jfs: Set the lbmDONE flag at
>> the end of lbmIODone"), merged in the 7.1 merge window, lets the JFS log
>> code report a write as finished while it is still in flight. JFS then tears
>> down and releases the loop device with that write still sitting in the loop
>> workqueue.
> 
> Why do we go offtrack messing with loop instead of investigating the
> file system misbehavior?

How can we investigate the file system misbehavior?
Earlier versions of this patch
( https://lkml.kernel.org/r/30ccdd3c-6353-4a0f-bdc7-230ec3bf4765@I-love.SAKURA.ne.jp )
included debug code for emitting BUG: message, which is intended for helping filesystem
developers identify the caller of an I/O request that failed to wait for completion,
but I got no response. Please show us viable approaches.

> 
>> Although the root cause is in JFS, improve the loop driver by waiting in
>> __loop_clr_fd() for ongoing I/O. Release &disk->open_mutex temporarily
>> because otherwise a deadlock would be triggered.
> 
> We can't just drop the held lock.
> 

That's why I proposed a new callback which you are refusing to add.

