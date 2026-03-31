Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70502DEA61
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977370; cv=pass; b=eqf+a4J8nHFhIj/SIt1eNAB5KUE9Ia6S0c27aE5hGTRndNECZ9ou3BImM9g3Kdpfb2wSCv5yKEkJE1Y3USmxIodojG3gshhUZmU6XGhSEzhjWs9IElTWVi4VB7T5ObpDghvjy8H7riugvSxi+N9rdFjE2Zs7LpkEm5qoYtufYlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977370; c=relaxed/simple;
	bh=2hNrDiiivNsXbCFSyICzKXOGiizxdY0uFLWx/+ImjGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgz0ESZlijSD47RZHZNAkFwmEyZe+zzyAehm+WlZUQM7gBelP1buXS/RkA/9xNMmbzPZ7Dd7I4a3HOlOIrx6BsTju/VSirp10b9+BFDpKy+4ZPHzP4cRS8FSCt23phs2j0l92YyS9KZV/XrmEHk4s5xSwEfAD1rAjT1P9Bi5JM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gFTIv7vx; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gFTIv7vx"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67bcb30c304so68101eaf.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 10:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977367; cv=none;
        d=google.com; s=arc-20240605;
        b=hK5A9XKTRBBPLIxDy67guBI85/zxhCKvf1rl8NqXn5cvDtUXx89w12lXLJkjeAjhQy
         NOmrOrrsXbtaWHmHE3eZ1iSljklEtgwos6+OfKfHEDlYYFWx9x4T1Nran9cMuvY/N1co
         1DxEGdQL/HYdcRl4Av0e7m1wYX/4RLcjpJNkgeWGfA/RHUl8nBkR6clNIVPhaFM7efOg
         1i9Nh0ItGyVdFQO41JGg0TXI5JM4OfJhLE2IDeQYkpLpPZhyWQt5+K7c5XE6OQQpUq56
         AGYU4FK2UTX7/wXgyCUUA5lAGF/0pWrohAq1z/aMUdJqKELPNrXHGzJXU7wqsHSbZyCK
         JrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sj/0bBLcIlBKueoea/E03O8WLVXBeHCgzW7cLlL+PAQ=;
        fh=L9rjngsSRmXAmAEhMGBy4Ig6yzRKdmNteqEVMaGGh98=;
        b=DvgcqKoVBIEA3yhnGSGlo0M7WZZBCrKCHDsC1+viIybXWafjJRBhV0Alikxk8dhno0
         qKfPxPiHXk6w2Gq5olYKNCo3lnol2R5osHmfRzcqEWkGZ77UcQmiQHX1XwVmRuc54Owz
         Wh/xPp/BADTJavbv6k3hjB+PPJMzPLAiV3tT0xCMhtBYYVZ67OYxul7Tpg9zILp60YR6
         hUEEP9LIsNr+fiV8gYKV/dqzdaO2Us7wyH4MB7cRWUls1sMe4gt04lrhaYpgPeyw64ka
         M074xFf/4HnRxMHejFhIJDNdEcdUruDXNgH8pRdAm/3ds92amsM+ULcas++bWjVfc5WY
         STfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774977367; x=1775582167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj/0bBLcIlBKueoea/E03O8WLVXBeHCgzW7cLlL+PAQ=;
        b=gFTIv7vxNotbHfe/IcePcfAmBh/2jlJEvyTHh8oxoEMmPJsNQJ1/fyAEj0NHIxi7mQ
         Q7oJnhzmxD7mucolBavw0ufJ87IDweZ5mdMT8gHkdIP/4WtjZCI6RKLeGVd6Ild9VkL0
         TQPsoPgOJ58obzNlb3C+jUxSqBpvwHcNi2u5g+2vz3xXYtvdPGcJrGCoKdGOTGqWZB/Y
         C8s0W/yVEgTY3AOVUUOsfQXkjeQAAJCycnRhrZHFNlNfJ6ta+Na1j85nMVORqx7bK6i9
         GN95PfKlK6LZnGmdgyP1yHpk846jPWVeyrDurjRwstRDyvr6CmlbX//zRC4Z9eOnE2v7
         7nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977367; x=1775582167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sj/0bBLcIlBKueoea/E03O8WLVXBeHCgzW7cLlL+PAQ=;
        b=XvpQtWx55gplpx/H/yjhI+JKasgP8o94QJKd7Q5c8vHJO7F7iBW9iPh1rtcaYp8O4D
         C1itIj/L8pLoMXQp9QJbUThkRnEXNM1D0iMYGbhxPRR24NKonTDBiCHr8AjxRBlBCS1i
         IZvJ8zge2sW6xZ1SQPrdgHKF3+oaGKCsUkDEC+vND7SKo3/HpFSzV1CWvnLicbtyJ4EQ
         YNulGHEfyOffrZ7eT6esq5UYjl8nV6kyxSIk0GQFl5h76ViqZZR/OJUKdxZ6wGuS8h/P
         XWBY0Jr4dcfFM2ssXpIGfGS0k3GM4Llu6WBWD5hTj4BYEaJqCw/yYCvydwzQhQlLcDFS
         wPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoUIL31BlCwbyQpLhT9qqF5rlgP+youYQx2NNLi8ud8akezDYWR7yn6xBBrkH5e2mrfMe089zmsQxYIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjl0F/JFWfNkfkAz6v3ovG/pzgTtUCDu0oRMIbcP92vBI+hjBP
	g84MyG7pCRMgcs68jlgTNPPUNSHokZsMU2vhPhw4wWC7k/U4TRgX9+lHrnb0lu4YP2pRYLCeeo4
	47BHhBY1fNeF+R71axFMKg9t3AxLmPi3taboKqsUl6A==
X-Gm-Gg: ATEYQzyhLacg8Lwv6UUavksR006JxBjV8QUvcELzzr+rrzuCX+ExfWht0Vpi4RJVQ5Y
	IKV/kCScjky1sVbYuwU4josk2WOXlng4gE0K1JAkvLLsJJkIPTrBdEdgiyT02IMFPR/VHh+GgdA
	fzGpbAt+QjYhQnN3eMxg/uclM19memb3/C/v7WVHZcqFTsPSCvMNidJkPl1IgqL53JDF0+KhP6P
	xEew9xKcOR1Dbu2wRpAcbBa+Uum2xkTk/7sRhpaBHsbnTkH5kMnIXPsXLhglsJ7FVU+tgE1THTZ
	pQ+3zwk=
X-Received: by 2002:a05:6820:1f83:b0:67e:2dcd:e887 with SMTP id
 006d021491bc7-67fabac0c32mr33408eaf.0.1774977367328; Tue, 31 Mar 2026
 10:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328134258.3206825-1-ming.lei@redhat.com> <CADUfDZo2pbwTsp_uJcTG+GYyBFmoU-5UPYu6dvAguRfgB_QWCA@mail.gmail.com>
 <ack6x5tm2pc4hslL@fedora>
In-Reply-To: <ack6x5tm2pc4hslL@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 31 Mar 2026 10:15:56 -0700
X-Gm-Features: AQROBzBjr3k1tXxg9GwQiSAiVUzF-FFlfyAmyeUNRyPWnlaZ3MqS6xxV0kds35w
Message-ID: <CADUfDZq=5Wf1AiCre7tkXNkBs95nX7v+5irTAx9PbFb3jYZT-w@mail.gmail.com>
Subject: Re: [PATCH] ublk: use unchecked copy helpers for bio page data
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 7:44=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sat, Mar 28, 2026 at 10:40:31AM -0700, Caleb Sander Mateos wrote:
> > On Sat, Mar 28, 2026 at 6:43=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Bio pages may originate from slab caches that lack SLAB_USERCOPY
> >
> > What is SLAB_USERCOPY? The only references to it I can find are in
> > comments in commit aa981a665d587 ("lkdtm: add usercopy tests").
> >
>
> Oops, I should have included the panic log here:

Okay, so maybe the commit message and comment should say the copy
range lies outside the slub usercopy region instead of referring to
the non-existent SLAB_USERCOPY? I'm not that familiar with the
usercopy hardening or jbd2, but the fix looks reasonable.

Best,
Caleb

>
> [   41.604744] usercopy: Kernel memory exposure attempt detected from SLU=
B object 'jbd2_1k' (offset 0, size 1024)!
> [   41.607063] ------------[ cut here ]------------
> [   41.607290] kernel BUG at mm/usercopy.c:102!
> [   41.607502] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [   41.607794] CPU: 0 UID: 0 PID: 2020 Comm: kublk Not tainted 7.0.0-rc3_=
next+ #616 PREEMPT(full)
> [   41.608261] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.17.0-8.fc42 06/10/2025
> [   41.608722] RIP: 0010:usercopy_abort+0x7a/0x7c
> [   41.608995] Code: 48 c7 c6 ab 55 2c 8b eb 0e 48 c7 c7 b0 92 2e 8b 48 c=
7 c6 b9 87 2b 8b 52 48 89 fa 48 c7 c7 30 73 1f 8b 50 41 52 e8 66 25 fe ff <=
0f> 0b 48 89 d9 49 89 e8 44 89 f2 31 f6 48 29 c1 48 c7 c7 00 56 2c
> [   41.609985] RSP: 0018:ffffd3dcca79fae0 EFLAGS: 00010246
> [   41.610286] RAX: 0000000000000063 RBX: ffff8d87ec655000 RCX: 000000000=
0000000
> [   41.610707] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8d87b=
5c1d440
> [   41.611111] RBP: 0000000000000400 R08: 0000000000000000 R09: 00000000f=
ffeffff
> [   41.611556] R10: ffffffff8bc8c040 R11: ffffd3dcca79f968 R12: ffff8d87e=
c655400
> [   41.611913] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8d85c=
400b000
> [   41.612375] FS:  00007f2ef3f066c0(0000) GS:ffff8d8828a82000(0000) knlG=
S:0000000000000000
> [   41.612832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.613186] CR2: 00007f2efc137000 CR3: 000000032c7f2006 CR4: 000000000=
0772ef0
> [   41.613623] PKRU: 55555554
> [   41.613811] Call Trace:
> [   41.613973]  <TASK>
> [   41.614108]  __check_heap_object+0xb8/0xd0
> [   41.614345]  __check_object_size+0x1b8/0x250
> [   41.614639]  ublk_copy_user_bvec.isra.0+0x65/0xf0 [ublk_drv]
> [   41.614981]  ublk_copy_user_pages.isra.0+0xc5/0x130 [ublk_drv]
> [   41.615360]  ublk_start_io+0xff/0x160 [ublk_drv]
> [   41.615669]  ublk_dispatch_req+0x99/0x240 [ublk_drv]
> [   41.615969]  ublk_cmd_list_tw_cb+0x2d/0x40 [ublk_drv]
> [   41.616248]  __io_run_local_work_loop+0x7c/0x80
> [   41.616449]  __io_run_local_work+0x159/0x230
> [   41.616634]  io_run_local_work+0x31/0x50
> [   41.616977]  io_cqring_wait+0x28e/0x680
> [   41.617292]  ? __io_issue_sqe+0x3b/0x1b0
> [   41.617607]  ? __pfx_io_wake_function+0x10/0x10
> [   41.617894]  __do_sys_io_uring_enter+0x601/0x8b0
> [   41.618183]  do_syscall_64+0x11c/0x15d0
> [   41.618443]  ? switch_fpu_return+0x56/0xf0
> [   41.618719]  ? do_syscall_64+0x2d6/0x15d0
> [   41.618994]  ? do_syscall_64+0x11c/0x15d0
> [   41.619262]  ? do_syscall_64+0x11c/0x15d0
> [   41.619525]  ? clear_bhb_loop+0x30/0x80
> [   41.619785]  ? clear_bhb_loop+0x30/0x80
> [   41.620049]  ? clear_bhb_loop+0x30/0x80
> [   41.620302]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   41.620598] RIP: 0033:0x7f2f045876fc
> [   41.620853] Code: 0f b6 c0 48 8b 79 20 8b 3f 83 e7 01 44 0f 45 d0 41 8=
3 ca 01 8b b9 cc 00 00 00 45 31 c0 41 b9 08 00 00 00 b8 aa 01 00 00 0f 05 <=
c3> 0f 1f 00 89 30 eb 9b 0f 1f 40 00 41 f6 c2 04 74 32 44 89 d0 41
> [   41.621710] RSP: 002b:00007f2ef3f05c38 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000001aa
> [   41.622112] RAX: ffffffffffffffda RBX: 00007f2ef3f05cc0 RCX: 00007f2f0=
45876fc
> [   41.622493] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 000000000=
0000000
> [   41.622901] RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000=
0000008
> [   41.623281] R10: 0000000000000011 R11: 0000000000000246 R12: 000000000=
0000002
> [   41.623649] R13: 0000000000000001 R14: 00007f2f0410c558 R15: 000000000=
00a6042
> [   41.624015]  </TASK>
> [   41.624239] Modules linked in: iscsi_tcp libiscsi_tcp libiscsi scsi_tr=
ansport_iscsi target_core_pscsi target_core_file target_core_iblock iscsi_t=
arget_mod target_core_mod isofs nfsd auth_rpcgss nfs_acl lockd grace nfs_lo=
calio sunrpc vfat fat intel_rapl_msr intel_rapl_common kvm_intel kvm ppdev =
virtio_gpu virtio_net parport_pc parport net_failover i2c_i801 rapl i2c_smb=
us failover virtio_dma_buf bochs joydev vfio_pci vfio_pci_core vfio_iommu_t=
ype1 vfio irqbypass ublk_drv configs loop zram nvme uas nvme_core usb_stora=
ge virtio_scsi ghash_clmulni_intel virtio_blk nvme_keyring nvme_auth serio_=
raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse dm_multipath qemu_fw_cfg
> [   41.626838] Dumping ftrace buffer:
> [   41.627085]    (ftrace buffer empty)
> [   41.627354] ---[ end trace 0000000000000000 ]---
>
>
> Thanks,
> Ming
>
