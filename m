Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA8C433FE
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 19:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27901610A2
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 19:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhJLT45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhJLT44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 15:56:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26CC061745
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 12:54:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r9so298293ile.5
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSQQl7NLruRiTVNTiLqdFwIsoJenpkdY6bn0zUH6ku0=;
        b=a+VZB/R+NgvatZdNwhXRFg6BOY5gb0EQIF69YAL6bM/pmsQjP2Dc/NRUYCZyVxZQCa
         ho5YBse3Q3UNijweZuj9cCABof27sjesANA/YVA38WkQzjkM1rxhM1qkStE0rexguI9q
         mhJt6FZeC4q39bPrvXaF36vsvvR2Ss95+r9240Wsh/HSRL84xQ4LFri8wxTR5Nq/x+LY
         lcj03Fa4xGNMGmh7cZKCdTRlT5INwlcgwYW4ZYFaLMVM7umD9cLGWowwoK54L1SE1ufh
         pcal6f3vniV9avJOm/oGBIfsB4SXUAa9TUovzesZd7eoPwm4jg/aW+SqmmSG+6PEPIPG
         cObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSQQl7NLruRiTVNTiLqdFwIsoJenpkdY6bn0zUH6ku0=;
        b=UriYbJzI4CnSJV33E5NV6kshGNS0Udr5tHpXBe4S3oTu5tjOtexo9SGRdus1J4Sc8l
         3yAwmFch11goaWm51RAdCWP2mXkJ4x5auzf7BBR/Xct/3BfW55E7oK/h1YrY8Z3i6jkD
         Yrzb2kAtXozxuhFukopxcWzrutehelynjftJEKsztCogYDgdnSxPycgS2r2WJsTctOGG
         0PDHFXwow3uXj9ZMBgHcc9QB5WkTfHVA50kdvJkI1LqiBd9ZdNaEGy7Qd9qaGVUu2Yd3
         CUgETya/4Md2mMlGvcX7mAZhaBWkotvJHM5QSF2ZRzAre7aTrtvRsFQqEWntwKyAj1mx
         CwCQ==
X-Gm-Message-State: AOAM533owAJjolgfAAPwznvGX6h0BYx71MIrsM1bfU+Nci20kKOC/SCO
        lHAh9aVb0zTUmv0dMuQCezD1jQ==
X-Google-Smtp-Source: ABdhPJwGwwkQzK13LaChOQ9IR6eIhQKxf7gZbOrZdNsambuzhxwC0ZuV76tjbJazTB2suELvTJZvBA==
X-Received: by 2002:a05:6e02:17ce:: with SMTP id z14mr25333259ilu.120.1634068493569;
        Tue, 12 Oct 2021 12:54:53 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u12sm4098795ioc.33.2021.10.12.12.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 12:54:53 -0700 (PDT)
Subject: Re: [PATCH -next] block: fix UAF from race of ioc_release_fn() and
 __ioc_clear_queue()
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijinlin3@huawei.com
References: <20211012083044.2409495-1-qiulaibin@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c9ad9f2-c487-c793-1ffc-5c3ec0fcc0ae@kernel.dk>
Date:   Tue, 12 Oct 2021 13:54:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211012083044.2409495-1-qiulaibin@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 2:30 AM, Laibin Qiu wrote:
> KASAN reports a use-after-free report when doing block test:
> 
> [293762.535116]
> ==================================================================
> [293762.535129] BUG: KASAN: use-after-free in
> queued_spin_lock_slowpath+0x78/0x4c8
> [293762.535133] Write of size 2 at addr ffff8000d5f12bc8 by task sh/9148
> [293762.535135]
> [293762.535145] CPU: 1 PID: 9148 Comm: sh Kdump: loaded Tainted: G W
> 4.19.90-vhulk2108.6.0.h824.kasan.eulerosv2r10.aarch64 #1
> [293762.535148] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [293762.535150] Call trace:
> [293762.535154] dump_backtrace+0x0/0x310
> [293762.535158] show_stack+0x28/0x38
> [293762.535165] dump_stack+0xec/0x15c
> [293762.535172] print_address_description+0x68/0x2d0
> [293762.535177] kasan_report+0x130/0x2f0
> [293762.535182] __asan_store2+0x80/0xa8
> [293762.535189] queued_spin_lock_slowpath+0x78/0x4c8
> [293762.535194] __ioc_clear_queue+0x158/0x160
> [293762.535198] ioc_clear_queue+0x194/0x258
> [293762.535202] elevator_switch_mq+0x64/0x170
> [293762.535206] elevator_switch+0x140/0x270
> [293762.535211] elv_iosched_store+0x1a4/0x2a0
> [293762.535215] queue_attr_store+0x90/0xe0
> [293762.535219] sysfs_kf_write+0xa8/0xe8
> [293762.535222] kernfs_fop_write+0x1f8/0x378
> [293762.535227] __vfs_write+0xe0/0x360
> [293762.535233] vfs_write+0xf0/0x270
> [293762.535237] ksys_write+0xdc/0x1b8
> [293762.535241] __arm64_sys_write+0x50/0x60
> [293762.535245] el0_svc_common+0xc8/0x320
> [293762.535250] el0_svc_handler+0xf8/0x160
> [293762.535253] el0_svc+0x10/0x218
> [293762.535254]
> [293762.535258] Allocated by task 3466763:
> [293762.535264] kasan_kmalloc+0xe0/0x190
> [293762.535269] kasan_slab_alloc+0x14/0x20
> [293762.535276] kmem_cache_alloc_node+0x1b4/0x420
> [293762.535280] create_task_io_context+0x40/0x210
> [293762.535284] generic_make_request_checks+0xc78/0xe38
> [293762.535288] generic_make_request+0xf8/0x640
> [293762.535394] generic_file_direct_write+0x100/0x268
> [293762.535401] __generic_file_write_iter+0x128/0x370
> [293762.535467] vfs_iter_write+0x64/0x90
> [293762.535489] ovl_write_iter+0x2f8/0x458 [overlay]
> [293762.535493] __vfs_write+0x264/0x360
> [293762.535497] vfs_write+0xf0/0x270
> [293762.535501] ksys_write+0xdc/0x1b8
> [293762.535505] __arm64_sys_write+0x50/0x60
> [293762.535509] el0_svc_common+0xc8/0x320
> [293762.535387] ext4_direct_IO+0x3c8/0xe80 [ext4]
> [293762.535394] generic_file_direct_write+0x100/0x268
> [293762.535401] __generic_file_write_iter+0x128/0x370
> [293762.535452] ext4_file_write_iter+0x610/0xa80 [ext4]
> [293762.535457] do_iter_readv_writev+0x28c/0x390
> [293762.535463] do_iter_write+0xfc/0x360
> [293762.535467] vfs_iter_write+0x64/0x90
> [293762.535489] ovl_write_iter+0x2f8/0x458 [overlay]
> [293762.535493] __vfs_write+0x264/0x360
> [293762.535497] vfs_write+0xf0/0x270
> [293762.535501] ksys_write+0xdc/0x1b8
> [293762.535505] __arm64_sys_write+0x50/0x60
> [293762.535509] el0_svc_common+0xc8/0x320
> [293762.535513] el0_svc_handler+0xf8/0x160
> [293762.535517] el0_svc+0x10/0x218
> [293762.535521]
> [293762.535523] Freed by task 3466763:
> [293762.535528] __kasan_slab_free+0x120/0x228
> [293762.535532] kasan_slab_free+0x10/0x18
> [293762.535536] kmem_cache_free+0x68/0x248
> [293762.535540] put_io_context+0x104/0x190
> [293762.535545] put_io_context_active+0x204/0x2c8
> [293762.535549] exit_io_context+0x74/0xa0
> [293762.535553] do_exit+0x658/0xae0
> [293762.535557] do_group_exit+0x74/0x1a8
> [293762.535561] get_signal+0x21c/0xf38
> [293762.535564] do_signal+0x10c/0x450
> [293762.535568] do_notify_resume+0x224/0x4b0
> [293762.535573] work_pending+0x8/0x10
> [293762.535574]
> [293762.535578] The buggy address belongs to the object at
> ffff8000d5f12bb8
> which belongs to the cache blkdev_ioc of size 136
> [293762.535582] The buggy address is located 16 bytes inside of
> 136-byte region [ffff8000d5f12bb8, ffff8000d5f12c40)
> [293762.535583] The buggy address belongs to the page:
> [293762.535588] page:ffff7e000357c480 count:1 mapcount:0
> mapping:ffff8000d8563c00 index:0x0
> [293762.536201] flags: 0x7ffff0000000100(slab)
> [293762.536540] raw: 07ffff0000000100 ffff7e0003118588 ffff8000d8adb530
> ffff8000d8563c00
> [293762.536546] raw: 0000000000000000 0000000000140014 00000001ffffffff
> 0000000000000000
> [293762.536551] page dumped because: kasan: bad access detected
> [293762.536552]
> [293762.536554] Memory state around the buggy address:
> [293762.536558] ffff8000d5f12a80: 00 00 00 00 00 00 fc fc fc fc fc fc fc
> fc fb fb
> [293762.536562] ffff8000d5f12b00: fb fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fc
> [293762.536566] >ffff8000d5f12b80: fc fc fc fc fc fc fc fb fb fb fb fb
> fb fb fb fb
> [293762.536568] ^
> [293762.536572] ffff8000d5f12c00: fb fb fb fb fb fb fb fb fc fc fc fc fc
> fc fc fc
> [293762.536576] ffff8000d5f12c80: 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00
> 
> [293762.536577]
> ==================================================================
> 
> ioc_release_fn() will destroy icq from ioc->icq_list and
> __ioc_clear_queue() will destroy icq from request_queue->icq_list.
> However, the ioc_release_fn() will hold ioc_lock firstly, and
> free ioc finally. Then __ioc_clear_queue() will get ioc from icq
> and hold ioc_lock, but ioc has been released, which will result
> in a use-after-free.
> 
> CPU0                                    CPU1
> put_io_context                          elevator_switch_mq
> queue_work &ioc->release_work            ioc_clear_queue
>                                            ^^^ splice q->icq_list
>                                          __ioc_clear_queue
>                                            ^^^get icq from icq_list
>                                               get ioc from icq->ioc
>   ioc_release_fn
>    spin_lock(ioc->lock)
>    ioc_destroy_icq(icq)
>    spin_unlock(ioc->lock)
>    free(ioc)
>                                          spin_lock(ioc->lock) <= UAF
> 
> Fix by grabbing the request_queue->queue_lock in ioc_clear_queue() to
> avoid this race scene.
> 
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  block/blk-ioc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 57299f860d41..1d6ba8ff5a66 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -242,9 +242,9 @@ void ioc_clear_queue(struct request_queue *q)
>  
>  	spin_lock_irq(&q->queue_lock);
>  	list_splice_init(&q->icq_list, &icq_list);
> -	spin_unlock_irq(&q->queue_lock);
>  
>  	__ioc_clear_queue(&icq_list);
> +	spin_unlock_irq(&q->queue_lock);
>  }

This looks good to me - but I'd change __ioc_clear_queue() to use
spin_lock() instead of spin_lock_irqsave() as well at the same time, as
we just nest inside this call.


-- 
Jens Axboe

