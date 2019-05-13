Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76133C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 18:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426422085A
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 18:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tGkLm+m4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfEMSwT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 14:52:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46848 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEMSwT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 14:52:19 -0400
Received: by mail-io1-f65.google.com with SMTP id q21so7695331iog.13
        for <linux-block@vger.kernel.org>; Mon, 13 May 2019 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kVTZGJqN7tVEH3YwojEmRicKcOtbpEmUQp8jWTo9LUE=;
        b=tGkLm+m42H68P4jTw9uOiQ/CLwMhkqowe64lrjUDOMJsecGhUqZ+jS+4aMZ3RzCf/r
         vycZNPtXiew3mSs24ZUSSNNxn+lRtrbg6ec5Q2G3shw5b0wnIxq2+O9TRs8RJ+MpoG6G
         43HQOMWExXr10JPDxTMPHYyzeMM3xyK1Gaer3fn2/QK+Vc3bdjqo6Gb5B9E70Oo4xRXs
         LlQA8uozT6GRkv6972b07hV8Rnspqy4xT+dhaJT57YaAwno1loD7snmimoZGX+m+Xfqh
         9vRDMe4ZAN/LdsStQl1RF9koMB6zRz9QSvDLA25eSqHTtc+UHBsDampRfJS3iCxlsIt7
         prjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kVTZGJqN7tVEH3YwojEmRicKcOtbpEmUQp8jWTo9LUE=;
        b=WWj5G/qjMyfWThKjUMVe9NX32Ce/sF267/luvZSStj7dOGdl/GYGnqG2+ExkN5xATu
         QRR7/mbNUm6O963PpBjgqVicYRi0nGtmVca8lTVwCfOz/PkrtVTxS8Oy/T/K8kwDtWlM
         Ius+4yFFn4SBy9Dht1uEf2VenkUx/8KE3rLnetDwCFUZrjciAURlZjlIeo5IvbQwdRNq
         18vpodXLNYgG/vp9/zh6V0HOnYKRJRx7Cz9sKgGCEcqEGxKR8NhFYcLuMooiUXnr3F9y
         y4IsM8LsCYlXNyqjfSFE4L3CES8kg2RmOop0DSpsOnApHcp7EvkdOUVQmPwAwcSW8oP6
         SSJg==
X-Gm-Message-State: APjAAAXR26D4UZPKWDFVvJ2RmrQ4jHSS7YLyu8o9E31s58mfgSXjomDh
        NW9ZpbnGoAa03lL927m19UrMTeKNLpXC7Q==
X-Google-Smtp-Source: APXvYqzUPk+aiwslClUa/KdoeImzhYv5nhCzPbEzsK0R3qsbdaGXaO6jQTEL2NjhuNhOH7mN/Wv00Q==
X-Received: by 2002:a5d:9284:: with SMTP id s4mr11957090iom.146.1557773538342;
        Mon, 13 May 2019 11:52:18 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 83sm141384ite.27.2019.05.13.11.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:52:17 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: fix infinite wait in khread_park() on
 io_finish_async()
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-block@vger.kernel.org
References: <20190513182028.29912-1-rpenyaev@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bcf3f935-e2c0-6bcf-92fb-760583ff5500@kernel.dk>
Date:   Mon, 13 May 2019 12:52:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513182028.29912-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/19 12:20 PM, Roman Penyaev wrote:
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
>    the following schedule() never returns.
> 
>  o if the flag ctx->sqo_stop is observed by the io_sq_thread() loop
>    it is quite possible, that kthread_should_park() check and the
>    following kthread_parkme() is never called, because kthread_park()
>    has not been yet called, but few moments later is is called and
>    waits there for park completion, which never happens, because
>    kthread has already exited.
> 
> It seems that parking here is not needed at all (thread is parked and
> then stopped and never unparked), so here in this patch I simply rely
> on kthread_should_stop() check and then exit the thread.

The park is a bit of a work-around, without it we get warning spews on
shutdown with SQPOLL set and affinity set to a single CPU.

Also see:

commit 06058632464845abb1af91521122fd04dd3daaec
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Apr 13 09:26:03 2019 -0600

    io_uring: park SQPOLL thread if it's percpu

-- 
Jens Axboe

