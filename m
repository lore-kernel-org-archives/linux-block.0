Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D61624C5;
	Tue,  6 Jan 2026 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702590; cv=none; b=AV5fEhyjOUcwdsOzKKrSTXYQtyuYOjtCvjSeNJbmtowbMnwhEekBbaPVEBEyywBgHexMTGJFWfQyQbO0tGilyUtfeTQGG0aizVbyRG929xgC/nNM6j3V9G5HvuKYUGxK9suzyHezjggHQqnmFsJEORKcp7CC4fylexbzBm9LQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702590; c=relaxed/simple;
	bh=w8ErrOQEKlfLGXbK2LIOSRpPj12EsGD6jcYl2D59xs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DILrGnPgHhheX6FGBuNv1mZRi6R5gWXuSSR4zRDV7M3I8E9PcbiRciYkr7/OMaWaFSMm4rntWy5y03URQ6gKaRPDUDPi/l+9dmhkQ10Sc566KMeGXCx3kTN5NCOYqbLJDbiLEAb0RwHON1Zbh+RaxWzU4sRQcRrRUWoiL8aBNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YjeXsS+z; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YjeXsS+z"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dlr8Q2XVvzlvgjk;
	Tue,  6 Jan 2026 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1767702580; x=1770294581; bh=7jHnsEAoTkixr6ViC3i/D2kr
	OYaTAc7gfumuPM9qGO0=; b=YjeXsS+zGsoMKytfaXuTSv129Gm8NkuvlFXu8diK
	QBzKwC9ydoGZf+OVWiCmKGGkvs5pUxvuImgQ4/NPvgVS4LQ6kbjTogifSIEnqDrd
	wujEZ7HSBKiKfPgt+Fg4cbGr9HiueW6Ozq9rn6ivsfalJd59DiPR7okYidnW22ez
	pVQVl2B/7sB7z315x+JSOKHVF0W7YVjO1tvfLsnS8HZa0eN3FE037anMBbFj4aCV
	Me0qwlR2viwEbQKbJ10jJYPMS97es68a/7AQxqJdNtYHnr157PsCiXSeu6XTIbSF
	xIZiwsjsZMZh+2j0A/9iKkgE/fr2QXhenCH6RI/8Ucy9Hw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uGgBFtkSTfm0; Tue,  6 Jan 2026 12:29:40 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dlr8K1gh6zlfgf6;
	Tue,  6 Jan 2026 12:29:36 +0000 (UTC)
Message-ID: <6eb6abcf-26aa-473d-843e-428ae0f38203@acm.org>
Date: Tue, 6 Jan 2026 04:29:36 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when
 called from interrupt context
To: djiony2011@gmail.com, ming.lei@redhat.com
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org, ionut.nechita@windriver.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev, sashal@kernel.org, stable@vger.kernel.org
References: <aUnu1HdMqQbksLeY@fedora>
 <20260106111411.6435-1-ionut.nechita@windriver.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260106111411.6435-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 3:14 AM, djiony2011@gmail.com wrote:
> [Mon Dec 22 10:18:18 2025] WARNING: CPU: 190 PID: 2041 at block/blk-mq.c:2291 blk_mq_run_hw_queue+0x1fa/0x260
> [Mon Dec 22 10:18:18 2025] Modules linked in:
> [Mon Dec 22 10:18:18 2025] CPU: 190 PID: 2041 Comm: kworker/u385:1 Tainted: G        W          6.6.0-1-rt-amd64 #1  Debian 6.6.71-1

6.6.71 is pretty far away from Jens' for-next branch. Please use Jens'
for-next branch for testing kernel patches intended for the upstream
kernel.

> [Mon Dec 22 10:18:18 2025] Call Trace:
> [Mon Dec 22 10:18:18 2025]  <TASK>
> [Mon Dec 22 10:18:18 2025]  blk_mq_run_hw_queues+0x6c/0x130
> [Mon Dec 22 10:18:18 2025]  blk_queue_start_drain+0x12/0x40
> [Mon Dec 22 10:18:18 2025]  blk_mq_destroy_queue+0x37/0x70
> [Mon Dec 22 10:18:18 2025]  __scsi_remove_device+0x6a/0x180
> [Mon Dec 22 10:18:18 2025]  scsi_alloc_sdev+0x357/0x360
> [Mon Dec 22 10:18:18 2025]  scsi_probe_and_add_lun+0x8ac/0xc00
> [Mon Dec 22 10:18:18 2025]  __scsi_scan_target+0xf0/0x520
> [Mon Dec 22 10:18:18 2025]  scsi_scan_channel+0x57/0x90
> [Mon Dec 22 10:18:18 2025]  scsi_scan_host_selected+0xd4/0x110
> [Mon Dec 22 10:18:18 2025]  do_scan_async+0x1c/0x190
> [Mon Dec 22 10:18:18 2025]  async_run_entry_fn+0x2f/0x130
> [Mon Dec 22 10:18:18 2025]  process_one_work+0x175/0x370
> [Mon Dec 22 10:18:18 2025]  worker_thread+0x280/0x390
> [Mon Dec 22 10:18:18 2025]  kthread+0xdd/0x110
> [Mon Dec 22 10:18:18 2025]  ret_from_fork+0x31/0x50
> [Mon Dec 22 10:18:18 2025]  ret_from_fork_asm+0x1b/0x30

Where in the above call stack is the code that disables interrupts?

> 3. **The actual problem on PREEMPT_RT**: There's a preceding "scheduling while atomic"
>     error that provides the real context:
> 
> [Mon Dec 22 10:18:18 2025] BUG: scheduling while atomic: kworker/u385:1/2041/0x00000002
> [Mon Dec 22 10:18:18 2025] Call Trace:
> [Mon Dec 22 10:18:18 2025]  dump_stack_lvl+0x37/0x50
> [Mon Dec 22 10:18:18 2025]  __schedule_bug+0x52/0x60
> [Mon Dec 22 10:18:18 2025]  __schedule+0x87d/0xb10
> [Mon Dec 22 10:18:18 2025]  rt_mutex_schedule+0x21/0x40
> [Mon Dec 22 10:18:18 2025]  rt_mutex_slowlock_block.constprop.0+0x33/0x170
> [Mon Dec 22 10:18:18 2025]  __rt_mutex_slowlock_locked.constprop.0+0xc4/0x1e0
> [Mon Dec 22 10:18:18 2025]  mutex_lock+0x44/0x60
> [Mon Dec 22 10:18:18 2025]  __cpuhp_state_add_instance_cpuslocked+0x41/0x110
> [Mon Dec 22 10:18:18 2025]  __cpuhp_state_add_instance+0x48/0xd0
> [Mon Dec 22 10:18:18 2025]  blk_mq_realloc_hw_ctxs+0x405/0x420
> [Mon Dec 22 10:18:18 2025]  blk_mq_init_allocated_queue+0x10a/0x480

How is the above call stack related to the reported problem? The above
call stack is about request queue allocation while the reported problem
happens during request queue destruction.

> I apologize for the confusion in my commit message. Should I:
> 1. Revise the commit message to accurately describe the blk_queue_start_drain() path?
> 2. Add details about the PREEMPT_RT context causing the atomic state?

The answer to both questions is yes.

Thanks,

Bart.
