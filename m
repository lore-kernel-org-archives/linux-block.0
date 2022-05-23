Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E778C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 14:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiEWOP1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 10:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiEWOPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 10:15:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327859322
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:15:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id u35so12577865qtc.13
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UOygwtue8FxveF0e91u7QAGHCJ4HdKKjaPKJK3YP7CE=;
        b=6KPFl+xnqEiXHDjC54rirh79X63AoLYJuJLg6zejRvudAQ5/Z2YxF1fK5Mmu+EzsZ/
         CMWilmVAaHFRfgJZaVXKZ8FyQUza1Z86w0lggRZgNcEgu48Qk+1sh96z71ajhhxqGJ/e
         EQSlG7No6QYA0pm0vnbHdZ8SAo18xdo2B2xeZLRcIRrL/dd2k4izFFx6EwLBEguB8dpQ
         7HSSNuEm315v+4mPnPsor7NE5xZ1x0gHJVFOXoJTEGs47TiLJYyel6CBDoN2OpqiCK6x
         Ba5D0/oE8NyPSb2Wo8Ms+/O1nJYhAd5E0wd6Oz0iFXyM0tT2vT4qxVbWzDr+Xvuw7RL6
         FjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOygwtue8FxveF0e91u7QAGHCJ4HdKKjaPKJK3YP7CE=;
        b=nZWs81nHv300CMJy5/eSbMsu2VcSU/tq3j4yNjilnSiLke9pFgFD59poodMDpm+7uE
         ukgC5RSqJhrMAwbI2xfjppeP3ov2jMQStiS8f95fabQTluYltgtxM/JLY8WU9XYGTpkw
         /sf6ou/tts0+Xq0ifARflQhdv+trpeP04loDUihuRRcRqGmgcaol7ByeABfewO1CvFAR
         iLRo5OmQPCynewMmFVzr88xjqDhjxBTIVpjU+ZHLfkIx9NDNXc3JrPZHWg8K1bIfXCmm
         YlzsPTtEISFIDLt6ptdSeBR895N81O/1aHd9YKIeWLr6cwxw+dCf3izOHhHOOq0EVJMy
         o2EA==
X-Gm-Message-State: AOAM531MMaV5DQ7wVLPCmxQhvicTflsG9pGUMCsd2M48XZpIEGKsjvXT
        5/4ADr1/wDVYSWfZZ8zyPSpfKQ==
X-Google-Smtp-Source: ABdhPJxjIPOYUwenosYkvPhI4FjM8uVXSr7y3QSr6b2XPYYdq6EirKyDr+yRQOC6zOsGbkMSwuVtJg==
X-Received: by 2002:a05:622a:1108:b0:2f3:d7d1:cf28 with SMTP id e8-20020a05622a110800b002f3d7d1cf28mr16123743qty.481.1653315323198;
        Mon, 23 May 2022 07:15:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v24-20020ae9e318000000b0069fc13ce1d4sm4413119qkf.5.2022.05.23.07.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:15:22 -0700 (PDT)
Date:   Mon, 23 May 2022 10:15:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 4/6] nbd: fix io hung while disconnecting device
Message-ID: <YouW+aI2jiqJtitw@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-5-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 21, 2022 at 03:37:47PM +0800, Yu Kuai wrote:
> In our tests, "qemu-nbd" triggers a io hung:
> 
> INFO: task qemu-nbd:11445 blocked for more than 368 seconds.
>       Not tainted 5.18.0-rc3-next-20220422-00003-g2176915513ca #884
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:qemu-nbd        state:D stack:    0 pid:11445 ppid:     1 flags:0x00000000
> Call Trace:
>  <TASK>
>  __schedule+0x480/0x1050
>  ? _raw_spin_lock_irqsave+0x3e/0xb0
>  schedule+0x9c/0x1b0
>  blk_mq_freeze_queue_wait+0x9d/0xf0
>  ? ipi_rseq+0x70/0x70
>  blk_mq_freeze_queue+0x2b/0x40
>  nbd_add_socket+0x6b/0x270 [nbd]
>  nbd_ioctl+0x383/0x510 [nbd]
>  blkdev_ioctl+0x18e/0x3e0
>  __x64_sys_ioctl+0xac/0x120
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fd8ff706577
> RSP: 002b:00007fd8fcdfebf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000040000000 RCX: 00007fd8ff706577
> RDX: 000000000000000d RSI: 000000000000ab00 RDI: 000000000000000f
> RBP: 000000000000000f R08: 000000000000fbe8 R09: 000055fe497c62b0
> R10: 00000002aff20000 R11: 0000000000000246 R12: 000000000000006d
> R13: 0000000000000000 R14: 00007ffe82dc5e70 R15: 00007fd8fcdff9c0
> 
> "qemu-ndb -d" will call ioctl 'NBD_DISCONNECT' first, however, following
> message was found:
> 
> block nbd0: Send disconnect failed -32
> 
> Which indicate that something is wrong with the server. Then,
> "qemu-nbd -d" will call ioctl 'NBD_CLEAR_SOCK', however ioctl can't clear
> requests after commit 2516ab1543fd("nbd: only clear the queue on device
> teardown"). And in the meantime, request can't complete through timeout
> because nbd_xmit_timeout() will always return 'BLK_EH_RESET_TIMER', which
> means such request will never be completed in this situation.
> 
> Now that the flag 'NBD_CMD_INFLIGHT' can make sure requests won't
> complete multiple times, switch back to call nbd_clear_sock() in
> nbd_clear_sock_ioctl(), so that inflight requests can be cleared.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
