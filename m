Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FC3C276E
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805152; cv=none; b=fwks2ZMWRNC7CXgeYx+kGi43QFE/CEnlCc/opHcyDcKKvQ+xD1xGdL2picc53780PLGiVW8gugrxMTXKvcmqg0tfIJFPr/9VMQOsM07IUEqZlE4pS9j0zpmKELN6hqIpXPAo19vDnEzqiC9ejoOLwk24JfdD9sm2qP4Dmqsx7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805152; c=relaxed/simple;
	bh=FXRFcCXDuYq8qmwYQZKSFwQnJ49W1x0ZsbSwvxX/FMY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IOa4T1YBGU7x8gmnCFFrd5ah2SdXTQJEgmtuYCpVn71idYRot1K4y9u/H0v4rsB4ijUnoTjVl2Dn5EXIq/46I9xwItFtMj3Mv2PHUVkSYeejZU3Xj+ziAi98dfC8Yas424/nCLljvaDNnBpkn4bkzRBHEmRvb3I9JjlyZe/My6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69CBd1d7026098;
	Mon, 12 Oct 2026 20:39:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69CBd1AK026095
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 12 Oct 2026 20:39:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d05d7049-70a1-4216-b268-1c209834dc84@I-love.SAKURA.ne.jp>
Date: Mon, 12 Oct 2026 20:39:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Wait for inflight requests in bdev_release()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
        Edward Adam Davis <eadavis@qq.com>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Bart Van Assche <bvanassche@acm.org>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
 <20261007130851.GA30117@lst.de>
 <4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp>
 <380f04ef-902d-4664-9ae3-228692d2efb9@I-love.SAKURA.ne.jp>
 <696e5e7c-e3f1-4181-be2a-8915fd1753cf@I-love.SAKURA.ne.jp>
 <cc2910d3-3113-44d4-94ef-0c8d365fac9c@I-love.SAKURA.ne.jp>
 <53c3ccf7-1a5e-4861-afc0-7cbfd3284655@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <53c3ccf7-1a5e-4861-afc0-7cbfd3284655@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav112.rs.sakura.ne.jp
X-Virus-Status: clean

sashiko's review on this patch
( https://sashiko.dev/#/patchset/53c3ccf7-1a5e-4861-afc0-7cbfd3284655%40I-love.SAKURA.ne.jp )
pointed out that attempting to freeze the queue or wait for in-flight requests
generically inside the block core's bdev_release() is highly dangerous.

To resolve this safely, we must move the synchronization out of bdev_release()
and back into the loop driver context. However, any viable loop-specific fix
must reconcile three architectural constraints explained below.

*** The Three Verified Constraints

1. __loop_clr_fd() must complete before close() returns to userspace

  We cannot defer the teardown asynchronously to a background workqueue or task_work
  context after close() returns. Past attempts (e.g., commit 322c4293ecc5) proved
  that breaking synchronous autoclear semantics causes failures due to delayed fput()
  on the backing file.

2. Outstanding loop I/O cannot be safely drained while holding disk->open_mutex

  Draining the loop workqueue or freezing the request queue while disk->open_mutex is
  held introduces heavy lock-inversion risks. As verified by syzbot, this creates a
  circular locking dependency: disk->open_mutex => (wq_completion)loopX => VFS /
  Subsystem Locks => disk->open_mutex.

3. Leaked in-flight requests can execute after device unbinding

  As demonstrated by recent debug trace logs, filesystems can leak outstanding
  reads/writes during mount/unmount. If the loop device unbinds the backing file
  pointer via __loop_clr_fd() before these leaked requests have been physically
  drained, the loop backend kworker will later attempt to process them against
  invalid or nullified structures, resulting in oops reported by syzbot.

*** The Two Viable Architectural Paths

  Because we cannot hold disk->open_mutex while flushing loop requests, yet we must
  finish flushing before lo_release() concludes, the block layer must choose one of
  the following two infrastructure designs:

Path A: Temporarily dropping disk->open_mutex inside loop.c

  We explicitly drop and re-acquire disk->open_mutex inside __loop_clr_fd() to
  safely execute synchronize_rcu(), drain_workqueue(), and queue freezing.

  * Safety Verification: This is entirely safe against parallel openers because
    the loop device state has already transitioned to Lo_rundown. Any concurrent
    lo_open() entering during the temporary unlock window will immediately and
    reliably fail with -ENXIO.

Path B: Introducing a new post_release block core callback

  We introduce a void (*post_release)(struct gendisk *disk) callback in struct
  block_device_operations. The block core will invoke this callback in bdev_release()
  immediately after it has dropped disk->open_mutex, but before calling module_put().

  * Safety Verification: This cleanly isolates loop-specific synchronization from the
    open_mutex lock context. Since it executes within the built-in block core lifecycle,
    it guarantees module safety and completely eliminates the lock-inversion risk.

*** Conclusion

  We cannot fix this loop regression without either temporarily releasing open_mutex
  (Path A) or introducing an interface to perform the cleanup after open_mutex is
  dropped (Path B).

Jens and Christoph, which architectural trade-off does the block layer team prefer to accept?
