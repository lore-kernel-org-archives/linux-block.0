Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D6C35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24192082F
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="BZfB3Kfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBKWVm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:21:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46725 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBKWVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 17:21:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so128175pfp.13
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1j/iXDxW1Lr4EsBt+a1fDgf541XJ5hBeidIT5TOUBP8=;
        b=BZfB3KfmVEa9NUmtZaJ8Vy1bbDBlVhBwF+9/aa892Jf0rwNclvosVrktcZ+JfRdqjv
         qdJubjbbpx0D/j8hpH0LdJhiOG0Ahq3O3E3e+zpeZuwAi9m2JOJztEOryKkoNiopyifC
         hBtxIvkwEsH+R+2PzgMu9gZt/tMHCFXDcYH1jYKoHiFQdbFHOlMYvA6RmVD+nrfglvI0
         gBYqaEHZc1LGK0kuk360VVuIR3cGPKDIr3OmyDRMfUGJC5vKzfU2As5TDqpFicv7vz0l
         aybZ8DgnSAgikJMW+Zc0Tg5Xo4D+j6rNfmUKdZ428ZL9w0ZmgU0PaYCCToF655N0KmlD
         xIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1j/iXDxW1Lr4EsBt+a1fDgf541XJ5hBeidIT5TOUBP8=;
        b=mfk8p8Bl2BX6ESVHy8VHC5LnpwLXV5d8SCGZ8BIwFi8MK0gib1H+ivlGnbNmxnSLfH
         DiyeVY3V3+q0sKSp8BoTPhT7230vZqqZr0aAkjDa2N2o6sjCLS0SJGSEmnQldkp3aWyc
         6H58xNc+oPqZrULteVqcvrig5+eyfvuM9tvzjhkYVwPyow9EyKdRZieTe4DEdZXKOIqr
         gQ6dtzOEYTMyAWwWLQagWFkrsGYH7CyorBG2s8NA/HJATVgyT0i5l3kmipkf+RWhsFim
         9UVTvNbNhZTgc+Nb6A1ZFnJjqhm9hSznpmu78QfFponOTozNplBLzvmLSobcLy8V7rE9
         oaCQ==
X-Gm-Message-State: APjAAAWcIq48hJ2c/C4qmvaiW3YRnV9wuf/7LSEo/bCduGi8Liz0PmH7
        zLjaoPuE5hbH4MGFf1V8M5XPfMii/38=
X-Google-Smtp-Source: APXvYqwuGsSe8HUq5f9YUowa49qCxvawT2yM8gIT5QkPIU6MM8eKwAfmvewQ3YF0NU19d5xmo1ZDnw==
X-Received: by 2002:a62:e318:: with SMTP id g24mr5162863pfh.218.1581459699708;
        Tue, 11 Feb 2020 14:21:39 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id z29sm5513607pgc.21.2020.02.11.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:21:39 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:21:38 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests v4] nbd/003:add mount and clear_sock test for nbd
Message-ID: <20200211222138.GH100751@vader>
References: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 23, 2019 at 11:18:29AM +0800, Sun Ke wrote:
> Add the test case to check nbd device. This test case catches regressions
> fixed by commit 92b5c8f0063e4 "nbd: replace kill_bdev() with
> __invalidate_device() again".
> 
> Establish the nbd connection. Run two processes. The first one do mount
> and umount, and the other one do clear_sock ioctl.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> [Omar: simplify]
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> simplified nbd/003 -> v4
> 1. mkfs.ext4 /dev/nbd0 >> "$FULL" 2>&1.
> 2. Allow mount and umount to fail. if clear sock do the first, mount and
>    umount can not be successful.
> 3. Add the loops to 5000. So it is very likely to trigger the BUGON.
> ---

Thanks, this looks good now. Even on v5.6-rc1, it seems to trigger a bug
(below). I'll go ahead and merge it anyways.

[  303.434579] EXT4-fs (nbd0): unable to read superblock
[  303.436134] nbd0: detected capacity change from 0 to 10737418240
[  303.437237] ldm_validate_partition_table(): Disk read failed.
[  303.438468]  nbd0: unable to read partition table
[  303.439485] ldm_validate_partition_table(): Disk read failed.
[  303.441976]  nbd0: unable to read partition table
[  303.452610] block nbd0: NBD_DISCONNECT
[  303.470762] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  303.472461] #PF: supervisor write access in kernel mode
[  303.473573] #PF: error_code(0x0002) - not-present page
[  303.474632] PGD 0 P4D 0                                                     
[  303.475197] Oops: 0002 [#1] PREEMPT SMP PTI
[  303.476084] CPU: 1 PID: 10589 Comm: nbd-client Not tainted 5.6.0-rc1 #1
[  303.477446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
[  303.479481] RIP: 0010:mutex_lock+0x10/0x20
[  303.480348] Code: 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 be 02 00 00 00 e9 b1 fa ff ff 90 0f 1f 44 00 00 31 c0 65 48 8b 14 25 00 7d 01 00 <f0> 48 0f b1 17 74 02 eb d7 c3 66 0f 1f 44 00 00 0f 1f 44 00 00 41
[  303.484418] RSP: 0018:ffffa2cb03a739d8 EFLAGS: 00010246
[  303.485814] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  303.487388] RDX: ffff9b6e7695d7c0 RSI: ffffffffad0fa1aa RDI: 0000000000000020
[  303.488895] RBP: ffffa2cb03a73a70 R08: 0000000000000000 R09: ffff9b6e7cccd870
[  303.490560] R10: 00000000000001dd R11: ffff9b6e7dcabb38 R12: ffff9b6e77e7f0b8
[  303.492080] R13: ffffa2cb03a73a00 R14: ffffffffc03f5e28 R15: ffffffffad50c2c0
[  303.493536] FS:  00007f128b70cf00(0000) GS:ffff9b6e7dc80000(0000) knlGS:0000000000000000
[  303.495147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  303.497022] CR2: 0000000000000020 CR3: 0000000077a14000 CR4: 00000000000006e0
[  303.500036] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  303.502180] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  303.504659] Call Trace:                                                     
[  303.505198]  flush_workqueue+0xa7/0x470
[  303.505999]  ? nbd_size_update+0x120/0x120 [nbd]
[  303.506960]  nbd_disconnect_and_put+0x51/0x70 [nbd]
[  303.507980]  nbd_genl_disconnect+0xc6/0x160 [nbd]
[  303.508971]  genl_rcv_msg+0x1d2/0x480
[  303.509755]  ? __netlink_sendskb+0x3b/0x50
[  303.510651]  ? netlink_unicast+0x200/0x240
[  303.511512]  ? genl_family_rcv_msg_attrs_parse+0x100/0x100
[  303.512647]  netlink_rcv_skb+0x75/0x140
[  303.513485]  genl_rcv+0x24/0x40                                             
[  303.514252]  netlink_unicast+0x199/0x240
[  303.515082]  netlink_sendmsg+0x243/0x480
[  303.515959]  sock_sendmsg+0x5e/0x60                                         
[  303.516699]  ____sys_sendmsg+0x21b/0x290
[  303.517563]  ? copy_msghdr_from_user+0xe1/0x160
[  303.518561]  ___sys_sendmsg+0x9e/0xe0
[  303.519299]  __sys_sendmsg+0x81/0xd0                                        
[  303.520133]  do_syscall_64+0x55/0x1d0
[  303.521446]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  303.522776] RIP: 0033:0x7f128bc257b7                                        
[  303.523640] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[  303.527427] RSP: 002b:00007ffda5862268 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  303.529015] RAX: ffffffffffffffda RBX: 00005601c7140d00 RCX: 00007f128bc257b7
[  303.532267] RDX: 0000000000000000 RSI: 00007ffda58622a0 RDI: 0000000000000003
[  303.534946] RBP: 00005601c7140c10 R08: 0000000000000004 R09: 0000000000000000
[  303.536810] R10: fffffffffffff08a R11: 0000000000000246 R12: 00005601c7140e20
[  303.538417] R13: 00007ffda58622a0 R14: 0000000000000003 R15: 00000000ffffffff
[  303.539894] Modules linked in: nbd btrfs pata_acpi ata_piix libata blake2b_generic xor scsi_mod nvme raid6_pq nvme_core t10_pi virtio_net libcrc32c crc_t10dif net_failover crct10dif_generic virtio_rng crct10dif_common rng_core failover
[  303.544347] CR2: 0000000000000020                                           
[  303.545180] ---[ end trace 12a9191fdb6b31e0 ]---
[  303.546216] RIP: 0010:mutex_lock+0x10/0x20
[  303.547546] Code: 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 be 02 00 00 00 e9 b1 fa ff ff 90 0f 1f 44 00 00 31 c0 65 48 8b 14 25 00 7d 01 00 <f0> 48 0f b1 17 74 02 eb d7 c3 66 0f 1f 44 00 00 0f 1f 44 00 00 41
[  303.551350] RSP: 0018:ffffa2cb03a739d8 EFLAGS: 00010246
[  303.552399] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  303.553828] RDX: ffff9b6e7695d7c0 RSI: ffffffffad0fa1aa RDI: 0000000000000020
[  303.555385] RBP: ffffa2cb03a73a70 R08: 0000000000000000 R09: ffff9b6e7cccd870
[  303.556859] R10: 00000000000001dd R11: ffff9b6e7dcabb38 R12: ffff9b6e77e7f0b8
[  303.558350] R13: ffffa2cb03a73a00 R14: ffffffffc03f5e28 R15: ffffffffad50c2c0
[  303.559619] FS:  00007f128b70cf00(0000) GS:ffff9b6e7dc80000(0000) knlGS:0000000000000000
[  303.561982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  303.563519] CR2: 0000000000000020 CR3: 0000000077a14000 CR4: 00000000000006e0
[  303.565038] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  303.566782] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
