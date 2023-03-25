Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E9BC6FD1C
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 07:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCYHZQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Mar 2023 03:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCYHZP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Mar 2023 03:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81B12054
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679729069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CDh1ACPED9uAXgCYz7lWgPrH2T8LZZyf3V8N3R6M93Q=;
        b=VEMcyQea9t0lW+z9UVphOIV8aXT6SP+v3H7ZSlYXalaLVG7gnVjqXZoTtFG6qY66FbB1RR
        5aVCAUD2QvBAS60He93KhlQSmiKW4V7P0riwhJRwVikyyIaTLBXAGaWMN9i/baW59ZlMNA
        qR4T1oMWBHCzEgJFJ4c5tN9htABVBIw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Z6D7iPNEMsCNZvKzzyjVWw-1; Sat, 25 Mar 2023 03:24:27 -0400
X-MC-Unique: Z6D7iPNEMsCNZvKzzyjVWw-1
Received: by mail-pl1-f199.google.com with SMTP id s11-20020a170902a50b00b001a1f8fc0d2cso2434226plq.15
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 00:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679729066;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDh1ACPED9uAXgCYz7lWgPrH2T8LZZyf3V8N3R6M93Q=;
        b=2/iQ8mmTM7ziycoGh2U7DEYAC58wHYyXLLa8znV+DafAQIJStGuc0/Yr7rzU8NHxrC
         V7bLaUx9K+fwEI7kAOw0jlNpmdY5NYf0LZNbD5tvLc05tl95fjqYUDj2IVBrHraodNAr
         1e3x81Zzn+5ZnTb5ZxQGH7rza6m09HzbGCnYBlmPFWSCIh0780nx3GzVkuXg/bW3O6oW
         QUbge8ItLXmDOSoUsDzzkPUEU/wHXeLr81X+pGbgMutiDFHMJcoiuqz1AH2G6Djq6iAz
         vKG8hyaCcaIRZ62BWKGvWg6olyWRJQ+xhiJ9uFelwt4BxQ8rMdvzj/ac1sb7dpQ4BNCw
         tjFw==
X-Gm-Message-State: AAQBX9dYsGVe3C6jmfTDJolw3RkEFOipC6/NX+UywgjMlt25Uf4aiDIe
        zxqrQsLLnUVOBNETyBFao5wSCKp+7EYgsaz8B0JjlM2p6OZr+kuIy98mZ3Mkr//cWXAABjkpcS5
        lqsVyIiu5NFBDUng5cElI0wUNHRiKVmetARbf5f0Iu/SG9QPTI/2D
X-Received: by 2002:a17:903:445:b0:1a2:1c7:1c36 with SMTP id iw5-20020a170903044500b001a201c71c36mr1800664plb.4.1679729066560;
        Sat, 25 Mar 2023 00:24:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350aIoVB9VO0Am1vDIj591g2fZMIZObYdXN5xl/+Pc0yNqx8DjzUf/ULQ4fbHgc+BzX+EVb+neObxwhDVyf3heXg=
X-Received: by 2002:a17:903:445:b0:1a2:1c7:1c36 with SMTP id
 iw5-20020a170903044500b001a201c71c36mr1800660plb.4.1679729066188; Sat, 25 Mar
 2023 00:24:26 -0700 (PDT)
MIME-Version: 1.0
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Sat, 25 Mar 2023 15:25:34 +0800
Message-ID: <CAGS2=YohS-+HDNaTfd_0xP249ewTc5ffgY+XB+kQnDQ+c_BwMg@mail.gmail.com>
Subject: [bug report] kernel panic at _find_next_zero_bit in io_uring testing
To:     linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

We found this kernel panic issue with upstream kernel 6.3.0-rc3 and
it's 100% reproduced, let me know if you need more info/testing,
thanks

kernel repo : https://github.com/torvalds/linux.git
reproducer :  run the testing from  git://git.kernel.dk/liburing

[ 1089.762678] Running test recv-msgall-stream.t:
[ 1089.922127] Running test recv-multishot.t:
[ 1090.231772] Running test reg-hint.t:
[ 1090.282612] general protection fault, probably for non-canonical
address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
[ 1090.294014] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[ 1090.301586] CPU: 3 PID: 36765 Comm: reg-hint.t Kdump: loaded Not
tainted 6.3.0-rc3.kasan+ #1
[ 1090.310035] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
2.16.1 08/17/2022
[ 1090.317612] RIP: 0010:_find_next_zero_bit+0x47/0x110
[ 1090.322603] Code: 55 48 c7 c5 ff ff ff ff 48 d3 e5 48 c1 e9 06 53
48 89 fb 4c 8d 2c cd 00 00 00 00 4e 8d 24 2f 4c 89 e6 48 83 ec 10 48
c1 ee 03 <80> 3c 16 00 0f 85 9a 00 00 00 49 8b 34 24 48 f7 d6 48 21 ee
75 4b
[ 1090.341358] RSP: 0018:ffff88848659fb68 EFLAGS: 00010246
[ 1090.346601] RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000000
[ 1090.353742] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 1090.360882] RBP: ffffffffffffffff R08: ffff888118b22704 R09: ffff888118b22717
[ 1090.368024] R10: ffffed10231644e2 R11: 0000000000000001 R12: 0000000000000000
[ 1090.375167] R13: 0000000000000000 R14: ffff8884c5c1a000 R15: 0000000000000000
[ 1090.382307] FS:  00007fd9683a6740(0000) GS:ffff88887f680000(0000)
knlGS:0000000000000000
[ 1090.390403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1090.396158] CR2: 0000000000404060 CR3: 0000000486274006 CR4: 00000000007706e0
[ 1090.403297] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1090.410439] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1090.417580] PKRU: 55555554
[ 1090.420292] Call Trace:
[ 1090.422748]  <TASK>
[ 1090.424862]  __io_fixed_fd_install+0x136/0x1d0
[ 1090.429328]  io_fixed_fd_install+0x4c/0xc0
[ 1090.433444]  io_socket+0x282/0x3b0
[ 1090.436866]  io_issue_sqe+0x153/0xeb0
[ 1090.440549]  io_submit_sqes+0x41d/0xcd0
[ 1090.444407]  __do_sys_io_uring_enter+0x4e9/0x830
[ 1090.449044]  ? __pfx___do_sys_io_uring_enter+0x10/0x10
[ 1090.454197]  ? __pfx___handle_mm_fault+0x10/0x10
[ 1090.458833]  ? __pfx_mt_find+0x10/0x10
[ 1090.462601]  do_syscall_64+0x59/0x90
[ 1090.466196]  ? handle_mm_fault+0x1a0/0x660
[ 1090.470311]  ? up_read+0x1c/0xb0
[ 1090.473560]  ? do_user_addr_fault+0x313/0xeb0
[ 1090.477935]  ? syscall_exit_work+0x103/0x130
[ 1090.482227]  ? exc_page_fault+0x57/0xc0
[ 1090.486084]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1090.491153] RIP: 0033:0x402f3e
[ 1090.494221] Code: 41 89 ca 8b ba cc 00 00 00 41 b9 08 00 00 00 b8
aa 01 00 00 41 83 ca 10 f6 82 d0 00 00 00 01 44 0f 44 d1 45 31 c0 31
d2 0f 05 <c3> 90 89 30 eb 99 0f 1f 40 00 8b 3f 45 31 c0 83 e7 06 41 0f
95 c0
[ 1090.512975] RSP: 002b:00007ffeb6c4ee98 EFLAGS: 00000246 ORIG_RAX:
00000000000001aa
[ 1090.520556] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000402f3e
[ 1090.527697] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
[ 1090.534830] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000008
[ 1090.541965] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeb6c4f0a8
[ 1090.549106] R13: 0000000000401860 R14: 0000000000406e08 R15: 00007fd9683e9000
[ 1090.556253]  </TASK>

