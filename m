Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FA224FA;
	Sun,  3 May 2026 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777787566; cv=none; b=YKi4ewSaWOHXg92pzmApSIRYSQ7anvcgT/dvewnXG0bYBGWq10uFr6jOJWdAB73Rb6lkURRNkRokicAhNwarq73vSttZMaay9PVLgzoR8CKWyHY2oGIbZJQCYFAscK8wAeNh7e0XEXZFxLsCei9z0EdVP6WgLv1+qd7fkUeRlwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777787566; c=relaxed/simple;
	bh=7+p+o/rhroUxkfbMGB72LwqTiS71a3jhkJJB4mE6sl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqtJdo9Z0xeGtZj9SFLQtTP/psfkevIiST0MmFTH2iZLMX63O01LQlOisxsuxMJH+0l63MX8V79ssbEFUnbTTqqfURYj7dTiDb85FQZopiWIHn6cMF6gscxiF+57taK6UNij75UpvPwx3084QPXWhTwhSt/JSOZO6Crb72qX6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Hf3RyffZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Hf3RyffZ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g7YpN4zkrzlgtd0;
	Sun,  3 May 2026 05:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777787559; x=1780379560; bh=IqE7MhhCDqKc7Zlp8tPSoJsT
	xXLU1qnMtGH8VV918nQ=; b=Hf3RyffZj4OMurpfFZS6e5HjSD37mNGa8GmGxJTA
	6bBYsWQmsTsS9Dinv2hjonrLICsZbr2SmME7rsoHsEOYQ08qtZxJEzIY7+2SOVw1
	6F9T3WinSY/uJ66yYbkUlJcRK1AFKyMPqleNuxGe4HDg/EeRRg+8LqdI4EybBLpv
	+6Tz6vlnnTws/VHabiq8nTaPUXOgd2w9KDpgf2tz/u1vG7Rd9BVRZTuppyRCpa6W
	hpPQbK+CoU4s19W4iqDiSSY2z69CWIUjlpA78ewtc2nP5P0/UDP1qHR9xj8V1Pxs
	Q06LIUF5emyqeNpvkKU855UI2xXB/kkWOVSBT95EDEz61g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id p_tQR2x9mnrb; Sun,  3 May 2026 05:52:39 +0000 (UTC)
Received: from [10.211.8.206] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g7YpC03JZzlgr44;
	Sun,  3 May 2026 05:52:34 +0000 (UTC)
Message-ID: <b568c125-d827-42f3-97ab-521a8648d917@acm.org>
Date: Sun, 3 May 2026 07:52:32 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blktrace: reject buf_size smaller than blk_io_trace
To: Deepanshu Kartikey <kartikey406@gmail.com>, axboe@kernel.dk,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
References: <20260322051838.1137822-1-kartikey406@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260322051838.1137822-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/26 6:18 AM, Deepanshu Kartikey wrote:
> Closes: https://syzkaller.appspot.com/bug?extid=ed8bc247f231c1a48e21
> [ ... ] 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99..6cc7d83ed1c2 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>   	if (ret)
>   		return -EFAULT;
>   
> -	if (!buts.buf_size || !buts.buf_nr)
> +	if (buts.buf_size < sizeof(struct blk_io_trace) || !buts.buf_nr)
>   		return -EINVAL;
>   
>   	buts2 = (struct blk_user_trace_setup2) {

Why sizeof(struct blk_io_trace) instead of sizeof(struct blk_io_trace2)?
Even sizeof(struct blk_io_trace2) is too small if any additional data is
included.

Additionally, how can this patch fix the issue mentioned in the linked 
syzbot report? Is the syzbot link correct? From the syzbot report:

Oops: general protection fault, probably for non-canonical address 
0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:bvec_set_page include/linux/bvec.h:44 [inline]
RIP: 0010:__bio_add_page block/bio.c:992 [inline]
RIP: 0010:bio_add_page+0x462/0x6e0 block/bio.c:1048
Call Trace:
  <TASK>
  bio_add_folio+0x64/0x90 block/bio.c:1084
  io_submit_add_bh fs/ext4/page-io.c:465 [inline]
  ext4_bio_write_folio+0x1446/0x1ea0 fs/ext4/page-io.c:603
  mpage_map_and_submit_buffers fs/ext4/inode.c:2326 [inline]
  mpage_map_and_submit_extent fs/ext4/inode.c:2516 [inline]
  ext4_do_writepages+0x207e/0x46e0 fs/ext4/inode.c:2928
  ext4_writepages+0x241/0x3b0 fs/ext4/inode.c:3022
  do_writepages+0x32e/0x550 mm/page-writeback.c:2554
  __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1750
  writeback_sb_inodes+0x992/0x1a20 fs/fs-writeback.c:2042
  __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2118
  wb_writeback+0x46a/0xb70 fs/fs-writeback.c:2229
  wb_check_start_all fs/fs-writeback.c:2355 [inline]
  wb_do_writeback fs/fs-writeback.c:2381 [inline]
  wb_workfn+0x95b/0xf50 fs/fs-writeback.c:2414
  process_one_work+0x9ab/0x1780 kernel/workqueue.c:3288
  process_scheduled_works kernel/workqueue.c:3379 [inline]
  worker_thread+0xba8/0x11e0 kernel/workqueue.c:3465
  kthread+0x388/0x470 kernel/kthread.c:436
  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
  </TASK>

Thanks,

Bart.
