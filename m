Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285797260F
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751334942; cv=none; b=s4YMQRq4eX0sfMiN8FtnHtsr6qNT8+9Fp3EArVeHqTVFfbYwFDG5YNAGRJbpQ+tebqtF2jbNoDxIIbUgE/WhuCaaB9tSge0W1uGQ0tGcqdpOLI2d1HHgCMi9/dgc/GAFAGL7e+ag7LghIf0p6C+K+KG4xW/8NPvBRcbWDSMCHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751334942; c=relaxed/simple;
	bh=qY0dAyF5Wm35VyKl4cqSVVMdEhPbkwClUNojP5AcvsQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P9nxO1Ls8BzqoUkC6WyWKEXgQ71+/QnZpoiGGVQo52XeqiOE3t9ssaXZC0olpx/2Krn1rS127XGdKgWUL4E1HLfCrnprcblXLoP4muoE17NNx7dBpIG2SVfhRl8iEQ1zPWUbkfxUZ+LeGaPBOf8CuTnuCpjNtf1SAt+uNK8NZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnfsW3ve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnfsW3ve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751334937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0q+AE5fMzsN+iGwiADRUER/JV7Ab+7rXTLnWLrEYCwA=;
	b=QnfsW3veZR+zVr8FWVs2PEl/d6RmBmA1P5+4Yo3mHtvdeiaOgjaVR1SPzcQqJw0dV9/D8l
	6jV3i219wOfF0w0C5nXD1DmvkyTlbV66CrTnls4VbL/0/NJi5HaXMdBJsTHDJRnzpZA13t
	A937mkA+/9j7C1M3dy0RnJ7mBU9j7TU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-wY97wEyAPP2s5E0ARo9jcA-1; Mon, 30 Jun 2025 21:55:36 -0400
X-MC-Unique: wY97wEyAPP2s5E0ARo9jcA-1
X-Mimecast-MFC-AGG-ID: wY97wEyAPP2s5E0ARo9jcA_1751334935
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so4060071a91.1
        for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 18:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751334935; x=1751939735;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0q+AE5fMzsN+iGwiADRUER/JV7Ab+7rXTLnWLrEYCwA=;
        b=LHxAk6j07OKBN025NCyRbF2BCMpAhRly5QJjrHHTrsOTWgPZufzZa9Ttk3c71/T9Dy
         8/j4M/OJ33BcZ0u9vUSgBwVYScIdSGa6k5tngNdW9mTR9fsWoly2DwB8czTOGgzAlPG8
         jMLkNtu26twedGZedLTBSt0mhWWZUYdsAB85e7ZfVtf7SxCRhLsWuBaFFhImGHUbVDTP
         P12w9x8ky71w6+aMXsQGxXqU0lELCe37ChM6EoJpsxoxEhCz0P14LD6H+pjd9yxw36Dt
         z1VNvr2GwBViMMqjZEJ7W/050sAO1v8k/p27p2hb2yvbVLwZ+jfGr6JmqtSokUlnRUoT
         ZLAg==
X-Gm-Message-State: AOJu0YwIRs22Y0R3TgR8fjyygg4JzNThfEWiIhp6KUe6BqHxm2+qezbh
	g/OaRAQc7+9Tvq3t4RSVc1hgiHl8jsVKETt+gmLKzDOAsPx8ianNcnseEzudmc60J9h2yu06SQu
	ENi8jwaEvehFkSQyd6n1SqKsu614o+nzo6felU58Qry2y9VUfsxgKCH99KQpKFVyPmJ3XBMUrSZ
	mo/tEIkWmqcFBCtHE5Wmmo7n9/QGjB8Tb0ZS7ku7XU0D+Cx3LGnw==
X-Gm-Gg: ASbGnctSkkmbjf3MFt3S0uWvhapOlXFGJa/1cAIXuc26/fgNTGehWIy8S9bGygp4P08
	43h25Jy2PBAnriVL+0zpip9A3abzYEp2xHT5Hd6u1StmFCnDsAYpD8tRqrDyCJr+a3jsqhzGJ2I
	oRNc9W
X-Received: by 2002:a17:90b:1dd2:b0:311:ea13:2e70 with SMTP id 98e67ed59e1d1-318c910aacbmr23457269a91.14.1751334934564;
        Mon, 30 Jun 2025 18:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpe4pMiXVq2K+tVWSiR1dsZXr+u7YlBc7YNjAu073OnGSOtzmEheVNM8oCbui6fwqdkf4qplge9mIoqOnMw6Y=
X-Received: by 2002:a17:90b:1dd2:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-318c910aacbmr23457217a91.14.1751334934138; Mon, 30 Jun 2025
 18:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 1 Jul 2025 09:55:23 +0800
X-Gm-Features: Ac12FXxYeWhx-KzgA2hrT-f7RAylh3JbSwTL5obTMClEjs3KvaMRjIWYewpIcGQ
Message-ID: <CAGVVp+UZ5VUYvW4ZktoF055Wg=PXO5vico76O3f_iwnfcLb-HA@mail.gmail.com>
Subject: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000060
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

the following kernel panic was triggered by 'ubdsrv  make test T=generic' tests,
please help check and let me know if you need any info/test, thanks.

repo: https://github.com/torvalds/linux.git
branch: master
INFO: HEAD of cloned kernel:
commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jun 29 13:09:04 2025 -0700

    Linux 6.16-rc4

dmesg log:
[ 3431.347957] BUG: kernel NULL pointer dereference, address: 0000000000000060
[ 3431.355744] #PF: supervisor read access in kernel mode
[ 3431.361484] #PF: error_code(0x0000) - not-present page
[ 3431.367224] PGD 119ffa067 P4D 0
[ 3431.370830] Oops: Oops: 0000 [#1] SMP NOPTI
[ 3431.375503] CPU: 22 UID: 0 PID: 397273 Comm: fio Tainted: G S
           6.16.0-rc4 #1 PREEMPT(voluntary)
[ 3431.386864] Tainted: [S]=CPU_OUT_OF_SPEC
[ 3431.391243] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE118M-1.32 06/29/2022
[ 3431.400954] RIP: 0010:ublk_queue_rqs+0x7d/0x1c0 [ublk_drv]
[ 3431.407085] Code: 00 00 4c 8b b8 c8 00 00 00 48 63 43 20 48 c1 e0
05 4d 8d 6c 07 30 48 85 d2 0f 84 c1 00 00 00 4c 01 f8 48 8b 7a 10 48
8b 70 40 <48> 8b 4e 60 48 39 4f 60 0f 84 9a 00 00 00 4d 85 e4 0f 84 9f
00 00
[ 3431.428035] RSP: 0018:ff711b900c5379d8 EFLAGS: 00010282
[ 3431.433869] RAX: ff300f05d5c534b0 RBX: ff300f05ea3b2940 RCX: ff300f05d5c53090
[ 3431.441834] RDX: ff300f05d5c534c0 RSI: 0000000000000000 RDI: 0000000000000000
[ 3431.449799] RBP: ff300f05ea3b2800 R08: 0000000000000000 R09: 0000000000000028
[ 3431.457766] R10: ff711b900c537a60 R11: ff300f062256ec20 R12: 0000000000000000
[ 3431.465723] R13: ff300f05d5c534e0 R14: ff711b900c537af0 R15: ff300f05d5c53090
[ 3431.473687] FS:  00007fddab6cd080(0000) GS:ff300f08df445000(0000)
knlGS:0000000000000000
[ 3431.482720] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3431.489137] CR2: 0000000000000060 CR3: 0000000122ff0001 CR4: 0000000000773ef0
[ 3431.497095] PKRU: 55555554
[ 3431.500108] Call Trace:
[ 3431.502829]  <TASK>
[ 3431.505172]  blk_mq_dispatch_queue_requests+0x15a/0x190
[ 3431.511011]  blk_mq_flush_plug_list+0x78/0x190
[ 3431.515971]  ? io_submit_one+0xee/0x370
[ 3431.520257]  __blk_flush_plug+0xf2/0x150
[ 3431.524639]  blk_finish_plug+0x28/0x40
[ 3431.528826]  __x64_sys_io_submit+0xd5/0x1e0
[ 3431.533500]  do_syscall_64+0x7f/0x980
[ 3431.537591]  ? blk_mq_start_request+0x48/0x190
[ 3431.542554]  ? __io_req_task_work_add+0x35/0x1f0
[ 3431.547711]  ? ublk_queue_rqs+0x103/0x1c0 [ublk_drv]
[ 3431.553255]  ? blk_mq_dispatch_queue_requests+0x162/0x190
[ 3431.559283]  ? blk_mq_flush_plug_list+0x78/0x190
[ 3431.564435]  ? io_submit_one+0xee/0x370
[ 3431.568717]  ? __blk_flush_plug+0xf2/0x150
[ 3431.573292]  ? rseq_get_rseq_cs.isra.0+0x16/0x210
[ 3431.578546]  ? rseq_ip_fixup+0x90/0x1d0
[ 3431.582820]  ? __rseq_handle_notify_resume+0x35/0x60
[ 3431.588363]  ? arch_exit_to_user_mode_prepare.isra.0+0x82/0xb0
[ 3431.594877]  ? do_syscall_64+0xb1/0x980
[ 3431.599160]  ? blk_mq_dispatch_queue_requests+0x162/0x190
[ 3431.605189]  ? blk_mq_flush_plug_list+0x78/0x190
[ 3431.610344]  ? io_submit_one+0xee/0x370
[ 3431.614625]  ? __blk_flush_plug+0xf2/0x150
[ 3431.619201]  ? blk_finish_plug+0x28/0x40
[ 3431.623581]  ? __x64_sys_io_submit+0x104/0x1e0
[ 3431.628542]  ? syscall_exit_work+0x108/0x140
[ 3431.633302]  ? clear_bhb_loop+0x50/0xa0
[ 3431.637585]  ? clear_bhb_loop+0x50/0xa0
[ 3431.641860]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 3431.647499] RIP: 0033:0x7fddab7d1a3d
[ 3431.651490] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 b3 0c 00 f7 d8 64 89
01 48
[ 3431.672448] RSP: 002b:00007ffd378a7a08 EFLAGS: 00000246 ORIG_RAX:
00000000000000d1
[ 3431.680900] RAX: ffffffffffffffda RBX: 00007fddab6ccff8 RCX: 00007fddab7d1a3d
[ 3431.688867] RDX: 000055ff413149c0 RSI: 0000000000000010 RDI: 00007fdda3226000
[ 3431.696824] RBP: 00007fdda3226000 R08: 00007fdda3240000 R09: 0000000000000280
[ 3431.704789] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
[ 3431.712755] R13: 0000000000000000 R14: 000055ff413149c0 R15: 000055ff4131b740
[ 3431.720723]  </TASK>
[ 3431.723160] Modules linked in: ublk_drv raid10 raid1 raid0 dm_raid
raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx
raid6_pq nf_tables rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs
lockd grace nfs_localio netfs sunrpc rfkill intel_rapl_msr
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm ipmi_ssif iTCO_wdt irqbypass
dax_hmem rapl cxl_acpi mgag200 cdc_ether isst_if_mbox_pci
iTCO_vendor_support cxl_port intel_cstate isst_if_mmio cxl_core tg3
usbnet intel_th_gth i2c_algo_bit i2c_i801 mei_me ioatdma intel_uncore
mii intel_th_pci einj mei pcspkr acpi_power_meter isst_if_common
i2c_smbus intel_vsec intel_pch_thermal intel_th dca ipmi_si acpi_ipmi
ipmi_devintf ipmi_msghandler acpi_pad sg fuse loop nfnetlink xfs
sd_mod ahci libahci libata ghash_clmulni_intel wmi dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: null_blk]
[ 3431.818860] CR2: 0000000000000060
[ 3431.822559] ---[ end trace 0000000000000000 ]---
[ 3431.856214] RIP: 0010:ublk_queue_rqs+0x7d/0x1c0 [ublk_drv]
[ 3431.862342] Code: 00 00 4c 8b b8 c8 00 00 00 48 63 43 20 48 c1 e0
05 4d 8d 6c 07 30 48 85 d2 0f 84 c1 00 00 00 4c 01 f8 48 8b 7a 10 48
8b 70 40 <48> 8b 4e 60 48 39 4f 60 0f 84 9a 00 00 00 4d 85 e4 0f 84 9f
00 00
[ 3431.883302] RSP: 0018:ff711b900c5379d8 EFLAGS: 00010282
[ 3431.889136] RAX: ff300f05d5c534b0 RBX: ff300f05ea3b2940 RCX: ff300f05d5c53090
[ 3431.897094] RDX: ff300f05d5c534c0 RSI: 0000000000000000 RDI: 0000000000000000
[ 3431.905052] RBP: ff300f05ea3b2800 R08: 0000000000000000 R09: 0000000000000028
[ 3431.913009] R10: ff711b900c537a60 R11: ff300f062256ec20 R12: 0000000000000000
[ 3431.920974] R13: ff300f05d5c534e0 R14: ff711b900c537af0 R15: ff300f05d5c53090
[ 3431.928940] FS:  00007fddab6cd080(0000) GS:ff300f08df445000(0000)
knlGS:0000000000000000
[ 3431.937973] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3431.944388] CR2: 0000000000000060 CR3: 0000000122ff0001 CR4: 0000000000773ef0
[ 3431.952354] PKRU: 55555554
[ 3431.955374] Kernel panic - not syncing: Fatal exception
[ 3431.961292] Kernel Offset: 0xd000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 3432.002335] ---[ end Kernel panic - not syncing: Fatal exception ]---

Best Regards,
Changhui

