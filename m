Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D332D738E
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851394; cv=none; b=JNn8RM3CJTZBKaQtUbYS9RdKbnxP57xMDrQ/kNaDCs7AQrPTJtGLb0XhgRPceGKq+yqAtA/Q+ltf++P7vdApslmBEgi5RoISVP6pXPoaq2k685/EOTqmm9y41gJkGdQUfXBqRrdZi+kdZ3sdTp1S+qQvgPWabNkoHDMwVWsqtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851394; c=relaxed/simple;
	bh=9VVP156D4CGysXbhR/QzUqoXbH2d4eJYRLbjik6Adxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYMfmR+ERF7J8z/FIeCCEzOTT13UXXYRqdn4RvVBKvZKjviaxHIV7gHZMEzKBsAW9QjgHvxPAVCgTNtpsXxjQPGDKdrJVJsLeH9Yi2/S8A+BOEsZ2VQbuNzHAwz2ejbjgDPV0O1eU2vqO5BLW7UMjlf+BigO9u32+l4Whs/gEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a4118c4f7so837861fa.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 09:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851386; x=1774456186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXKjAsvokhKmTsOPQC6EE6fcQQb9uaeN84Xf2NThv88=;
        b=GiFQxelh9um9YvmRr5RD/lUpm7ZOFfsR6k4+87yJBaRc9dpYfWYjd3+oaHRHszREix
         GeswbtFoMRfassHU0oeq4a9FNGzbfPvj7fSwaMreeSFZYs4414SOZnu1dFR5TkUXCUyV
         g2cvhiqGF+Vp4i8albRbETtct/+iunDWXTobAK3Yuq9JgTytEk8uyIs0+54UV+7YDSFT
         XbubWKoeh6HTArMLmigECI0elHA0S9O8WDdEo4OO2kUGFB66LPHkUtMpj/UlKPgR11J8
         pfrGAuamNrphFNm3M7jInGTXXcXq4chqvlqD1zsHMD2KS7o34mx+0Ei+dIl7GJFDnj4d
         okFA==
X-Gm-Message-State: AOJu0YzrN+htFnC2kVJ3dycr7QOWhoncFtk10zfXqkihnoT92QCdzHm/
	k7fIBDjDCNhnbckb+9kVDWEQ+NY2V9RG3ra+653HOql/rBgvZMhMnCks
X-Gm-Gg: ATEYQzyZSF8GCIYT/bwtgQyeva7zIMnyRc8Uu3MksVRw6svx2CXxaqAlegUId8fE6cB
	eB2Y4igqrbOvmOsih67g9EeYsXw7/tmGQjfpegpt31Q1mMRmuMnhROFih/zPp650/OgGwN2rMEz
	za0o7n0gKe/GM700lfSIJFT5vLHBCYMOFS49GnRgSKJHSVLa2ccOqTbts4AAXXnVvr/9eKlFwRy
	GG277E09vqDdgx1OcggLm0l/yPAaTIVEsyJGgIzSnMNxHy3xZ3i//ZqMnjmidTUtRxu4tEvrmUz
	Hff7/4yJjp4kdtKzv1/L1FvAzwQ0cUTIr0Nl2cAAtGLmZAdXzsNsZy+nDENFOnvT4CclKQshA7c
	tjs/NTVDojz4sWF3ExLakUq2W39k6Z/IBfkuq6hde8ESqkZKIJCUh5OiO39Yedxr6gDReLqwfpZ
	nBY92iv7EU6877cgYsNpyY
X-Received: by 2002:a2e:8e81:0:b0:38a:35be:bf4e with SMTP id 38308e7fff4ca-38bd5850598mr13142141fa.24.1773851386066;
        Wed, 18 Mar 2026 09:29:46 -0700 (PDT)
Received: from [10.68.32.41] ([5.194.237.34])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bd54893c8sm7669101fa.27.2026.03.18.09.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 09:29:45 -0700 (PDT)
Message-ID: <c7796a31-1995-4d17-b911-fadfa62b9f76@linux.com>
Date: Wed, 18 Mar 2026 20:29:43 +0400
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
To: Cen Zhang <zzzccc427@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
References: <20260318034810.3089217-1-zzzccc427@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260318034810.3089217-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



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

Reviewed-by: Denis Efremov <efremov@linux.com>

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

