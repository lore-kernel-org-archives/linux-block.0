Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB2AC4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4228A60C40
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhHKOnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhHKOnh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 10:43:37 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE437C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 07:43:13 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so762556oos.10
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zFpW35VAqTVbRXlTd7jmoOR7iipYPhK6qb5f5IIUzQE=;
        b=GduVUHzuLXGdzTiM4KFV0dGHgoLnzzksflkN3d0aoUuOgqPhHSYvOTqIiVH1fcbo8C
         gnv8XtjG6bQaLfHog60zfmca8UlqbatMfAC4iYcumYthuOswUZunIaDg5UJmWqWEyGum
         u8XAfMBFob/D3uQtaeCtoLtE7a+pgkWnAL4Tht0XC4qIiYKFZqhssdKRxrZkx9yVRnIx
         7NGOkHZ44oQlkgKvSJ9FHf1qhz4ns2S30JF32vnQpqS1n4j2mHe6I1KDSqgGjFgfTra0
         9sGBrdkGAyddjpWhSC3GfAikG000hgL4cdrSrlB4kxdxw7yzErFnpK65Qb/PQkZGPqFD
         K0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFpW35VAqTVbRXlTd7jmoOR7iipYPhK6qb5f5IIUzQE=;
        b=fMFf22oKZ0cqfcjhbYS8x2bnt22HM1tBGWpMBkJVlr/8cxUcfMogw0HCH9qioEWZ02
         3ATe+H2CTUzSGcpT0scJw66DrzwWC2gN+aNiEmNpFH4G7xD6nGn+GR7fF7EW43SAwGCM
         awZ2nuMSgM6BCbRuWbEKSAs50dL5LwspYHIMUVs5+Y6i6OiBHmbZ2zxBOyNPfdXtgQFo
         iO3goQlQVhsji1+BWGqQVAgcXW4VDHnlnrq2MHdzuvc19XdTmzRVWNRYMBXRF9VDuVEI
         bIgPhvHduxufQL4GXTxflneg4JcL8RpS/hmij9GZYaf3DGmLrK3L9slSgJNmRkFxE2ms
         cy1Q==
X-Gm-Message-State: AOAM531+uEqgKqVlHP5Y7Ow/1Hun9WDWPwLrBDxZHZHczjMdE2xmQnel
        q2VzQ7JSpAEbM8GSmtJhRfYmsg==
X-Google-Smtp-Source: ABdhPJxqVOUXQAUAJ4oN2HxB5bqZkjlOWwQJHZW/4YPWYA06wPS3Tm16cN0xhgbGUm8KiwZRueMC4g==
X-Received: by 2002:a4a:984c:: with SMTP id z12mr8828660ooi.78.1628692993236;
        Wed, 11 Aug 2021 07:43:13 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e10sm2668307oig.42.2021.08.11.07.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 07:43:12 -0700 (PDT)
Subject: Re: call trace at pc : __blkdev_direct_IO+0x45c/0x4dc
To:     Bruno Goncalves <bgoncalv@redhat.com>, linux-block@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>, Yi Zhang <yizhan@redhat.com>
References: <CA+QYu4qo0uLomBiZuMU3nBdk-zQRQJWVf1TyPUmg-ziyCRS7kQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a9eb2f0-8f50-1da2-5b68-1c0a935be685@kernel.dk>
Date:   Wed, 11 Aug 2021 08:43:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+QYu4qo0uLomBiZuMU3nBdk-zQRQJWVf1TyPUmg-ziyCRS7kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 7:35 AM, Bruno Goncalves wrote:
> Hello,
> 
> We've hit the issue below twice during our tests on kernel 5.14.0-rc5,
> the issues happened only on aarch64 when using xfstests [1]. More logs
> are available at [2].
> 
> The commits we hit this are:
> Commit: 39a7b1209b44 - Merge branch 'io_uring-bio-cache.3' into for-next
> Commit: 4a23f3da70f0 - Merge branch 'io_uring-bio-cache.3' into for-next
> 
> [ 1984.069676] XFS (sda4): Mounting V5 Filesystem
> [ 1984.099258] XFS (sda4): Ending clean mount
> [ 1984.104770] xfs filesystem being mounted at /mnt/xfstests/mnt1
> supports timestamps until 2038 (0x7fffffff)
> [ 1984.185598] run fstests generic/006 at 2021-08-10 18:02:37
> [ 1985.746695] XFS (sda4): Unmounting Filesystem
> [ 1986.007696] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000020
> [ 1986.016515] Mem abort info:
> [ 1986.019298]   ESR = 0x96000004
> [ 1986.022368]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 1986.027671]   SET = 0, FnV = 0
> [ 1986.030732]   EA = 0, S1PTW = 0
> [ 1986.033863]   FSC = 0x04: level 0 translation fault
> [ 1986.038730] Data abort info:
> [ 1986.041609]   ISV = 0, ISS = 0x00000004
> [ 1986.045434]   CM = 0, WnR = 0
> [ 1986.048390] user pgtable: 4k pages, 48-bit VAs, pgdp=000000881c5e2000
> [ 1986.054831] [0000000000000020] pgd=0000000000000000, p4d=0000000000000000
> [ 1986.061625] Internal error: Oops: 96000004 [#1] SMP
> [ 1986.066496] Modules linked in: dm_log_writes dm_flakey rfkill
> mlx5_ib ib_uverbs ib_core sunrpc coresight_etm4x i2c_smbus
> coresight_replicator coresight_tpiu coresight_tmc joydev mlx5_core
> mlxfw psample tls acpi_ipmi ipmi_ssif ipmi_devintf ipmi_msghandler
> thunderx2_pmu coresight_funnel coresight cppc_cpufreq vfat fat fuse
> zram ip_tables xfs ast crct10dif_ce i2c_algo_bit drm_vram_helper
> ghash_ce drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> cec drm_ttm_helper ttm drm gpio_xlp i2c_xlp9xx uas usb_storage
> aes_neon_bs
> [ 1986.113226] CPU: 115 PID: 246060 Comm: xfs_repair Not tainted 5.14.0-rc5 #1
> [ 1986.120179] Hardware name: HPE Apollo 70             /C01_APACHE_MB
>         , BIOS L50_5.13_1.16 07/29/2020
> [ 1986.129908] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> [ 1986.135905] pc : __blkdev_direct_IO+0x45c/0x4dc
> [ 1986.140438] lr : __blkdev_direct_IO+0x44c/0x4dc
> [ 1986.144959] sp : ffff80003aa03ba0
> [ 1986.148262] x29: ffff80003aa03ba0 x28: ffff8000123936c8 x27: ffff00879948cb18
> [ 1986.155391] x26: 0000000000000002 x25: ffff00879948cb18 x24: ffff000f7d92c180
> [ 1986.162519] x23: ffff000811325400 x22: 00000000ffffffff x21: 0000000000200000
> [ 1986.169646] x20: ffff80003aa03d38 x19: ffff00879948cb00 x18: 0000000000000000
> [ 1986.176774] x17: 0000000000000000 x16: 0000000000010000 x15: fffffc021e4f0002
> [ 1986.183901] x14: 0000000000000000 x13: ffff8000115b8090 x12: 00000000ffffffff
> [ 1986.191029] x11: ffff80001145afe0 x10: 0000000000001c60 x9 : ffff800010401b70
> [ 1986.198156] x8 : ffff000f7d92de40 x7 : 0000000000000000 x6 : 00000008e1dbe6bc
> [ 1986.205283] x5 : 0000000000001cd0 x4 : 0000000000000000 x3 : ffffffffffffefff
> [ 1986.212411] x2 : 0000000000000002 x1 : ffff800011064b70 x0 : 0000000000000000
> [ 1986.219539] Call trace:
> [ 1986.221975]  __blkdev_direct_IO+0x45c/0x4dc
> [ 1986.226149]  blkdev_direct_IO+0x70/0xb0
> [ 1986.229977]  generic_file_read_iter+0x8c/0x194
> [ 1986.234420]  blkdev_read_iter+0x54/0x90
> [ 1986.238246]  new_sync_read+0xdc/0x154
> [ 1986.241906]  vfs_read+0x158/0x1e4
> [ 1986.245212]  ksys_pread64+0x84/0xcc
> [ 1986.248691]  __arm64_sys_pread64+0x2c/0x40
> [ 1986.252779]  invoke_syscall+0x50/0x120
> [ 1986.256520]  el0_svc_common+0x48/0x100
> [ 1986.260259]  do_el0_svc+0x34/0xa0
> [ 1986.263563]  el0_svc+0x2c/0x54
> [ 1986.266616]  el0t_64_sync_handler+0x1a4/0x1b0
> [ 1986.270964]  el0t_64_sync+0x19c/0x1a0
> [ 1986.274621] Code: 2a0003f5 35fffda0 f85e8320 b9400a75 (b9402001)
> [ 1986.280706] ---[ end trace c7734f7d18437758 ]---

Thanks for the report!

That branch is not in for-next, it's a work in progress. It was briefly
in my next branch by mistake, but only for a very short amount of time.
I'll be pushing out a new version later today.

-- 
Jens Axboe

