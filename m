Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681135A121
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475905; cv=none; b=hMs4IiudIlIetZADgpZ4PT7yyavjSrhkKqKAuFuOHu1TW1sZaoDZBPgas1bi9jIq8qCn02e01zMFsD1P4B7sRvRDTAnwjr6mNP/poRRDp8BPoqKzEIGax6n3TU2o4K+MVL3eFd5tTzayErASaucjCyf6x9NjayUtJzBjYK50sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475905; c=relaxed/simple;
	bh=ame+Pa0/gdl4rhKzGoPHPOUZgcijktfvQOyo15cGTMY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=p+FRXib+gRd3bV+uMAymRxQXXDwuodRf2v31ac8uYfJLDfue4RxyBeaOxtfxtt73QcXaIU1lnJq0SI1byw8ffNLH8NP99mEPY9o5aWaVqaRcQorJqVLohi+pxU2G66nTk31BjisQC5JMbymZbILBI0VpzWRlXO+ROMEUCpVrzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ItVjuxbz; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ItVjuxbz"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-433692bbe4fso24060325ab.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763475902; x=1764080702; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWYnqNUKtbqjHzFZIJ9O0NTVsqxIwu0nDdpJJx+cyic=;
        b=ItVjuxbz5WMM3v4c/GenkHXn7G1QbtiK+09OhF1xTHbdnMJy1LMF8BczhSnDmEzfW+
         pxwWs26dH6y4UmByh1uqscUKYBKzMN2ILxPF68dhnZQWikuwVZLvywNLOBNj5yNZE8/4
         Rl38TgKAj3CwYzMB1ciXnQPuOj4N0OLSdZP/Zy2O3FP2NndTfatY0BleCes78guL/D18
         zwchfhh5S8M+EYXYSG51gT4ehOlFcN9jP42N1zeeoUhoOMst1wo1lPnKqt+GcdCnat7z
         o+QYsgooFrUKn1THrW7RqV4SDaUPmY+hFFpPRB3ejiIB9L7fbd1S4Mvhn9rhJDrBquER
         5b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475902; x=1764080702;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWYnqNUKtbqjHzFZIJ9O0NTVsqxIwu0nDdpJJx+cyic=;
        b=O0mDjiH/N9GHGmkxjAf8czp28ZJ0vvIGF0H4BhCT2V2LyJQaJ9beB/UXGhKuX8AJmc
         9VDto8yCbWoiwu4Am2r+pHkMX80MZQoOpsJd8WWkMtHOJXPhsgAjafskbh/Ft5hQKqhs
         SxlvwyXxATMB08tX+JkWLMU+1e0JRvjt8LS8l0YDsHfv13Za7FyGnAckDBFyaQ00C6Pq
         EFPDf6vHtIQ3ZalpSYHdE1aLriS08T+ysqIZKU7fqHjvMw5mPBMVWAB3G2/vBgEBW1Vb
         P0uhAFEGuZ9Saw04P9SKbN037gu73OuQPuphYclqlkbqT5EfYE/36cTvXgqwsdGVJL2v
         x55w==
X-Forwarded-Encrypted: i=1; AJvYcCUBuGTFwhQrbymPzc57wrxgFWOj1/ItgXWYixsv9zhK96Tjlh733jOvGawKxYRiGV3JslSEclCrMOj/RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCn0rVCXCn/PX6412ul5HAWhfFZlDouiAj79Www0kXnJQCufXL
	U3sTsJzX3zyh48O35Nx/v3BtsdkWKuY0FQ/yRoPdGoKDKS7kjCzIe3sO+jkfUeXE6gnxslWWuQP
	F1isv
X-Gm-Gg: ASbGncvOSN0D4nxeLhNodZgbM2SqbZ9dyksvs58Ol17zw/eY/lZrqLXeXA3XXI7O2ma
	eIis8hS1BU0HlC/6JmM0R5bAn8lIYCvE+Ztt7K9YhYytH1WhhX+FPOokgyk78zlE0a0qHYUHfBa
	Lbh9BY7o1JLYLfSr+2DibWpYluSWh4wwSZmSN7+1bPkGDD4vAnb5ykdz89wk8BbVD1rsE8+DhNv
	xf0JyN9fNDhkPuf4rpi1jsTWEPGLXyYs8M15L0CDq21PVp4cQFJWmCLXhP2OJTDP0mmKt5zLUjn
	ObM/Cw2A3+e7ry+xLJT4ywR7q1Ai7AEbpDOVV2ki3Q2AsPZNiTl/ZgURv9z9DK4YPb9NBU+i7zk
	fTBxf9v2Hle5rgmTUwXrUbCZyR9GnzczTdH4id8TmIxi41E9Xg8WHKOQzPKdcQpHhkdhR3jaR+V
	W9EEaG5fNg
X-Google-Smtp-Source: AGHT+IGcZ0Pm1Fbu0N2W6EWoxrfTQPEdpg/47EMIw5uvS9I3kUkYXkYR9/qfGaoLIHIVc7h/fKMHXw==
X-Received: by 2002:a92:da87:0:b0:434:96ea:ff4f with SMTP id e9e14a558f8ab-43496eb0044mr121286855ab.40.1763475901992;
        Tue, 18 Nov 2025 06:25:01 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839a49bfsm82128395ab.24.2025.11.18.06.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:25:01 -0800 (PST)
Message-ID: <26acdfdf-de13-430b-8c73-f890c7689a84@kernel.dk>
Date: Tue, 18 Nov 2025 07:24:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: nvme discard issue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Ran into this on my test box:

WARNING: CPU: 271 PID: 6837 at drivers/nvme/host/core.c:874 nvme_setup_discard+0x166/0x250 [nvme_core]
Modules linked in: ipmi_ssif nls_ascii nls_cp437 vfat fat joydev wmi_bmof evdev platform_profile dell_smbios dell_wmi_descriptor dcdbas acpi_power_meter ccp button rng_core acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler pcspkr wmi k10temp fuse efi_pstore configfs dm_mod efivarfs autofs4 btrfs xor hid_generic usbhid hid raid6_pq zstd_compress ahci libahci xhci_pci libata xhci_hcd bnxt_en tg3 scsi_mod nvme libphy ptp usbcore scsi_common nvme_core mdio_bus usb_common pps_core sp5100_tco watchdog i2c_piix4 i2c_smbus
CPU: 271 UID: 0 PID: 6837 Comm: kworker/271:1H Not tainted 6.18.0-rc6+ #325 NONE 
Hardware name: Dell Inc. PowerEdge R7625/06444F, BIOS 1.14.1 08/08/2025
Workqueue: xfs-log/nvme0n1p6 xlog_ioend_work
RIP: 0010:nvme_setup_discard+0x166/0x250 [nvme_core]
Code: ac 00 00 00 81 4b 1c 00 10 00 00 48 c1 e8 0c 48 c1 e0 06 48 03 05 2a 4f be bf 48 89 83 a0 00 00 00 31 c0 5b 5d 41 5c 41 5d c3 <0f> 0b b8 00 00 00 80 48 01 f0 0f 82 c1 00 00 00 48 c7 c2 00 00 00
RSP: 0018:ff5a3bf8a8c9bbd0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ff48de72c98aa000 RCX: 0000000000000ea0
RDX: 00000000000000ec RSI: ff48de78433d1000 RDI: 00000000000000eb
RBP: ff48de72c98aa120 R08: 00000000342cfaf8 R09: 0000000000000008
R10: ff5a3bf8a8c9bbd0 R11: ff48de78433d1000 R12: ff48deba4347a800
R13: 00000000000000eb R14: 0000000000000000 R15: ff5a3bf8a8c9bd60
FS:  0000000000000000(0000) GS:ff48de7ea3419000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe64dffeb10 CR3: 0000008197429006 CR4: 0000000000371ef0
Call Trace:
 <TASK>
 nvme_setup_cmd+0x1aa/0x500 [nvme_core]
 ? __submit_bio+0x94/0x1f0
 nvme_prep_rq+0x39/0x90 [nvme]
 nvme_queue_rqs+0xb5/0x190 [nvme]
 blk_mq_dispatch_queue_requests+0x125/0x140
 ? bio_alloc_bioset+0xc5/0x360
 blk_mq_flush_plug_list+0x54/0x160
 __blk_flush_plug+0xbc/0x100
 ? __blkdev_issue_discard+0x6c/0xd0
 blk_finish_plug+0x1e/0x40
 xfs_discard_extents+0x1a6/0x1e0
 ? __free_frozen_pages+0x403/0x5b0
 xlog_cil_process_committed+0x44/0x60
 xlog_state_do_callback+0x135/0x290
 xlog_ioend_work+0x2c/0x70
 process_one_work+0x13f/0x2a0
 worker_thread+0x2e7/0x420
 ? process_one_work+0x2a0/0x2a0
 kthread+0xd4/0x1c0
 ? kthread_fetch_affinity.isra.0+0x90/0x90
 ? kthread_fetch_affinity.isra.0+0x90/0x90
 ret_from_fork+0x157/0x180
 ? kthread_fetch_affinity.isra.0+0x90/0x90
 ret_from_fork_asm+0x11/0x20
 </TASK>
---[ end trace 0000000000000000 ]---
I/O error, dev nvme0c0n1, sector 429422568 op 0x3:(DISCARD) flags 0x2000000 phys_seg 235 prio class 2
I/O error, dev nvme0c0n1, sector 692087256 op 0x3:(DISCARD) flags 0x2004000 phys_seg 256 prio class 2
I/O error, dev nvme0c0n1, sector 827951352 op 0x3:(DISCARD) flags 0x2000000 phys_seg 239 prio class 2
I/O error, dev nvme0c0n1, sector 811257984 op 0x3:(DISCARD) flags 0x2000000 phys_seg 18 prio class 2
traps: objtool[191612] general protection fault ip:562d82a6bdfc sp:7ffd15cd0858 error:0 in objtool[15dfc,562d82a5a000+1c000]
traps: objtool[200442] general protection fault ip:55bbf5846dfc sp:7fffe542f3f8 error:0 in objtool[15dfc,55bbf5835000+1c000]

which seems to be from:

commit 2516c246d01c23a5f5310e9ac78d9f8aad9b1d0e
Author: Keith Busch <kbusch@kernel.org>
Date:   Fri Nov 14 10:31:45 2025 -0800

    block: consider discard merge last

This was just doing an allmodconfig build, using XFS as per the trace
above. The fs is mounted:

/dev/nvme0n1p6 on /home type xfs (rw,relatime,discard,inode64,logbufs=8,logbsize=32k,noquota)

-- 
Jens Axboe

