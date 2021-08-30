Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714DDC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 15:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5620B60E77
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 15:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhH3PB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:01:27 -0400
Received: from corp-mailer.zoner.com ([217.198.120.77]:44100 "EHLO
        corp-mailer.zoner.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhH3PB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 11:01:27 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2021 11:01:26 EDT
Received: from [10.1.0.142] (gw-sady.zoner.com [217.198.112.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by corp-mailer.zoner.com (Postfix) with ESMTPSA id C53261F242;
        Mon, 30 Aug 2021 16:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoner.cz;
        s=zcdkim1-3eaw99fduzu913p; t=1630335174;
        bh=jTtX19V7rN1gW3tJF2gaK1GF57mg19NgK+PxH5ptzLs=;
        h=From:Subject:To:Cc:Date:From;
        b=vnK23PcWPAhHJvrpPo4eLMCuYjZOSO67kDlgAcMv1PQATuDWis/CCYR8/yvb6brd5
         07VKzgfe4XrS0R8PckHeZK9cPaXSHFAsUAO44gPxkVcwzZO0cbc3bDfvsegdrgEE9J
         ETtlE2GEjScSzh0HK+lLrI9krnOv9omR6BzTG9xXgyfuxj5pWTnf9J8gBD3CEdwGX0
         iNquj1e3nXA9Jyk7MfLF/sECYxUR99F4WgzvLvTcREUyt86eyDUsx6N3YOoVJEzO0+
         g6kmoSreRQAz/2UrZPUOYp/LxvEeyqEfdJXSAEfsDCW8FMFWOFMbwlmC76UlgRVOFy
         UENlwE1yvv62Q==
From:   Martin Svec <martin.svec@zoner.cz>
Subject: NULL pointer dereference in blk_mq_put_rq_ref (LTS kernel 5.10.56)
To:     linux-block@vger.kernel.org
Cc:     Martin Svec <martin.svec@zoner.cz>
Message-ID: <1706c570-6c07-4eb7-219f-de3366e54077@zoner.cz>
Date:   Mon, 30 Aug 2021 16:52:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Content-Language: cs
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

after upgrade from 5.4.x to 5.10.56 one of our LIO iSCSI Target servers hung
with kernel NULL pointer dereference bug, see below. According to the call trace
I guess that the bug is related to the generic blk-mq subsystem. I don't see any
fixes related to blk-mq between 5.10.56 and 5.10.60, so this bug probably occurs
in latest 5.10 stable releases too. I this a known issue or do you have any ideas
what's wrong?

Aug 30 02:40:28 lio-206 kernel: [1084425.983233] BUG: kernel NULL pointer dereference, address: 00000000000000c0
Aug 30 02:40:28 lio-206 kernel: [1084425.985093] #PF: supervisor read access in kernel mode
Aug 30 02:40:28 lio-206 kernel: [1084425.986811] #PF: error_code(0x0000) - not-present page
Aug 30 02:40:28 lio-206 kernel: [1084425.988557] PGD 0 P4D 0
Aug 30 02:40:28 lio-206 kernel: [1084425.990290] Oops: 0000 [#1] SMP PTI
Aug 30 02:40:28 lio-206 kernel: [1084425.992035] CPU: 7 PID: 760 Comm: snmpd Tainted: G            E     5.10.56-znr1+ #26
Aug 30 02:40:28 lio-206 kernel: [1084425.993829] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5 08/16/2017
Aug 30 02:40:28 lio-206 kernel: [1084425.995725] RIP: 0010:blk_mq_put_rq_ref+0x9/0x60
Aug 30 02:40:28 lio-206 kernel: [1084425.997572] Code: 8d 43 48 48 39 c2 75 13 40 0f b6 d5 48 89 df be 01 00 00 00 5b 5d e9 96 fe ff ff 0f 0b 0f 1f 40 00 0f 1f 44 00 00 48 8b 47 10 <48> 8b 80 c0 00 00 00 48 3b 78 40 74 1e 48 8d 97
Aug 30 02:40:28 lio-206 kernel: [1084426.001491] RSP: 0018:ffffb34680d3fb70 EFLAGS: 00010206
Aug 30 02:40:28 lio-206 kernel: [1084426.003479] RAX: 0000000000000000 RBX: ffff9a91d8654400 RCX: 0000000000000001
Aug 30 02:40:28 lio-206 kernel: [1084426.005448] RDX: 0000000000000002 RSI: 0000000000000202 RDI: ffff9a91d8654400
Aug 30 02:40:28 lio-206 kernel: [1084426.007439] RBP: ffffb34680d3fbe0 R08: 0000000000000000 R09: 0000000000000025
Aug 30 02:40:28 lio-206 kernel: [1084426.009336] R10: 0000000002f41000 R11: 0000000000000004 R12: ffff9a920ec7b800
Aug 30 02:40:28 lio-206 kernel: [1084426.011196] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000025
Aug 30 02:40:28 lio-206 kernel: [1084426.013036] FS:  00007fa597b76280(0000) GS:ffff9a93379c0000(0000) knlGS:0000000000000000
Aug 30 02:40:28 lio-206 kernel: [1084426.014985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 30 02:40:28 lio-206 kernel: [1084426.016774] CR2: 00000000000000c0 CR3: 0000000148c68004 CR4: 00000000003706e0
Aug 30 02:40:28 lio-206 kernel: [1084426.018666] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Aug 30 02:40:28 lio-206 kernel: [1084426.020513] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Aug 30 02:40:28 lio-206 kernel: [1084426.022198] Call Trace:
Aug 30 02:40:28 lio-206 kernel: [1084426.023809]  bt_iter+0x50/0x80
Aug 30 02:40:28 lio-206 kernel: [1084426.025352]  blk_mq_queue_tag_busy_iter+0x192/0x2d0
Aug 30 02:40:28 lio-206 kernel: [1084426.026861]  ? blk_mq_hctx_mark_pending+0x70/0x70
Aug 30 02:40:28 lio-206 kernel: [1084426.028335]  ? blk_mq_hctx_mark_pending+0x70/0x70
Aug 30 02:40:28 lio-206 kernel: [1084426.029744]  blk_mq_in_flight+0x35/0x60
Aug 30 02:40:28 lio-206 kernel: [1084426.031180]  diskstats_show+0x75/0x2a0
Aug 30 02:40:28 lio-206 kernel: [1084426.032530]  ? klist_next+0x82/0x110
Aug 30 02:40:28 lio-206 kernel: [1084426.033829]  seq_read_iter+0x26f/0x3f0
Aug 30 02:40:28 lio-206 kernel: [1084426.035069]  proc_reg_read_iter+0x37/0x70
Aug 30 02:40:28 lio-206 kernel: [1084426.036259]  new_sync_read+0x118/0x1a0
Aug 30 02:40:28 lio-206 kernel: [1084426.037395]  vfs_read+0xf1/0x180
Aug 30 02:40:28 lio-206 kernel: [1084426.038481]  ksys_read+0x59/0xd0
Aug 30 02:40:28 lio-206 kernel: [1084426.039519]  do_syscall_64+0x33/0x80
Aug 30 02:40:28 lio-206 kernel: [1084426.040512]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 02:40:28 lio-206 kernel: [1084426.041498] RIP: 0033:0x7fa598f0d461
Aug 30 02:40:28 lio-206 kernel: [1084426.042496] Code: fe ff ff 50 48 8d 3d fe d0 09 00 e8 e9 03 02 00 66 0f 1f 84 00 00 00 00 00 48 8d 05 99 62 0d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41
Aug 30 02:40:28 lio-206 kernel: [1084426.044700] RSP: 002b:00007ffed07839e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Aug 30 02:40:28 lio-206 kernel: [1084426.045861] RAX: ffffffffffffffda RBX: 00005570c7ec0430 RCX: 00007fa598f0d461
Aug 30 02:40:28 lio-206 kernel: [1084426.047050] RDX: 0000000000000400 RSI: 00005570c7ea5300 RDI: 0000000000000009
Aug 30 02:40:28 lio-206 kernel: [1084426.048259] RBP: 0000000000000d68 R08: 0000000000000000 R09: 0000000000000000
Aug 30 02:40:28 lio-206 kernel: [1084426.049479] R10: 00007fa597b76280 R11: 0000000000000246 R12: 00007fa598fda760
Aug 30 02:40:28 lio-206 kernel: [1084426.050716] R13: 00007fa598fdb2a0 R14: 00000000000003bd R15: 00005570c7ec0430
Aug 30 02:40:28 lio-206 kernel: [1084426.051970] Modules linked in: intel_rapl_msr(E) dcdbas(E) evdev(E) intel_rapl_common(E) sb_edac(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) irqbypass(E) crc3
Aug 30 02:40:28 lio-206 kernel: [1084426.052054]  libcrc32c(E) crc32c_generic(E) md_mod(E) sd_mod(E) t10_pi(E) crc_t10dif(E) crct10dif_generic(E) ahci(E) libahci(E) ehci_pci(E) crct10dif_pclmul(E) ehci_hcd(E) crct10dif_common(E) c
Aug 30 02:40:28 lio-206 kernel: [1084426.068553] CR2: 00000000000000c0
Aug 30 02:40:28 lio-206 kernel: [1084426.070151] ---[ end trace b0bed0ae976fe2c4 ]---
Aug 30 02:40:28 lio-206 kernel: [1084426.156299] RIP: 0010:blk_mq_put_rq_ref+0x9/0x60
Aug 30 02:40:28 lio-206 kernel: [1084426.157936] Code: 8d 43 48 48 39 c2 75 13 40 0f b6 d5 48 89 df be 01 00 00 00 5b 5d e9 96 fe ff ff 0f 0b 0f 1f 40 00 0f 1f 44 00 00 48 8b 47 10 <48> 8b 80 c0 00 00 00 48 3b 78 40 74 1e 48 8d 97
Aug 30 02:40:28 lio-206 kernel: [1084426.161200] RSP: 0018:ffffb34680d3fb70 EFLAGS: 00010206
Aug 30 02:40:28 lio-206 kernel: [1084426.162843] RAX: 0000000000000000 RBX: ffff9a91d8654400 RCX: 0000000000000001
Aug 30 02:40:28 lio-206 kernel: [1084426.164514] RDX: 0000000000000002 RSI: 0000000000000202 RDI: ffff9a91d8654400
Aug 30 02:40:28 lio-206 kernel: [1084426.166168] RBP: ffffb34680d3fbe0 R08: 0000000000000000 R09: 0000000000000025
Aug 30 02:40:28 lio-206 kernel: [1084426.167915] R10: 0000000002f41000 R11: 0000000000000004 R12: ffff9a920ec7b800
Aug 30 02:40:28 lio-206 kernel: [1084426.169552] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000025
Aug 30 02:40:28 lio-206 kernel: [1084426.171198] FS:  00007fa597b76280(0000) GS:ffff9a93379c0000(0000) knlGS:0000000000000000
Aug 30 02:40:28 lio-206 kernel: [1084426.172929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 30 02:40:28 lio-206 kernel: [1084426.174602] CR2: 00000000000000c0 CR3: 0000000148c68004 CR4: 00000000003706e0
Aug 30 02:40:28 lio-206 kernel: [1084426.176284] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Aug 30 02:40:28 lio-206 kernel: [1084426.177964] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Aug 30 02:40:28 lio-206 systemd[1]: snmpd.service: Main process exited, code=killed, status=9/KILL
Aug 30 02:40:28 lio-206 systemd[1]: snmpd.service: Failed with result 'signal'.

(Please Cc me because I'm not a member of linux-block list.)

Thank you for your help,

Best regards

Martin

