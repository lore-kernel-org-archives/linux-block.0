Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ECCC433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E0520659
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JfDhaN3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfGaOoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:44:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44902 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfGaOoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 10:44:46 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so136657699iob.11
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qrlqtZ2LKCO/jAEUyoC0ndYHr6eCC8ojnK1cOs+wqck=;
        b=JfDhaN3AScGDGpzWgm9xrnPXbQ++2WNE1r4GEcLr/qd34GmXeLRGat/k+Hvh3TcqNf
         SueYicShJy6t5NnHvDWnleUMrfbqIcMLGoAmYQMBQFiPsT13VrqghyxzoJ7Dhtc/j/K6
         kfDXD94VIddubuxk8T5ieXXqjmkdzAiMq2/nHt+lHNYdnpii7ngINLFyHE8SM4lAHQyg
         QcwXzJT13C8Tsbpxf6tBUIu7kGinpFNrXKT7yV7Vs0WB2MfQyum+xhWbT/sAl/ZicrgU
         /xC1x47bQA7ORxTjt/03vry8pa7fyFJYjoxcvfH8d7DDNzGzdffa3/+rJ+meIcfGsEdd
         jDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qrlqtZ2LKCO/jAEUyoC0ndYHr6eCC8ojnK1cOs+wqck=;
        b=bwQtSeUMgIOrCNtU7f7CchScjNnFH1UV+WViDkhM4it6OKa2zjrQhVGoDm5k+fy1WN
         XsF5CHtS6CFRWqGGlwSpLYy26AZ9MpaZ87JYSzHjRgOmjH8oiAdgOy6FgDa6Ay12Cnlt
         qV84HSNcMKMBiPXgzWsOdN9tQ8zypELZNvpSOw2BuATHKQFLIyqjozUyT5kjXrYizC9D
         GPogIfVrycrpqccWeCqA0dkO4cbx4+CEeWI4DxSCLFxdv9ky2UnYjqDw8hNeWrLVjbF5
         zNypLjp4RI6FW643PtLHjQmN00cVKujF1cv07pIckrVJ69pSTSPKGS6L2Zyr8+iQlTDw
         IcYg==
X-Gm-Message-State: APjAAAVP3aFG0V3Y3KPYtsVpi6peUnaqfXNiCeaum9ivBvNEukvdeyzj
        jd9rvZ78eCf5vjPSTVOeREp7J3kdruo=
X-Google-Smtp-Source: APXvYqzGdyAEJDKYQW25Oj8eyD6mVr2igsVbGdOolZ/umcOu9umrQHNk0C2oEwDLx04PtjYdf2VXSA==
X-Received: by 2002:a5d:8a10:: with SMTP id w16mr1589851iod.175.1564584284936;
        Wed, 31 Jul 2019 07:44:44 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h8sm62015017ioq.61.2019.07.31.07.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:44:43 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: fix KASAN use after free in
 io_sq_wq_submit_work
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        linux-block@vger.kernel.org
References: <1564555173-10766-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <183aa5ea-67b6-0fd5-04e1-46d4a5c96c5c@kernel.dk>
Date:   Wed, 31 Jul 2019 08:44:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564555173-10766-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/19 12:39 AM, Jackie Liu wrote:
> [root@localhost ~]# ./liburing/test/link
> 
> QEMU Standard PC report that:
> 
> [   29.379892] CPU: 0 PID: 84 Comm: kworker/u2:2 Not tainted 5.3.0-rc2-00051-g4010b622f1d2-dirty #86
> [   29.379902] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   29.379913] Workqueue: io_ring-wq io_sq_wq_submit_work
> [   29.379929] Call Trace:
> [   29.379953]  dump_stack+0xa9/0x10e
> [   29.379970]  ? io_sq_wq_submit_work+0xbf4/0xe90
> [   29.379986]  print_address_description.cold.6+0x9/0x317
> [   29.379999]  ? io_sq_wq_submit_work+0xbf4/0xe90
> [   29.380010]  ? io_sq_wq_submit_work+0xbf4/0xe90
> [   29.380026]  __kasan_report.cold.7+0x1a/0x34
> [   29.380044]  ? io_sq_wq_submit_work+0xbf4/0xe90
> [   29.380061]  kasan_report+0xe/0x12
> [   29.380076]  io_sq_wq_submit_work+0xbf4/0xe90
> [   29.380104]  ? io_sq_thread+0xaf0/0xaf0
> [   29.380152]  process_one_work+0xb59/0x19e0
> [   29.380184]  ? pwq_dec_nr_in_flight+0x2c0/0x2c0
> [   29.380221]  worker_thread+0x8c/0xf40
> [   29.380248]  ? __kthread_parkme+0xab/0x110
> [   29.380265]  ? process_one_work+0x19e0/0x19e0
> [   29.380278]  kthread+0x30b/0x3d0
> [   29.380292]  ? kthread_create_on_node+0xe0/0xe0
> [   29.380311]  ret_from_fork+0x3a/0x50
> 
> [   29.380635] Allocated by task 209:
> [   29.381255]  save_stack+0x19/0x80
> [   29.381268]  __kasan_kmalloc.constprop.6+0xc1/0xd0
> [   29.381279]  kmem_cache_alloc+0xc0/0x240
> [   29.381289]  io_submit_sqe+0x11bc/0x1c70
> [   29.381300]  io_ring_submit+0x174/0x3c0
> [   29.381311]  __x64_sys_io_uring_enter+0x601/0x780
> [   29.381322]  do_syscall_64+0x9f/0x4d0
> [   29.381336]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [   29.381633] Freed by task 84:
> [   29.382186]  save_stack+0x19/0x80
> [   29.382198]  __kasan_slab_free+0x11d/0x160
> [   29.382210]  kmem_cache_free+0x8c/0x2f0
> [   29.382220]  io_put_req+0x22/0x30
> [   29.382230]  io_sq_wq_submit_work+0x28b/0xe90
> [   29.382241]  process_one_work+0xb59/0x19e0
> [   29.382251]  worker_thread+0x8c/0xf40
> [   29.382262]  kthread+0x30b/0x3d0
> [   29.382272]  ret_from_fork+0x3a/0x50
> 
> [   29.382569] The buggy address belongs to the object at ffff888067172140
>                  which belongs to the cache io_kiocb of size 224
> [   29.384692] The buggy address is located 120 bytes inside of
>                  224-byte region [ffff888067172140, ffff888067172220)
> [   29.386723] The buggy address belongs to the page:
> [   29.387575] page:ffffea00019c5c80 refcount:1 mapcount:0 mapping:ffff88806ace5180 index:0x0
> [   29.387587] flags: 0x100000000000200(slab)
> [   29.387603] raw: 0100000000000200 dead000000000100 dead000000000122 ffff88806ace5180
> [   29.387617] raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
> [   29.387624] page dumped because: kasan: bad access detected
> 
> [   29.387920] Memory state around the buggy address:
> [   29.388771]  ffff888067172080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> [   29.390062]  ffff888067172100: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> [   29.391325] >ffff888067172180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   29.392578]                                         ^
> [   29.393480]  ffff888067172200: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> [   29.394744]  ffff888067172280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   29.396003] ==================================================================
> [   29.397260] Disabling lock debugging due to kernel taint
> 
> io_sq_wq_submit_work free and read req again.

Good catch, and I v2 is much cleaner than the first one. Applied.


-- 
Jens Axboe

