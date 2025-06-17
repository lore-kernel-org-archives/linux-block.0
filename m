Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8172EFD80
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190956; cv=none; b=V/ye7eN80c7m6WonnIL+dCMkH8aJPmpCQ5VbRiFSSsUK4cSQgWRpQ1gEENMuJ8Eu68SVgPjA7I/OMyJ7ETYNVrSd0YcYvEbu4pe9FGWhkW4JbrDbGZDLBesH5SW8YN+vGlaxreNZj0LZB3E69oM+lPASqfjtXb0GPIG5r4sJVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190956; c=relaxed/simple;
	bh=VxCVGL0P21DSn2hPLKqNFWl7T0ihWR229SxIKSht+co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdRfNcfJ2Xy+N1XbpGMiEGFeppDRTjFieDw42VcsPnIonuoyUcs9II+EMIk6IPvRhbrNBx2/AV5syktvGA8a5hJRT3xBwxCUvqROvxrjm5iXPegC0aUwrq+R+gm8vipbPTDKOlV9t5NobQeJj16FeJVtQbvWyDx/BYSdl4BdnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FkCimV+p; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FkCimV+p"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bMHyK4f9VzlgqVx;
	Tue, 17 Jun 2025 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750190952; x=1752782953; bh=MbwAx93LVko8xTuWA3X4lzig
	Fm0x+Cv0+TJ60rhRvtI=; b=FkCimV+pxxtZ+vGN8P2lzyygxvxgPAdJ2It40M1v
	Du++Ot4GA4YMstowFgCPqgJOApUbjuMq+gmviEIWtbJyKjw8IKbzwnWRZregI4Q4
	AF4eHxDLA7UlgXxNGeQxH9qGYQIkfWhOnpdtYu1xZXxKU5WbSThIVdCDrt85rKpT
	xXyjsrIICC17MllaHp/whcolA5LVY9QYrmFUMnZ/jzsomDzpWd157fJXxb74vJTB
	JCJvW6bF/W9c55PrDDaAK6zzAOVSda76UoHO8NmSTWlKTO1pgmdlzxs4tBII/sfx
	If6HH4tvO8aN80OXVMJwTggilirl7aXNsG3GrqMwlJuFqg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zlt32Z4GqW1C; Tue, 17 Jun 2025 20:09:12 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bMHyF5TkXzlgqVk;
	Tue, 17 Jun 2025 20:09:08 +0000 (UTC)
Message-ID: <ea187ee4-378e-4c59-afdd-3ecd8ed57243@acm.org>
Date: Tue, 17 Jun 2025 13:09:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250611044416.2351850-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250611044416.2351850-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 9:44 PM, Christoph Hellwig wrote:
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 8f15d1aa6eb8..45c91016cef3 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1306,7 +1306,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
>   	spin_unlock_irqrestore(&zwplug->lock, flags);
>   
>   	bdev = bio->bi_bdev;
> -	submit_bio_noacct_nocheck(bio);
>   
>   	/*
>   	 * blk-mq devices will reuse the extra reference on the request queue
> @@ -1314,8 +1313,12 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
>   	 * path for BIO-based devices will not do that. So drop this extra
>   	 * reference here.
>   	 */
> -	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
> +	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO)) {
> +		bdev->bd_disk->fops->submit_bio(bio);
>   		blk_queue_exit(bdev->bd_disk->queue);
> +	} else {
> +		blk_mq_submit_bio(bio);
> +	}
>   
>   put_zwplug:
>   	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */

This patch is necessary but not sufficient. With this patch applied, if
I run the deadlock reproducer (tests/zbd/013) with Jens' for-next
branch, the deadlock shown below is reported. The first call stack shows
the familiar queue_ra_store() invocation. The second call stack is new
and shows a dm_split_and_process_bio() invocation.

sysrq: Show Blocked State
task:check           state:D stack:27208 pid:2728  tgid:2728  ppid:2697 
  task_flags:0x480040 flags:0x00004002
Call Trace:
  __schedule+0x8be/0x1c10
  schedule+0xdd/0x270
  blk_mq_freeze_queue_wait+0xfd/0x140
  blk_mq_freeze_queue_nomemsave+0x1e/0x30
  queue_ra_store+0x155/0x2a0
  queue_attr_store+0x24d/0x2d0
  sysfs_kf_write+0xdc/0x120
  kernfs_fop_write_iter+0x39f/0x5a0
  vfs_write+0x4fa/0x1300
  ksys_write+0x109/0x1f0
  __x64_sys_write+0x76/0xb0
  x64_sys_call+0x276/0x17d0
  do_syscall_64+0x94/0x3a0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
task:kworker/52:2H   state:D stack:26528 pid:2873  tgid:2873  ppid:2 
  task_flags:0x4208060 flags:0x00004000
Workqueue: dm-0_zwplugs blk_zone_wplug_bio_work
Call Trace:
  __schedule+0x8be/0x1c10
  schedule+0xdd/0x270
  __bio_queue_enter+0x32d/0x7c0
  __submit_bio+0x1dd/0x6c0
  __submit_bio_noacct+0x147/0x580
  submit_bio_noacct_nocheck+0x4de/0x620
  submit_bio_noacct+0x8f4/0x1a50
  dm_split_and_process_bio+0x8a1/0x1c00 [dm_mod 
14a6a78a54cd51bfc1d6559d48b0c80b677774ec]
  dm_submit_bio+0x137/0x490 [dm_mod 
14a6a78a54cd51bfc1d6559d48b0c80b677774ec]
  blk_zone_wplug_bio_work+0x455/0x630
  process_one_work+0xe29/0x1420
  worker_thread+0x5ed/0xff0
  kthread+0x3cd/0x840
  ret_from_fork+0x412/0x520
  ret_from_fork_asm+0x11/0x20

Bart.
