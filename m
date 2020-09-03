Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E4C433E9
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 17:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EB32072A
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 17:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gcDaUUgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgICRqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 13:46:06 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFBEC061244
        for <linux-block@vger.kernel.org>; Thu,  3 Sep 2020 10:46:06 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q6so3573993ild.12
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PkIa3KxbE8Hp78HaaZXtm98I6t6KIpN7ApBeNPDHJig=;
        b=gcDaUUgWmYxYYTYoFGg7vLGRZKWRUoKv7z6Mtsk/SLOqGueZUUfqJTw4RwtUYAC2P9
         cXVJUtAzun8eLkVUi3jaZNl8bGc+x7yX8wa9MOdVB3+fb1wwgI6c9vAeViEMryoQ03pg
         bK1lfu0zKYGafZ6mHVBQWs4E2hl+FnLj2xWA7VqeRiuVFAFbcvu6kqTt/BC2jrWRfhmI
         QgBE9FsHf/aDJFtwbKnMjJHWy3aLG78mnvF/iJFACAJ1nzUZl5owcsMMkI7ZN0P8qJFU
         u4h0JLs9V7HSooAkz3icLzONWZI5v9Qe0zrNWYjmGfDisA6p40O4B3o4afYijIblo1PO
         EJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkIa3KxbE8Hp78HaaZXtm98I6t6KIpN7ApBeNPDHJig=;
        b=Neg1C71NxIwhbuvNAWJRgA0uhNjeiIVsfVIjsuws6UE+F4Xs6D6JWZWSXSrvyfZ1gW
         gLK2f3nGxLZU2Zvwy4s7CyCoNifHCtxlF6MMW7VeDJL3FS85c4H42l7k8/w2txWp2yCi
         blxuNrExg5miZG6IK8fpYQ9ZgG2xtMEJlhz2+rmK5aDvojMok7Tq24hscBFDVGMJ/bnn
         lGH1y5j87yU6v728i7MWpYOjtd/e1MXg8xofnj6zvfAEmk9AanKb+3uCZ8wnwLKh+Stg
         W6x9oG34Zq2RPi1uw7qD9ZzJGo94VsnkB2PmpexjwF9foXE/1WGka7Jq6i3rS+SGdrEL
         fjpQ==
X-Gm-Message-State: AOAM530EkhhVlMhoThxqyzz0asPkuzEQmFN7bHRZSCa5TgIW60u9c3IL
        vM+FTzZNSvEWSu/sHSdG/T7/lQ==
X-Google-Smtp-Source: ABdhPJxcyEb3+RWOYo+s5WYmSAlAA720lPHCHYttte5gk6tDXgQxy7WwiSXmzsGMQ3ch30fnYDkAXA==
X-Received: by 2002:a92:c904:: with SMTP id t4mr4289653ilp.257.1599155165881;
        Thu, 03 Sep 2020 10:46:05 -0700 (PDT)
Received: from [192.168.1.117] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i85sm1878087ile.27.2020.09.03.10.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 10:46:05 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Test_report_for_kernel_5?=
 =?UTF-8?Q?=2e9=2e0-rc3-020ad03=2ecki_=28block=29?=
To:     Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org
Cc:     Changhui Zhong <czhong@redhat.com>
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com>
 <0f92c40e-b234-896c-0810-af36ee95e259@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <18db2772-3f37-55a7-d92e-dbcbe92d2cc4@kernel.dk>
Date:   Thu, 3 Sep 2020 11:46:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0f92c40e-b234-896c-0810-af36ee95e259@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 11:10 AM, Rachel Sibley wrote:
> 
> On 9/3/20 1:07 PM, CKI Project wrote:
>>
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>              Commit: 020ad0333b03 - Merge branch 'for-5.10/block' into for-next
>>
>> The results of these automated tests are provided below.
>>
>>      Overall result: FAILED (see details below)
>>               Merge: OK
>>             Compile: OK
>>               Tests: PANICKED
>>
>> All kernel binaries, config files, and logs are available for download here:
>>
>>    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/09/02/613166
>>
>> One or more kernel tests failed:
>>
>>      ppc64le:
>>       💥 storage: software RAID testing
>>
>>      aarch64:
>>       💥 storage: software RAID testing
>>
>>      x86_64:
>>       💥 storage: software RAID testing
> 
> Hello,
> 
> We're seeing a panic for all non s390x arches triggered by swraid test. Seems to be reproducible
> for all succeeding pipelines after this one, and we haven't yet seen it in mainline or yesterday's
> block tree results.
> 
> Thank you,
> Rachel
> 
> https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/09/02/613166/build_aarch64_redhat%3A968098/tests/8757835_aarch64_3_console.log
> 
> [ 8394.609219] Internal error: Oops: 96000004 [#1] SMP
> [ 8394.614070] Modules linked in: raid0 loop raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx dm_log_writes dm_flakey 
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill sunrpc vfat fat xgene_hwmon xgene_enet at803x mdio_xgene xgene_rng 
> xgene_edac mailbox_xgene_slimpro drm ip_tables xfs sdhci_of_arasan sdhci_pltfm i2c_xgene_slimpro crct10dif_ce sdhci gpio_dwapb cqhci xhci_plat_hcd 
> gpio_xgene_sb gpio_keys aes_neon_bs
> [ 8394.654298] CPU: 3 PID: 471427 Comm: kworker/3:2 Kdump: loaded Not tainted 5.9.0-rc3-020ad03.cki #1
> [ 8394.663299] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.25 Oct 17 2016
> [ 8394.672999] Workqueue: md_misc mddev_delayed_delete
> [ 8394.677853] pstate: 40400085 (nZcv daIf +PAN -UAO BTYPE=--)
> [ 8394.683399] pc : percpu_ref_exit+0x5c/0xc8
> [ 8394.687473] lr : percpu_ref_exit+0x20/0xc8
> [ 8394.691547] sp : ffff800019f33d00
> [ 8394.694843] x29: ffff800019f33d00 x28: 0000000000000000
> [ 8394.700129] x27: ffff0003c63ae000 x26: ffff8000120b6228
> [ 8394.705414] x25: 0000000000000001 x24: ffff0003d8322a80
> [ 8394.710698] x23: 0000000000000000 x22: 0000000000000000
> [ 8394.715983] x21: 0000000000000000 x20: ffff8000121d2000
> [ 8394.721266] x19: ffff0003d8322af0 x18: 0000000000000000
> [ 8394.726550] x17: 0000000000000000 x16: 0000000000000000
> [ 8394.731834] x15: 0000000000000007 x14: 0000000000000003
> [ 8394.737119] x13: 0000000000000000 x12: ffff0003888a1978
> [ 8394.742403] x11: ffff0003888a1918 x10: 0000000000000001
> [ 8394.747688] x9 : 0000000000000000 x8 : 0000000000000000
> [ 8394.752972] x7 : 0000000000000400 x6 : 0000000000000001
> [ 8394.758257] x5 : ffff800010423030 x4 : ffff8000121d2e40
> [ 8394.763540] x3 : 0000000000000000 x2 : 0000000000000000
> [ 8394.768825] x1 : 0000000000000000 x0 : 0000000000000000
> [ 8394.774110] Call trace:
> [ 8394.776544]  percpu_ref_exit+0x5c/0xc8
> [ 8394.780273]  md_free+0x64/0xa0
> [ 8394.783311]  kobject_put+0x7c/0x218
> [ 8394.786781]  mddev_delayed_delete+0x3c/0x50
> [ 8394.790944]  process_one_work+0x1c4/0x450
> [ 8394.794932]  worker_thread+0x164/0x4a8
> [ 8394.798662]  kthread+0xf4/0x120
> [ 8394.801787]  ret_from_fork+0x10/0x18
> [ 8394.805344] Code: 2a0403e0 350002c0 a9400262 52800001 (f9400000)
> [ 8394.811407] ---[ end trace 481cab6e1ad73da1 ]---

Ming, I wonder if this is:

commit d0c567d60f3730b97050347ea806e1ee06445c78
Author: Ming Lei <ming.lei@redhat.com>
Date:   Wed Sep 2 20:26:42 2020 +0800

    percpu_ref: reduce memory footprint of percpu_ref in fast path

Rachel, any chance you can do a run with that commit reverted?

-- 
Jens Axboe

