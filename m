Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0C2192F9
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484063; cv=none; b=LadUx1V2bie+20GB2xG32VJzyTUbS6vYBZ37tAJgdfW+Ype5W3XauassWrVCvDz9zLhOkLRf98eXpZZEJEtmzZmH9AOheKBRmyLOItoj92EFKUmj12+byHx3c0tQbjp7UdJ+kEdyYBJ+pacO5faf02MDL+VP7ZLuQikG+e8UCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484063; c=relaxed/simple;
	bh=dSD+KoG73v1usY7f9yfIt6YqfiJ7Dvh5m2XiS9vO3BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBHtHsg1olVo8lSJvpR+zZtOABEizN+MhjtMomYqecAZIi2llOWGno8P99Ax1BSxkkA9fSYpjIoOtQv4fmlhtVUaIXEwWNEhgn9Z4qdCWEKeWvu24hHzGLgUbCFSB/QpwHf+FvNxEw6PwjFLiQyN+2LxINBhgvCCTV0R/9lwCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=P88uhPH2; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="P88uhPH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1788484057;
	bh=MHiirmakvdDhAEHiG2ro8dTWZ4wSYqYUtZH1UUbh6IE=;
	h=From:Subject:Date:Message-ID;
	b=P88uhPH2Y0PU8vxOb6QngcaRIg1jzT+CLojB+ysgmeXK2BCZ0/5P0Eupxri83y+eh
	 Ppj+n3+XZpfKw7Btmx6mGtvvshCpnrOGf9aE9zONTnGBJSDrBJI37mkA3jZ31D8vsk
	 M+HOpHbZrPb1V8pWFB3//jYupTJiwbjeeLuvvGwk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.31) with ESMTP
	id 6A9A19D100004541; Fri, 4 Sep 2026 09:07:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6719886816568
X-SMAIL-UIID: B8B4C3ABA9774BBE8A26798221B7806F-20260904-090732-1
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8] loop: Fix NULL pointer dereference in lo_rw_aio()
Date: Fri,  4 Sep 2026 09:07:19 +0800
Message-ID: <20260904010721.2085-1-hdanton@sina.com>
In-Reply-To: <dc2f1e00-5e10-4e02-9415-c6ecb2cbc6b3@I-love.SAKURA.ne.jp>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 4 Sep 2026 08:50:46 +0900 Tetsuo Handa wrote:
> syzbot is reporting NULL pointer dereference in lo_rw_aio() [1][2].
> An analysis by the Gemini AI collaborator [3] considers that this problem
> is caused by a timing shift primarily exposed by commit 65565ca5f99b
> ("block: unify the synchronous bi_end_io callbacks"), along with helper
> refactorings like commit 92c3737a2473 ("block: add a bio_submit_or_kill
> helper").
> 
> But due to difficulty of reproducing this race, discussion about what is
> happening and how to fix this problem is stalling. Also, we haven't
> identified how many filesystems are subjected to this problem.
> 
> Therefore, introduce a grace period for flushing outstanding I/O
> (which should be a good thing from the perspective of defensive
> programming) so that we won't hit NULL pointer dereference problem.
> 
> However, calling drain_workqueue() from __loop_clr_fd() with
> disk->open_mutex held causes lockdep warnings. We need to flush
> outstanding I/O without disk->open_mutex held. But we can't use task work
> context, for there is no way to reliably wait for completion of a task work
> function inside a loadable module when module unloading code for that
> loadable module has started. We need to use a callback function which is
> embedded into a built-in module so that it can reliably wait for completion
> of synchronous teardown for the loop driver module.
> 
> Therefore, add a dedicated callback for the loop module to the block core
> layer, and invoke that callback immediately after disk->open_mutex is
> released. It is possible that multiple threads invoke that callback
> when a teardown work was scheduled because disk->open_mutex was already
> released, but concurrently calling flush_work() in order to wait for
> completion of an outstanding teardown work will be safe.
> 
> Link: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 [1]
> Link: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 [2]
> Link: https://lkml.kernel.org/r/fbb3edda-f108-4e5b-acf2-266f043f8125@I-love.SAKURA.ne.jp [3]
> Link: https://lkml.kernel.org/r/9f8b5ab0-efbc-4cf3-a1f8-b43377416946@I-love.SAKURA.ne.jp [4]
> Fixes: 65565ca5f99b ("block: unify the synchronous bi_end_io callbacks")
> Assisted-by: Gemini-Pro
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> What this patch does is basically the same with the v6 patch. Can this be
> a possible alternative for Bart's
> 
>   Releasing and reacquiring disk->open_mutex from __loop_clr_fd() seems
>   risky to me. There is plenty of code in block/bdev.c that assumes that
>   disk->open_mutex is not released by lo_release().
> 
> comment?
> 
>  block/bdev.c           |  2 ++
>  drivers/block/loop.c   | 65 +++++++++++++++++++++++++++++++++---------
>  include/linux/blkdev.h |  5 ++++
>  3 files changed, 59 insertions(+), 13 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index cd8323083740..7ce5acaacf43 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1188,6 +1188,8 @@ void bdev_release(struct file *bdev_file)
>  	else
>  		blkdev_put_whole(bdev);
>  	mutex_unlock(&disk->open_mutex);
> +	if (bdev->bd_disk->fops->post_release)
> +		bdev->bd_disk->fops->post_release(bdev->bd_disk);
>  
A great leap forward, I like this.

> +
> +static void lo_post_release(struct gendisk *disk)
> +{
> +	struct loop_device *lo = disk->private_data;
> +
> +	/* Wait for __loop_clr_fd() to complete. */
> +	flush_work(&lo->lo_clr_work);
>  }
