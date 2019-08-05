Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE764C433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888702064A
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 16:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfHEQln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:41:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33824 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfHEQlm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 12:41:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so39926986pfo.1
        for <linux-block@vger.kernel.org>; Mon, 05 Aug 2019 09:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7g7YM14Izdox16rChRQkgOb4ElpVElGuZyqFXflhlbY=;
        b=EB2nBQURGcszlcN1FR9qz5EQPWA1tFrjEp9RbQ2UOCeN3LE43C4R+uu2FANUrqcTn3
         x6mzGZINDn8BHRrr0poMQaJ2iQs0gh2ZaRjMABS4yjc7hFt2Er41aMbZNHOWwry9D7Np
         nOFLpZSefFoBxhepsYN+z1DJpZMDUK8CdDZ5Uy9PQbUZBZvsYVhpYs9nEWtceeIe01JG
         PcT0sLpAWs7o5C75d0glVUQhBkNSm0nu0o9VSk8+N+QhfSLfkI3vg72djFNKjY1JOhkt
         +MKhm7T4u2zHyKs0wycxPfLQaEZRCVcqyJ9x91Ku3JV5Mi26eyHs14dKxqP7IsUXKIze
         h9DA==
X-Gm-Message-State: APjAAAVbkAhXdn+/pYs/+g0M/w4KpiLy0CSuU2NmCC9I7kRJSlzR/ulf
        EWVUvLw+a254kvrNFEHeQCo=
X-Google-Smtp-Source: APXvYqwKVvmV3KvhL5rd9iLXtsmWUrwWqxsAAevigVeKFNKCSgpqtETBKPck4IWF+bslV1d1t70CuQ==
X-Received: by 2002:a63:31c1:: with SMTP id x184mr134743882pgx.128.1565023301554;
        Mon, 05 Aug 2019 09:41:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s6sm125701006pfs.122.2019.08.05.09.41.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:41:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>, John Lenton <john.lenton@canonical.com>
Cc:     Kai-Heng Feng <kaihengfeng@me.com>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
 <20190730133607.GD28829@quack2.suse.cz>
Message-ID: <43344436-99b5-f0a7-b71e-2bbb025dfd09@acm.org>
Date:   Mon, 5 Aug 2019 09:41:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730133607.GD28829@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/19 6:36 AM, Jan Kara wrote:
> On Tue 30-07-19 12:16:46, Jan Kara wrote:
>> On Tue 30-07-19 10:36:59, John Lenton wrote:
>>> On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
>>>>
>>>> Thanks for the notice and the references. What's your version of
>>>> util-linux? What your test script does is indeed racy. You have there:
>>>>
>>>> echo Running:
>>>> for i in {a..z}{a..z}; do
>>>>      mount $i.squash /mnt/$i &
>>>> done
>>>>
>>>> So all mount(8) commands will run in parallel and race to setup loop
>>>> devices with LOOP_SET_FD and mount them. However util-linux (at least in
>>>> the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
>>>> retries with the new loop device. So at this point I don't see why the patch
>>>> makes difference... I guess I'll need to reproduce and see what's going on
>>>> in detail.
>>>
>>> We've observed this in arch with util-linux 2.34, and ubuntu 19.10
>>> (eoan ermine) with util-linux 2.33.
>>>
>>> just to be clear, the initial reports didn't involve a zany loop of
>>> mounts, but were triggered by effectively the same thing as systemd
>>> booted a system with a lot of snaps. The reroducer tries to makes
>>> things simpler to reproduce :-). FWIW,  systemd versions were 244 and
>>> 242 for those systems, respectively.
>>
>> Thanks for info! So I think I see what's going on. The two mounts race
>> like:
>>
>> MOUNT1					MOUNT2
>> num = ioctl(LOOP_CTL_GET_FREE)
>> 					num = ioctl(LOOP_CTL_GET_FREE)
>> ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>>   - returns OK
>> 					ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>> 					  - acquires exclusine loop$num
>> 					    reference
>> mount("/dev/loop$num", ...)
>>   - sees exclusive reference from MOUNT2 and fails
>> 					  - sees loop device is already
>> 					    bound and fails
>>
>> It is a bug in the scheme I've chosen that racing LOOP_SET_FD can block
>> perfectly valid mount. I'll think how to fix this...
> 
> So how about attached patch? It fixes the regression for me.

Hi Jan,

A new kernel warning is triggered by blktests block/001 that did not happen
without this patch. Reverting commit 89e524c04fa9 ("loop: Fix mount(2)
failure due to race with LOOP_SET_FD") makes that kernel warning disappear.
Is this reproducible on your setup?

Thanks,

Bart.

kernel: sr 10:0:0:0: [sr1] scsi-1 drive
kernel: scsi host9: scsi_runtime_resume
kernel: sr 10:0:0:0: Attached scsi CD-ROM sr1
kernel: driver: 'sr': driver_bound: bound to device '10:0:0:0'
kernel: bus: 'scsi': really_probe: bound device 10:0:0:0 to driver sr
kernel: scsi 9:0:0:0: CD-ROM            Linux    scsi_debug       0188 PQ: 0 ANSI: 7
kernel: WARNING: CPU: 5 PID: 907 at fs/block_dev.c:1899 __blkdev_put+0x396/0x3a0
systemd-udevd[906]: Process 'cdrom_id --lock-media /dev/sr2' failed with exit code 1.
kernel: bus: 'scsi': driver_probe_device: matched device 9:0:0:0 with driver sr
kernel: Modules linked in: scsi_debug crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 glue_helper crypto_simd joydev cryptd virtio_balloon virtio_console serio_raw qemu_fw_cfg iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables 
autofs4 hid_generic usbhid virtio_net psmouse hid ahci net_failover libahci i2c_piix4 floppy virtio_blk virtio_scsi failover pata_acpi [last unloaded: scsi_debug]
kernel: bus: 'scsi': really_probe: probing driver sr with device 9:0:0:0
kernel: sr 10:0:0:0: Attached scsi generic sg2 type 5
kernel: CPU: 5 PID: 907 Comm: systemd-udevd Not tainted 5.3.0-rc3-dbg+ #5
kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
kernel: RIP: 0010:__blkdev_put+0x396/0x3a0
kernel: Code: 49 8d 7d 08 e8 6b c8 f4 ff 49 8b 45 08 48 85 c0 0f 84 9c fe ff ff 8b b5 64 ff ff ff 48 8b bd 70 ff ff ff ff d0 e9 88 fe ff ff <0f> 0b e9 54 fd ff ff 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 57 41
kernel: RSP: 0018:ffff8881111afd18 EFLAGS: 00010202
kernel: RAX: 0000000000000000 RBX: ffff888035472e00 RCX: ffffffff814a4783
kernel: RDX: 0000000000000002 RSI: dffffc0000000000 RDI: ffff888035472ea8
kernel: RBP: ffff8881111afde0 R08: ffffed1006a8e5c4 R09: ffffed1006a8e5c4
kernel: R10: ffff8881111afd08 R11: ffff888035472e1f R12: 0000000000000000
kernel: R13: 00000000080a005d R14: ffff888035472e18 R15: ffff888115e5f028
kernel: sr 9:0:0:0: Power-on or device reset occurred
kernel: FS:  00007f113411d8c0(0000) GS:ffff88811b740000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
systemd-udevd[1257]: Process '/usr/bin/sg_inq --export /dev/sr1' failed with exit code 15.
systemd-udevd[1257]: Process 'cdrom_id --lock-media /dev/sr1' failed with exit code 1.
systemd-udevd[906]: Process '/usr/bin/sg_inq --export /dev/sr3' failed with exit code 15.
systemd-udevd[906]: Process 'cdrom_id --lock-media /dev/sr3' failed with exit code 1.
kernel: sr 9:0:0:0: [sr2] scsi-1 drive
kernel: CR2: 00007ffc4ac7fc98 CR3: 000000011127a001 CR4: 0000000000360ee0
kernel: debugfs: Directory 'sr2' with parent 'block' already present!
kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kernel: Call Trace:
kernel:  ? __kasan_check_write+0x14/0x20
kernel: sr 9:0:0:0: Attached scsi CD-ROM sr2
kernel:  ? __mutex_unlock_slowpath+0xbd/0x400
kernel:  ? bd_set_size+0x70/0x70
kernel:  ? preempt_count_sub+0x18/0xc0
kernel:  blkdev_put+0x62/0x200
kernel:  blkdev_close+0x49/0x50
kernel:  __fput+0x15c/0x390
kernel: driver: 'sr': driver_bound: bound to device '9:0:0:0'
systemd-udevd[913]: Process '/usr/bin/sg_inq --export /dev/sr1' failed with exit code 15.
kernel:  ____fput+0xe/0x10
kernel:  task_work_run+0xc3/0xf0
kernel: bus: 'scsi': really_probe: bound device 9:0:0:0 to driver sr
kernel:  exit_to_usermode_loop+0xee/0xf0
systemd-udevd[913]: Process 'cdrom_id --lock-media /dev/sr1' failed with exit code 1.
kernel: sr 9:0:0:0: Attached scsi generic sg2 type 5
kernel:  do_syscall_64+0x213/0x270
systemd-udevd[1004]: Process '/usr/bin/sg_inq --export /dev/sr2' failed with exit code 15.
systemd-udevd[906]: Process '/usr/bin/sg_inq --export /dev/sr1' failed with exit code 15.
kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xbe
kernel: RIP: 0033:0x7f11343a0674
kernel: Code: eb 8d e8 bf 1b 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 69 cd 0d 00 8b 00 85 c0 75 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3c c3 0f 1f 00 53 89 fb 48 83 ec 10 e8 44 e7
kernel: RSP: 002b:00007ffc4ac80d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
kernel: RAX: 0000000000000000 RBX: 0000000000000006 RCX: 00007f11343a0674
kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
kernel: RBP: 00007f113411d7e0 R08: 000055f286c9f4b0 R09: 0000000000000000
kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
kernel: R13: 00000000000061b0 R14: 000055f287600fd0 R15: 000055f28757f3d0
kernel: irq event stamp: 2072492
kernel: hardirqs last  enabled at (2072491): [<ffffffff81ef8b1c>] _raw_spin_unlock_irq+0x2c/0x50
kernel: hardirqs last disabled at (2072492): [<ffffffff8100291a>] trace_hardirqs_off_thunk+0x1a/0x20
kernel: softirqs last  enabled at (2069158): [<ffffffff81043a03>] fpu__copy+0xe3/0x470
kernel: softirqs last disabled at (2069156): [<ffffffff81043975>] fpu__copy+0x55/0x470
kernel: ---[ end trace 352d17ea465743b6 ]---
systemd-udevd[1004]: Process 'cdrom_id --lock-media /dev/sr2' failed with exit code 1.
