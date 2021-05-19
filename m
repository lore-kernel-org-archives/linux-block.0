Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC5C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FE3611B0
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 19:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhESTzZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhESTzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 15:55:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32630C06175F;
        Wed, 19 May 2021 12:54:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d78so9784858pfd.10;
        Wed, 19 May 2021 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MtQ4QMhacvE9H697yKg0y9WJKH5vHDX0jMNB3TsvZ9o=;
        b=S0UM1lWBkkf82jL6M7fA49r7YTKmTpx7zKqy7ldM6w9vJVlyp/hQVK77dcOqzSLam3
         eoO5zwTQe473xrVELi14OzFRRbu/p/27hbFUuszc5xcpMTyovdjwXR5zq6uI2Yh3/t/L
         MnEacxFW//l2K0vQeH1COzzXPoDymmPTWdpVUXh1G4nxpwFx35++lfUip0BfKzKTZraD
         MST9uNUUAVlRBXQu1JKMsiVIodhc6cuObdvsQN630CMPPgCahBOysFT8qsSx+dYvkCdK
         85fLZXOyTDSKZQZtPpfgQMTbl60GpzNXhU7jeNsCWW/l9yqxdnJX19tHV7LrgIwAS4bq
         WMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MtQ4QMhacvE9H697yKg0y9WJKH5vHDX0jMNB3TsvZ9o=;
        b=te4ueGQlvEgyNurtJ2DXNKwj/UGkKLvMw0/2sr1fyiwI1PDigVay/mWcFg3asPhb5e
         9J263gVC6jBtulqu2y7P6oWz9ZIZjY8qg7pVGBJ6pPe3lZe8mVWThbkCCIUI1EqoX1CJ
         55SjJzcTwfy3Y6mbd8LqSY4A+WZlGPG8fh7ZPy+04tJvz6LMthpUZQ6YEDblD6KxJKFU
         Bhpxmoo8L61QwnBtPlUcEjgMNK3VjursyUx0YMim7xrQ7NofJ1J7oJOAOvD0Mu52+AeE
         pCUTK0aiCaQxzRdj3ajwiR/Pt+tldkxjJMispqZa7w8sIea7r5RZgTs8lImBRnZDQtqI
         oAZQ==
X-Gm-Message-State: AOAM532SxJ4xlijQpOyhlx1sFPSv+pSCuuq/6oSMeQ60L8jWQBm2NZQg
        kxdwYmPhsfLhGprboygxpRY=
X-Google-Smtp-Source: ABdhPJzBxRP23Pq0cpLunctYV2Hn1cAIk8pa4ioVC58rqmLCwMBhoZAZ0ifxvKm+0wGwx1LZaXT2Hw==
X-Received: by 2002:a63:af0f:: with SMTP id w15mr766296pge.295.1621454044551;
        Wed, 19 May 2021 12:54:04 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4102:f4c7:9246:e6c4])
        by smtp.gmail.com with ESMTPSA id a18sm159568pgg.51.2021.05.19.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:54:04 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 19 May 2021 12:54:02 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YKVs2pSiTaRSQljC@google.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <20210423011108.11988-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423011108.11988-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 01:11:05AM +0000, Luis Chamberlain wrote:
> Provide a simple state machine to fix races with driver exit where we
> remove the CPU multistate callbacks and re-initialization / creation of
> new per CPU instances which should be managed by these callbacks.
> 
> The zram driver makes use of cpu hotplug multistate support, whereby it
> associates a struct zcomp per CPU. Each struct zcomp represents a
> compression algorithm in charge of managing compression streams per CPU.
> Although a compiled zram driver only supports a fixed set of compression
> algorithms, each zram device gets a struct zcomp allocated per CPU. The
> "multi" in CPU hotplug multstate refers to these per cpu struct zcomp
> instances. Each of these will have the CPU hotplug callback called for
> it on CPU plug / unplug. The kernel's CPU hotplug multistate keeps a
> linked list of these different structures so that it will iterate over
> them on CPU transitions.
> 
> By default at driver initialization we will create just one zram device
> (num_devices=1) and a zcomp structure then set for the now default
> lzo-rle comrpession algorithm. At driver removal we first remove each
> zram device, and so we destroy the associated struct zcomp per CPU. But
> since we expose sysfs attributes to create new devices or reset / initialize
> existing zram devices, we can easily end up re-initializing a struct zcomp
> for a zram device before the exit routine of the module removes the cpu
> hotplug callback. When this happens the kernel's CPU hotplug will detect
> that at least one instance (struct zcomp for us) exists. This can happen
> in the following situation:
> 
> CPU 1                            CPU 2
> 
> class_unregister(...);
> idr_for_each(...);
> zram_debugfs_destroy();
>                                 disksize_store(...);
> idr_destroy(...);
> unregister_blkdev(...);
> cpuhp_remove_multi_state(...);
> 
> The warning comes up on cpuhp_remove_multi_state() when it sees that the
> state for CPUHP_ZCOMP_PREPARE does not have an empty instance linked list.
> In this case, that a struct zcom still exists, the driver allowed its
> creation per CPU even though we could have just freed them per CPU
> though a call on another CPU, and we are then later trying to remove the
> hotplug callback.
> 
> Fix all this by providing a zram initialization boolean
> protected the the shared in the driver zram_index_mutex,
> which we can use to annotate when sysfs attributes are
> safe to use or not -- once the driver is properly initialized.
> When the driver is going down we also are sure to not let
> userspace muck with attributes which may affect each per cpu
> struct zcomp.
> 
> This also fixes a series of possible memory leaks. The
> crashes and memory leaks can easily be caused by issuing
> the zram02.sh script from the LTP project [0] in a loop
> in two separate windows:
> 
>   cd testcases/kernel/device-drivers/zram
>   while true; do PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh; done
> 
> You end up with a splat as follows:
> 
> kernel: zram: Removed device: zram0
> kernel: zram: Added device: zram0
> kernel: zram0: detected capacity change from 0 to 209715200
> kernel: Adding 104857596k swap on /dev/zram0.  Priority:-2 extents:1 across:104857596k SSFS
> kernel: zram0: detected capacitky change from 209715200 to 0
> kernel: zram0: detected capacity change from 0 to 209715200
> kernel: ------------[ cut here ]------------
> kernel: Error: Removing state 63 which has instances left.
> kernel: WARNING: CPU: 7 PID: 70457 at kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
> kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>
> kernel: CPU: 7 PID: 70457 Comm: rmmod Tainted: G            E     5.12.0-rc1-next-20210304 #3
> kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> kernel: RIP: 0010:__cpuhp_remove_state_cpuslocked+0xf9/0x100
> kernel: Code: <etc>
> kernel: RSP: 0018:ffffa800c139be98 EFLAGS: 00010282
> kernel: RAX: 0000000000000000 RBX: ffffffff9083db58 RCX: ffff9609f7dd86d8
> kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9609f7dd86d0
> kernel: RBP: 0000000000000000i R08: 0000000000000000 R09: ffffa800c139bcb8
> kernel: R10: ffffa800c139bcb0 R11: ffffffff908bea40 R12: 000000000000003f
> kernel: R13: 00000000000009d8 R14: 0000000000000000 R15: 0000000000000000
> kernel: FS: 00007f1b075a7540(0000) GS:ffff9609f7dc0000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES 0000 CR0: 0000000080050033
> kernel: CR2: 00007f1b07610490 CR3: 00000001bd04e000 CR4: 0000000000350ee0
> kernel: Call Trace:
> kernel: __cpuhp_remove_state+0x2e/0x80
> kernel: __do_sys_delete_module+0x190/0x2a0
> kernel:  do_syscall_64+0x33/0x80
> kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The "Error: Removing state 63 which has instances left" refers
> to the zram per CPU struc zcomp instances left.
> 
> [0] https://github.com/linux-test-project/ltp.git
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>
