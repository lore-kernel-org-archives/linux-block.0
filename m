Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB13359A89
	for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776509820; cv=none; b=r8LePCoFUPuXumZEGEsSyOa6xqwgsUwLWr6x5qO0T+JICzTzGLHphOD/lnaty//D9KGfZcR02iCFnRBLyDzenGPqdn1xp3mcvGbxhTpLJkEcIGEmdbema7M9Q8PZbX2+yx3T8E3VR/IyvM7bCs5XprPrVGvpJ1mWwNWqwEZ4ZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776509820; c=relaxed/simple;
	bh=lpI139pCz63EVreh7MQx8jnWEtkf3aN0Ie0iwKpsryo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqoETCCU5FiBsCYtAqnh5jww3zLOAI1QqJrpZEbCbYc1zFUYNH3derX67aGIPfga1Tpwx3qqhYHC3RVgqje00X/9rAVvUdcG6QLPYehEKDso6ABn4y6exiVot+szQsIld69M0ir1Mu9WWdP/xKtlncHOgyzKYPoSRLQVcboet/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso15301171fa.2
        for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 03:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776509817; x=1777114617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/s3iOB5g6tavv0rCoi3/af/qHsBC39RLx+n0S97JS30=;
        b=Q/7RiQiKypI007JYunGk+EPEd4iZ7F+T9tIyd/d0xC/0T9VMQKcBPWjAfiktCnA2Y6
         xukh+ZJP3pzjWZ+0rMQ3p4xsWzYBqT8V3vKoQqeJn9FtpBbXYGZOxVDJnwuRDOb5TTuo
         EkknfEhWsxPpnGAd7E4k3i2KFWnkfKUuIbEigNkM5cu2iMsrtiw7FZ1Cw7BOx8Co3z6D
         e08a9ekCcQX5kZrrnXvbpwi3LVCcXOiRqpFa4B0V0K2O2tAJWY6G3OZDCSLoFysT/tkJ
         h4jDOdfrM+79+US7q2LV9YJz09ofpTe0evY8QcC8ZLGyGncmVwmRnzxMBQZxBF8Bn1hK
         csqg==
X-Gm-Message-State: AOJu0Yxy8R5mraQtHBrOju3757OMphG2+GHLKe5KWcTS3XTuqSyft+nR
	n+Z5G7fjRrJQbfpzawzwpK+3DBJLdX9zR+8YF0+XSLrN4WRemj/Q203taF3Oaw==
X-Gm-Gg: AeBDieuORqGgR4FvYDFVmj9+YTvk+gEX5yf6MDuIZUM0QwGTIcKnWRDINMWSylzEBh7
	erakwrRyDfSs+73o2BwoJlz1K8nYRNDtu/YHWRf8qOop9yRCReFp14nYjbaISz/20PMcmLhgR9l
	tjuRzGveIN2CMfAK1wgoKLR1rrLfr9ai27eLDlAaXoBKJ+zdXIjM0TOk6vJEadeFY5urUWWYy1o
	MmT3BToYAMyGgX/cTbpR+vt9JhCAd9hpR5VXNHPwj3rGsMUdYBRwwHVSaD+QXpywmU6ZNPtNdhp
	P0BEpkQ/tALPlwR8DSVwcydcErlTdes+hvh1QsNN8aG57kve/3PbyaBbSj6WXVyWdOf9ZV4fEK7
	yrj50Q6aXnvJRBgvuBfQqz3jMzPS/Cf6ceHUDmodmcU5ogtsGCHZ0VY9d4pK8M1wWmRRo0C1HCB
	OkaVmora0GJekaif4ceG6ys/S8iDx7rddWDq1Y7pxjU/4ANeR0rnGmET16U4M6BYCLLluL0OgcA
	rHkxbc=
X-Received: by 2002:a05:651c:54f:b0:38e:48fb:cf65 with SMTP id 38308e7fff4ca-38ec77fb141mr18162211fa.1.1776509816598;
        Sat, 18 Apr 2026 03:56:56 -0700 (PDT)
Received: from [10.68.32.41] (bba-86-97-226-202.alshamil.net.ae. [86.97.226.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb6f0bfdsm10282441fa.26.2026.04.18.03.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 03:56:55 -0700 (PDT)
Message-ID: <0117f4a4-fa38-45af-a129-cc691e607c5c@linux.com>
Date: Sat, 18 Apr 2026 14:56:53 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH v2] floppy: annotate data-races around command_status and
 floppy_work_fn
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, Cen Zhang <zzzccc427@gmail.com>
References: <20260318034810.3089217-1-zzzccc427@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260318034810.3089217-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Jens, can you also take this patch to your tree?

Thanks,
Denis

On 18/03/2026 07:48, Cen Zhang wrote:
> command_status is accessed by multiple contexts:
>  - generic_done() and do_wakeup() write it from the floppy
>    workqueue context.
>  - wait_til_done() reads it in wait_event conditions without
>    holding fdc_busy.
>  - is_alive() reads it locklessly to check driver liveness.
>  - floppy_queue_rq(), lock_fdc(), and unlock_fdc() write it
>    during FDC ownership transitions.
> 
> There is currently no LKMM annotation for these concurrent accesses
> since command_status relies on the deprecated volatile qualifier.
> Remove volatile and use READ_ONCE()/WRITE_ONCE() on every access
> to command_status to provide proper LKMM data-race annotations.
> 
> Also annotate floppy_work_fn with WRITE_ONCE() in schedule_bh()
> and READ_ONCE() in floppy_work_workfn(), and current_type[drive]
> with READ_ONCE() in drive_no_geom() where it can be read without
> holding the FDC lock.
> 
> The races were found by our tools:
> 
>  1) command_status: generic_done (write) vs wait_til_done (read)
> 
>   ============ DATARACE ============
>   Function: generic_done+0x54/0xa0 drivers/block/floppy.c:985
>   Function: success_and_wakeup+0xeb/0x1e0 drivers/block/floppy.c:2046
>   Function: setup_rw_floppy+0x15dc/0x1d80 drivers/block/floppy.c:1046
>   Function: floppy_ready+0x2630/0x4000
>   Function: floppy_work_workfn+0x56/0x70 drivers/block/floppy.c:1012
>   Function: process_one_work kernel/workqueue.c:3236 [inline]
>   Function: process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
>   ============OTHER_INFO============
>   Function: wait_til_done+0x134/0x740 drivers/block/floppy.c:2026
>   Function: poll_drive+0x1fa/0x2a0
>   Function: fd_ioctl+0x13c8/0x1da0 drivers/block/floppy.c:3873
>   Function: blkdev_ioctl+0x421/0x510 block/ioctl.c:705
>   Function: vfs_ioctl fs/ioctl.c:51 [inline]
>   Function: __do_sys_ioctl fs/ioctl.c:598 [inline]
>   Function: __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
>   =================END==============
> 
>  2) current_type[drive]: drive_no_geom (read) vs set_geometry (write)
> 
>   ============ DATARACE ============
>   Function: drive_no_geom drivers/block/floppy.c:606 [inline]
>   Function: floppy_check_events+0x9c9/0xcf0 drivers/block/floppy.c:4187
>   Function: disk_check_events+0xca/0x4d0 block/disk-events.c:193
>   Function: process_one_work kernel/workqueue.c:3236 [inline]
>   Function: process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
>   Function: worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
>   Function: kthread+0x3d4/0x800 kernel/kthread.c:463
>   ============OTHER_INFO============
>   Function: set_geometry+0xe1d/0x1980 drivers/block/floppy.c:2237
>   Function: fd_ioctl+0xff4/0x1da0 drivers/block/floppy.c:3912
>   Function: blkdev_ioctl+0x421/0x510 block/ioctl.c:705
>   Function: vfs_ioctl fs/ioctl.c:51 [inline]
>   Function: __do_sys_ioctl fs/ioctl.c:598 [inline]
>   Function: __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
>   =================END==============
> 
>  3) floppy_work_fn: schedule_bh (write) vs
>     floppy_interrupt->schedule_bh (write)
> 
>   ============ DATARACE ============
>   Function: schedule_bh drivers/block/floppy.c:1005 [inline]
>   Function: do_wakeup+0x19c/0x220 drivers/block/floppy.c:3219
>   Function: success_and_wakeup+0x192/0x1e0 drivers/block/floppy.c:1994
>   Function: setup_rw_floppy+0x15dc/0x1d80 drivers/block/floppy.c:1046
>   Function: floppy_ready+0x2630/0x4000
>   Function: floppy_work_workfn+0x56/0x70 drivers/block/floppy.c:1012
>   Function: process_one_work kernel/workqueue.c:3236 [inline]
>   Function: process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
>   ============OTHER_INFO============
>   Function: floppy_interrupt+0xbf4/0x1220
>   Function: floppy_hardint+0x432/0x630
>   Function: __handle_irq_event_percpu+0x10a/0x5d0 kernel/irq/handle.c:158
>   Function: handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:210
>   Function: handle_edge_irq+0x223/0x9f0 kernel/irq/chip.c:855
>   =================END==============
> 
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  drivers/block/floppy.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 92e446a64371..cf8246e7155e 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -502,7 +502,7 @@ static int probing;
>  #define FD_COMMAND_ERROR	2
>  #define FD_COMMAND_OKAY		3
>  
> -static volatile int command_status = FD_COMMAND_NONE;
> +static int command_status = FD_COMMAND_NONE;
>  static unsigned long fdc_busy;
>  static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
>  static DECLARE_WAIT_QUEUE_HEAD(command_done);
> @@ -601,7 +601,8 @@ static inline void fdc_outb(unsigned char value, int fdc, int reg)
>  
>  static inline bool drive_no_geom(int drive)
>  {
> -	return !current_type[drive] && !ITYPE(drive_state[drive].fd_device);
> +	return !READ_ONCE(current_type[drive]) &&
> +	       !ITYPE(drive_state[drive].fd_device);
>  }
>  
>  #ifndef fd_eject
> @@ -640,7 +641,7 @@ static const char *timeout_message;
>  static void is_alive(const char *func, const char *message)
>  {
>  	/* this routine checks whether the floppy driver is "alive" */
> -	if (test_bit(0, &fdc_busy) && command_status < 2 &&
> +	if (test_bit(0, &fdc_busy) && READ_ONCE(command_status) < 2 &&
>  	    !delayed_work_pending(&fd_timeout)) {
>  		DPRINT("%s: timeout handler died.  %s\n", func, message);
>  	}
> @@ -892,7 +893,7 @@ static int lock_fdc(int drive)
>  	if (wait_event_interruptible(fdc_wait, !test_and_set_bit(0, &fdc_busy)))
>  		return -EINTR;
>  
> -	command_status = FD_COMMAND_NONE;
> +	WRITE_ONCE(command_status, FD_COMMAND_NONE);
>  
>  	reschedule_timeout(drive, "lock fdc");
>  	set_fdc(drive);
> @@ -906,7 +907,7 @@ static void unlock_fdc(void)
>  		DPRINT("FDC access conflict!\n");
>  
>  	raw_cmd = NULL;
> -	command_status = FD_COMMAND_NONE;
> +	WRITE_ONCE(command_status, FD_COMMAND_NONE);
>  	cancel_delayed_work(&fd_timeout);
>  	do_floppy = NULL;
>  	cont = NULL;
> @@ -990,7 +991,9 @@ static void (*floppy_work_fn)(void);
>  
>  static void floppy_work_workfn(struct work_struct *work)
>  {
> -	floppy_work_fn();
> +	void (*fn)(void) = READ_ONCE(floppy_work_fn);
> +
> +	fn();
>  }
>  
>  static DECLARE_WORK(floppy_work, floppy_work_workfn);
> @@ -999,7 +1002,7 @@ static void schedule_bh(void (*handler)(void))
>  {
>  	WARN_ON(work_pending(&floppy_work));
>  
> -	floppy_work_fn = handler;
> +	WRITE_ONCE(floppy_work_fn, handler);
>  	queue_work(floppy_wq, &floppy_work);
>  }
>  
> @@ -1864,7 +1867,7 @@ static void show_floppy(int fdc)
>  
>  	pr_info("cont=%p\n", cont);
>  	pr_info("current_req=%p\n", current_req);
> -	pr_info("command_status=%d\n", command_status);
> +	pr_info("command_status=%d\n", READ_ONCE(command_status));
>  	pr_info("\n");
>  }
>  
> @@ -1991,7 +1994,7 @@ static void do_wakeup(void)
>  {
>  	reschedule_timeout(MAXTIMEOUT, "do wakeup");
>  	cont = NULL;
> -	command_status += 2;
> +	WRITE_ONCE(command_status, READ_ONCE(command_status) + 2);
>  	wake_up(&command_done);
>  }
>  
> @@ -2019,11 +2022,12 @@ static int wait_til_done(void (*handler)(void), bool interruptible)
>  	schedule_bh(handler);
>  
>  	if (interruptible)
> -		wait_event_interruptible(command_done, command_status >= 2);
> +		wait_event_interruptible(command_done,
> +					 READ_ONCE(command_status) >= 2);
>  	else
> -		wait_event(command_done, command_status >= 2);
> +		wait_event(command_done, READ_ONCE(command_status) >= 2);
>  
> -	if (command_status < 2) {
> +	if (READ_ONCE(command_status) < 2) {
>  		cancel_activity();
>  		cont = &intr_cont;
>  		reset_fdc();
> @@ -2031,18 +2035,18 @@ static int wait_til_done(void (*handler)(void), bool interruptible)
>  	}
>  
>  	if (fdc_state[current_fdc].reset)
> -		command_status = FD_COMMAND_ERROR;
> -	if (command_status == FD_COMMAND_OKAY)
> +		WRITE_ONCE(command_status, FD_COMMAND_ERROR);
> +	if (READ_ONCE(command_status) == FD_COMMAND_OKAY)
>  		ret = 0;
>  	else
>  		ret = -EIO;
> -	command_status = FD_COMMAND_NONE;
> +	WRITE_ONCE(command_status, FD_COMMAND_NONE);
>  	return ret;
>  }
>  
>  static void generic_done(int result)
>  {
> -	command_status = result;
> +	WRITE_ONCE(command_status, result);
>  	cont = &wakeup_cont;
>  }
>  
> @@ -2873,7 +2877,7 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	list_add_tail(&bd->rq->queuelist, &floppy_reqs);
>  	spin_unlock_irq(&floppy_lock);
>  
> -	command_status = FD_COMMAND_NONE;
> +	WRITE_ONCE(command_status, FD_COMMAND_NONE);
>  	__reschedule_timeout(MAXTIMEOUT, "fd_request");
>  	set_fdc(0);
>  	process_fd_request();

