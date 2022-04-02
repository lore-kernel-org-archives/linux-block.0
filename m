Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF7FC433EF
	for <linux-block@archiver.kernel.org>; Sat,  2 Apr 2022 07:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiDBHIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Apr 2022 03:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBHIk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Apr 2022 03:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76E30102422
        for <linux-block@vger.kernel.org>; Sat,  2 Apr 2022 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648883208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HyMSiJlOQvjIy8EGlx27j+iS4lIlX1GOMrjnd5IUUSk=;
        b=IF3v1ffIKPK646r1vPGrHQ5GPej+kjFxTQI8sZKyIACpUXQuLY5PE3O9yMa0ynndxItGHr
        robHTjM3vqfEm13vgQtzApNaNl316IEUp2C4S7M+VfN55jcn6bANEIgh/EW1PL7LJNKav2
        bNOv1Jb3g9OY5hk/kX+goJMh8O660g4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-Fo2QaCCSMc610F5dsOQJdg-1; Sat, 02 Apr 2022 03:06:47 -0400
X-MC-Unique: Fo2QaCCSMc610F5dsOQJdg-1
Received: by mail-pg1-f199.google.com with SMTP id z132-20020a63338a000000b003844e317066so2672139pgz.19
        for <linux-block@vger.kernel.org>; Sat, 02 Apr 2022 00:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HyMSiJlOQvjIy8EGlx27j+iS4lIlX1GOMrjnd5IUUSk=;
        b=8CHCtnMY3SrLNwxdLooQPwDOawOs7aikhKC4Jeiv4L3vUR68ucFr0byzBgkm5OXue3
         UzXn2TskRlB9pL6MjRAdR1nPgGz23BvYsBnxlAnKWTqsG9WcrdagKTwOfWZUB2zLfBt8
         Bct3CiZALP40di2jK1ouBeulrEIh3lFgawawbCoFR7Wt8mfhSmGq9Nqr5bHSOAF/UMx8
         2PqU2x/AownJl1AgBZv9aMelHaD9p6Wiwc9xbypu4tSicQfDynrsZPP27TDjh9+cfiXn
         ti2ry+BC0s2QVspibnFbGv2nLtmS6fHQVcWtTdD081xfT3V3JrrfvN8J5RlSVJI0vO1Z
         /oRw==
X-Gm-Message-State: AOAM533LmWGXS2vLhTSMfdtvSoBK5PtY+JAWxxRQqnNr82Z/cwHckwQJ
        qqv9cs6P1HeHkdZsKivOOQbUO5FO3bJKRWGjsgcILi//Bz0AxJEtkimtoX7TqaiV+0LC3qW0j3s
        0IpVvYjG8mkLXmcO98tZnj+4MtzuK7Fqr6pst8UU=
X-Received: by 2002:a17:902:ce8f:b0:154:6031:b53e with SMTP id f15-20020a170902ce8f00b001546031b53emr13551113plg.159.1648883206216;
        Sat, 02 Apr 2022 00:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyZf4Lobqcgjo9zG6mfY2sEsOCsigZvVE7GNj0PFthgZr9CyVzKyvMFUQmY8B8MBMZ7a6nW2jFTGZm5x3/8C8=
X-Received: by 2002:a17:902:ce8f:b0:154:6031:b53e with SMTP id
 f15-20020a170902ce8f00b001546031b53emr13551096plg.159.1648883205929; Sat, 02
 Apr 2022 00:06:45 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 2 Apr 2022 15:06:34 +0800
Message-ID: <CAHj4cs8F51f_Br7kBPYN0yDo4FqFFbodHAUN6_c=Rd4Bd+Y1sw@mail.gmail.com>
Subject: [bug report][bisected] modprob -r scsi-debug take more than 3mins
 during blktests srp/ tests
To:     linux-scsi <linux-scsi@vger.kernel.org>
Cc:     dgilbert@interlog.com, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I found the scsi-debug module removing [1] takes more than 3mins
during blktests srp/ tests, and bisecting shows it was introduced from
[2],
Pls help check it, let me know if you need more info for it, thanks.

[1]
# time ./check srp/001
srp/001 (Create and remove LUNs)                             [passed]
    runtime    ...  3.194s
real 3m12.119s
user 0m0.859s
sys 0m2.227s

# ps aux | grep modprobe
root      250153  0.0  0.0  10600  2264 pts/0    D+   01:34   0:00
modprobe -r scsi_debug

# cat /proc/250153/stack
[<0>] blk_execute_rq+0x95/0xb0
[<0>] __scsi_execute+0xe2/0x250
[<0>] sd_sync_cache+0xac/0x190
[<0>] sd_shutdown+0x67/0xf0
[<0>] sd_remove+0x39/0x80
[<0>] __device_release_driver+0x234/0x240
[<0>] device_release_driver+0x23/0x30
[<0>] bus_remove_device+0xd8/0x140
[<0>] device_del+0x18b/0x3f0
[<0>] __scsi_remove_device+0x102/0x140
[<0>] scsi_forget_host+0x55/0x60
[<0>] scsi_remove_host+0x72/0x110
[<0>] sdebug_driver_remove+0x22/0xa0 [scsi_debug]
[<0>] __device_release_driver+0x181/0x240
[<0>] device_release_driver+0x23/0x30
[<0>] bus_remove_device+0xd8/0x140
[<0>] device_del+0x18b/0x3f0
[<0>] device_unregister+0x13/0x60
[<0>] sdebug_do_remove_host+0xd1/0xf0 [scsi_debug]
[<0>] scsi_debug_exit+0x58/0xe1e [scsi_debug]
[<0>] __do_sys_delete_module.constprop.0+0x170/0x260
[<0>] do_syscall_64+0x3a/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

# dmesg | tail -10
[  345.863755] ib_srpt:srpt_release_channel_work: ib_srpt 10.16.221.74-32
[  345.863855] ib_srpt:srpt_release_channel_work: ib_srpt 10.16.221.74-34
[  345.863953] ib_srpt:srpt_release_channel_work: ib_srpt 10.16.221.74-36
[  346.373371] sd 15:0:0:0: [sdb] Synchronizing SCSI cache
[  532.864536] sd 15:0:0:0: [sdb] Synchronize Cache(10) failed:
Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK
------> seems most of the time were taken here
[  532.929626] eno1np0 speed is unknown, defaulting to 1000
[  532.938524] eno2np1 speed is unknown, defaulting to 1000
[  532.943957] eno4 speed is unknown, defaulting to 1000
[  532.998059] rdma_rxe: rxe-ah pool destroyed with unfree'd elem
[  533.011781] rdma_rxe: unloaded

[2]
commit 2aad3cd8537033cd34f70294a23f54623ffe9c1b (refs/bisect/bad)
Author: Douglas Gilbert <dgilbert@interlog.com>
Date:   Sat Jan 8 20:28:45 2022 -0500

    scsi: scsi_debug: Address races following module load

