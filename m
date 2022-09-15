Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB6EECAAD3
	for <linux-block@archiver.kernel.org>; Thu, 15 Sep 2022 12:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIOMuo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Sep 2022 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIOMum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2022 08:50:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0340BD4
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 05:50:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 543001F8B2;
        Thu, 15 Sep 2022 12:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663246238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/lN5D4FYkIzbMKRvu2sFC7f+RX30G3My1vJkTKfrQxU=;
        b=Wt3zJs3UHy+yXRGJZWnT/fDg5EtZCb+I/E6fqRhJDNXkKsqArVYcj3N8ZKy6p9lHKwxVoD
        V9As9CjBG53tiajfFGEBr5zRSi78u+vvEGLZ2nL3xIK9rJeonCRgKatxelk8R2RQMgLm8L
        RU5nYD30+NYfvGKAI/2o3haW1eqAnvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663246238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/lN5D4FYkIzbMKRvu2sFC7f+RX30G3My1vJkTKfrQxU=;
        b=TFqLh8eHcs9s0Y3EwUflTOWegk/c2vK4VKlYRF/KSs/W6b1JYUOIO2vGDQhJ+86pX2+bbJ
        gmd6v/G2Tvz9nxDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46C13133B6;
        Thu, 15 Sep 2022 12:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VKgZEZ4fI2PZTQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 15 Sep 2022 12:50:38 +0000
Date:   Thu, 15 Sep 2022 14:50:37 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        James Smart <jsmart2021@gmail.com>, hare@suse.de
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220915125037.fqhcokdn4scnklyq@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
 <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
 <20220914110717.pvzm2666mklkg73a@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914110717.pvzm2666mklkg73a@carbon.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> So do we agree the fc host should not stop reconnecting? James?

With the change below the test succeeds once:

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 42767fb75455..b167cf9fee6d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3325,8 +3325,6 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
                dev_info(ctrl->ctrl.device,
                        "NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
                        ctrl->cnum, status);
-               if (status > 0 && (status & NVME_SC_DNR))
-                       recon = false;
        } else if (time_after_eq(jiffies, rport->dev_loss_end))
                recon = false;

This part was introduced with f25f8ef70ce2 ("nvme-fc: short-circuit
reconnect retries"):

    nvme-fc: short-circuit reconnect retries

    Returning an nvme status from nvme_fc_create_association() indicates
    that the association is established, and we should honour the DNR bit.
    If it's set a reconnect attempt will just return the same error, so
    we can short-circuit the reconnect attempts and fail the connection
    directly.

It looks like the reasoning here didn't take into consideration the
scenario we have here. I'd say we should not do it and handle it similar
as with have with tcp/rdma.

The second time the target explodes in various ways. I suspect the
problem starts with tgtport->dev being NULL. Though the NULL pointer has
nothing todo with my change above it, as I saw it in the previous runs
as well. The WARNING/oops just happens less often without out the patch
above. With it is reproducible.


[  205.677228] (NULL device *): {0:2} Association deleted
[  205.677307] (NULL device *): {0:2} Association freed
[  205.677336] (NULL device *): Disconnect LS failed: No Association
[  205.721480] nvme nvme0: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  205.735687] (NULL device *): {0:0} Association deleted
[  205.735770] (NULL device *): {0:0} Association freed

[  205.737922] ============================================
[  205.737942] WARNING: possible recursive locking detected
[  205.737961] 6.0.0-rc2+ #26 Not tainted
[  205.737978] --------------------------------------------
[  205.737996] kworker/5:0/47 is trying to acquire lock:
[  205.738016] ffff8881304311e8 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: __flush_work+0x4c2/0x760
[  205.738073] 
               but task is already holding lock:
[  205.738094] ffffc90000397de0 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: process_one_work+0x4ec/0xa90
[  205.738139] 
               other info that might help us debug this:
[  205.738162]  Possible unsafe locking scenario:

[  205.738183]        CPU0
[  205.738196]        ----
[  205.738208]   lock((work_completion)(&tport->ls_work));
[  205.738232]   lock((work_completion)(&tport->ls_work));
[  205.738254] 
                *** DEADLOCK ***

[  205.738278]  May be due to missing lock nesting notation

[  205.738301] 2 locks held by kworker/5:0/47:
[  205.738318]  #0: ffff888142212948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x4ec/0xa90
[  205.738365]  #1: ffffc90000397de0 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: process_one_work+0x4ec/0xa90
[  205.738412] 
               stack backtrace:
[  205.738431] CPU: 5 PID: 47 Comm: kworker/5:0 Not tainted 6.0.0-rc2+ #26 a3543a403f60337b00194a751e59d1695bae8a5b
[  205.738465] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  205.738490] Workqueue: nvmet-wq fcloop_tport_lsrqst_work [nvme_fcloop]
[  205.738534] Call Trace:
[  205.738548]  <TASK>
[  205.738562]  dump_stack_lvl+0x56/0x73
[  205.738586]  __lock_acquire.cold+0x15d/0x2e2
[  205.738619]  ? lockdep_hardirqs_on_prepare+0x200/0x200
[  205.738647]  ? lockdep_lock+0xa7/0x160
[  205.738669]  lock_acquire+0x15d/0x3f0
[  205.738689]  ? __flush_work+0x4c2/0x760
[  205.738712]  ? lock_release+0x710/0x710
[  205.738733]  ? pvclock_clocksource_read+0xdc/0x1b0
[  205.738759]  ? mark_lock.part.0+0x108/0xd90
[  205.738784]  __flush_work+0x4e5/0x760
[  205.738804]  ? __flush_work+0x4c2/0x760
[  205.738828]  ? queue_delayed_work_on+0x90/0x90
[  205.738851]  ? lock_release+0x1fb/0x710
[  205.738876]  ? mark_held_locks+0x6b/0x90
[  205.738896]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
[  205.738925]  ? lockdep_hardirqs_on_prepare+0x136/0x200
[  205.738948]  ? trace_hardirqs_on+0x2d/0xf0
[  205.738972]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
[  205.738997]  ? __free_pages_ok+0x397/0x7e0
[  205.739023]  fcloop_targetport_delete+0x24/0xf0 [nvme_fcloop 1d5c548e62c1c6933b09815fc35f2c26e025239d]
[  205.739064]  nvmet_fc_free_tgtport+0x1d5/0x220 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  205.739110]  nvmet_fc_disconnect_assoc_done+0x133/0x150 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  205.739152]  ? nvmet_fc_xmt_ls_rsp+0xa0/0xa0 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  205.739189]  fcloop_rport_lsrqst_work+0xbe/0x110 [nvme_fcloop 1d5c548e62c1c6933b09815fc35f2c26e025239d]
[  205.739230]  process_one_work+0x5b6/0xa90
[  205.739256]  ? pwq_dec_nr_in_flight+0x100/0x100
[  205.739278]  ? lock_acquired+0x33d/0x5b0
[  205.739302]  ? _raw_spin_unlock_irq+0x24/0x50
[  205.739330]  worker_thread+0x2c0/0x710
[  205.739356]  ? process_one_work+0xa90/0xa90
[  205.739390]  kthread+0x16c/0x1a0
[  205.739412]  ? kthread_complete_and_exit+0x20/0x20
[  205.739436]  ret_from_fork+0x1f/0x30
[  205.739469]  </TASK>
[  265.728627] nvme nvme0: NVME-FC{0}: dev_loss_tmo (60) expired while waiting for remoteport connectivity.
[  265.728760] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"


or


[  106.172123] ==================================================================
[  106.172134] BUG: KASAN: null-ptr-deref in nvmet_execute_disc_get_log_page+0x1d3/0x5a0 [nvmet]
[  106.172212] Read of size 8 at addr 0000000000000520 by task kworker/4:3/7895
[  106.172226] CPU: 4 PID: 7895 Comm: kworker/4:3 Not tainted 6.0.0-rc2+ #26 a3543a403f60337b00194a751e59d1695bae8a5b
[  106.172238] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  106.172245] Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
[  106.172270] Call Trace:
[  106.172276]  <TASK>
[  106.172282]  dump_stack_lvl+0x56/0x73
[  106.172298]  kasan_report+0xb1/0xf0
[  106.172317]  ? nvmet_execute_disc_get_log_page+0x1d3/0x5a0 [nvmet 3bf416f83ec95a5fd1f5e7e8430a2ea0fb7e3bb4]
[  106.172374]  nvmet_execute_disc_get_log_page+0x1d3/0x5a0 [nvmet 3bf416f83ec95a5fd1f5e7e8430a2ea0fb7e3bb4]
[  106.172435]  ? nvmet_execute_disc_set_features+0xa0/0xa0 [nvmet 3bf416f83ec95a5fd1f5e7e8430a2ea0fb7e3bb4]
[  106.172490]  ? rcu_read_lock_sched_held+0x43/0x70
[  106.172506]  ? __alloc_pages+0x34d/0x410
[  106.172518]  ? __alloc_pages_slowpath.constprop.0+0x1500/0x1500
[  106.172530]  ? lock_is_held_type+0xac/0x130
[  106.172547]  ? _find_first_bit+0x28/0x50
[  106.172557]  ? policy_node+0x95/0xb0
[  106.172570]  ? sgl_alloc_order+0x151/0x200
[  106.172586]  nvmet_fc_handle_fcp_rqst+0x2cb/0x5c0 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.172610]  ? nvmet_fc_transfer_fcp_data+0x380/0x380 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.172628]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
[  106.172644]  ? lockdep_hardirqs_on_prepare+0x136/0x200
[  106.172659]  nvmet_fc_rcv_fcp_req+0x3bd/0x76b [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.172680]  ? nvmet_fc_handle_ls_rqst_work+0x1350/0x1350 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.172698]  ? mark_held_locks+0x6b/0x90
[  106.172707]  ? _raw_spin_unlock_irq+0x24/0x50
[  106.172718]  ? lockdep_hardirqs_on_prepare+0x136/0x200
[  106.172731]  fcloop_fcp_recv_work+0xe4/0x120 [nvme_fcloop 1d5c548e62c1c6933b09815fc35f2c26e025239d]
[  106.172753]  process_one_work+0x5b6/0xa90
[  106.172770]  ? pwq_dec_nr_in_flight+0x100/0x100
[  106.172779]  ? lock_acquired+0x33d/0x5b0
[  106.172791]  ? _raw_spin_unlock_irq+0x24/0x50
[  106.172806]  worker_thread+0x2c0/0x710
[  106.172822]  ? process_one_work+0xa90/0xa90
[  106.172830]  kthread+0x16c/0x1a0
[  106.172838]  ? kthread_complete_and_exit+0x20/0x20
[  106.172848]  ret_from_fork+0x1f/0x30
[  106.172869]  </TASK>
[  106.172874] ==================================================================
[  106.172879] Disabling lock debugging due to kernel taint
[  106.172891] BUG: kernel NULL pointer dereference, address: 0000000000000520
[  106.172920] #PF: supervisor read access in kernel mode
[  106.172940] #PF: error_code(0x0000) - not-present page
[  106.172960] PGD 0 P4D 0 
[  106.172979] Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  106.173000] CPU: 4 PID: 7895 Comm: kworker/4:3 Tainted: G    B              6.0.0-rc2+ #26 a3543a403f60337b00194a751e59d1695bae8a5b
[  106.173036] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  106.173065] Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
[  106.173102] RIP: 0010:nvmet_execute_disc_get_log_page+0x1d3/0x5a0 [nvmet]
[  106.173172] Code: 10 48 89 df e8 be 24 b3 cc 4c 89 ef 4c 8b 3b e8 b3 24 b3 cc 4c 8b b5 b8 01 00 00 4d 8d a6 20 05 00 00 4c 89 e7 e8 9d 24 b3 cc <49> 8b 9e 20 05 00 00 4c 39 e3 0f 84 7e 03 00 00 49 81 c7 b4 03 00
[  106.173220] RSP: 0018:ffffc9000834f998 EFLAGS: 00010286
[  106.173243] RAX: 0000000000000001 RBX: ffff88811c820070 RCX: ffffffff8d4fbd36
[  106.173268] RDX: fffffbfff223e8f9 RSI: 0000000000000008 RDI: ffffffff911f47c0
[  106.173291] RBP: ffff88811c822508 R08: 0000000000000001 R09: ffffffff911f47c7
[  106.173314] R10: fffffbfff223e8f8 R11: 0000000000000001 R12: 0000000000000520
[  106.173337] R13: ffff88811c8226c0 R14: 0000000000000000 R15: ffff88810e9d0000
[  106.173361] FS:  0000000000000000(0000) GS:ffff88821f800000(0000) knlGS:0000000000000000
[  106.173388] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.173409] CR2: 0000000000000520 CR3: 000000010c1b2004 CR4: 0000000000170ee0
[  106.173438] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  106.173461] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  106.173484] Call Trace:
[  106.173498]  <TASK>
[  106.173515]  ? nvmet_execute_disc_set_features+0xa0/0xa0 [nvmet 3bf416f83ec95a5fd1f5e7e8430a2ea0fb7e3bb4]
[  106.173593]  ? rcu_read_lock_sched_held+0x43/0x70
[  106.173616]  ? __alloc_pages+0x34d/0x410
[  106.173639]  ? __alloc_pages_slowpath.constprop.0+0x1500/0x1500
[  106.173666]  ? lock_is_held_type+0xac/0x130
[  106.173692]  ? _find_first_bit+0x28/0x50
[  106.173712]  ? policy_node+0x95/0xb0
[  106.173735]  ? sgl_alloc_order+0x151/0x200
[  106.173761]  nvmet_fc_handle_fcp_rqst+0x2cb/0x5c0 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.173804]  ? nvmet_fc_transfer_fcp_data+0x380/0x380 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.173843]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
[  106.173868]  ? lockdep_hardirqs_on_prepare+0x136/0x200
[  106.173895]  nvmet_fc_rcv_fcp_req+0x3bd/0x76b [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.173936]  ? nvmet_fc_handle_ls_rqst_work+0x1350/0x1350 [nvmet_fc 7a9748591fe196fb85ac8210ffbd9cf866e138c8]
[  106.173976]  ? mark_held_locks+0x6b/0x90
[  106.173996]  ? _raw_spin_unlock_irq+0x24/0x50
[  106.174019]  ? lockdep_hardirqs_on_prepare+0x136/0x200
[  106.174045]  fcloop_fcp_recv_work+0xe4/0x120 [nvme_fcloop 1d5c548e62c1c6933b09815fc35f2c26e025239d]
[  106.174087]  process_one_work+0x5b6/0xa90
[  106.174114]  ? pwq_dec_nr_in_flight+0x100/0x100
[  106.174135]  ? lock_acquired+0x33d/0x5b0
[  106.174159]  ? _raw_spin_unlock_irq+0x24/0x50
[  106.174186]  worker_thread+0x2c0/0x710
[  106.174212]  ? process_one_work+0xa90/0xa90
[  106.174233]  kthread+0x16c/0x1a0
[  106.174250]  ? kthread_complete_and_exit+0x20/0x20
[  106.174274]  ret_from_fork+0x1f/0x30
[  106.174303]  </TASK>
[  106.174315] Modules linked in: nvme_fcloop nvme_fc nvme_fabrics nvmet_fc nvmet nvme_core nvme_common af_packet rfkill nls_iso8859_1 nls_cp437 intel_rapl_msr vfat intel_rapl_common fat snd_hda_codec_generic kvm_intel snd_hda_intel snd_intel_dspcfg iTCO_wdt snd_hda_codec intel_pmc_bxt snd_hwdep kvm iTCO_vendor_support snd_hda_core joydev irqbypass snd_pcm i2c_i801 pcspkr i2c_smbus snd_timer efi_pstore snd virtio_net soundcore virtio_balloon lpc_ich net_failover failover tiny_power_button button fuse configfs ip_tables x_tables crct10dif_pclmul crc32_pclmul ghash_clmulni_intel hid_generic usbhid aesni_intel crypto_simd cryptd serio_raw sr_mod xhci_pci xhci_pci_renesas cdrom xhci_hcd virtio_blk usbcore virtio_gpu virtio_dma_buf qemu_fw_cfg btrfs blake2b_generic libcrc32c crc32c_intel xor raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs virtio_rng
[  106.174738] CR2: 0000000000000520
[  106.174756] ---[ end trace 0000000000000000 ]---
[  106.174775] RIP: 0010:nvmet_execute_disc_get_log_page+0x1d3/0x5a0 [nvmet]
[  106.174844] Code: 10 48 89 df e8 be 24 b3 cc 4c 89 ef 4c 8b 3b e8 b3 24 b3 cc 4c 8b b5 b8 01 00 00 4d 8d a6 20 05 00 00 4c 89 e7 e8 9d 24 b3 cc <49> 8b 9e 20 05 00 00 4c 39 e3 0f 84 7e 03 00 00 49 81 c7 b4 03 00
[  106.174893] RSP: 0018:ffffc9000834f998 EFLAGS: 00010286
[  106.174915] RAX: 0000000000000001 RBX: ffff88811c820070 RCX: ffffffff8d4fbd36
[  106.174939] RDX: fffffbfff223e8f9 RSI: 0000000000000008 RDI: ffffffff911f47c0
[  106.174963] RBP: ffff88811c822508 R08: 0000000000000001 R09: ffffffff911f47c7
[  106.174986] R10: fffffbfff223e8f8 R11: 0000000000000001 R12: 0000000000000520
[  106.175009] R13: ffff88811c8226c0 R14: 0000000000000000 R15: ffff88810e9d0000
[  106.175032] FS:  0000000000000000(0000) GS:ffff88821f800000(0000) knlGS:0000000000000000
[  106.175058] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.175079] CR2: 0000000000000520 CR3: 000000010c1b2004 CR4: 0000000000170ee0
[  106.175121] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  106.175144] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  107.593127] nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 

