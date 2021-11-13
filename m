Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D56C433F5
	for <linux-block@archiver.kernel.org>; Sat, 13 Nov 2021 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A6F60EBC
	for <linux-block@archiver.kernel.org>; Sat, 13 Nov 2021 22:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKMWOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Nov 2021 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhKMWOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Nov 2021 17:14:21 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2689C061767;
        Sat, 13 Nov 2021 14:11:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b4so11064090pgh.10;
        Sat, 13 Nov 2021 14:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=m37Omi2UMuJMDbjNlt9q0al0XVi3TQBj/3X4wcXFE2o=;
        b=qyIuS/QzBZBvW3GDtasyTW+ukKDRvmxxqA5tIWooSTwA5ngU67cIBubyyEBubT65RT
         nZ3dvgDRUj6ySHAfOWKcvXfyUo8VcBowKFRKs9qEi8QNJVnKDnHJ/MmYqfVpSk9uCqF6
         RS0hYfXMQqRZqyqgd1PUA1N7huKwtFfCoJPgiYUnkbhP2Qz7Ok5+Og29tCVq3NKeaxwY
         ttCt8LwiR5qpeF0mVReFkutjxfBI96miA2RdwHe0wwjpOGShuo3wsgC27075NgYLilGp
         PtRat7ml/rH98cSgUzU3xLOpFk38mqkBykyFmt8r1eYQ5Zxx5pppZBf5mZcRdXAlgSPy
         rSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=m37Omi2UMuJMDbjNlt9q0al0XVi3TQBj/3X4wcXFE2o=;
        b=M836/6YOnqpHf7N5/ObLhGNGkfXlh+x0qgx6Cfw/yR7zrN2gnABDwKRoqQUbcZ/RC7
         I7qyWosW/ejLqA0Amx+0ATY5nxqEwf8H1bBW7KP8VZgkJEiuE/qMgDDfJE8Y/sTOkZu+
         EQAbBlXProUn/A7zA6PNPRF/6CrQxcoesE0QVCDBJLAzylpSxGRBUyrffMIBicfaGQeV
         CI8w2gr50223kXUetYCm4UYcgyxfaDu6uhOjekwAz//ilACl7AtnaxFN89zIsMBc9osH
         sDSnsd8vdEPC59UogkntYnIsgL0pvUp3bLTIPLQo2e1lXdKzMzBHzawkN4kgcIezfDnb
         sDRw==
X-Gm-Message-State: AOAM530uRxfADiDTGNfhxwebHN7Be4eUq6HzTiEPj+ChJPDc90SKpUjB
        78KLEDleh8bZsnqQdEMBz3sFUa/Yn5M=
X-Google-Smtp-Source: ABdhPJyKc+cleJ/HE+AdBwEI/DGyDeu9vT4RfOArFnhDcoJUo4OJSKyqz60ICRsxLP9uL+jxcGxsrg==
X-Received: by 2002:a05:6a00:16cb:b0:44b:bd38:e068 with SMTP id l11-20020a056a0016cb00b0044bbd38e068mr23074273pfc.34.1636841485123;
        Sat, 13 Nov 2021 14:11:25 -0800 (PST)
Received: from [10.1.1.26] (222-155-101-117-fibre.sparkbb.co.nz. [222.155.101.117])
        by smtp.gmail.com with ESMTPSA id h186sm10064068pfg.59.2021.11.13.14.11.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Nov 2021 14:11:24 -0800 (PST)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
 <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
 <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
 <yq1sfw2g7xr.fsf@ca-mkp.ca.oracle.com>
 <CAMuHMdVdwwT5yQPpQ5Frr-Un5OMk9LX3sF_zocOejrouSjaO-w@mail.gmail.com>
 <fbe43b88-720f-6956-60ea-18e07d73244e@gmail.com>
 <CAMuHMdXe4bA-a968cUcdaCKesMtkMc+qs=4L8nF2QQ0rWvAVHw@mail.gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c4739cb0-8732-6dcd-546a-1439ba803f2b@gmail.com>
Date:   Sun, 14 Nov 2021 11:11:18 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXe4bA-a968cUcdaCKesMtkMc+qs=4L8nF2QQ0rWvAVHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert, Martin,

On 12/11/21 20:37, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Thu, Nov 11, 2021 at 10:35 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> how easy is that to reproduce?
>
> Fairly easy: it happens either on mounting, or after a few seconds booting
> into my old Debian userspace.
>
>> sd_setup_read_write_cmnd() does not validate the request's FUA flag
>> against sdkp->DPOFUA (not suggesting that it should ...). I'd like to
>> try and trace when such a mismatch happens.
>
> Thanks!

Also happens with the pata-falcon driver (which stats it doesnt support 
DPO or FUA).

Seen twice, once on boot, once on reboot (FUA bit not set in the SCSI 
command descriptor when the disk doesn't support that, to avoid a panic, 
otherwise still 5833291ab6de). Each time when a remount operation happens:

EXT4-fs (sda1): re-mounted. Opts: . Quota mode: disabled.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 695 at drivers/scsi/sd.c:1271 
sd_init_command+0x6aa/0x886
Modules linked in:
CPU: 0 PID: 695 Comm: mount Not tainted 
5.15.0-atari-fpuemu-clean-signalfixes-remove-set_fs-ataflopfix4+ #88
Stack from 00be1c10:
         00be1c10 0035cc02 0035cc02 002cac7a 00379b57 000004f7 00000009 
00ad80a4
         002cacd4 00379b57 000004f7 0020ac5e 00000009 00000000 00000000 
00209d00
         00000008 00000000 00000001 00000000 00000001 00ab6400 0020ac5e 
00379b57
         000004f7 00000009 00000000 00adc800 00add9d0 00ab6400 00000001 
001269c4
         00003a98 00ad8000 00adc800 00ad80a4 00ab6400 00adc800 00000008 
00020801
         00000000 00000008 00000000 00000001 00000001 00201876 00ad80a4 
00ad80a4
Call Trace: [<002cac7a>] __warn+0x9e/0xb6
  [<002cacd4>] warn_slowpath_fmt+0x42/0x62
  [<0020ac5e>] sd_init_command+0x6aa/0x886
  [<00209d00>] max_write_same_blocks_store+0x6c/0x88
  [<0020ac5e>] sd_init_command+0x6aa/0x886
  [<001269c4>] ext4_get_group_desc+0x0/0xb0
  [<00003a98>] setup_frame+0xba/0x20a
  [<00020801>] _I_CALL_TOP+0xf21/0x1900
  [<00201876>] scsi_queue_rq+0x4f8/0x67e
  [<00194aaa>] __blk_mq_try_issue_directly+0x8a/0xf8
  [<00194adc>] __blk_mq_try_issue_directly+0xbc/0xf8
  [<00194fd0>] blk_mq_try_issue_directly+0x28/0x7a
  [<0019584c>] blk_mq_submit_bio+0x3fc/0x422
  [<0018c6f6>] __submit_bio+0x0/0x78
  [<0018b5cc>] bio_list_pop+0x0/0x1a
  [<00092800>] btf_check_type_match+0x274/0x2e4
  [<00020801>] _I_CALL_TOP+0xf21/0x1900
  [<00002000>] _start+0x0/0x8
  [<0018c7dc>] submit_bio_noacct+0x6e/0x152
  [<00020801>] _I_CALL_TOP+0xf21/0x1900
  [<000f21fc>] test_bit+0x0/0x12
  [<00051f68>] ktime_get_real_seconds+0x0/0x30
  [<000f21fc>] test_bit+0x0/0x12
  [<00051f68>] ktime_get_real_seconds+0x0/0x30
  [<000f329c>] submit_bh_wbc.isra.54+0x178/0x182
  [<000f21fc>] test_bit+0x0/0x12
  [<000f32b8>] submit_bh+0x12/0x18
  [<00020800>] _I_CALL_TOP+0xf20/0x1900
  [<000f362e>] __sync_dirty_buffer+0x78/0xaa
  [<00020800>] _I_CALL_TOP+0xf20/0x1900
  [<00158684>] test_bit+0x0/0x12
  [<0015a508>] ext4_commit_super+0xa8/0xf8
  [<00020800>] _I_CALL_TOP+0xf20/0x1900
  [<0015be82>] ext4_setup_super+0x132/0x1ac
  [<0015c970>] ext4_remount+0x49c/0x57e
  [<00004003>] do_rt_sigreturn+0xe1/0x1b8
  [<000dbe3e>] dentry_lru_isolate_shrink+0x0/0x1c
  [<000efaf0>] legacy_reconfigure+0x30/0x42
  [<000ce664>] reconfigure_super+0xae/0x178
  [<000e4a38>] path_mount+0x274/0x61c
  [<000e4e20>] do_mount+0x40/0x5c
  [<000e50c4>] sys_mount+0xf8/0x10e
  [<00002922>] syscall+0x8/0xc
  [<0018c00c>] blk_cleanup_queue+0x5a/0xc6

---[ end trace b0cd975622ec08c4 ]---
EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro. Quota mode: disabled.
ext4 filesystem being remounted at / supports timestamps until 2038 
(0x7fffffff)

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1174 at drivers/scsi/sd.c:1271 
sd_init_command+0x6aa/0x886
Modules linked in:
CPU: 0 PID: 1174 Comm: umount Tainted: G        W 
5.15.0-atari-fpuemu-clean-signalfixes-remove-set_fs-ataflopfix4+ #88
Stack from 00b6dc70:
         00b6dc70 0035cc02 0035cc02 002cac7a 00379b57 000004f7 00000009 
00ad80a4
         002cacd4 00379b57 000004f7 0020ac5e 00000009 00000000 00000000 
00209d00
         00000008 00000000 00000001 00000000 00000001 00ab6400 0020ac5e 
00379b57
         000004f7 00000009 00000000 00adc800 00add9d0 00ab6400 00000001 
00000000
         00003a98 00ad8000 00adc800 00ad80a4 00ab6400 00adc800 00000008 
00023801
         00000000 00000008 00000000 00000001 00000001 00201876 00ad80a4 
00ad80a4
Call Trace: [<002cac7a>] __warn+0x9e/0xb6
  [<002cacd4>] warn_slowpath_fmt+0x42/0x62
  [<0020ac5e>] sd_init_command+0x6aa/0x886
  [<00209d00>] max_write_same_blocks_store+0x6c/0x88
  [<0020ac5e>] sd_init_command+0x6aa/0x886
  [<00003a98>] setup_frame+0xba/0x20a
  [<00023801>] fp_fadd+0x1d5/0x1e4
  [<00201876>] scsi_queue_rq+0x4f8/0x67e
  [<00194aaa>] __blk_mq_try_issue_directly+0x8a/0xf8
  [<00194adc>] __blk_mq_try_issue_directly+0xbc/0xf8
  [<00194fd0>] blk_mq_try_issue_directly+0x28/0x7a
  [<0019584c>] blk_mq_submit_bio+0x3fc/0x422
  [<0018c6f6>] __submit_bio+0x0/0x78
  [<0018b5cc>] bio_list_pop+0x0/0x1a
  [<00092800>] btf_check_type_match+0x274/0x2e4
  [<00023801>] fp_fadd+0x1d5/0x1e4
  [<00002000>] _start+0x0/0x8
  [<0018c7dc>] submit_bio_noacct+0x6e/0x152
  [<00023801>] fp_fadd+0x1d5/0x1e4
  [<000f21fc>] test_bit+0x0/0x12
  [<000f21fc>] test_bit+0x0/0x12
  [<000f329c>] submit_bh_wbc.isra.54+0x178/0x182
  [<00158684>] test_bit+0x0/0x12
  [<000f21fc>] test_bit+0x0/0x12
  [<000f32b8>] submit_bh+0x12/0x18
  [<00020800>] _I_CALL_TOP+0xf20/0x1900
  [<000f362e>] __sync_dirty_buffer+0x78/0xaa
  [<00020800>] _I_CALL_TOP+0xf20/0x1900
  [<00158684>] test_bit+0x0/0x12
  [<00158684>] test_bit+0x0/0x12
  [<0015a508>] ext4_commit_super+0xa8/0xf8
  [<00020800>] _I_CALL_TOP+0xf20/0x1900
  [<00158684>] test_bit+0x0/0x12
  [<0015c80e>] ext4_remount+0x33a/0x57e
  [<00004003>] do_rt_sigreturn+0xe1/0x1b8
  [<000dbe3e>] dentry_lru_isolate_shrink+0x0/0x1c
  [<000efaf0>] legacy_reconfigure+0x30/0x42
  [<000ce664>] reconfigure_super+0xae/0x178
  [<000e3ab0>] path_umount+0x17c/0x2e8
  [<000e3c62>] ksys_umount+0x46/0x54
  [<000e3c8a>] sys_oldumount+0xa/0xe
  [<00002922>] syscall+0x8/0xc
  [<0018c00c>] blk_cleanup_queue+0x5a/0xc6

---[ end trace b0cd975622ec08c5 ]---
EXT4-fs (sda1): re-mounted. Opts: (null). Quota mode: disabled.
EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro. Quota mode: disabled.

Not sure this helps much.

Cheers,

	Michael

>
>> On 12/11/21 03:48, Geert Uytterhoeven wrote:
>>> On Thu, Nov 11, 2021 at 2:19 PM Martin K. Petersen
>>> <martin.petersen@oracle.com> wrote:
>>>>> sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>>>> sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
>>>>> sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
>>>>> sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
>>>>> critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>>>>> Buffer I/O error on dev sda1, logical block 0, lost sync page write
>>>>
>>>> Peculiar. That write command looks OK to me. I wonder if it's the FUA
>>>> bit that trips it?
>>>>
>>>> What does:
>>>>
>>>> # dmesg | grep FUA
>>>>
>>>> say?
>>>
>>> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
>>> support DPO or FUA
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
