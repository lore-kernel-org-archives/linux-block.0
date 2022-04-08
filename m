Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1EAC433FE
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 01:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiDHBrs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 21:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiDHBrh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 21:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301AD9BADE
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 18:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649382331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FoDzCOy/f50izW3uGq4HanBpQorxeNmbwRnYzToRWQo=;
        b=g3UUIF2ETwzhyG/cL59Nb/bJGDGXzp+pDPQTkdvOM4zD1BSRWkFFUzDjWZ3bWOfKyvJRto
        ppDkk55pW2YN45VvKLt/HlRXzCjzeGI6U6niLfYT9ert7oEf6wZwOzCrzw/X0idKdY4guJ
        Fp3FJ1lx9zT20UMdeVlV8OjUGe/iD2Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-yVXm_n1uNQCBYpUNfzpNKA-1; Thu, 07 Apr 2022 21:45:30 -0400
X-MC-Unique: yVXm_n1uNQCBYpUNfzpNKA-1
Received: by mail-pl1-f200.google.com with SMTP id e2-20020a17090301c200b001545acd89c9so3706192plh.3
        for <linux-block@vger.kernel.org>; Thu, 07 Apr 2022 18:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoDzCOy/f50izW3uGq4HanBpQorxeNmbwRnYzToRWQo=;
        b=oC4bg8hTLS/h1p+hIVAdspf5JStOQIsavZBM63FULz4jh50sybt7xQS7JtivshGnXw
         d0yIEcf7M7vp8kpze+nQwlW9BdlGG7I340eIOpw2oQIQHRDIhVqC5XdwT7vqnz4VdTpq
         MIX2qluNMcv7JYtUXt5w6OBbMdhv3gqYS99k7FcWCOF9gH60G+7W6y0PZn/Ahu0X3mn1
         LBMzrAT3z56hbAP60KnVN+tg0kve1+NVT0wHCI2Xf6KAvhcHnrFqA8kqw2nEtIgh6EJf
         Hl1BAyg01f3xZzDz9T24fcGdACc8p//66dHWuyTCYT8XHEbEeEMmpskQoP6r0lx7NkiG
         hR+Q==
X-Gm-Message-State: AOAM530SMQG6VmZ6KHwaojL57E9+aKASRW4pCO1xHA53VX2nc1ZEtkpT
        LZOkaFnpdbD5kvsP1+3ldUdtDsQrLvACZm2WgiYMHoLS3Ijw+1T9UWA7j23xQZLsLFX4cSTSyF6
        1/Twi/fZP+2Ug3FT9Relmmh6R7ya335l5TGk8qqQ=
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id a9-20020a17090aa50900b001cac48ea795mr18929602pjq.165.1649382329362;
        Thu, 07 Apr 2022 18:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5kJtjvs/EKbJNkV73/X2nWnk/S7t+gBp7Bzb5JU5aF7KK8RFxuYokRIxpHt08O5l9sBT0Xp+GcpYOQqrhJqQ=
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id
 a9-20020a17090aa50900b001cac48ea795mr18929581pjq.165.1649382329031; Thu, 07
 Apr 2022 18:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8F51f_Br7kBPYN0yDo4FqFFbodHAUN6_c=Rd4Bd+Y1sw@mail.gmail.com>
In-Reply-To: <CAHj4cs8F51f_Br7kBPYN0yDo4FqFFbodHAUN6_c=Rd4Bd+Y1sw@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 8 Apr 2022 09:45:17 +0800
Message-ID: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
Subject: Re: [bug report][bisected] modprob -r scsi-debug take more than 3mins
 during blktests srp/ tests
To:     linux-scsi <linux-scsi@vger.kernel.org>
Cc:     dgilbert@interlog.com, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping

On Sat, Apr 2, 2022 at 3:06 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
> I found the scsi-debug module removing [1] takes more than 3mins
> during blktests srp/ tests, and bisecting shows it was introduced from
> [2],
> Pls help check it, let me know if you need more info for it, thanks.
>
> [1]
> # time ./check srp/001
> srp/001 (Create and remove LUNs)                             [passed]
>     runtime    ...  3.194s
> real 3m12.119s
> user 0m0.859s
> sys 0m2.227s
>
> # ps aux | grep modprobe
> root      250153  0.0  0.0  10600  2264 pts/0    D+   01:34   0:00
> modprobe -r scsi_debug
>
> # cat /proc/250153/stack
> [<0>] blk_execute_rq+0x95/0xb0
> [<0>] __scsi_execute+0xe2/0x250
> [<0>] sd_sync_cache+0xac/0x190
> [<0>] sd_shutdown+0x67/0xf0
> [<0>] sd_remove+0x39/0x80
> [<0>] __device_release_driver+0x234/0x240
> [<0>] device_release_driver+0x23/0x30
> [<0>] bus_remove_device+0xd8/0x140
> [<0>] device_del+0x18b/0x3f0
> [<0>] __scsi_remove_device+0x102/0x140
> [<0>] scsi_forget_host+0x55/0x60
> [<0>] scsi_remove_host+0x72/0x110
> [<0>] sdebug_driver_remove+0x22/0xa0 [scsi_debug]
> [<0>] __device_release_driver+0x181/0x240
> [<0>] device_release_driver+0x23/0x30
> [<0>] bus_remove_device+0xd8/0x140
> [<0>] device_del+0x18b/0x3f0
> [<0>] device_unregister+0x13/0x60
> [<0>] sdebug_do_remove_host+0xd1/0xf0 [scsi_debug]
> [<0>] scsi_debug_exit+0x58/0xe1e [scsi_debug]
> [<0>] __do_sys_delete_module.constprop.0+0x170/0x260
> [<0>] do_syscall_64+0x3a/0x80
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> # dmesg | tail -10
> [  345.863755] ib_srpt:srpt_release_channel_work: ib_srpt 10.16.221.74-32
> [  345.863855] ib_srpt:srpt_release_channel_work: ib_srpt 10.16.221.74-34
> [  345.863953] ib_srpt:srpt_release_channel_work: ib_srpt 10.16.221.74-36
> [  346.373371] sd 15:0:0:0: [sdb] Synchronizing SCSI cache
> [  532.864536] sd 15:0:0:0: [sdb] Synchronize Cache(10) failed:
> Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK
> ------> seems most of the time were taken here
> [  532.929626] eno1np0 speed is unknown, defaulting to 1000
> [  532.938524] eno2np1 speed is unknown, defaulting to 1000
> [  532.943957] eno4 speed is unknown, defaulting to 1000
> [  532.998059] rdma_rxe: rxe-ah pool destroyed with unfree'd elem
> [  533.011781] rdma_rxe: unloaded
>
> [2]
> commit 2aad3cd8537033cd34f70294a23f54623ffe9c1b (refs/bisect/bad)
> Author: Douglas Gilbert <dgilbert@interlog.com>
> Date:   Sat Jan 8 20:28:45 2022 -0500
>
>     scsi: scsi_debug: Address races following module load



--
Best Regards,
  Yi Zhang

