Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B071BD9DF;
	Mon, 25 Nov 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732575547; cv=none; b=nWBPhHYYA8TGzuQJH4to8Yn2qDKPCYGGFjj+/P0Rq3rgu85dv4K4YzVwOw+aHW6cgAZ9wjfO5LBGhC+GqiJsSoTVrsep3y1IjtjIopqlum/2a/xcuiP+Y0QbqQxFhirYcCYJoKGf1uel4hT3V5Pfu9YMtSo+s9Jhs7t3ILGdTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732575547; c=relaxed/simple;
	bh=0blCG3DP1evniy9U/k+IkKe7SbMcODpN/0eXmXPbdX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HSBbIT9nCj6xc5oVSo/l/G0EolYU4zJ4G4zJ2W5dYywt3Y9jwUhJKwVlXxAhCMZp1GJDwcx4p4OBzJcJAPjqw/+rXP3wUsr8xsPKmycSGII6Q5cCz6ACpaCUTQazNKPLBHDB8Nb75Gem1JmvOUBSypSfGHKK/XBm0M0eUP6HIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mhrPeDmp; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mhrPeDmp"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Xy1NS5MCSz6CmR09;
	Mon, 25 Nov 2024 22:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732575540; x=1735167541; bh=utVP4qmwjFsS8SANZNfbg76W
	neJase6P/AUjR/8V0IY=; b=mhrPeDmp68XT+9lCGvrBqzydwrhvBKf0aEbXkF3z
	4BLgLKb7YE3hsv/l1rIq3XyCbkwPplC4MPX5bCzGqoNtSmBMCFgUJcJ847fDUQEY
	WFB3nYdj3MUUtszrmvp+zWBHUJ7DH3zmzl7xa144uaE2mSHVNtwHv3dp6h9OdWhQ
	ZZI1h+CpEF3c1fjFDM+SUJ5JN8ne06O5mqz7iwyyA62rF4JfvgF1+7Vr5gRpV5ZS
	bAlQEjXKW3xFSDX0RdfgSGyxUL6SCnBXB4wLAxPPl2/6IpDsV5flMx6jydyo5UtJ
	jjWMilK7hngmlKxWz5H32bqlZW0g2oEROD5VcomBbaGJxw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kmUf2SHm8PuM; Mon, 25 Nov 2024 22:59:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Xy1NK6Fgvz6CmR1W;
	Mon, 25 Nov 2024 22:58:57 +0000 (UTC)
Message-ID: <2d5e17d7-53a5-4c4e-b961-96a23abfed9f@acm.org>
Date: Mon, 25 Nov 2024 14:58:55 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in dd_exit_sched
To: syzbot <syzbot+f53c29806b4b263165f3@syzkaller.appspotmail.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>
References: <67442263.050a0220.1cc393.0069.GAE@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <67442263.050a0220.1cc393.0069.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/24 11:08 PM, syzbot wrote:
> statistics for priority 0: i 8 m 0 d 8 c 0
> WARNING: CPU: 0 PID: 7130 at block/mq-deadline.c:562 dd_exit_sched+0x2a8/0x3a0 block/mq-deadline.c:559
> Modules linked in:
> CPU: 0 UID: 0 PID: 7130 Comm: kworker/u8:10 Not tainted 6.12.0-syzkaller-03657-g43fb83c17ba2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> Workqueue: nbd-del nbd_dev_remove_work
> RIP: 0010:dd_exit_sched+0x2a8/0x3a0 block/mq-deadline.c:559
> Call Trace:
>   <TASK>
>   blk_mq_exit_sched+0x2ce/0x4a0 block/blk-mq-sched.c:547
>   elevator_exit+0x5e/0x80 block/elevator.c:159
>   del_gendisk+0x7a8/0x930 block/genhd.c:735
>   nbd_dev_remove drivers/block/nbd.c:264 [inline]
>   nbd_dev_remove_work+0x47/0xe0 drivers/block/nbd.c:280
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>

All ongoing I/O requests should have completed before elevator_exit() is
called. del_gendisk() calls __blk_freeze_queue_start() indirectly before
it calls elevator_exit() but it doesn't wait for the queue freeze
operation to complete. Isn't that a bug in del_gendisk()?

Thanks,

Bart.
