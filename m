Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D015BC05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 05:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBFFXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 00:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFFX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 00:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F084196B0
        for <linux-block@vger.kernel.org>; Sun,  5 Feb 2023 21:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675660959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ypoIFRZSrzpCBMl09Rd/nBKur9+RYfjLZaM8S5BJK+8=;
        b=KuHZ3PSLxMiOOjIbPSpwlbLNUv+otb6WhT7hxUXXLcN/8DKrkb5uALkOY/FmRjjX8vnvya
        y/WFuWHqpXM17gb6QVEhL73CIFz+WLuyU71AOQCC3dGIOtnlTM165B8I7a9WFGxvygOhEv
        54IirDpgPA/+xQ6Iv7WjkoWMMveltQM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-1OTe_SqTPYeHCWI26-B6cQ-1; Mon, 06 Feb 2023 00:22:38 -0500
X-MC-Unique: 1OTe_SqTPYeHCWI26-B6cQ-1
Received: by mail-pl1-f198.google.com with SMTP id jk21-20020a170903331500b00198d701ad9cso4638811plb.20
        for <linux-block@vger.kernel.org>; Sun, 05 Feb 2023 21:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypoIFRZSrzpCBMl09Rd/nBKur9+RYfjLZaM8S5BJK+8=;
        b=XD5A6l+sbt57BQZj40mFpkyouTycUSF+wQfAjx+IFMCA6WZkr9rk6/vXWxwKN2YUwy
         e48nkI3NY27qDilwY1CheowrKmVJabM9f7yR797I+wRgsXgruwMajvoyG2/Q3WTKrPiN
         eh2yPaRfv1z+p8TA4BBCv8EWNu8w24L2JM+CFYUyysDqydHfjQKRNNoq0GfSrz9LpwFp
         3r3/Vrk8cLH6neL8tn447EJ4rCiWBLws4O9n76YFXVrlp4aVommsMdyP/fkvMpA/7mVH
         aKwC01QcmlBEGes29Vsrzg9OfNNImh21JXk250rCsSCiE+RjevXvBBneZpkIiK+F6qw5
         NSsg==
X-Gm-Message-State: AO0yUKUEbqiBLii+Nhkx5ABkURxbT9oCHTe4n5JXefoB58mSNcKvND22
        T4jimKvCjQ8zpo7LITXyMigEzgNvFVVZ3ek8SkJvH2ahG478+xle1uzPlJWWGR0ocX/c9WdVTbG
        lVw1L+Og65F/tQFup5g1AnM1Ocx+B0eQDPA61ltk=
X-Received: by 2002:a17:90a:3484:b0:230:8977:efba with SMTP id p4-20020a17090a348400b002308977efbamr1259120pjb.145.1675660955882;
        Sun, 05 Feb 2023 21:22:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/Zk20Jv5tYQzvNpNL8myN9EcSgssvSo8YlUuBQyKOB2qvu9wBSS30jEm9I0OGrfnHoAUNiemO4c+ExUoJfhsQ=
X-Received: by 2002:a17:90a:3484:b0:230:8977:efba with SMTP id
 p4-20020a17090a348400b002308977efbamr1259118pjb.145.1675660955429; Sun, 05
 Feb 2023 21:22:35 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 6 Feb 2023 13:22:23 +0800
Message-ID: <CAHj4cs-ZvyXKU9iAVKSkh2NfN5238rh-OaU8_uDBHVFtJb2ASQ@mail.gmail.com>
Subject: [bug report] RIP: 0010:blkg_free+0xa/0xe0 observed on latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
CKI reported one new issue with the latest linux-block/for-next, pls
help check it, thanks.

linux-block.git@for-next
commit: 99bd489eac97

[ 4407.784047] Running test [R:13334567 T:10 - Storage - block -
storage fio numa - Kernel: 6.2.0-rc6]
[ 4509.133240] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 4509.133654] #PF: supervisor read access in kernel mode
[ 4509.133930] #PF: error_code(0x0000) - not-present page
[ 4509.134206] PGD 0 P4D 0
[ 4509.134373] Oops: 0000 [#1] PREEMPT SMP PTI
[ 4509.134579] CPU: 2 PID: 965 Comm: auditd Tainted: G          I
  6.2.0-rc6 #1
[ 4509.135384] Hardware name: HP ProLiant DL360p Gen8, BIOS P71 05/24/2019
[ 4509.135758] RIP: 0010:blkg_free+0xa/0xe0
[ 4509.135983] Code: cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48
89 fd 53 <48> 8b 07 31 db 48 8d b8 b8 02 00 00 e8 b5 de 7e 00 48 8b bc
1d d0
[ 4509.137791] RSP: 0018:ffffb5a64507bad0 EFLAGS: 00010002
[ 4509.138107] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000000
[ 4509.139024] RDX: ffff9e298c71d100 RSI: ffff9e2cc3028800 RDI: 0000000000000000
[ 4509.139893] RBP: 0000000000000000 R08: ffff9e2cf282fb88 R09: ffff9e2cd2f252d0
[ 4509.140709] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e2cc3028800
[ 4509.141591] R13: ffff9e2cc7712a00 R14: ffff9e2cc4f66800 R15: ffff9e2cc3028800
[ 4509.142382] FS:  00007f39005656c0(0000) GS:ffff9e2caf680000(0000)
knlGS:0000000000000000
[ 4509.142687] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4509.143718] CR2: 0000000000000000 CR3: 000000010fcda005 CR4: 00000000000606e0
[ 4509.144551] Call Trace:
[ 4509.144739]  <TASK>
[ 4509.145286]  blkg_create+0x2d/0x350
[ 4509.145873]  bio_associate_blkg_from_css+0x1fc/0x330
[ 4509.146168]  iomap_do_writepage+0x346/0x800
[ 4509.146424]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[ 4509.146708]  write_cache_pages+0x172/0x4a0
[ 4509.146929]  ? __pfx_iomap_do_writepage+0x10/0x10
[ 4509.147565]  iomap_writepages+0x1c/0x40
[ 4509.147825]  xfs_vm_writepages+0x6b/0xa0 [xfs]
[ 4509.148851]  do_writepages+0xb0/0x1b0
[ 4509.149077]  ? _raw_spin_unlock+0x15/0x30
[ 4509.149330]  ? inode_prepare_wbs_switch+0x6c/0x90
[ 4509.150004]  filemap_fdatawrite_wbc+0x5f/0x80
[ 4509.150788]  __filemap_fdatawrite_range+0x4a/0x60
[ 4509.151558]  file_write_and_wait_range+0x46/0xb0
[ 4509.152268]  xfs_file_fsync+0x4c/0x220 [xfs]
[ 4509.153315]  ? syscall_trace_enter.isra.0+0x13f/0x1c0
[ 4509.153622]  __x64_sys_fsync+0x37/0x60
[ 4509.153844]  do_syscall_64+0x5b/0x80
[ 4509.154059]  ? do_syscall_64+0x67/0x80
[ 4509.154296]  ? __irq_e[ 4509.242631]
entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 4509.254719] RIP: 0033:0x7f3900bcffac
[ 4509.254976] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48
89 e5 48 83 ec 10 89 7d fc e8 30 0e f8 ff 8b 7d fc 89 c2 b8 4a 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 92 0e f8 ff 8b 45
fc c9
[ 4509.256302] RSP: 002b:00007f3900564cc0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[ 4509.257080] RAX: ffffffffffffffda RBX: 0000562496b76120 RCX: 00007f3900bcffac
[ 4509.257880] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
[ 4509.258653] RBP: 00007f3900564cd0 R08: 0000000000000000 R09: 0000562496b76108
[ 4509.259411] R10: 0000000000000000 R11: 0000000000000293 R12: 0000562496b760e0
[ 4509.260171] R13: ffffffffffffff88 R14: 0000000000000002 R15: 00007ffcfba66bb0
[ 4509.260964]  </TASK>
[ 4509.261107] Modules linked in: rfkill intel_rapl_msr
intel_rapl_common sb_edac sunrpc x86_pkg_temp_thermal
intel_powercleter dca fuse loop zram xfs crct10dif_pclmul crc32_pclmul
crc32c_intel polyval_c2_ssse3 serio_raw hpsa mgag200 hpwdt
scsi_transport_sas [last unloaded: scsi_debug]
[ 4509.763301] CR2: 0000000000000000
[ 4509.763858] ---[ end trace 0000000000000000 ]---
[ 4509.765833] pstore: backend (erst) writing error (-28)
[ 4509.766151] RIP: 0010:blkg_free+0xa/0xe0
[ 4509.766382] Code: cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48
89 fd 53 <48> 8b 07 31 db 48 8d b8 b8 02 00 00 e8 b5 de 7e 00 48 8b bc
1d d0
[ 4509.767698] RSP: 0018:ffffb5a64507bad0 EFLAGS: 00010002
[ 4509.767985] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000000
[ 4509.768759] RDX: ffff9e298c71d100 RSI: ffff9e2cc3028800 RDI: 0000000000000000
[ 4509.769509] RBP: 0000000000000000 R08: ffff9e2cf282fb88 R09: ffff9e2cd2f252d0
[ 4509.770283] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e2cc3028800
[ 4509.771041] R13: ffff9e2cc7712a00 R14: ffff9e2cc4f66800 R15: ffff9e2cc3028800
[ 4509.771840] FS:  00007f39005656c0(0000) GS:ffff9e2caf680000(0000)
knlGS:0000000000000000
[ 4509.772348] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4509.773045] CR2: 0000000000000000 CR3: 000000010fcda005 CR4: 00000000000606e0
[ 4509.773820] Kernel panic - not syncing: Fatal exception
[ 4509.776266] Kernel Offset: 0x37000000 from 0xffffffff81000000 (relocation r


-- 
Best Regards,
  Yi Zhang

