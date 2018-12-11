Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA904C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 02:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0812081F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 02:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzWwIsVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0812081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeLKCgV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:36:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39807 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 21:36:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so590428wmd.4
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 18:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EEKAobLvEgMDKxPHVhFhQiHsmXyAfLFYM39HtyZS1zI=;
        b=qzWwIsVJgMfemKAQDCYCZLWfFvAqvnGsgUearceUoGFYroMuJtT97yCCfW8QhHyiJf
         1Hrh9a3CpfIQTIHqi84wa8aUGqgO+DoyWWKvCc2Beft5jtweRd7+nr/PIDrbaRdIctor
         zDd90AcZlZX6n915uydLOk900vg/t5zetIB0LJeRXua7xRiJe+DILOT6eHfuLNzhJ1jt
         X3IpTlOk5O999RleUFQeKl7mglleQGG9POLhCkd9hfSDByKqotd+bvq8huuiS2hcVqRn
         ywAC2/gW+4/m8sHvy+IEEdBPAIaWDC9XHMn/unRIIWvUMwuzXFE0NCjjHpqrW2yZGhjG
         HvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EEKAobLvEgMDKxPHVhFhQiHsmXyAfLFYM39HtyZS1zI=;
        b=CXtVDjwAa8Q9ifnggS1Lov9MXSv5MkPkzEzgOA96Zbqscsu+sYcQvksZmrL9DfUpb4
         IIvxzmIu4lhOjdh92TsJ9/XjgvSwhjE9RV9phWUVh79TElaDk9AXe7Jn8uvfCgXSHd31
         pK1lMGY1JcNK2JXgmHVpBcRwwAXImgnA+QkKjjRxLYuI8smxNDyHmrmbQxP5CraVJk9z
         dNOczGcVfs1ORXDTK+wQto3OHF/SQsunsXCcKGOIqwsuVgI768inwctUdehyAihIRvIR
         L0Qq3Nn9S8LBVpZs1qEI95Lz8Hz3nwI97xgHQmsflw70VlVillnnF3AnS8ev1L/Xjq9U
         2QXw==
X-Gm-Message-State: AA+aEWYg6AW6jxXJAld68n22SwMx5qvXOqgj5LaslNjbidBUugEPO6Sr
        aptcoqL//jbaRUQqcQR4AeUE+Jv0FhFmMkWxSlgRk7rUWqI=
X-Google-Smtp-Source: AFSGD/V1H+BkAueJmuld0TNoSOTGhwjhZDhETxT3sbsv6xfOc0/hyulbbqtj4apCVzLdtvRJj9DWAJ1DnXSZxyAHaKs=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr581289wml.61.1544495778789;
 Mon, 10 Dec 2018 18:36:18 -0800 (PST)
MIME-Version: 1.0
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 11 Dec 2018 10:36:07 +0800
Message-ID: <CACVXFVO_QXipD3cmPvpLyBYSiEcWPN_ThQ=0pO9AwLqN-Lv93w@mail.gmail.com>
Subject: block: kernel panic in __bio_associate_blkg+0x1e
To:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens and Dennis,

Just found the following issue when testing for-4.21/block when
running stress io & device
remove on scsi_debug, and it should be caused by recent blkcg changes.

[   37.144330] sd 8:0:0:15: [sds] Synchronizing SCSI cache
[   37.665644] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000048
[   37.674748] PGD 8000000269c3b067 P4D 8000000269c3b067 PUD 269c3c067 PMD 0
[   37.675703] Oops: 0000 [#1] PREEMPT SMP PTI
[   37.676294] CPU: 2 PID: 1270 Comm: fio Not tainted
4.20.0-rc6_f0ea84586b7c_for-next+ #1
[   37.677392] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.10.2-2.fc27 04/01/2014
[   37.678563] RIP: 0010:__bio_associate_blkg+0x1e/0x81
[   37.679255] Code: 00 00 5b 5d c3 0f 1f 44 00 00 eb 94 0f 1f 44 00
00 41 54 55 48 89 fd 53 48 89 f3 e8 80 ff ff ff bf 01 00 00 00 e8 94
37 d7 ff <48> 8b 43 48 a8 03 74 06 48 8b 53 40 eb 1b 65 48 ff 00 41 b4
01 eb
[   37.681801] RSP: 0018:ffffc9000169bb80 EFLAGS: 00010246
[   37.682525] RAX: ffff888269c40000 RBX: 0000000000000000 RCX: 0000000000000000
[   37.683506] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8132c44f
[   37.684486] RBP: ffff888270fecb18 R08: 000000000000001e R09: ffffffffffffffff
[   37.685473] R10: 00000000ffffffca R11: 0000000000000000 R12: ffff88826630b758
[   37.686450] R13: ffff888270fecb18 R14: ffff888107811118 R15: ffff888270fecb18
[   37.687435] FS:  00007f7d486c6ec0(0000) GS:ffff888277b00000(0000)
knlGS:0000000000000000
[   37.688548] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.689345] CR2: 0000000000000048 CR3: 0000000269c4a001 CR4: 0000000000760ee0
[   37.690333] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.691330] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   37.692320] PKRU: 55555554
[   37.692704] Call Trace:
[   37.693070]  bio_associate_blkg_from_css+0x4e/0x57
[   37.693734]  bio_associate_blkg+0x4d/0x53
[   37.694300]  blkdev_direct_IO+0x1d4/0x3c9
[   37.694861]  ? __switch_to_asm+0x34/0x70
[   37.695417]  ? aio_complete+0x2cc/0x2cc
[   37.695962]  ? __switch_to_asm+0x34/0x70
[   37.696511]  ? __switch_to_asm+0x40/0x70
[   37.697066]  ? __switch_to_asm+0x34/0x70
[   37.697614]  ? __switch_to_asm+0x40/0x70
[   37.698166]  ? __switch_to_asm+0x34/0x70
[   37.698717]  ? generic_file_read_iter+0x96/0x110
[   37.699366]  generic_file_read_iter+0x96/0x110
[   37.699991]  aio_read+0xe9/0x178
[   37.700448]  ? __switch_to_asm+0x34/0x70
[   37.701004]  ? __switch_to_asm+0x34/0x70
[   37.701552]  ? __switch_to_asm+0x40/0x70
[   37.702109]  ? __switch_to_asm+0x34/0x70
[   37.702659]  ? __switch_to_asm+0x40/0x70
[   37.703214]  ? __switch_to_asm+0x34/0x70
[   37.703762]  ? __switch_to_asm+0x40/0x70
[   37.704317]  ? __switch_to_asm+0x34/0x70
[   37.704867]  ? __switch_to_asm+0x40/0x70
[   37.705423]  ? __switch_to_asm+0x34/0x70
[   37.705973]  ? __switch_to_asm+0x40/0x70
[   37.706523]  ? __switch_to_asm+0x34/0x70
[   37.707088]  ? io_submit_one+0x2e1/0x67b
[   37.707638]  io_submit_one+0x2e1/0x67b
[   37.708171]  ? __se_sys_io_submit+0xc5/0x15e
[   37.708770]  __se_sys_io_submit+0xc5/0x15e
[   37.709348]  ? 0xffffffff81000000
[   37.709819]  ? do_syscall_64+0x84/0x13f
[   37.710362]  ? __se_sys_io_submit+0x15e/0x15e
[   37.710987]  do_syscall_64+0x84/0x13f
[   37.711505]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.712216] RIP: 0033:0x7f7d471c6687
[   37.712720] Code: 00 00 00 49 83 38 00 75 ed 49 83 78 08 00 75 e6
8b 47 0c 39 47 08 75 de 31 c0 c3 0f 1f 84 00 00 00 00 00 b8 d1 00 00
00 0f 05 <c3> 0f 1f 84 00 00 00 00 00 b8 d2 00 00 00 0f 05 c3 0f 1f 84
00 00
[   37.715280] RSP: 002b:00007ffcb7d448c8 EFLAGS: 00000202 ORIG_RAX:
00000000000000d1
[   37.716314] RAX: ffffffffffffffda RBX: 00007f7d22e90298 RCX: 00007f7d471c6687
[   37.717297] RDX: 00000000009f4b20 RSI: 0000000000000001 RDI: 00007f7d484ea000
[   37.718280] RBP: 0000000000003e70 R08: 0000000000000001 R09: 00000000008799e0
[   37.719264] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f7d22e90298
[   37.720249] R13: 0000000000000000 R14: 00000000009f4cc0 R15: 00000000009e0c60
[   37.721232] Modules linked in: scsi_debug isofs iTCO_wdt i2c_i801
i2c_core iTCO_vendor_support lpc_ich mfd_core ip_tables sr_mod cdrom
usb_storage sd_mod ahci libahci libata crc32c_intel qemu_fw_cfg
virtio_scsi dm_mirror dm_region_hash dm_log dm_mod
[   37.724240] Dumping ftrace buffer:
[   37.724717]    (ftrace buffer empty)
[   37.725223] CR2: 0000000000000048
[   37.725692] ---[ end trace 4758725073447b42 ]---


Thanks,
Ming Lei
