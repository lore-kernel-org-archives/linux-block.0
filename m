Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62455185E
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 02:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234394; cv=none; b=q4sF3jNhUafq/7qQK3fGHQb0RCsB1ZMw1JQ/YC8GgLlxbqq1lOQD0yFTpomdeWdq2NrI5A4uozZa1LqVIYYJXJuhgXuH2awIor5cNRKvLxGN7QEOT/7eGfveUTQ/hoX5J00yCXZRbgCayGI+elI0j/VdBdJLh8BXNxPKiNS0M0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234394; c=relaxed/simple;
	bh=X6aq2Fjbh8Za29G2GrBKBhUwpQak2XpNqvvF1woHUNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shQK0c4mnp6Ycb1O+wVIQZUMUecHkGNJhyl2k9NUn7egT/4urMT/G+71pJoMn0klbz+C7NZI8EEUTApcrmzdhsaWU/vf02mWzUf3r+XCZ6C2GOWeLFln98z/AZSV9i1gN6HywQ3cDaLs+5x/V11XuH3UIOie+BQcvPPZcvYzRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaBVvzsz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaBVvzsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713234391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtJUZgUWFkaarp6lf8JTT+lkKnvuZIGzQFD6qXf1PEo=;
	b=CaBVvzszRTk4HOKDFKQ7CuzkRodMutJCco2AKQqvO56m/k34SMpwS0U5wzRFkKqLO22VbO
	d5BzM8EVBGL5hrQNU9hKcXv0UTBup+NPwlKlsJmCMVQ5XPiqlrLK3kNLaeVn9LV2zIAhSd
	bABDon45k116l4SNc1GJfyD/A6bR6bA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-2LmQX2o6M0GZUl6wxU3ZUw-1; Mon, 15 Apr 2024 22:26:29 -0400
X-MC-Unique: 2LmQX2o6M0GZUl6wxU3ZUw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a4ff147030so4146206a91.3
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 19:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713234388; x=1713839188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtJUZgUWFkaarp6lf8JTT+lkKnvuZIGzQFD6qXf1PEo=;
        b=uAIc4rDpyzRNPOBKtBsXXybXZPOKeL9OQPl1e3PbeRSujgf5o7JvUes+odr84EADaP
         CyZCuaziSnLy5bj8HQpupMjdmASLmXw4g0Xpndk8uL39jWBHqmsNIQqyNObSuOIOpEiD
         AVb2GTjv7IxZQ7XwiSJEzmwD0axjS6ADd6gz1ENHD24KI4ROdtcBbcTw+k+wN3KMottY
         Yd7Z6/4IknkFdr1ms9sA+gOJ6MNxA7q/AVjIywpBYy/g/DxF1DF18FznYjAGE4hfqZub
         DzMz0FUmlnRE9HBRb8gp9XMMnjD9ZK+y8VZRBJ0tKfSMvaUNZAxrhPhwHK0qk09i9dRB
         8nhg==
X-Forwarded-Encrypted: i=1; AJvYcCUG+Jivme6njjXBaLmhPQ3wnTmurX1oCJQr7VmtfSu618zgnUpgYr+mIkBzWsJMaQdzWLGrA1y6QBbivAi37hQnyC74OxoedpCte6M=
X-Gm-Message-State: AOJu0YygAWpWXLJ8HPoAruSeJPy4tT4yRw9zonxY6aFqsB/TqjUS+1Zy
	rs3HKUuk8EnBk2BbOI81IeoCl5Ig1TOz1c5RoSkG0Qx0MrgvEtnnG8As0j7RPe8lrEeZcbPto7d
	EotuN4ElbmmRhXY0dzM3Ba9/AjhGbMGbygPl6hOLfkCVHGYeyVo0OeXeUHuz109W2xDWoz0Ce+4
	yCUqwGbij+jE1odtXShWqGCSg7SqmW81FN1lJZtDOGVcZb3KOiBOM=
X-Received: by 2002:a17:90a:17c7:b0:2a5:decc:47e5 with SMTP id q65-20020a17090a17c700b002a5decc47e5mr11434299pja.38.1713234388146;
        Mon, 15 Apr 2024 19:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF08XscsZav7BTxrzgVzOHXGCS3SQkfOg3RqQ12DdILoawqeD6IPTc5/V3eGo/Ed5WtKxNOeZ+P8fKF2oXIkMY=
X-Received: by 2002:a17:90a:17c7:b0:2a5:decc:47e5 with SMTP id
 q65-20020a17090a17c700b002a5decc47e5mr11434294pja.38.1713234387825; Mon, 15
 Apr 2024 19:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
 <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk> <Zh3TjqD1763LzXUj@fedora>
In-Reply-To: <Zh3TjqD1763LzXUj@fedora>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 16 Apr 2024 10:26:16 +0800
Message-ID: <CAGVVp+X81FhOHH0E3BwcsVBYsAAOoAPXpTX5D_BbRH4jqjeTJg@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at io_uring/io_uring.c:2835 io_ring_exit_work+0x2b6/0x2e0
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >
> > I can't reproduce this here, fwiw. Ming, something you've seen?
>
> I just test against the latest for-next/block(-rc4 based), and still can'=
t
> reproduce it. There was such RH internal report before, and maybe not
> ublk related.
>
> Changhui, if the issue can be reproduced in your machine, care to share
> your machine for me to investigate a bit?
>
> Thanks,
> Ming
>

I still can reproduce this issue on my machine=EF=BC=8C
and I shared machine to Ming=EF=BC=8Che can do more investigation for this =
issue=EF=BC=8C

[ 1244.207092] running generic/006
[ 1246.456896] blk_print_req_error: 77 callbacks suppressed
[ 1246.456907] I/O error, dev ublkb1, sector 2395864 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1246.465887] I/O error, dev ublkb1, sector 2551168 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1246.473176] I/O error, dev ublkb1, sector 2395928 op 0x1:(WRITE)
flags 0x8800 phys_seg 4 prio class 0
[ 1246.473185] I/O error, dev ublkb1, sector 2395888 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1246.483487] I/O error, dev ublkb1, sector 2550936 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1246.493775] I/O error, dev ublkb1, sector 2395984 op 0x1:(WRITE)
flags 0x8800 phys_seg 3 prio class 0
[ 1246.493778] I/O error, dev ublkb1, sector 2395960 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1246.504071] I/O error, dev ublkb1, sector 2221344 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1246.514367] I/O error, dev ublkb1, sector 2408312 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1246.524665] I/O error, dev ublkb1, sector 2223680 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1258.012089] blk_print_req_error: 214 callbacks suppressed
[ 1258.012097] I/O error, dev ublkb1, sector 2191768 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[ 1258.019007] I/O error, dev ublkb1, sector 2123752 op 0x0:(READ)
flags 0x0 phys_seg 5 prio class 0
[ 1258.028079] I/O error, dev ublkb1, sector 2195728 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1258.037993] I/O error, dev ublkb1, sector 2127424 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1258.048276] I/O error, dev ublkb1, sector 2191920 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[ 1258.058567] I/O error, dev ublkb1, sector 2127384 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1258.068467] I/O error, dev ublkb1, sector 2200624 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1258.078763] I/O error, dev ublkb1, sector 2127656 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1258.089058] I/O error, dev ublkb1, sector 2195360 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1258.089061] I/O error, dev ublkb1, sector 2191784 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1269.576153] blk_print_req_error: 237 callbacks suppressed
[ 1269.576161] I/O error, dev ublkb1, sector 2061112 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[ 1269.592138] I/O error, dev ublkb1, sector 2177016 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1269.602051] I/O error, dev ublkb1, sector 2184568 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1269.612347] I/O error, dev ublkb1, sector 2061304 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[ 1269.622258] I/O error, dev ublkb1, sector 2059360 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1269.632556] I/O error, dev ublkb1, sector 2061320 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1269.642466] I/O error, dev ublkb1, sector 2059080 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1269.652763] I/O error, dev ublkb1, sector 2061128 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1269.662672] I/O error, dev ublkb1, sector 2059112 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1269.672969] I/O error, dev ublkb1, sector 2061136 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1299.615464] blk_print_req_error: 74 callbacks suppressed
[ 1299.615472] I/O error, dev ublkb1, sector 2023992 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1299.631730] I/O error, dev ublkb1, sector 2387840 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1299.641647] I/O error, dev ublkb1, sector 2017904 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[ 1299.651551] I/O error, dev ublkb1, sector 2386584 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1299.661852] I/O error, dev ublkb1, sector 2017872 op 0x0:(READ)
flags 0x0 phys_seg 3 prio class 0
[ 1299.671769] I/O error, dev ublkb1, sector 2387944 op 0x0:(READ)
flags 0x0 phys_seg 3 prio class 0
[ 1299.681689] I/O error, dev ublkb1, sector 2386672 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1299.691991] I/O error, dev ublkb1, sector 2023968 op 0x1:(WRITE)
flags 0x8800 phys_seg 3 prio class 0
[ 1299.702289] I/O error, dev ublkb1, sector 2386864 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1299.712586] I/O error, dev ublkb1, sector 2018072 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[ 1310.309570] blk_print_req_error: 118 callbacks suppressed
[ 1310.309579] I/O error, dev ublkb1, sector 1939168 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[ 1310.310554] I/O error, dev ublkb1, sector 2575992 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1310.315649] I/O error, dev ublkb1, sector 1939704 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1310.325550] I/O error, dev ublkb1, sector 2582152 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1310.335456] I/O error, dev ublkb1, sector 1939776 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1310.345751] I/O error, dev ublkb1, sector 2576008 op 0x0:(READ)
flags 0x0 phys_seg 4 prio class 0
[ 1310.356048] I/O error, dev ublkb1, sector 1939456 op 0x1:(WRITE)
flags 0x8800 phys_seg 2 prio class 0
[ 1310.356051] I/O error, dev ublkb1, sector 1939424 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1310.356054] I/O error, dev ublkb1, sector 1939272 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[ 1310.356057] I/O error, dev ublkb1, sector 1939440 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[ 1321.569744] ------------[ cut here ]------------
[ 1321.574931] WARNING: CPU: 15 PID: 679 at io_uring/io_uring.c:2835
io_ring_exit_work+0x2b6/0x2e0
[ 1321.584673] Modules linked in: ext4 mbcache jbd2 rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common i10nm_edac nfit libnvdimm
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif
rapl intel_cstate mgag200 i2c_algo_bit dax_hmem iTCO_wdt cxl_acpi
drm_shmem_helper iTCO_vendor_support cxl_core mei_me drm_kms_helper
ioatdma i2c_i801 isst_if_mmio intel_uncore isst_if_mbox_pci mei einj
isst_if_common pcspkr intel_pch_thermal i2c_smbus intel_vsec ipmi_si
dca ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad drm fuse
xfs libcrc32c sd_mod t10_pi sg crct10dif_pclmul crc32_pclmul
crc32c_intel ahci libahci libata tg3 ghash_clmulni_intel wmi dm_mirror
dm_region_hash dm_log dm_mod
[ 1321.665566] CPU: 15 PID: 679 Comm: kworker/u96:9 Not tainted 6.9.0-rc3+ =
#1
[ 1321.673251] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE120G-1.40 09/20/2022
[ 1321.682970] Workqueue: iou_exit io_ring_exit_work
[ 1321.688235] RIP: 0010:io_ring_exit_work+0x2b6/0x2e0
[ 1321.693689] Code: 89 e7 e8 6d de ff ff 48 8b 44 24 58 65 48 2b 04
25 28 00 00 00 75 2e 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc
cc cc cc <0f> 0b 41 be 60 ea 00 00 e9 45 fe ff ff 0f 0b e9 1d ff ff ff
e8 c1
[ 1321.714654] RSP: 0018:ff37e1e101257dd0 EFLAGS: 00010293
[ 1321.720494] RAX: 00000001000f97d6 RBX: ff3771afdd8bec48 RCX: 00000000000=
00000
[ 1321.728468] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff3771afdd8=
be840
[ 1321.736437] RBP: ff37e1e101257e60 R08: 0000000000000000 R09: ffffffffa6c=
54ca0
[ 1321.744406] R10: 0000000000000000 R11: 0000000000000000 R12: ff3771afdd8=
be800
[ 1321.752376] R13: ff3771afdd8be840 R14: 0000000000000032 R15: 00000000000=
00000
[ 1321.760354] FS:  0000000000000000(0000) GS:ff3771b2efb80000(0000)
knlGS:0000000000000000
[ 1321.769396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1321.775808] CR2: 00007f5334002088 CR3: 00000003ba220001 CR4: 00000000007=
71ef0
[ 1321.783783] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1321.791757] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1321.799733] PKRU: 55555554
[ 1321.802760] Call Trace:
[ 1321.805498]  <TASK>
[ 1321.807847]  ? __warn+0x7f/0x130
[ 1321.811460]  ? io_ring_exit_work+0x2b6/0x2e0
[ 1321.816238]  ? report_bug+0x18a/0x1a0
[ 1321.820340]  ? handle_bug+0x3c/0x70
[ 1321.824247]  ? exc_invalid_op+0x14/0x70
[ 1321.828537]  ? asm_exc_invalid_op+0x16/0x20
[ 1321.833222]  ? io_ring_exit_work+0x2b6/0x2e0
[ 1321.837998]  ? finish_task_switch.isra.0+0x8e/0x2a0
[ 1321.843457]  process_one_work+0x193/0x3d0
[ 1321.847945]  worker_thread+0x2fc/0x410
[ 1321.852140]  ? __pfx_worker_thread+0x10/0x10
[ 1321.856907]  kthread+0xdc/0x110
[ 1321.860421]  ? __pfx_kthread+0x10/0x10
[ 1321.864617]  ret_from_fork+0x2d/0x50
[ 1321.868622]  ? __pfx_kthread+0x10/0x10
[ 1321.872812]  ret_from_fork_asm+0x1a/0x30
[ 1321.877208]  </TASK>
[ 1321.879655] ---[ end trace 0000000000000000 ]---

