Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BFBC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 10:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D032086A
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 10:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNY8p/u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393466AbfITK2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:28:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33392 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393456AbfITK2K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 06:28:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so5945613edl.0;
        Fri, 20 Sep 2019 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1xe6a2/0gVc3Xq1ZtS/ISAo8XWj2OhYSkGlgwGDDGFE=;
        b=pNY8p/u+GbxDTGOHVCOISF3kkioYS3CUw/I4pjLC2irZliKRTpOqqe/aFdbNiGte2X
         ROGBWYy/1CQTtFQgW+MJ9SrYtQjec/x0tVU6na7GxiaCKjwfQsKMpyO4zZzeau1+Db1A
         SpWnRiK6srczHnVAetC5UbWIpgHILAJjNzFMDYvdkAxf1r2bTVz48x0XNr2jmNu8HVaj
         zj1tZgW2+zwBkV/DhNDsTrE8MZo6TyB1YFcf6pOES9eE+Ckr5MKbHF+QJU7sazDORpYT
         TFHi7isk+VO2lj+QZtWj3Lg21Pm9ihMrKeFJoEcbrMnvQKKIfgbHc8GSA26upnczMD18
         lKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1xe6a2/0gVc3Xq1ZtS/ISAo8XWj2OhYSkGlgwGDDGFE=;
        b=svKa3CeoxRTmhcmnjEOpg9OXOVfVsqIcq3uSwiBCQuLPblq16nXhAulcn7RoYKoWss
         aLRLaO0JyBo8crksp9oNJ0ugwSOiAsy6/1McuSfpu8cIu1uC6EjM/qISwRnT40oX89SQ
         f7eRvuZGtD8I9nBkbabK7wXp8D1NcOLIlx7zZl7xkFB9p4brQiYYzcC0BhTW1XKgKmf5
         vdKmNE/y7lD+BzJzp7L8MLgMSTTGNxD4lehaUu/44mpK8kA/8eBYKMjwjqamb3uTFaVD
         uBSaU05jRLURo5qdqUMKV0EWGjPNH7Jl5nXS0RGfILLNuY5N5eCe+dvuXYBaZFr+h5Ag
         qTmA==
X-Gm-Message-State: APjAAAUlB+k/YQ/OEjso4ZoflhGczzFJOdct9GnBZRMSVNY5xUZQcQlH
        5rCApWtcpGogznn5FRmzTZsJq26LMzbuovY/bHZvJ2oW
X-Google-Smtp-Source: APXvYqzlgPv4JSSlSf1+BofyowDIzFDwFG3zB5iIlMvP/1bWPpneUY31JajU98BSHnq4SSh9zgxPw41zme+g4GLKtcw=
X-Received: by 2002:a17:906:a84d:: with SMTP id dx13mr18844955ejb.230.1568975288528;
 Fri, 20 Sep 2019 03:28:08 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 20 Sep 2019 13:27:57 +0300
Message-ID: <CADxRZqz_TF7jyGtbg9cVSnCGh2VzfCoRGBdCU_yE_v1cveq1Pg@mail.gmail.com>
Subject: [sparc64] pktcdvd: setup of pktcdvd device failed
To:     linux-block@vger.kernel.org
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

Getting the following call trace on boot on sparc64 ldom/machine with
current git kernel:

...
[   13.352975] aes_sparc64: Using sparc64 aes opcodes optimized AES
implementation
[   13.428002] ------------[ cut here ]------------
[   13.428081] WARNING: CPU: 21 PID: 586 at
drivers/block/pktcdvd.c:2597 pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
[   13.428147] Attempt to register a non-SCSI queue
[   13.428184] Modules linked in: pktcdvd libdes cdrom aes_sparc64
n2_rng md5_sparc64 sha512_sparc64 rng_core sha256_sparc64 flash
sha1_sparc64 ip_tables x_tables ipv6 crc_ccitt nf_defrag_ipv6 autofs4
ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear
md_mod crc32c_sparc64
[   13.428452] CPU: 21 PID: 586 Comm: pktsetup Not tainted
5.3.0-10169-g574cc4539762 #1234
[   13.428507] Call Trace:
[   13.428542]  [00000000004635c0] __warn+0xc0/0x100
[   13.428582]  [0000000000463634] warn_slowpath_fmt+0x34/0x60
[   13.428626]  [000000001045b244] pkt_setup_dev+0x2e4/0x5a0 [pktcdvd]
[   13.428674]  [000000001045ccf4] pkt_ctl_ioctl+0x94/0x220 [pktcdvd]
[   13.428724]  [00000000006b95c8] do_vfs_ioctl+0x628/0x6e0
[   13.428764]  [00000000006b96c8] ksys_ioctl+0x48/0x80
[   13.428803]  [00000000006b9714] sys_ioctl+0x14/0x40
[   13.428847]  [0000000000406294] linux_sparc_syscall+0x34/0x44
[   13.428890] irq event stamp: 4181
[   13.428924] hardirqs last  enabled at (4189): [<00000000004e0a74>]
console_unlock+0x634/0x6c0
[   13.428984] hardirqs last disabled at (4196): [<00000000004e0540>]
console_unlock+0x100/0x6c0
[   13.429048] softirqs last  enabled at (3978): [<0000000000b2e2d8>]
__do_softirq+0x498/0x520
[   13.429110] softirqs last disabled at (3967): [<000000000042cfb4>]
do_softirq_own_stack+0x34/0x60
[   13.429172] ---[ end trace 2220ca468f32967d ]---
[   13.430018] pktcdvd: setup of pktcdvd device failed
[   13.455589] des_sparc64: Using sparc64 des opcodes optimized DES
implementation
[   13.515334] camellia_sparc64: Using sparc64 camellia opcodes
optimized CAMELLIA implementation
[   13.522856] pktcdvd: setup of pktcdvd device failed
[   13.529327] pktcdvd: setup of pktcdvd device failed
[   13.532932] pktcdvd: setup of pktcdvd device failed
[   13.536165] pktcdvd: setup of pktcdvd device failed
[   13.539372] pktcdvd: setup of pktcdvd device failed
[   13.542834] pktcdvd: setup of pktcdvd device failed
[   13.546536] pktcdvd: setup of pktcdvd device failed
[   15.431071] XFS (dm-0): Mounting V5 Filesystem
...


Full boot log at [1] and kernel config [2].

4.12.0 kernel have different message on boot for pktcdvd module
(something with circular locking)...

4.14.0 kernel have OOPS, boot log at [3]

starting from 4.16.0 and up to current git kernel messages are/almost
the same ...

1. https://github.com/mator/sparc64-dmesg/blob/master/dmesg-5.3.0-10169-g574cc4539762
2. https://github.com/mator/sparc64-dmesg/blob/master/config-5.3.0-10169-g574cc4539762.gz
3. https://github.com/mator/sparc64-dmesg/blob/master/dmesg-4.14.0
