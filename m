Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD9C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558F12082E
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M/IL1OOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfEPOUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:20:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37629 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPOUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:20:46 -0400
Received: by mail-io1-f67.google.com with SMTP id u2so2726583ioc.4
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65FBkP4Y7bckhSsvcaAkNDTvG4xiHDf43YBBqGOSIMY=;
        b=M/IL1OOEagxAPTuCLzK94p2qu9EtZMhLI92+WN9zVu0vdBh9ClIO7Hbvn8TKQkBOs/
         8TbQ3+77MygBWc7APwMgD8ow9b6xNN19WgVPYj1E8AdZvcJcPaE7of2vYOokwKoshU2Z
         dMFmxgz2cZII90jiXBb4fSQ5Qzfxu2vHqjpujXyshN4alRaRop0itKxNvaADObfHE+lO
         5XVIlhwCIBTBbc8Lz410xSHcAlSaOqtj/i4eL5jduQ06jNHA1qbrfbo7IQW0VJ2jVR7w
         duenwIULJ/DpIMtnGEqXHE2cbjgoNJJe/q1IVWVBQoRMXldGLMpRwYgYCnBGy9hPUKNz
         6Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65FBkP4Y7bckhSsvcaAkNDTvG4xiHDf43YBBqGOSIMY=;
        b=A49MP+eWoSXWpaXM4H4T9ZdwnqZmGmOG6FzJ8MtMfBRCGwolMd4uDvxaUV5VsWIGnT
         MMf+AVc6Xz8gBVyEKS0XUtSHLnGfWpiHdJvfclLrRS7Cw+Z6wLJ/bmYRANiOpM2X3AsU
         SUQV668jXHZQXgiDX0Tkzk4b7ly0O2gEoeNPNb6ck7/iOAj+KaQ2gspUi8q8IjD0vgn7
         75+sgYRd2lzWH+t9Dmi7BfQuMiZKqcdHQgy6IhFe6TJLRHezX3XbpKr/JscXTY7Ert/C
         lOs/7S4jJNmTcR7E1cy6CAZasmnn0IjCRGb2LNq7MdYhpGbX4H1squv0OABq6m63hm3V
         WwKA==
X-Gm-Message-State: APjAAAUTXw/eZtH5NmSB+DNjDQtaD6VOrYPZHaV4/OiRoOR+2zKryRsW
        dIooOJrymjBegb5sJtVGbOFJsqQuKhuGtA==
X-Google-Smtp-Source: APXvYqyafi6KrwgQeV5MDkjjAsl2F/zg5c4L8+fRY6MXPLhRlMRh7Fuj1vt3KlWV79ge5OZHDtCs2w==
X-Received: by 2002:a6b:5814:: with SMTP id m20mr27663068iob.293.1558016445078;
        Thu, 16 May 2019 07:20:45 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t133sm1789672iod.84.2019.05.16.07.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:20:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] io_uring: fix infinite wait in khread_park() on
 io_finish_async()
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-block@vger.kernel.org
References: <20190516085357.30801-1-rpenyaev@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a708c3f0-0a23-d83a-aef1-740ccf5c6c1c@kernel.dk>
Date:   Thu, 16 May 2019 08:20:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516085357.30801-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 2:53 AM, Roman Penyaev wrote:
> This fixes couple of races which lead to infinite wait of park completion
> with the following backtraces:
> 
>   [20801.303319] Call Trace:
>   [20801.303321]  ? __schedule+0x284/0x650
>   [20801.303323]  schedule+0x33/0xc0
>   [20801.303324]  schedule_timeout+0x1bc/0x210
>   [20801.303326]  ? schedule+0x3d/0xc0
>   [20801.303327]  ? schedule_timeout+0x1bc/0x210
>   [20801.303329]  ? preempt_count_add+0x79/0xb0
>   [20801.303330]  wait_for_completion+0xa5/0x120
>   [20801.303331]  ? wake_up_q+0x70/0x70
>   [20801.303333]  kthread_park+0x48/0x80
>   [20801.303335]  io_finish_async+0x2c/0x70
>   [20801.303336]  io_ring_ctx_wait_and_kill+0x95/0x180
>   [20801.303338]  io_uring_release+0x1c/0x20
>   [20801.303339]  __fput+0xad/0x210
>   [20801.303341]  task_work_run+0x8f/0xb0
>   [20801.303342]  exit_to_usermode_loop+0xa0/0xb0
>   [20801.303343]  do_syscall_64+0xe0/0x100
>   [20801.303349]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>   [20801.303380] Call Trace:
>   [20801.303383]  ? __schedule+0x284/0x650
>   [20801.303384]  schedule+0x33/0xc0
>   [20801.303386]  io_sq_thread+0x38a/0x410
>   [20801.303388]  ? __switch_to_asm+0x40/0x70
>   [20801.303390]  ? wait_woken+0x80/0x80
>   [20801.303392]  ? _raw_spin_lock_irqsave+0x17/0x40
>   [20801.303394]  ? io_submit_sqes+0x120/0x120
>   [20801.303395]  kthread+0x112/0x130
>   [20801.303396]  ? kthread_create_on_node+0x60/0x60
>   [20801.303398]  ret_from_fork+0x35/0x40
> 
>  o kthread_park() waits for park completion, so io_sq_thread() loop
>    should check kthread_should_park() along with khread_should_stop(),
>    otherwise if kthread_park() is called before prepare_to_wait()
>    the following schedule() never returns:
> 
>    CPU#0                    CPU#1
> 
>    io_sq_thread_stop():     io_sq_thread():
> 
>                                while(!kthread_should_stop() && !ctx->sqo_stop) {
> 
>       ctx->sqo_stop = 1;
>       kthread_park()
> 
> 	                            prepare_to_wait();
>                                     if (kthread_should_stop() {
> 				    }
>                                     schedule();   <<< nobody checks park flag,
> 				                  <<< so schedule and never return
> 
>  o if the flag ctx->sqo_stop is observed by the io_sq_thread() loop
>    it is quite possible, that kthread_should_park() check and the
>    following kthread_parkme() is never called, because kthread_park()
>    has not been yet called, but few moments later is is called and
>    waits there for park completion, which never happens, because
>    kthread has already exited:
> 
>    CPU#0                    CPU#1
> 
>    io_sq_thread_stop():     io_sq_thread():
> 
>       ctx->sqo_stop = 1;
>                                while(!kthread_should_stop() && !ctx->sqo_stop) {
>                                    <<< observe sqo_stop and exit the loop
> 			       }
> 
> 			       if (kthread_should_park())
> 			           kthread_parkme();  <<< never called, since was
> 					              <<< never parked
> 
>       kthread_park()           <<< waits forever for park completion
> 
> In the current patch we quit the loop by only kthread_should_park()
> check (kthread_park() is synchronous, so kthread_should_stop() is
> never observed), and we abandon ->sqo_stop flag, since it is racy.
> At the end of the io_sq_thread() we unconditionally call parmke(),
> since we've exited the loop by the park flag.

Thanks Roman, looks (and tests) good. Applied.

-- 
Jens Axboe

