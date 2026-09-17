Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED92D2495
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604201; cv=none; b=Gj4UmHqmw/0j8bF3Ok7013y7vpwK6FzX2gCG/ttZY6dKjQ413287PTZPt7RGof/uVX4yZBHFJ97jOkvRXmIkmoKLXBzACWV+nt70m+TdGANB4NyDY8Ho6710eeKOE14Mp74Tt90OrOEhGvd/TnPwzA5m8H5/RT4b7regEMue8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604201; c=relaxed/simple;
	bh=ZCZT14E9BuIAMnhrbWwggU9ouR0/AHb2ffDVSXPs/SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBWmDk/fDieSOpN2S7V2LQnKUqnUhPecyJJtqrtmoE5S7/wAhjTX0/yA2Lr9+gXBKZNVx8x6m39MUzXsPdPoDRWXhZpKn4jfTZNs1cw6tpyhuSmpZIu45h82N9T2+gU8J5Wz0Xtz4+Fsqgng6yJLKnzlb5BcJMM2gUqTucL4Va8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68H0GHcW092659;
	Thu, 17 Sep 2026 09:16:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68H0GHHY092656
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 17 Sep 2026 09:16:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0ede7060-2fd4-4580-bc17-770a6d4a36d4@I-love.SAKURA.ne.jp>
Date: Thu, 17 Sep 2026 09:16:13 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <cover.1789587960.git.bvanassche@acm.org>
 <cb1383e61e1b4d63906deb9a947f781416282939.1789587960.git.bvanassche@acm.org>
 <aae44539-837a-4f75-9af5-694ecfd10784@I-love.SAKURA.ne.jp>
 <e80c661a-1754-4842-89e2-8f0737e49055@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e80c661a-1754-4842-89e2-8f0737e49055@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav115.rs.sakura.ne.jp

On 2026/09/17 8:05, Bart Van Assche wrote:
>> Since .post_release is called entirely outside of disk->open_mutex, multiple
>> non-final close() threads can concurrently invoke lo_post_release() and race
>> inside __loop_clr_fd() without any serialization.
> 
> This is wrong. The .release() and .post_release() callbacks are only
> called once. The following code from fs/file_table.c illustrates this:
> 
> void fput(struct file *file)
> {
>     if (unlikely(file_ref_put(&file->f_ref)))
>         __fput_deferred(file);
> }
> 
> /* the real guts of fput() - releasing the last reference to file */
> static void __fput(struct file *file)
> {
>     [ ... ]
>     if (file->f_op->release)
>         file->f_op->release(inode, file);
>     [ ... ]
> }

You are misunderstanding bdev_release() concurrency for the same "struct gendisk"
even if __fput() for the same "struct file" does not run concurrently.

Two processes can obtain file descriptor of the same loop device using open() syscall.
Two processes can release that file descriptor using close() syscall.

While __fput() is serialized within each thread because it runs under the task work context,
lo_post_release() (for the same "struct loop_device" which can be derived from "struct gendisk")
is not serialized between two processes.

