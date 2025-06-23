Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C72609E4
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710841; cv=none; b=AiVOk78CKjUa2NKxkr3YfSfBSlPMPMGm//teG1kMlq20ZBEUzLXLMl9898P+CSM7Mx5sE5LrnLXXj+9BHBzAT5TWPsAl1eigB7YckRJIvJTFZ6ckt6w1/gJbx19e8ugSMGAhUSVuLsb4HOqTBOSGyqWvezzpW4Qlrv+USCb/P5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710841; c=relaxed/simple;
	bh=sX2XIsKw1XDJ1Bu6988F3/kiOpyzfB+eeSCNQM0wE/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lnvh17FZQpf0rRUy9HFM0sE47TQ+AooCC2DdQW7Nk2MstFIbzSzTM9skLwYzOllIawRBpeSKW5Gh9SgRAjnTO0jPyT+NwRfK/ITHo1Cl8qNqNp2HuSIvUhugXWj/eP4KWP0tqRrhaApQnA21GnWpUN+8cy60HPgYOFiJXAQqguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AkcG3c5K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AkcG3c5K"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237d849253fso7257615ad.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750710838; x=1751315638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSWCbpDJOV+b7LW1+MzsVEin7V2eeNVdzForWh+zFVs=;
        b=AkcG3c5KUCYqTKAKlS+3ZpSsD4cRQMhYIe9rqG32fQZpI4nfu1rR4zfQrTvRPK4/h9
         z0NuE8hd/kofpN2/+/y390UMbQmlC0wSk665iBPjQIh1JuFciliZBE2akZOolwwL+V56
         A20zVc/hGZzva1a6Ldb4phn97InmJo1bTugdF05cCYikInD0q7N7mYEL46YqixtEfA1l
         lwtW4xRgi5wY6YfWt5a6jAVEYthTmlAp4sANEGKKOxf550RpVoBfCK07NBNPWcvuzhSV
         n+jdmY93E52dyhkLUn4oR4VeO3bdOQGY3Geek+h+1Et6q0U4UwFwT31ZJR6PFu0mJlMW
         0KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710838; x=1751315638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSWCbpDJOV+b7LW1+MzsVEin7V2eeNVdzForWh+zFVs=;
        b=YwftXje4P/Ywg2njFKXm5v3LpTHCb/7AbUNrNIcLhTXfuNJCUOC2vSmfmcxfqIFgmC
         kbsBiO4q7N9xgpal8nr3LUbii0K1+NgSCNqyj8mzunOaCTW4dwgP2UqUja44W3yKwmzp
         T2i3ufhGRxVXzLHktMN2NYHIcC7+iaTCVdZ1LFvCL5xqQM60JjvMKCqmZt2fodG2JuLP
         ulwIzmhPEvDcNFZuxoI+ehLPl/9uUFyciPcUyeX1v9m8mJQRcz1nSsci0vCprRGBxOT9
         yGdq1V8IrjMye6ZKPqFwZYis49oQMGyA5t84te4zkgHIxGJL6KaUGCb+FMWtwS33Nk0J
         e+/w==
X-Forwarded-Encrypted: i=1; AJvYcCXpmAAICtG8T4+peu2RSRD5t07Kukqj0CYcfWuIW7hi2SOTkdzLplzxd0ejz38Wx0ZbKa+Dnzp8218OjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ttL9z3Q06LotiGNAuT7pGgcyu07M5NMmrfrIByjuAQnSbz5V
	44R6Mr7hz+QIAJZdDGLso5pHKV6f/MJxW8hSYQfL01STjtGmgBG0lEjCsuRAUojB+zj6UtyzteE
	oVC4d9FY3FqrzGK4F9mtUicL2pT6/CY2hVCC0NDe6QAqOAARxeq+OwpE=
X-Gm-Gg: ASbGnctWi59JGF3vDAdNv+hMc2p4CtBDXUk1qh1x3zKcuK2kX1kJ2rjQBh4zSGW6I/6
	4eWi6UUn2zgjLmHqN++1eJ2nB0IaVKRls92qGFdmmEN7B7hspyZrqPBl3skIZffXP9KMZtRuI0a
	svS9olVjVyRjjgBGINF7cVmgu+xJWSPG2MFQaOpLJh4w==
X-Google-Smtp-Source: AGHT+IH8WekRvpTL6LeALjd6jqQN6OGHrIkHDIK2I2ivcM+T0VjkznJbe21It1JvweFmioyarnWhzGkY5bSucQXzqCQ=
X-Received: by 2002:a17:90b:4e8b:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-3159d8d89cemr7221096a91.5.1750710838460; Mon, 23 Jun 2025
 13:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com>
 <aFjR1M2RwGn8y9Rs@fedora> <CAGVVp+V-X6vEz1sbvenTBeXJa_8OZTaV3MwPOhhR5aOjmWm50Q@mail.gmail.com>
In-Reply-To: <CAGVVp+V-X6vEz1sbvenTBeXJa_8OZTaV3MwPOhhR5aOjmWm50Q@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 23 Jun 2025 13:33:44 -0700
X-Gm-Features: AX0GCFtZ657nexxOf4E9Ma7O7_8CcVCkRB9y7i5ihYgm6gzHA2jac_7ENR94T1g
Message-ID: <CADUfDZr9rLCcZ_fO+6kivSesxLV4xj8Efrzp3C0oJ++YNGO-EQ@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000001
To: Changhui Zhong <czhong@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:13=E2=80=AFAM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> On Mon, Jun 23, 2025 at 12:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> w=
rote:
> >
> > Hi Changhui,
> >
> > On Mon, Jun 23, 2025 at 10:58:24AM +0800, Changhui Zhong wrote:
> > > Hello,
> > >
> > > the following kernel panic was triggered by ubdsrv  generic/002,
> > > please help check and let me know if you need any info/test, thanks.
> > >
> > > commit HEAD:
> > >
> > > commit 2589cd05008205ee29f5f66f24a684732ee2e3a3
> > > Merge: 98d0347fe8fb e1c75831f682
> > > Author: Jens Axboe <axboe@kernel.dk>
> > > Date:   Wed Jun 18 05:11:50 2025 -0600
> > >
> > >     Merge branch 'io_uring-6.16' into for-next
> > >
> > >     * io_uring-6.16:
> > >       io_uring: fix potential page leak in io_sqe_buffer_register()
> > >       io_uring/sqpoll: don't put task_struct on tctx setup failure
> > >       io_uring: remove duplicate io_uring_alloc_task_context() defini=
tion
> >
> > The above branch has been merged to v6.16-rc3, can you reproduce it wit=
h -rc3?
> >
> > I tried to duplicate in my test VM, not succeed with -rc3.
> >
> > ...
> >
> > > [ 7044.064528] BUG: kernel NULL pointer dereference, address: 0000000=
000000001
> > > [ 7044.071507] #PF: supervisor read access in kernel mode
> > > [ 7044.076653] #PF: error_code(0x0000) - not-present page
> > > [ 7044.081801] PGD 462c42067 P4D 462c42067 PUD 462c43067 PMD 0
> > > [ 7044.087488] Oops: Oops: 0000 [#1] SMP NOPTI
> > > [ 7044.091685] CPU: 13 UID: 0 PID: 367 Comm: kworker/13:1H Not tainte=
d
> > > 6.16.0-rc2+ #1 PREEMPT(voluntary)
> > > [ 7044.100991] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> > > 2.22.2 09/12/2024
> > > [ 7044.108565] Workqueue: kblockd blk_mq_requeue_work
> > > [ 7044.113374] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
> >
> > Can you share where the above line points to source line if it can be
> > reproduced in -rc3?
> >
> > gdb> l *(__io_req_task_work_add+0x18)
> >
> >
> > Thanks,
> > Ming
> >
>
> now successfully reproduced on v6.16-rc3, more loop tests are needed
> to trigger this issue=EF=BC=8C
>
> [ 8898.102836] BUG: kernel NULL pointer dereference, address: 00000000000=
00001
> [ 8898.109848] #PF: supervisor read access in kernel mode
> [ 8898.115011] #PF: error_code(0x0000) - not-present page
> [ 8898.120161] PGD 80000001bcd7b067 P4D 80000001bcd7b067 PUD 1ee49f067 PM=
D 0
> [ 8898.127043] Oops: Oops: 0000 [#1] SMP PTI
> [ 8898.131065] CPU: 2 UID: 0 PID: 47056 Comm: kworker/2:2H Not tainted
> 6.16.0-rc3 #1 PREEMPT(voluntary)
> [ 8898.140283] Hardware name: Dell Inc. PowerEdge R340/045M96, BIOS
> 2.17.3 09/12/2024
> [ 8898.147860] Workqueue: kblockd blk_mq_requeue_work
> [ 8898.152658] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
> [ 8898.157895] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 66 0f 1f 00 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 6f 60
> 48 89 fb <f6> 45 01 20 0f 84 8e 00 00 00 31 c0 f6 47 48 0c 0f 94 c0 21
> c6 41

Disassembling this:
0:  41 56                   push   r14
2:  41 55                   push   r13
4:  41 54                   push   r12
6:  55                      push   rbp
7:  53                      push   rbx
8:  48 8b 6f 60             mov    rbp,QWORD PTR [rdi+0x60]
c:  48 89 fb                mov    rbx,rdi
f:  f6 45 01 20             test   BYTE PTR [rbp+0x1],0x20 <--here
13: 0f 84 8e 00 00 00       je     0xa7
19: 31 c0                   xor    eax,eax
1b: f6 47 48 0c             test   BYTE PTR [rdi+0x48],0xc
1f: 0f 94 c0                sete   al
22: 21 c6                   and    esi,eax

So we look to be at the start of __io_req_task_work_add(). rdi stores
req, rbp stores req->ctx, and so the test instruction that's faulting
is loading (the second byte of) req->ctx->flags for the
req->ctx->flags & IORING_SETUP_DEFER_TASKRUN check. This means
req->ctx is NULL. Is it possible the req has already been completed or
cancelled? The stacktrace shows that this is coming from
blk_mq_requeue_work, which is definitely interesting.

Best,
Caleb

> [ 8898.176650] RSP: 0018:ffffd28e08d03c50 EFLAGS: 00010206
> [ 8898.181882] RAX: ffffffffc0dc73d0 RBX: ffff8d64218c35c0 RCX: ffff8d676=
ee1e828
> [ 8898.189025] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8d642=
18c35c0
> [ 8898.196165] RBP: 0000000000000000 R08: 0000000000010000 R09: ffff8d640=
2d42600
> [ 8898.203308] R10: ffff8d6400c1d8c0 R11: fefefefefefefeff R12: ffff8d642=
18c35c0
> [ 8898.210448] R13: ffffd28e08d03cc8 R14: 0000000000000000 R15: ffff8d642=
0901310
> [ 8898.217592] FS:  0000000000000000(0000) GS:ffff8d67cd7c5000(0000)
> knlGS:0000000000000000
> [ 8898.225685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8898.231441] CR2: 0000000000000001 CR3: 00000001951b8003 CR4: 000000000=
03726f0
> [ 8898.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 8898.245720] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 8898.252876] Call Trace:
> [ 8898.255335]  <TASK>
> [ 8898.257450]  ublk_queue_rq+0x50/0x90 [ublk_drv]
> [ 8898.261989]  blk_mq_dispatch_rq_list+0x13c/0x510
> [ 8898.266620]  __blk_mq_sched_dispatch_requests+0x118/0x1a0
> [ 8898.272027]  ? xa_find_after+0xfc/0x190
> [ 8898.275876]  blk_mq_sched_dispatch_requests+0x2d/0x70
> [ 8898.280937]  blk_mq_run_hw_queue+0x26a/0x2e0
> [ 8898.285216]  blk_mq_run_hw_queues+0x7f/0x140
> [ 8898.289498]  blk_mq_requeue_work+0x19f/0x1e0
> [ 8898.293782]  process_one_work+0x188/0x340
> [ 8898.297820]  worker_thread+0x257/0x3a0
> [ 8898.301578]  ? __pfx_worker_thread+0x10/0x10
> [ 8898.305871]  kthread+0xf9/0x240
> [ 8898.309022]  ? __pfx_kthread+0x10/0x10
> [ 8898.312785]  ? __pfx_kthread+0x10/0x10
> [ 8898.316549]  ret_from_fork+0xed/0x110
> [ 8898.320220]  ? __pfx_kthread+0x10/0x10
> [ 8898.323981]  ret_from_fork_asm+0x1a/0x30
> [ 8898.327919]  </TASK>
> [ 8898.330118] Modules linked in: ublk_drv rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver nfs lockd grace nfs_localio netfs sunrpc ipmi_ssif
> intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common intel_pmc_core_pltdrv intel_pmc_core
> pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec
> intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp coretemp
> kvm_intel kvm platform_profile dell_wmi dell_smbios iTCO_wdt irqbypass
> dell_wmi_descriptor iTCO_vendor_support rapl sparse_keymap rfkill
> intel_cstate mgag200 tg3 mei_me dcdbas intel_uncore i2c_algo_bit
> pcspkr mei i2c_i801 idma64 i2c_smbus ie31200_edac acpi_power_meter
> intel_pch_thermal ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg
> fuse loop dm_multipath nfnetlink xfs sd_mod ahci libahci megaraid_sas
> libata ghash_clmulni_intel video pinctrl_cannonlake wmi dm_mirror
> dm_region_hash dm_log dm_mod [last unloaded: ublk_drv]
> [ 8898.409843] CR2: 0000000000000001
> [ 8898.413172] ---[ end trace 0000000000000000 ]---
> [ 8898.510831] pstore: backend (erst) writing error (-19)
> [ 8898.515985] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
> [ 8898.521221] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 66 0f 1f 00 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 6f 60
> 48 89 fb <f6> 45 01 20 0f 84 8e 00 00 00 31 c0 f6 47 48 0c 0f 94 c0 21
> c6 41
> [ 8898.539975] RSP: 0018:ffffd28e08d03c50 EFLAGS: 00010206
> [ 8898.545208] RAX: ffffffffc0dc73d0 RBX: ffff8d64218c35c0 RCX: ffff8d676=
ee1e828
> [ 8898.552348] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8d642=
18c35c0
> [ 8898.559492] RBP: 0000000000000000 R08: 0000000000010000 R09: ffff8d640=
2d42600
> [ 8898.566631] R10: ffff8d6400c1d8c0 R11: fefefefefefefeff R12: ffff8d642=
18c35c0
> [ 8898.573775] R13: ffffd28e08d03cc8 R14: 0000000000000000 R15: ffff8d642=
0901310
> [ 8898.580913] FS:  0000000000000000(0000) GS:ffff8d67cd7c5000(0000)
> knlGS:0000000000000000
> [ 8898.589011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8898.594763] CR2: 0000000000000001 CR3: 00000001951b8003 CR4: 000000000=
03726f0
> [ 8898.601906] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 8898.609047] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 8898.616191] Kernel panic - not syncing: Fatal exception
> [ 8898.621466] Kernel Offset: 0x1dc00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 8898.646077] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
>
> (gdb) l *(__io_req_task_work_add+0x18)
> 0xffffffff81907668 is in __io_req_task_work_add (io_uring/io_uring.c:1251=
).
> 1246            io_fallback_tw(tctx, false);
> 1247    }
> 1248
> 1249    void __io_req_task_work_add(struct io_kiocb *req, unsigned flags)
> 1250    {
> 1251            if (req->ctx->flags & IORING_SETUP_DEFER_TASKRUN)
> 1252                    io_req_local_work_add(req, flags);
> 1253            else
> 1254                    io_req_normal_work_add(req);
> 1255    }
> (gdb)
>
>
> Thanks,
> Changhui
>
>
