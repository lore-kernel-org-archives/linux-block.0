Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D9C3DA7D
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 21:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjACVvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 16:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACVvX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 16:51:23 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D5E14D0C
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 13:51:22 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x26so15313955pfq.10
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2023 13:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qxvs5SYghBmedzIwLFBV33XsD6FLWJo430wnuX1zEMA=;
        b=EWQRYcfZJpAMuqgcxUSgdsGobAkCqjzR6lPAnHYchkqdU+7Vr3eUH55IKYQcRPek94
         b/WPO0QhFcog0p6W+ebzGc+ARf8F+ubSMbWmGyyvSrHL4yS8K7aUxI+EDxWGty/8QPJU
         Pm10s6qwwdgnFKUNmemLUDO/h4ElKV/5tgbF43h2DvgRzLTvSUNDdQZXh7UaaNdFZauK
         OGjxZuzgTxGapgX7VvJ62htCkL1IkchDXDvB3IRJsHyUhZ095vRrUw1aavhBJ5mhBrq+
         BDm4pSG3l/ZAFDkZpJqS995pSIvaP3bQMqlrz0bGsAvI2H0BJTkxRMpo+RJxLXMMCBDx
         nOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxvs5SYghBmedzIwLFBV33XsD6FLWJo430wnuX1zEMA=;
        b=uD8HxtnhPd14cekKN7yDD7Guq6FLqKnzz0schoaUeh709szaWxDdpxOYBMcnV/ey+W
         VK6VVgR2+w1iIjn/QoyZ/GoyB10+gMq8jK3uHTJD33JahuTPtOB3PpxhmBP84s5iGlpZ
         Ioj0zrEpRT4Nk89WeXgySqqOWx/sajlN9iyJ86L/PFUt5AdIMrKhhBE7sGNlaZ75s4pI
         g/u/Gc3zT/mo1ac9o3X1HVfSrryc9+jOOi2U9PXT8tidszZNqh7ykaayf8zge0Rx0r0e
         vc/YndNjy9MtIhTo9x1aPl+t8UaF7Mm3DFDdJSDt83U+/LJT871iHioJAUCW1f7ObOvv
         CS/Q==
X-Gm-Message-State: AFqh2kpA5/sU0JRxqzW4geFJnmzzJhJtcT2lfEiRwdBZ/IFsO3RJoysi
        955Hv9RwV7IHQyddg0e67XftdQ==
X-Google-Smtp-Source: AMrXdXtSnGnYZDTU3uOZOm2dPFSnQFpQk59KKoh7gJPT3sy2H888UxiiQB5AAb96riK2vCzq/x4CYw==
X-Received: by 2002:a62:1996:0:b0:582:d97d:debc with SMTP id 144-20020a621996000000b00582d97ddebcmr406085pfz.3.1672782681658;
        Tue, 03 Jan 2023 13:51:21 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b0057726bd7335sm15564507pfp.121.2023.01.03.13.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 13:51:21 -0800 (PST)
Message-ID: <974410c0-46e8-c240-388c-9b0c339fcd09@kernel.dk>
Date:   Tue, 3 Jan 2023 14:51:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Potential hang on ublk_ctrl_del_dev()
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/3/23 2:47?PM, Nadav Amit wrote:
> Hello Ming,
> 
> I am trying the ublk and it seems very exciting.
> 
> However, I encounter an issue when I remove a ublk device that is mounted or
> in use.
> 
> In ublk_ctrl_del_dev(), shouldn?t we *not* wait if ublk_idr_freed() is false?
> It seems to me that it is saner to return -EBUSY in such a case and let
> userspace deal with the results.
> 
> For instance, if I run the following (using ubdsrv):
> 
>  $ mkfs.ext4 /dev/ram0
>  $ ./ublk add -t loop -f /dev/ram0
>  $ sudo mount /dev/ublkb0 tmp
>  $ sudo ./ublk del -a
> 
> ublk_ctrl_del_dev() would not be done until the partition is unmounted, and you
> can get a splat that is similar to the one below.
> 
> What do you say? Would you agree to change the behavior to return -EBUSY?
> 
> Thanks,
> Nadav
> 
> 
> [  974.149938] INFO: task ublk:2250 blocked for more than 120 seconds.
> [  974.157786]       Not tainted 6.1.0 #30
> [  974.162369] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  974.171417] task:ublk            state:D stack:0     pid:2250  ppid:2249   flags:0x00004004
> [  974.181054] Call Trace:
> [  974.184097]  <TASK>
> [  974.186726]  __schedule+0x37e/0xe10
> [  974.190915]  ? __this_cpu_preempt_check+0x13/0x20
> [  974.196463]  ? lock_release+0x133/0x2a0
> [  974.201043]  schedule+0x67/0xe0
> [  974.204846]  ublk_ctrl_uring_cmd+0xf45/0x1110
> [  974.210016]  ? lock_is_held_type+0xdd/0x130
> [  974.214990]  ? var_wake_function+0x60/0x60
> [  974.219872]  ? rcu_read_lock_sched_held+0x4f/0x80
> [  974.225443]  io_uring_cmd+0x9a/0x130
> [  974.229743]  ? io_uring_cmd_prep+0xf0/0xf0
> [  974.234638]  io_issue_sqe+0xfe/0x340
> [  974.238946]  io_submit_sqes+0x231/0x750
> [  974.243553]  __x64_sys_io_uring_enter+0x22b/0x640
> [  974.249134]  ? trace_hardirqs_on+0x3c/0xe0
> [  974.254042]  do_syscall_64+0x35/0x80
> [  974.258361]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Ming, this also looks like ublk doesn't always honor
IO_URING_F_NONBLOCK, we can't be sleeping like that under issue. Then it
should be bounced with -EAGAIN and retried from an io-wq worker.

-- 
Jens Axboe

