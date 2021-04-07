Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659DBC433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379E56124B
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 12:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbhDGMzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 08:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235427AbhDGMzY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 08:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2009661107;
        Wed,  7 Apr 2021 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617800114;
        bh=lWEeiE79QRAlhJ4u0nrvJR9QbbMCN9ln7GUe4ySW3jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jm1iTsCf5TY8k0c6lX3wiYFBExWytgbSDwEkSP7T2mcVfSt/3qmdWvquF9TCGIS0x
         Q8aBCRXELo01YIYbQmULg0ups7JDx+tDm/Lwl+rzY3pVANU+oQp0vHaPfTkvnQYKky
         3DkYfYhhjkobjby/zZ2JjdZ6FhhgINXHw+ifFqB8=
Date:   Wed, 7 Apr 2021 14:55:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        rafael@kernel.org
Subject: Re: [Question] do we need fail __device_add_disk when functions in
 it return error
Message-ID: <YG2rsARsXsvx57+2@kroah.com>
References: <3d3dce33-a2d7-ebfa-c35e-55c2de7df7af@huawei.com>
 <5d610970-2bf1-4f4f-143f-9d78d41f7a6b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d610970-2bf1-4f4f-143f-9d78d41f7a6b@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 07, 2021 at 07:50:20PM +0800, Yufen Yu wrote:
> Hi, all
> 
> Recently, our syzbot test reported NULL pointer dereference in device_del()
> by injecting memory allocation fail in device_add() invoking from register_disk(),
> as following:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
> CPU: 0 PID: 9441 Comm: syz-executor348 Tainted: G        W         5.10.0+ #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> RIP: 0010:kill_device+0x9b/0x160 drivers/base/core.c:3050
> Code: fd 49 83 c6 48 4c 89 f3 48 c1 eb 03 42 80 3c 3b 00 74 08 4c 89 f7 e8 94 ef 8c fd bd 08 01 00 00 49 03 2e 48 89 e8 48 c1 e8 03 <42> 8a 04 38 84 c0 0f 85 89 00 00 00 0f b6 6d 00 83 e5 01 31 ff 89
> RSP: 0018:ffffc900032bfd38 EFLAGS: 00010206
> RAX: 0000000000000021 RBX: 1ffff1100299b816 RCX: ffff8881115cc200
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 0000000000000108 R08: dffffc0000000000 R09: ffff8881115cc200
> R10: ffffed100299b830 R11: 0000000000000000 R12: dffffc0000000000
> R13: 0000000000000008 R14: ffff888014cdc0b0 R15: dffffc0000000000
> FS:  0000000000e29880(0000) GS:ffff888061000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006cc098 CR3: 0000000018764000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  device_del+0x62/0xa00 drivers/base/core.c:3078
>  del_gendisk+0x725/0x880 block/genhd.c:952
>  loop_remove+0x42/0xa0 drivers/block/loop.c:2193
>  loop_control_ioctl+0x31d/0x3a0 drivers/block/loop.c:2292
>  vfs_ioctl+0xa2/0xf0 fs/ioctl.c:48
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>  __x64_sys_ioctl+0xfe/0x140 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> When device_add() fail caused by some memory allocation fail, it will free
> 'dev->p' and set the pointer as NULL. Since add_disk() will ignore the functions
> fail and go on working, it will cause various NULL pointer dereference in del_gendisk(),
> including 'dev->p' is NULL in kill_device() from device_del(), 'name' is NULL in
> sysfs_remove_link() from del_gendisk(), kobj->sd is 'NULL' when call dpm_sysfs_remove()
> from device_del(), and so on.
> 
> I try to fix the the problem by passing device_del() when device_add() fail[1], which is
> is not complete. And Greg thinks we should fix up users of device_del().
> 
> My question is do we need to check return value of register_disk() and fail __device_add_disk()
> when functions in it fail.
> Is there some historical reason that let us ignore various fail from __device_add_disk()
> and register_disk()?

Probably because the only way you can ever hit this is if you are
injecting faults into the system.  Can you ever normally fail the memory
allocation any other way under a normal system operation?

Try making a patch and see what it looks like...

good luck!

greg k-h
