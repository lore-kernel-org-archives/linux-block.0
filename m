Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F8C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 16:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKAQQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiKAQQA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 12:16:00 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29F1C431
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 09:15:55 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id j15so20842684wrq.3
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 09:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGy8Dqh8hTd259ahNXmFjnIGuKmlYP4QUP1cKt4WnNk=;
        b=5AS2frg2Sj1nk6QjZSMYLGERFtzXKJ9vQcNcSZmjIy85vbbvSwS4UJ0lGDA0OqUSEw
         E7C7Zz7mk45+/nmMxe5pbwcZxnwUPHXrduHqRO03WPORpWpINgp1wS8h/A6Miq8fck98
         83RIYhmAWqAXQZiW1xNpx74jLUmw4PNeFiBAePz/Jk8Mur9DgaMsn7+9W/G2ybbAwvOy
         6CAM3HxCTphbjDuhg7y+MZmTScTvhzS+Aj52JlEwoIo24bmQkCKazMabfIqmelkouemF
         64/teIxpYOx1f9iZSyUYcHJBz2dxjhs+bXSyYqEiaN+1w5308olaLkxpKwsdAqwFrgmZ
         VeAg==
X-Gm-Message-State: ACrzQf1LMRCKL0L89BSFkmCvRhgdeSKwxNpfktdCMup2Z7OsDWKO//5K
        bC4o0OtSZG2HuWTwOZTQR7aj7a0IqBw=
X-Google-Smtp-Source: AMsMyM41uVTouWXM9Izuq7lDNEBTLFqOM0czgn82sWPNasvDXvRyUV/vhQ01O8dOm71KMvrDnXPlQg==
X-Received: by 2002:adf:f482:0:b0:236:7a2f:69f with SMTP id l2-20020adff482000000b002367a2f069fmr12515104wro.115.1667319353742;
        Tue, 01 Nov 2022 09:15:53 -0700 (PDT)
Received: from [192.168.1.243] ([5.30.201.27])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b002368a6deaf8sm10490897wrm.57.2022.11.01.09.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 09:15:53 -0700 (PDT)
Message-ID: <da291a9d-ce19-e48f-f2dc-a866218d9b95@linux.com>
Date:   Tue, 1 Nov 2022 20:15:50 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: efremov@linux.com
Subject: Re: [PATCH] block/floppy: Fix memory leak in do_floppy_init()
Content-Language: en-US
To:     Yuan Can <yuancan@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <20221031120443.78993-1-yuancan@huawei.com>
From:   Denis Efremov <efremov@linux.com>
In-Reply-To: <20221031120443.78993-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 10/31/22 16:04, Yuan Can wrote:
> A memory leak was reported when floppy_alloc_disk() failed in
> do_floppy_init().
> 
> unreferenced object 0xffff888115ed25a0 (size 8):
>   comm "modprobe", pid 727, jiffies 4295051278 (age 25.529s)
>   hex dump (first 8 bytes):
>     00 ac 67 5b 81 88 ff ff                          ..g[....
>   backtrace:
>     [<000000007f457abb>] __kmalloc_node+0x4c/0xc0
>     [<00000000a87bfa9e>] blk_mq_realloc_tag_set_tags.part.0+0x6f/0x180
>     [<000000006f02e8b1>] blk_mq_alloc_tag_set+0x573/0x1130
>     [<0000000066007fd7>] 0xffffffffc06b8b08
>     [<0000000081f5ac40>] do_one_initcall+0xd0/0x4f0
>     [<00000000e26d04ee>] do_init_module+0x1a4/0x680
>     [<000000001bb22407>] load_module+0x6249/0x7110
>     [<00000000ad31ac4d>] __do_sys_finit_module+0x140/0x200
>     [<000000007bddca46>] do_syscall_64+0x35/0x80
>     [<00000000b5afec39>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> unreferenced object 0xffff88810fc30540 (size 32):
>   comm "modprobe", pid 727, jiffies 4295051278 (age 25.529s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000007f457abb>] __kmalloc_node+0x4c/0xc0
>     [<000000006b91eab4>] blk_mq_alloc_tag_set+0x393/0x1130
>     [<0000000066007fd7>] 0xffffffffc06b8b08
>     [<0000000081f5ac40>] do_one_initcall+0xd0/0x4f0
>     [<00000000e26d04ee>] do_init_module+0x1a4/0x680
>     [<000000001bb22407>] load_module+0x6249/0x7110
>     [<00000000ad31ac4d>] __do_sys_finit_module+0x140/0x200
>     [<000000007bddca46>] do_syscall_64+0x35/0x80
>     [<00000000b5afec39>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> If the floppy_alloc_disk() failed, disks of current drive will not be set,
> thus the lastest allocated set->tag cannot be freed in the error handling
> path. A simple call graph shown as below:
> 
>  floppy_module_init()
>    floppy_init()
>      do_floppy_init()
>        for (drive = 0; drive < N_DRIVE; drive++)
>          blk_mq_alloc_tag_set()
>            blk_mq_alloc_tag_set_tags()
>              blk_mq_realloc_tag_set_tags() # set->tag allocated
>          floppy_alloc_disk()
>            blk_mq_alloc_disk() # error occurred, disks failed to allocated
> 
>        ->out_put_disk:
>        for (drive = 0; drive < N_DRIVE; drive++)
>          if (!disks[drive][0]) # the last disks is not set and loop break
>            break;
>          blk_mq_free_tag_set() # the latest allocated set->tag leaked
> 
> Fix this problem by free the set->tag of current drive before jump to
> error handling path.
> 
> Fixes: 302cfee15029 ("floppy: use a separate gendisk for each media format")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---

Thank you for the patch! I took it to 
https://github.com/evdenis/linux-floppy/commit/b8c08b4dfa7c90860d77b980ce80382514452b2a
and will send to Jens before 6.2 with other floppy fixes.
I'll also send it to stable trees.

>  drivers/block/floppy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index ccad3d7b3ddd..487840e3564d 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4593,8 +4593,10 @@ static int __init do_floppy_init(void)
>  			goto out_put_disk;
>  
>  		err = floppy_alloc_disk(drive, 0);
> -		if (err)
> +		if (err) {
> +			blk_mq_free_tag_set(&tag_sets[drive]);
>  			goto out_put_disk;
> +		}
>  
>  		timer_setup(&motor_off_timer[drive], motor_off_callback, 0);
>  	}

Thanks,
Denis
