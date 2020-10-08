Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B174C43467
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 10:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB892177B
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 10:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUPo6s/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgJHKQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729211AbgJHKQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 06:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602152211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=cMRW9M1Ddoj83fgZtAitt6hN75l9tAUqm8qnXl36FEQ=;
        b=MUPo6s/QImEt2jOFRYXyxRh0C778wGXoAD16FNniujgKhmh7ubENYAwHXqgrreVMEGUH/D
        Y4F6fOtxrLNfbkgZVG/XApocgd91qoN/XMzqjem17xz0Sv3EFC5/h4lr9ZzCem5K5MwdPL
        41LkFyenyUWmik1HCdxeToWgr0H86YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-5aZQLBURPQOlgOrnfNWcrQ-1; Thu, 08 Oct 2020 06:16:47 -0400
X-MC-Unique: 5aZQLBURPQOlgOrnfNWcrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19F4980A190;
        Thu,  8 Oct 2020 10:16:44 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CCA86CE4E;
        Thu,  8 Oct 2020 10:16:43 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E33E818095FF;
        Thu,  8 Oct 2020 10:16:42 +0000 (UTC)
Date:   Thu, 8 Oct 2020 06:16:42 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block <linux-block@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de
Message-ID: <1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com>
In-Reply-To: <1992220618.3314096.1602151485520.JavaMail.zimbra@redhat.com>
Subject: [bug report] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28
 refcount_warn_saturate+0xa6/0xf0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.5]
Thread-Topic: WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
Thread-Index: jPcpxPYfr6Aw6pikS+V4bF3xau86MA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I saw this failure[2] on both stable and block/for-next recently, seems it was introduced from[1], pls help check it, thanks.


[1]
commit 236187c4ed195161dfa4237c7beffbba0c5ae45b
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Tue Jul 28 13:16:36 2020 -0700

    nvme-tcp: fix timeout handler


[2]
#nvme_trtype=tcp ./check nvme/012

[ 2152.546343] run blktests nvme/012 at 2020-10-08 05:59:03
[ 2152.799640] loop: module loaded
[ 2152.835222] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2152.860697] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 2152.937889] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
[ 2152.952085] nvme nvme0: creating 12 I/O queues.
[ 2152.958042] nvme nvme0: mapped 12/0/0 default/read/poll queues.
[ 2152.969948] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
[ 2154.927953] XFS (nvme0n1): Mounting V5 Filesystem
[ 2154.942432] XFS (nvme0n1): Ending clean mount
[ 2154.948183] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[ 2215.193645] nvme nvme0: queue 7: timeout request 0x11 type 4
[ 2215.199331] nvme nvme0: starting error recovery
[ 2215.203890] nvme nvme0: queue 7: timeout request 0x12 type 4
[ 2215.204483] block nvme0n1: no usable path - requeuing I/O
[ 2215.214976] block nvme0n1: no usable path - requeuing I/O
[ 2215.215495] nvme nvme0: Reconnecting in 10 seconds...
[ 2215.215502] ------------[ cut here ]------------
[ 2215.215505] refcount_t: underflow; use-after-free.
[ 2215.215617] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
[ 2215.215619] Modules linked in: loop nvme_tcp nvme_fabrics nvme_core nvmet_tcp nvmet rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache sunrpc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep hp_wmi amd64_edac_mod edac_mce_amd kvm_amd ccp kvm irqbypass k10temp sparse_keymap rfkill pcspkr nv_tco wmi_bmof snd_pcm snd_timer snd soundcore i2c_nforce2 acpi_cpufreq ip_tables xfs nouveau video mxm_wmi i2c_algo_bit ata_generic drm_kms_helper cec mptsas ttm scsi_transport_sas firewire_ohci mptscsih pata_acpi drm serio_raw mptbase firewire_core forcedeth crc_itu_t sata_nv pata_amd wmi floppy
[ 2215.215710] CPU: 6 PID: 45 Comm: kworker/6:0H Not tainted 5.9.0-rc8+ #1
[ 2215.215713] Hardware name: Hewlett-Packard HP xw9400 Workstation/0A1Ch, BIOS 786D6 v04.02 04/21/2009
[ 2215.215721] Workqueue: kblockd blk_mq_timeout_work
[ 2215.215736] RIP: 0010:refcount_warn_saturate+0xa6/0xf0
[ 2215.215742] Code: 05 ca 98 22 01 01 e8 bf cf ad ff 0f 0b c3 80 3d b8 98 22 01 00 75 95 48 c7 c7 d8 53 3e a7 c6 05 a8 98 22 01 01 e8 a0 cf ad ff <0f> 0b c3 80 3d 97 98 22 01 00 0f 85 72 ff ff ff 48 c7 c7 30 54 3e
[ 2215.215745] RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
[ 2215.215750] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
[ 2215.215753] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
[ 2215.215755] RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
[ 2215.215758] R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
[ 2215.215761] R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
[ 2215.215765] FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
[ 2215.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2215.215771] CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
[ 2215.215773] Call Trace:
[ 2215.215784]  blk_mq_check_expired+0x109/0x1b0
[ 2215.215797]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
[ 2215.215801]  ? blk_poll+0x300/0x300
[ 2215.215806]  blk_mq_timeout_work+0x44/0xe0
[ 2215.215814]  process_one_work+0x1b4/0x370
[ 2215.215820]  worker_thread+0x53/0x3e0
[ 2215.215825]  ? process_one_work+0x370/0x370
[ 2215.215829]  kthread+0x11b/0x140
[ 2215.215834]  ? __kthread_bind_mask+0x60/0x60
[ 2215.215841]  ret_from_fork+0x22/0x30
[ 2215.215847] ---[ end trace 7d137e36e23c0d19 ]---
[ 2215.220371] block nvme0n1: no usable path - requeuing I/O
[ 2215.220377] block nvme0n1: no usable path - requeuing I/O
[ 2215.466666] block nvme0n1: no usable path - requeuing I/O
[ 2215.472056] block nvme0n1: no usable path - requeuing I/O
[ 2215.477444] block nvme0n1: no usable path - requeuing I/O
[ 2215.482828] block nvme0n1: no usable path - requeuing I/O
[ 2215.488219] block nvme0n1: no usable path - requeuing I/O
[ 2215.493625] block nvme0n1: no usable path - requeuing I/O
[ 2240.794172] nvmet: ctrl 2 keep-alive timer (15 seconds) expired!
[ 2240.800189] nvmet: ctrl 2 fatal error occurred!
[ 2245.402268] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[ 2245.408286] nvmet: ctrl 1 fatal error occurred!
[ 2262.862528] nvmet: creating controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
[ 2288.411172] nvme nvme0: queue 0: timeout request 0x0 type 4
[ 2288.416794] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[ 2288.423254] nvme nvme0: failed to connect queue: 0 ret=881
[ 2288.428773] nvme nvme0: Failed reconnect attempt 1
[ 2288.433568] nvme nvme0: Reconnecting in 10 seconds...
[ 2298.651953] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
[ 2298.665918] nvme_ns_head_submit_bio: 30 callbacks suppressed
[ 2298.665926] block nvme0n1: no usable path - requeuing I/O
[ 2298.676993] block nvme0n1: no usable path - requeuing I/O
[ 2298.682393] block nvme0n1: no usable path - requeuing I/O
[ 2298.687791] block nvme0n1: no usable path - requeuing I/O
[ 2298.693202] block nvme0n1: no usable path - requeuing I/O
[ 2298.698593] block nvme0n1: no usable path - requeuing I/O
[ 2298.703988] block nvme0n1: no usable path - requeuing I/O
[ 2298.709375] block nvme0n1: no usable path - requeuing I/O
[ 2298.714758] block nvme0n1: no usable path - requeuing I/O
[ 2298.720152] block nvme0n1: no usable path - requeuing I/O
[ 2298.725691] nvme nvme0: creating 12 I/O queues.
[ 2298.737066] nvme nvme0: mapped 12/0/0 default/read/poll queues.
[ 2298.745612] nvme nvme0: Successfully reconnected (2 attempt)



Best Regards,
  Yi Zhang


