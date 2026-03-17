Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DEE1F1537
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785780; cv=none; b=ZKStc35+L6yvWJQwcoi/RTPvUYq9dx6U31hXjYlGSBOI1InL2Cio00L5u+EaXuGoMZdmNmPl/p4IQakwqj6ryKv7ZyHuICXop7Icu4YflXJcrG2D9nbsY3Hg6JGCgd3lAXFjNgTb7cE/3krw3rH3cl/DBjLCVpPFnVJNRoR6B1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785780; c=relaxed/simple;
	bh=cbk0KmpSBN0gRdMOOzwzobkvq9/63Vw2F/mwMGza5vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GujurC26XjCr8qUR3yhTy9RTA03Y3JWF3koaoWkVFg5xvXIsSGoSfsBdx16mWz599DfLxP0plwQLqiAWDq0Jm1zGcz1h/GzL8gJYpyQUw/HgczqvNn5DOH5yb+lvQLbfKVJSNkhMGTXPIuD9i+H7XFuJZ+QG3ozp6SpGpIE9lww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a27a7f711eso42274e87.2
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 15:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785777; x=1774390577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9EaTAS3TCBEoNvybqZAkYdlegFkdiUQjyghCpDGEHk=;
        b=rGPSwMF7D+4wMoUz7jIttgROkyQWewYrdZOK3EWtzPdP56bH67FXV6uEesw3TXSiFf
         RvjWIFYELO+743ncg3YGsewDISwhiZcC1ghGEcMn8rIamT+5QQcR65GPV1+0c+YVed5w
         CSEqzd4JI/OEG2pN6/jZY9DEKlSyRcoOgzkvmggjvlVJlrsLya1GSnQaTGcadREQKtKZ
         3c920eauN1x8dpQQYp2wK2WbsmPnP5lDQldIe4E/+Y9F/8t15KuqbiWCWKIDNb/KyuyX
         DWoNKNZsHO0HSiN/wah1QObiQHz8rOlKZZ6xlYXkcO0Pt8WXpMlrcR9+MHJqSIIYiDFq
         oqSg==
X-Gm-Message-State: AOJu0YwCx2MRJ9hHfA92MR5xizDhUkQfmre1zNa3PlyJ7ue0hcSC1Mv0
	NuOj+wMKGdL7JDOw0fjmmPlc0GXx6TV9lY2UuP04LUNNPiakLwYBfDp4
X-Gm-Gg: ATEYQzycLeKw2V43wY5GP/XhelOY9CdcqI//TNFv3T4ZF3Dhpbrmv+lIerWDqPaUF95
	DNRXhxj44kHtJo+IG5a2LwXQfb4oeQnPJygAstY88IUXzPtDVNGld6Kof49hd1X4lv4XDj0FiZT
	DBlsPq+0nG8IOy2ZE00oQ2YFybXEZaq2nykX8i5/P84nX03zAtM4Q7gxi9SSj85mHTwKsSVic8n
	Y/ZyerIQ3nl54Uftk/Io2h20bg9o0UX3cU5GuEvub4zu3r7AYj9nyGydfEDxB6goMaYYFF4QVDk
	dLDUq5PqGWvROq5zoYR314UJSkq2nnA82Qx9WcPRjzV2VdczqtUTz/UB1TkI712TUi+fwb4oYzy
	Hh+PWBKnl8Bp4NQKvCjQmMy673rshc+78m0rOcLQFe3qsnPGuHsBuh+8O7BlfVmyQCSON3gKe/q
	U4wFWLi5mm4Ylg5HY7KXkt
X-Received: by 2002:ac2:43ca:0:b0:5a1:7434:6b32 with SMTP id 2adb3069b0e04-5a2796c3442mr349033e87.23.1773785777151;
        Tue, 17 Mar 2026 15:16:17 -0700 (PDT)
Received: from [10.68.32.41] ([5.194.237.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c742c5sm136304e87.57.2026.03.17.15.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 15:16:16 -0700 (PDT)
Message-ID: <810f2e9c-c8c9-47ad-9ea0-b3a15d647453@linux.com>
Date: Wed, 18 Mar 2026 02:16:13 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: annotate data-races around command_status and
 floppy_work_fn
To: Cen Zhang <zzzccc427@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com,
 zhenghaoran154@gmail.com, hanguidong02@gmail.com, ziyuzhang201@gmail.com
References: <20260316090826.2878527-1-zzzccc427@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260316090826.2878527-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

thank you for the patch. Some comments below.

On 16/03/2026 13:08, Cen Zhang wrote:
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

Please, inline a KCSAN report if you used it.

> 
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  drivers/block/floppy.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 92e446a64371..1da7947fe042 100644
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
> +	WRITE_ONCE(command_status, command_status + 2);

WRITE_ONCE(command_status, READ_ONCE(command_status) + 2); ?

or with a temporary variable.

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

