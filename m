Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9438C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8596564FC8
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhCJNLl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 08:11:41 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38980 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhCJNLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 08:11:18 -0500
Received: by mail-pg1-f170.google.com with SMTP id x29so11384217pgk.6;
        Wed, 10 Mar 2021 05:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=btKY3IgQ1GNdae0DLNKzIkquPglfa/A0Wav8NdKMsHA=;
        b=mart3b+Y55vhWdCGQF2PHS8MkGEvmi7wrFlzgKUpnqt1HMGCweI9mMt0WErUDvMwFr
         0mUNjkr3uW9WV4PI/8C2tgEz3BQxzTTGS7o1L09A+a+J34RUMqZdnVUHssy2mxdgKj1C
         Qu9eREDAjxX9jN35p5Ctv/NNC9835eBdahAcVPp2yrDiEn4XG5uiz5nDIK3idLUV02Xr
         FOSBWLczN9ndZlmky5VVZX/yg5zM9kGW0qFWNZOvDw6ERkq2hWeGYIlwmiQBOsEcvKem
         ZuiA1RZAwq1F4LhXJ1EbzRRLpd8cyMeKwVjnhzGtvEE6+mrh1tsEEs/5oud+5pKN+yzk
         KptA==
X-Gm-Message-State: AOAM53311ZhoUAcFABT1yJNdoWuDB9ozhm6eTxkW+4GCn9z2OYgpOv+p
        OoFe6f5qzNtzHmj/ARMJG+M=
X-Google-Smtp-Source: ABdhPJxkh3cbB6BSssdsB9/UivjWwJxcJup15pCJ9XbipZQioZjr7n3h3Q+ewp7MlGOjAUwt/Sxx4Q==
X-Received: by 2002:a63:4c20:: with SMTP id z32mr2635909pga.377.1615381877324;
        Wed, 10 Mar 2021 05:11:17 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j10sm6581148pjs.11.2021.03.10.05.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 05:11:16 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7BEB94024E; Wed, 10 Mar 2021 13:11:15 +0000 (UTC)
Date:   Wed, 10 Mar 2021 13:11:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210310131115.GQ4332@42.do-not-panic.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEbjom8FIclEgRYv@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> On Sat, Mar 06, 2021 at 02:20:34AM +0000, Luis Chamberlain wrote:
> > The zram driver makes use of cpu hotplug multistate support,
> > whereby it associates a zram compression stream per CPU. To
> > support CPU hotplug multistate a callback enabled to allow
> > the driver to do what it needs when a CPU hotplugs.
> > 
> > It is however currently possible to end up removing the
> > zram driver callback prior to removing the zram compression
> > streams per CPU. This would leave these compression streams
> > hanging.
> > 
> > We need to fix ordering for driver load / removal, zram
> > device additions, in light of the driver's use of cpu
> > hotplug multistate. Since the zram driver exposes many
> > sysfs attribute which can also muck with the comrpession
> > streams this also means we can hit page faults today easily.
> 
> Hi Luis,
> 
> First of all, thanks for reporting the ancient bugs.
> 
> Looks like you found several bugs and I am trying to digest them
> from your description to understand more clear. I need to ask
> stupid questions, first.
> 
> If I understand correctly, bugs you found were related to module
> unloading race while the zram are still working.
> If so, couldn't we fix the bug like this(it's not a perfect
> patch but just wanted to show close module unloading race)?
> (I might miss other pieces here. Let me know. Thanks!)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a711a2e2a794..646ae9e0b710 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1696,6 +1696,8 @@ static void zram_reset_device(struct zram *zram)
>                 return;
>         }
> 
> +       module_put(THIS_MODULE);
> +
>         comp = zram->comp;
>         disksize = zram->disksize;
>         zram->disksize = 0;
> @@ -1744,13 +1746,19 @@ static ssize_t disksize_store(struct device *dev,
>                 goto out_free_meta;
>         }
> 
> +       if (!try_module_get(THIS_MODULE))
> +               goto out_free_zcomp;
> +
>         zram->comp = comp;
>         zram->disksize = disksize;
> +
>         set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
>         up_write(&zram->init_lock);
> 
>         return len;
> 
> +out_free_zcomp:
> +       zcomp_destroy(comp);
>  out_free_meta:
>         zram_meta_free(zram, disksize);
>  out_unlock:

This still allows for a crash on the driver by running the zram02.sh script twice.

Mar 09 14:52:19 kdevops-blktests-block-dev kernel: zram0: detected capacity change from 209715200 to 0
Mar 09 14:52:19 kdevops-blktests-block-dev kernel: BUG: unable to handle page fault for address: ffffba7db7904008
Mar 09 14:52:19 kdevops-blktests-block-dev kernel: #PF: supervisor read access in kernel mode
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: #PF: error_code(0x0000) - not-present page
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: PGD 100000067 P4D 100000067 PUD 100311067 PMD 14cd2f067 PTE 0
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Oops: 0000 [#1] SMP NOPTI
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CPU: 0 PID: 2137 Comm: zram02.sh Tainted: G            E     5.12.0-rc1-next-20210304+ #4
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RIP: 0010:zram_free_page+0x1b/0xf0 [zram]
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Code: 1f 44 00 00 48 89 c8 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 54 49 89 f4 55 89 f5 53 48 8b 17 48 c1 e5 04 48 89 f>
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RSP:0018:ffffba7d808f3d88 EFLAGS: 00010286
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RAX: 0000000000000000 RBX: ffff9eee5317d200 RCX: 0000000000000000
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RDX: ffffba7db7904000 RSI: 0000000000000000 RDI: ffff9eee5317d200
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RBP: 0000000000000000 R08: 00000008f78bb1d3 R09: 0000000000000000
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000000
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R13: ffff9eee53d4cb00 R14: ffff9eee5317d220 R15: ffff9eee70508b80
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: FS: 00007f4bb1482580(0000) GS:ffff9eef77c00000(0000) knlGS:0000000000000000
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CR2: ffffba7db7904008 CR3: 0000000107e9c000 CR4: 0000000000350ef0
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Call Trace:
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: zram_reset_device+0xe9/0x150 [zram]
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: reset_store+0x9a/0x100 [zram]
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: kernfs_fop_write_iter+0x124/0x1b0
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: new_sync_write+0x11c/0x1b0
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: vfs_write+0x1c2/0x260
Mar 09 14:52:20 kdevops-blktests-block-dev kernel:  ksys_write+0x5f/0xe0
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: do_syscall_64+0x33/0x80
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RIP: 0033:0x7f4bb13aaf33
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00
00 00 85 c0 75 14 b8 01 00 0>
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RSP: 002b:00007ffce0090d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RAX: ffffffffffffffda RBX: 000055a17c4a14b0 RCX: 00007f4bb13aaf33
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RDX: 0000000000000002 RSI: 000055a17c4a14b0 RDI: 0000000000000001
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RBP: 0000000000000002 R08: 000055a17c48a1d0 R09: 0000000000000000
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R10: 000055a17c48a1d1 R11: 0000000000000246 R12: 0000000000000001
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R13: 0000000000000002 R14: 7fffffffffffffff R15: 0000000000000000
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Modules linked in: zram(E) zsmalloc(E) xfs(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) joydev(E) evdev(>
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: zram0: detected capacity change from 0 to 209715200
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CR2: ffffba7db7904008
Mar 09 14:52:20 kdevops-blktests-block-dev kernel: ---[ end trace 534ee1d0b880dd90 ]---

I can try to modify it to include second patch first, as that is
required. There are two separate bugs here. Or was your goalt to
try to address both with only one patch?

  Luis
