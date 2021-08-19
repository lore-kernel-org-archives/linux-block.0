Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2733AC4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052FB6108E
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 15:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhHSP7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235430AbhHSP7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 11:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629388739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Me1COlJE+fNf2MA2i+p9n93Ad6ij71m4GnFgud0n3B8=;
        b=GSB4pe2BAKwEHTvTRSlZUZiyuO9Y4F9X6U8t37g/k4gAa7C7AzArxKzWzHVY0I7MVwS982
        6bWfwSAhMAfWHeRCUJRLuBSUUaYWjkRuIoQBO+q3AvW7HT+q2hxjCeNow0fQK+Y4z10w5g
        IW+UcC5OryERiRYiIzl9NrQTk3r8YdY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-1DJbaIvEPsya2uM_xG9i4w-1; Thu, 19 Aug 2021 11:58:58 -0400
X-MC-Unique: 1DJbaIvEPsya2uM_xG9i4w-1
Received: by mail-qk1-f198.google.com with SMTP id k9-20020a05620a138900b003d59b580010so4469165qki.18
        for <linux-block@vger.kernel.org>; Thu, 19 Aug 2021 08:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Me1COlJE+fNf2MA2i+p9n93Ad6ij71m4GnFgud0n3B8=;
        b=We4wa6rYtK4f0SjC2OeJap7/SP6jkkhvFqOBYL/KEQo0mL5gKXaqlVpGDjW77HrNRm
         2TGl/F/5Pc1IbvQyE8mekw0vL/oPJCQvXu6T+fdd9FK9QLvY77o6z1WiHwR053jqSmPn
         l3P8iRJyB6Rt1Mm1cBOE3TTw4Njoh3nn0NrCDMlBGO2818YYC1JeMB71hXne7vo3y886
         Ww6GAvV4MOyCR/ycyb4R4WBhS3sTDhOM85Nu5AUjrX+v7aVFDtRsfBXJi8Vuogl7TBeF
         HWu+znyBotZFdoC/03UjAsdyJ+glmSahc4rtwEnkAmJYSLE9QQWL+1MXCfNirB55a1fz
         Dsew==
X-Gm-Message-State: AOAM530RNot6Na2bbhLt1BdsDfGMA0kEoXxGhctTrimDqpvd87c3+BWf
        2OPH86u6FICA4SWTcDPjCZ02f2rD58iMq2Ot3vAjNuHgHKiosNXfH2grRlW8QAxKytM2KVkM5ha
        uWe9zcITzyIKDg4vU0u3o+A==
X-Received: by 2002:a37:758:: with SMTP id 85mr4435134qkh.85.1629388737456;
        Thu, 19 Aug 2021 08:58:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxefvr/mOUSF1fGm4FdKDFibnkNOEf+USNOW/H/TjXlLx7KD2LZw74sb0iRe3TRHkSoeB8WRg==
X-Received: by 2002:a37:758:: with SMTP id 85mr4435120qkh.85.1629388737202;
        Thu, 19 Aug 2021 08:58:57 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d20sm1795263qkl.13.2021.08.19.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:58:56 -0700 (PDT)
Date:   Thu, 19 Aug 2021 11:58:56 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: holders not working properly, regression [was: Re: use regular
 gendisk registration in device mapper v2]
Message-ID: <YR5/wMEkr1TwV7FD@redhat.com>
References: <20210804094147.459763-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 04 2021 at  5:41P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> The device mapper code currently has a somewhat odd gendisk registration
> scheme where it calls add_disk early, but uses a special flag to skip the
> "queue registration", which is a major part of add_disk.  This series
> improves the block layer holder tracking to work on an entirely
> unregistered disk and thus allows device mapper to use the normal scheme
> of calling add_disk when it is ready to accept I/O.
> 
> Note that this leads to a user visible change - the sysfs attributes on
> the disk and the dm directory hanging off it are not only visible once
> the initial table is loaded.  This did not make a different to my testing
> using dmsetup and the lvm2 tools.
> 
> Changes since v1:
>  - rebased on the lastes for-5.15/block tree
>  - improve various commit messages, including commit references

Hi,

This was originally reported to me by Tushar (cc'd).

Unfortunately I too am seeing a block-5.15/linux-next regression
related to holders when testing dm-multipath with an mptest test
case. To reproduce the following trcaes and crash simply do:

git clone git://github.com/snitm/mptest.git
cd mptest
./runtest tests/test_02_sdev_delete

I got bogged with trying different kernels, because I _thought_ I
verified mptest's tests all passed when I reviewed v1 of this
patchset.  ut I'll pivot to looking closer at these traces and the
code to try to find the issue. But I've sat on this regression since
Tuesday so need to at least share with others now:

** Running: ./tests/test_02_sdev_delete

[ 1411.113642] ------------[ cut here ]------------
[ 1411.118260] kernfs: can not remove 'dm-0', no directory
[ 1411.123488] WARNING: CPU: 16 PID: 23326 at fs/kernfs/dir.c:1509 kernfs_remove_by_name_ns+0x81/0x90
[ 1411.132446] Modules linked in: dm_queue_length dm_multipath tcm_loop target_core_user uio target_core_pscsi target_core_file target_core_iblock iscsi_target_mod target_core_mod dm_mod nfsv3 nfs_acl nfs lockd grace sunrpc intel_rapl_msr intel_rapl_common skx_edac nfit intel_powerclamp coretemp kvm_intel kvm iTCO_wdt iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul nd_pmem mei_me ghash_clmulni_intel i2c_i801 nd_btt ipmi_si joydev pcspkr mei sg i2c_smbus lpc_ich wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter ip_tables xfs libcrc32c sd_mod ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm ahci nvme libahci i40e nvme_core libata crc32c_intel i2c_core t10_pi
[ 1411.197935] CPU: 16 PID: 23326 Comm: dmsetup Tainted: G        W         5.14.0-rc4.snitm+ #196
[ 1411.206624] Hardware name: Supermicro SYS-1029P-WTR/X11DDW-L, BIOS 2.0a 12/06/2017
[ 1411.214190] RIP: 0010:kernfs_remove_by_name_ns+0x81/0x90
[ 1411.219504] Code: 45 8f 58 00 31 c0 5b 5d 41 5c c3 48 c7 c7 e0 e1 6a 85 e8 32 8f 58 00 b8 fe ff ff ff eb e8 48 c7 c7 c8 78 f3 84 e8 9e ef 53 00 <0f> 0b b8 fe ff ff ff eb d3 66 0f 1f 44 00 00 0f 1f 44 00 00 41 57
[ 1411.238251] RSP: 0018:ffffb6c3a198fc00 EFLAGS: 00010286
[ 1411.243474] RAX: 0000000000000000 RBX: ffff963d80d08980 RCX: 0000000000000000
[ 1411.250608] RDX: 0000000000000001 RSI: ffff963d600979d0 RDI: ffff963d600979d0
[ 1411.257741] RBP: ffff96360771a7d8 R08: 0000000000000000 R09: c0000000ffff7fff
[ 1411.264875] R10: 0000000000000001 R11: ffffb6c3a198fa10 R12: ffff963d835f5800
[ 1411.272007] R13: ffff963d835f5870 R14: dead000000000122 R15: dead000000000100
[ 1411.279140] FS:  00007f9e557e1840(0000) GS:ffff963d60080000(0000) knlGS:0000000000000000
[ 1411.287227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1411.292973] CR2: 0000000002dd9020 CR3: 000000014209e002 CR4: 00000000007706e0
[ 1411.300102] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1411.307238] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1411.314370] PKRU: 55555554
[ 1411.317082] Call Trace:
[ 1411.319536]  bd_unlink_disk_holder+0x78/0xc0
[ 1411.323815]  dm_put_table_device+0x5a/0xf0 [dm_mod]
[ 1411.328697]  dm_put_device+0x83/0xe0 [dm_mod]
[ 1411.333063]  ? dm_put_path_selector+0x30/0x40 [dm_multipath]
[ 1411.338721]  free_priority_group+0x8b/0xc0 [dm_multipath]
[ 1411.344121]  free_multipath+0x6a/0xa0 [dm_multipath]
[ 1411.349088]  ? table_load+0x2d0/0x2d0 [dm_mod]
[ 1411.353545]  dm_table_destroy+0x62/0x140 [dm_mod]
[ 1411.358257]  ? table_load+0x2d0/0x2d0 [dm_mod]
[ 1411.362703]  dev_suspend+0xe6/0x290 [dm_mod]
[ 1411.366976]  ctl_ioctl+0x1af/0x420 [dm_mod]
[ 1411.371162]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
[ 1411.375350]  __x64_sys_ioctl+0x84/0xc0
[ 1411.379102]  do_syscall_64+0x3a/0x80
[ 1411.382683]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1411.387731] RIP: 0033:0x7f9e550aa567

Trace that finally crashed was:
[ 1413.924355] general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] SMP PTI
[ 1413.924356] CPU: 0 PID: 23394 Comm: dmsetup Tainted: G        W         5.14.0-rc4.snitm+ #196
[ 1413.924357] Hardware name: Supermicro SYS-1029P-WTR/X11DDW-L, BIOS 2.0a 12/06/2017
[ 1413.924358] RIP: 0010:string_nocheck+0x12/0x70
[ 1413.924358] Code: 00 00 4c 89 e2 be 20 00 00 00 48 89 ef e8 e6 a4 00 00 4c 01 e3 eb 81 90 49 89 f2 48 89 ce 48 89 f8 48 c1 fe 30 66 85 f6 74 4f <44> 0f b6 0a 45 84 c9 74 46 83 ee 01 41 b8 01 00 00 00 48 8d 7c 37
[ 1413.924359] RSP: 0018:ffffb6c3a1a6f9d0 EFLAGS: 00010086
[ 1413.924360] RAX: ffffb6c3a1a6faf2 RBX: ffffb6c3a1a6fae0 RCX: ffff0a00ffffff04
[ 1413.924361] RDX: dead000000000122 RSI: ffffffffffffffff RDI: ffffb6c3a1a6faf2
[ 1413.924361] RBP: dead000000000122 R08: 0000000000000009 R09: 0000000000000000
[ 1413.924362] R10: ffffb6c3a1a6fae0 R11: ffffb6c3a1a6f988 R12: ffff0a00ffffff04
[ 1413.924362] R13: ffffffff84f37876 R14: 0000000000000008 R15: ffffffff84f37876
[ 1413.924362] FS:  00007f967061f840(0000) GS:ffff963d5fe00000(0000) knlGS:0000000000000000
[ 1413.924363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1413.924363] CR2: 0000000002bfc000 CR3: 00000001e22c0002 CR4: 00000000007706f0
[ 1413.924363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1413.924364] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1413.924364] PKRU: 55555554
[ 1413.924364] Call Trace:
[ 1413.924364]  string+0x40/0x50
[ 1413.924364]  vsnprintf+0x339/0x520
[ 1413.924365]  vprintk_store+0xad/0x440
[ 1413.924365]  ? __irq_work_queue_local+0x48/0x50
[ 1413.924365]  ? irq_work_queue+0x16/0x20
[ 1413.924366]  ? wake_up_klogd.part.31+0x30/0x40
[ 1413.924366]  ? vprintk_emit+0x11a/0x240
[ 1413.924366]  vprintk_emit+0xf7/0x240
[ 1413.924367]  __warn_printk+0x6b/0x87
[ 1413.924367]  ? kernfs_put+0xd0/0x190
[ 1413.924367]  kernfs_find_ns+0x9f/0xc0
[ 1413.924368]  kernfs_remove_by_name_ns+0x31/0x90
[ 1413.924368]  bd_unlink_disk_holder+0x78/0xc0
[ 1413.924369]  dm_put_table_device+0x5a/0xf0 [dm_mod]
[ 1413.924369]  dm_put_device+0x83/0xe0 [dm_mod]
[ 1413.924369]  ? dm_put_path_selector+0x30/0x40 [dm_multipath]
[ 1413.924369]  free_priority_group+0x8b/0xc0 [dm_multipath]
[ 1413.924370]  free_multipath+0x6a/0xa0 [dm_multipath]
[ 1413.924370]  ? table_load+0x2d0/0x2d0 [dm_mod]
[ 1413.924370]  dm_table_destroy+0x62/0x140 [dm_mod]
[ 1413.924370]  ? table_load+0x2d0/0x2d0 [dm_mod]
[ 1413.924371]  dev_suspend+0xe6/0x290 [dm_mod]
[ 1413.924371]  ctl_ioctl+0x1af/0x420 [dm_mod]
[ 1413.924371]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
[ 1413.924372]  __x64_sys_ioctl+0x84/0xc0
[ 1413.924372]  do_syscall_64+0x3a/0x80
[ 1413.924373]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1413.924373] RIP: 0033:0x7f966fee8567

