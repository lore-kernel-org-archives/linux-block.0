Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC6CC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725EB60F92
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 12:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhHCMli (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 08:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236102AbhHCMli (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Aug 2021 08:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627994486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XBKiyfDLN73VIvW+qSms32KoimQr7JTXCqpwnrH+oN0=;
        b=SeeQgwGQDM+8BmKpX71QGZ5N3lpB4tnv7pLNQpR/A84Gv3XQZ6hxsAsJ92zZJb2cgqh0Y/
        vMFAB2oKabCB6LWv5x01yKQqY2ovodP3ExvsG8nyNzdcrLpftopiyXkFE5tJVjkFEHMcBV
        RSQj3sdJ8OYslN1QJ2N4S/raUejlu0I=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-Qk2_brcFOaO2Ao4kH3o1rA-1; Tue, 03 Aug 2021 08:41:25 -0400
X-MC-Unique: Qk2_brcFOaO2Ao4kH3o1rA-1
Received: by mail-ot1-f72.google.com with SMTP id 20-20020a9d05940000b02904d1011b3b03so9666170otd.10
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 05:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XBKiyfDLN73VIvW+qSms32KoimQr7JTXCqpwnrH+oN0=;
        b=KVIqj/EUQZoR7UHT3Z66I1Fd1u4KVcJHm1cX+BwQM+DjcBUclo2ofeS58lVbdY4i3t
         NuMFuuWx4y+d5c25LoOBO7Bd3GKdEzRO5C1hmf47LY2ty+/RHITYWDJpLGdT2Sr395q0
         ZZVCTOl5D25UfWehP/l6H73y/l5cHDSd9xepa2zxZUZtfe/9SDtydgp0i2r5ECuntP88
         qXUiLDfpTUup3exkGhImimueGkZXvFDduJn6abt4DBQEpBWFHSJmVom5Hp3XjbhWawLw
         f/eozw0P8mT47RFdV4eH8WMT3wVIUdOBNpagTdTJhbfGa3l65DYGrym6/kV3fJsapJLW
         JFEQ==
X-Gm-Message-State: AOAM531mt9BxFNDrioKv+Tl2DDSE/NDatsSSHyKP3WakqwmcIZDQWmfK
        HgDWzTU9k9graNWR3P/9LjgWbZSCbj7AFtVx6y5SsbcscwL/zOKOgWPUfvsJiioGgDNaYGCk1sR
        oyZsBHZ+AzlnJ65qONmDtqfMvCCVhEfh4DDmetYw=
X-Received: by 2002:a05:6830:40ae:: with SMTP id x46mr14975199ott.71.1627994484472;
        Tue, 03 Aug 2021 05:41:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/D5sbCSAJmaUSYn9xQglIqVPjGlKvymaZ3n5UY+2APO7Gl4iTNkkuohg7I7fOCmv7AB7YlbWOeizBhfiSGXA=
X-Received: by 2002:a05:6830:40ae:: with SMTP id x46mr14975186ott.71.1627994484166;
 Tue, 03 Aug 2021 05:41:24 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 3 Aug 2021 14:41:13 +0200
Message-ID: <CA+QYu4q6tkiHHW707P6c0zSZ6xMbk6OFC2JYRmDjhVKA8UKyzg@mail.gmail.com>
Subject: BUG: MAX_LOCKDEP_ENTRIES too low! during storage test
To:     linux-block@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

We've hit the call trace below during our tests of kernel with
(commit: c7d102232649 - Merge tag 'net-5.14-rc4') on ppc64le. We only
hit this once so far and unfortunately we don't have any reliable
reproducer. More logs on [1].

[16978.535174] BUG: MAX_LOCKDEP_ENTRIES too low!
[16978.535201] turning off the locking correctness validator.
[16978.535224] CPU: 76 PID: 887944 Comm: ext4lazyinit Tainted: G
    OE     5.14.0-rc3 #1
[16978.535253] Call Trace:
[16978.535271] [c0000004684fb430] [c000000000978154]
dump_stack_lvl+0x98/0xe0 (unreliable)
[16978.535307] [c0000004684fb470] [c000000000205f48]
add_lock_to_list.constprop.0+0x208/0x220
[16978.535348] [c0000004684fb4e0] [c00000000020cb40]
__lock_acquire+0x1e70/0x2710
[16978.535386] [c0000004684fb610] [c00000000020df4c] lock_acquire+0x11c/0x450
[16978.535423] [c0000004684fb710] [c00000000119193c]
_raw_spin_lock_irqsave+0x6c/0xc0
[16978.535462] [c0000004684fb750] [c008000019a80038]
dm_deferred_entry_inc+0x30/0x80 [dm_bio_prison]
[16978.535506] [c0000004684fb780] [c008000018b48558]
thin_map+0x3a0/0x410 [dm_thin_pool]
[16978.535538] [c0000004684fb820] [c000000000d1c228] __map_bio.isra.0+0xa8/0x400
[16978.535576] [c0000004684fb8b0] [c000000000d1cca4]
__split_and_process_non_flush+0x264/0x380
[16978.535614] [c0000004684fb960] [c000000000d1cf40] dm_submit_bio+0x180/0x620
[16978.535650] [c0000004684fba30] [c00000000088da6c]
submit_bio_noacct+0x12c/0x5a0
[16978.535680] [c0000004684fbad0] [c0000000008818e4] submit_bio_wait+0x74/0xb0
[16978.535715] [c0000004684fbb60] [c000000000899c68]
blkdev_issue_zeroout+0xd8/0x310
[16978.535754] [c0000004684fbc00] [c0000000006dcde0]
ext4_init_inode_table+0x260/0x4d0
[16978.535793] [c0000004684fbce0] [c00000000073ff2c]
ext4_lazyinit_thread+0x85c/0xae0
[16978.535832] [c0000004684fbda0] [c000000000198cd0] kthread+0x1a0/0x1b0
[16978.535868] [c0000004684fbe10] [c00000000000cfd4]
ret_from_kernel_thread+0x5c/0x64

[1] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/07/30/345792757/build_ppc64le_redhat%3A1466822690/tests/lvm_snapper_test/

Thank you,
Bruno

