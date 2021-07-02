Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE03C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 05:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB42661424
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 05:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhGBGBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 02:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGBGBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 02:01:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C7C061762;
        Thu,  1 Jul 2021 22:58:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e20so8619849pgg.0;
        Thu, 01 Jul 2021 22:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lu7eSsn+Id/N8FajSofs9OS3PuI6JD/yF6zHZnFxH30=;
        b=KE4M4gZmLORI1SCZ8EN1b30jV6VN5mJtRvPT6vDsEpDkW91sXks9YPQbNFlubvsO4y
         gaHRfTvhP0r/ZSWm4lKC21SzphxQCqgLCVhVYOYtd+ZOJWKK7PJwoxt5wr8M7YKKJT+F
         q988TxX1cb7JNBBJHwAkjHx9K7M2LM4mGHubSR5LrACbCXobUk5ilpBZ6Y8TlbYpethL
         4mb6QNl1zmpLaLtcokK/tEuTARLF2U1NQ7nzyeTull2X0iLL8mZlJmfs75tTqKLvEXkH
         81IbsVH5VpAIwYHDtpRBd+HJik9t+VRKIAi7+gU4fK16JfgBUJvQ/yr8lxZ4iHYMBfD1
         Nk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Lu7eSsn+Id/N8FajSofs9OS3PuI6JD/yF6zHZnFxH30=;
        b=Ifz4X2c4hMeZ44N3VZz7plOreye/6hT0ohbhGIdz4OvFM290f2I4HY1wGYqbybI/nL
         0zysDOET4XWdFG9GWYZOYsPCMEwB5BaMZYGAIUM1tVFcp3JaWk71Ch5nU3jPHjSYObwC
         uXXuiwPGHTZHyai9uEszDufv3MKzpr/qwfnZAalbW5pwxt/RQL1gzJLyGxjZLnyp7Guw
         9+igeFLUq6SoZKYK9LtlYnhbcoyZgNs5T7D5O2c9+S/zpUHypEFoi33pzIeH7hXpb7Nu
         DKIWEWIXG4ZqswXjHUnc/G+vZ/9/VqXI3V+3nZvEm5SVcMa1tvL296cYuJw3yumuDdbL
         /EMw==
X-Gm-Message-State: AOAM532Gcvxxw5cY9jaezKJkPx0wmRl6ASZxKHEgDPnnYjjPb4gQAMLC
        Ptua5uHJ0rlaYwCiuegwGtA=
X-Google-Smtp-Source: ABdhPJx9iQiOGTL4RIMoRFJF6qMeGkWQTyUsVYDxONye2RFuBrJspgLl5vrzhN1/vvBRYpfBb3fSrw==
X-Received: by 2002:a62:5285:0:b029:2e9:e0d5:67dc with SMTP id g127-20020a6252850000b02902e9e0d567dcmr3792309pfb.79.1625205511403;
        Thu, 01 Jul 2021 22:58:31 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:e476:fcd4:d1bf:22a2])
        by smtp.gmail.com with ESMTPSA id k13sm1834882pfu.57.2021.07.01.22.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 22:58:30 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 1 Jul 2021 22:58:28 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, rafael@kernel.org,
        axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] zram: fix deadlock with sysfs attribute usage and
 module removal
Message-ID: <YN6rBKIHmLhEo36w@google.com>
References: <20210702043716.2692247-1-mcgrof@kernel.org>
 <20210702043716.2692247-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702043716.2692247-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 09:37:16PM -0700, Luis Chamberlain wrote:
> When sysfs attributes use a lock also used on module removal we can
> potentially deadlock. This happens when for instance a sysfs file on
> a driver is used, then at the same time we have module removal call
> trigger. The module removal call code holds a lock, and then the sysfs
> file entry waits for the same lock. While holding the lock the module
> removal tries to remove the sysfs entries, but these cannot be removed
> yet as one is waiting for a lock. This won't complete as the lock is
> already held. Likewise module removal cannot complete, and so we deadlock.
> 
> To fix this we just *try* to get a refcount to the module when a shared
> lock is used, prior to mucking with a sysfs attribute. If this fails we
> just give up right away.
> 
> We use a try method as a full lock means we'd then make our sysfs
> attributes busy us out from possible module removal, and so userspace
> could force denying module removal, a silly form of "DOS" against module
> removal. A try lock on the module removal ensures we give priority to
> module removal and interacting with sysfs attributes only comes second.
> Using a full lock could mean for instance that if you don't stop poking
> at sysfs files you cannot remove a module.
> 
> This deadlock was first reported with the zram driver, a sketch of how
> this can happen follows:
> 
> CPU A                              CPU B
>                                    whatever_store()
> module_unload
>   mutex_lock(foo)
>                                    mutex_lock(foo)
>    del_gendisk(zram->disk);
>      device_del()
>        device_remove_groups()
> 
> In this situation whatever_store() is waiting for the mutex foo to
> become unlocked, but that won't happen until module removal is complete.
> But module removal won't complete until the sysfs file being poked
> completes which is waiting for a lock already held.
> 
> This is a generic kernel issue with sysfs files which use any lock also
> used on module removal. Different generic solutions have been proposed.
> One approach proposed is by directly by augmenting attributes with module
> information [0]. This patch implements a solution by adding macros with
> the prefix MODULE_DEVICE_ATTR_*() which accomplish the same. Until we
> don't have a generic agreed upon solution for this shared between drivers,
> we must implement a fix for this on each driver.
> 
> We make zram use the new MODULE_DEVICE_ATTR_*() helpers, and completely
> open code the solution for class attributes as there are only a few of
> those.
> 
> This issue can be reproduced easily on the zram driver as follows:
> 
> Loop 1 on one terminal:
> 
> while true;
> 	do modprobe zram;
> 	modprobe -r zram;
> done
> 
> Loop 2 on a second terminal:
> while true; do
> 	echo 1024 >  /sys/block/zram0/disksize;
> 	echo 1 > /sys/block/zram0/reset;
> done
> 
> Without this patch we end up in a deadlock, and the following
> stack trace is produced which hints to us what the issue was:
> 
> INFO: task bash:888 blocked for more than 120 seconds.
>       Tainted: G            E 5.12.0-rc1-next-20210304+ #4
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:bash            state:D stack:    0 pid:  888 ppid: 887 flags:<etc>
> Call Trace:
>  __schedule+0x2e4/0x900
>  schedule+0x46/0xb0
>  schedule_preempt_disabled+0xa/0x10
>  __mutex_lock.constprop.0+0x2c3/0x490
>  ? _kstrtoull+0x35/0xd0
>  reset_store+0x6c/0x160 [zram]
>  kernfs_fop_write_iter+0x124/0x1b0
>  new_sync_write+0x11c/0x1b0
>  vfs_write+0x1c2/0x260
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f34f2c3df33
> RSP: 002b:00007ffe751df6e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f34f2c3df33
> RDX: 0000000000000002 RSI: 0000561ccb06ec10 RDI: 0000000000000001
> RBP: 0000561ccb06ec10 R08: 000000000000000a R09: 0000000000000001
> R10: 0000561ccb157590 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007f34f2d0e6a0 R14: 0000000000000002 R15: 00007f34f2d0e8a0
> INFO: task modprobe:1104 can't die for more than 120 seconds.
> task:modprobe        state:D stack:    0 pid: 1104 ppid: 916 flags:<etc>
> Call Trace:
>  __schedule+0x2e4/0x900
>  schedule+0x46/0xb0
>  __kernfs_remove.part.0+0x228/0x2b0
>  ? finish_wait+0x80/0x80
>  kernfs_remove_by_name_ns+0x50/0x90
>  remove_files+0x2b/0x60
>  sysfs_remove_group+0x38/0x80
>  sysfs_remove_groups+0x29/0x40
>  device_remove_attrs+0x4a/0x80
>  device_del+0x183/0x3e0
>  ? mutex_lock+0xe/0x30
>  del_gendisk+0x27a/0x2d0
>  zram_remove+0x8a/0xb0 [zram]
>  ? hot_remove_store+0xf0/0xf0 [zram]
>  zram_remove_cb+0xd/0x10 [zram]
>  idr_for_each+0x5e/0xd0
>  destroy_devices+0x39/0x6f [zram]
>  __do_sys_delete_module+0x190/0x2a0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f32adf727d7
> RSP: 002b:00007ffc08bb38a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 000055eea23cbb10 RCX: 00007f32adf727d7
> RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055eea23cbb78
> RBP: 000055eea23cbb10 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007f32adfe5ac0 R11: 0000000000000206 R12: 000055eea23cbb78
> R13: 0000000000000000 R14: 0000000000000000 R15: 000055eea23cbc20
> 
> [0] https://lkml.kernel.org/r/20210401235925.GR4332@42.do-not-panic.com
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Minchan Kim <minchan@kernel.org>

Much simple/clean now. Thanks for persuing the effort.
