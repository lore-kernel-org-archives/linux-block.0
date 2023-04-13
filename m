Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A486C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 03:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDMDZb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 23:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDMDZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 23:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53364ED8
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681356283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35McZdf9UWo32gLwV0EKd8c1eLlSsbYsec90OOWzHbs=;
        b=bcn5dTxv3DoUpUjEmFBzuNyuKbkmGM18b6xxiFMytTTmOwQZklk97ygxtoMhSUy2Qf9AzX
        VGzr3u+K7RKOftpRnppStgbXTrHIu+KVdIFKWnvpupJMqcnJx1L1QtWiGPudVKhn/msIsK
        sNxEtI6hIeVjwPa7TbMZMJ7TZM0d5e4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-HXSsgKGBOdGsTPL3e0yvsg-1; Wed, 12 Apr 2023 23:24:42 -0400
X-MC-Unique: HXSsgKGBOdGsTPL3e0yvsg-1
Received: by mail-ua1-f69.google.com with SMTP id y22-20020ab05616000000b00771f717cc16so1324176uaa.9
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 20:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681356281; x=1683948281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35McZdf9UWo32gLwV0EKd8c1eLlSsbYsec90OOWzHbs=;
        b=FVjuCvwkbR8IQs9/b1ll5w44Bf0PcWQjJX9YOun2CLkXnWk/V3PQ6+OYd5Df9MdRAg
         GO0u+hUzZ5tm80iauOlpHC8ETnMc+UKX9lDDFA3VcOBW5S3tFdj7w8PobhvoFY3FOgbg
         xZoKY5Nlr247zrBoHudxAUnz3kMWjL/XIswv70BmnOgydl4xRS2CPSguEtR4rN3vFzZu
         9QxTc7Jm9iloei0Xp9YxDkpVeruCSjz6aXeLZ8me/mG4aa85wpLl/uQAN8U7u1kPZhA/
         54FGrWr1hg4GViElsTEoqH+Iada7jXNhLnJqw3uqJKikoc5fYCo5WHv6Sn31towIchWc
         CsFg==
X-Gm-Message-State: AAQBX9ctAEwoZ679VuKjiigBgq+PAUvIP3rcMhMy+yhz3Mf53Kf7YWsY
        CaIOGUzA2mRgEbfCyf/MEyF85iXToaCJJ2k4pmYAi7MzgMgQnjwnPY1yJmqNJp7nINmQAxBc4ec
        75g6I77r4mzLDfW6u5Fb37+cCqFopWJmABZA7aHc=
X-Received: by 2002:a67:c108:0:b0:42c:6f50:a4b3 with SMTP id d8-20020a67c108000000b0042c6f50a4b3mr407931vsj.6.1681356281513;
        Wed, 12 Apr 2023 20:24:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yza0EdcU7rqidR2/1mYmZ2DLklbo3ANZJXd995ADzkiiBI/Tq09VZfpBYQ/FXBeb3SBWmfbCT+rzmRb2QmKsM=
X-Received: by 2002:a67:c108:0:b0:42c:6f50:a4b3 with SMTP id
 d8-20020a67c108000000b0042c6f50a4b3mr407926vsj.6.1681356281288; Wed, 12 Apr
 2023 20:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230412040827.8082-1-kch@nvidia.com>
In-Reply-To: <20230412040827.8082-1-kch@nvidia.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 13 Apr 2023 11:24:30 +0800
Message-ID: <CAFj5m9+Ru5ZVtdvmjiwiM+quFiFqihJhqQ15Rr2g44wOymPKog@mail.gmail.com>
Subject: Re: [PATCH] null_blk: fix queue mode Oops for membacked
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, dlemoal@kernel.org,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, shinichiro.kawasaki@wdc.com,
        error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 12, 2023 at 12:11=E2=80=AFPM Chaitanya Kulkarni <kch@nvidia.com=
> wrote:
>
> Make sure to check device queue mode in the null_validate_conf()
> and return error for NULL_Q_RQ as we don't allow legacy I/O path,
> without this patch we get OOPs when queue mode is set to 1 from
> configfs, following are repro steps :-
>
> modprobe null_blk nr_devices=3D0
> mkdir config/nullb/nullb0
> echo 1 > config/nullb/nullb0/memory_backed
> echo 4096 > config/nullb/nullb0/blocksize
> echo 20480 > config/nullb/nullb0/size
> echo 1 > config/nullb/nullb0/queue_mode
> echo 1 > config/nullb/nullb0/power
>
> Entering kdb (current=3D0xffff88810acdd080, pid 2372) on processor 42 Oop=
s: (null)
> due to oops @ 0xffffffffc041c329
> CPU: 42 PID: 2372 Comm: sh Tainted: G           O     N 6.3.0-rc5lblk+ #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-=
g155821a1990b-prebuilt.qemu.org 04/01/2014
> RIP: 0010:null_add_dev.part.0+0xd9/0x720 [null_blk]
> Code: 01 00 00 85 d2 0f 85 a1 03 00 00 48 83 bb 08 01 00 00 00 0f 85 f7 0=
3 00 00 80 bb 62 01 00 00 00 48 8b 75 20 0f 85 6d 02 00 00 <48> 89 6e 60 48=
 8b 75 20 bf 06 00 00 00 e8 f5 37 2c c1 48 8b 75 20
> RSP: 0018:ffffc900052cbde0 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: ffff88811084d800 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888100042e00
> RBP: ffff8881053d8200 R08: ffffc900052cbd68 R09: ffff888105db2000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000002
> R13: ffff888104765200 R14: ffff88810eec1748 R15: ffff88810eec1740
> FS:  00007fd445fd1740(0000) GS:ffff8897dfc80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000060 CR3: 0000000166a00000 CR4: 0000000000350ee0
> DR0: ffffffff8437a488 DR1: ffffffff8437a489 DR2: ffffffff8437a48a
> DR3: ffffffff8437a48b DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  nullb_device_power_store+0xd1/0x120 [null_blk]
>  configfs_write_iter+0xb4/0x120
>  vfs_write+0x2ba/0x3c0
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fd4460c57a7
> Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e f=
a 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffd3792a4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd4460c57a7
> RDX: 0000000000000002 RSI: 000055b43c02e4c0 RDI: 0000000000000001
> RBP: 000055b43c02e4c0 R08: 000000000000000a R09: 00007fd44615b4e0
> R10: 00007fd44615b3e0 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007fd446198520 R14: 0000000000000002 R15: 00007fd446198700
>  </TASK>
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

