Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EB2A1C9
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669986; cv=none; b=YLlerC+/mp/CUEfgnzwGgnkkrksg8SKAKzx6Vp+nEQciEcE1M0nhpQYyjHFCV+WsPb8/QZyIPPJVaNZp0TH/Z/aBPSy/HZyIDl3QHk6cXHNDwIYoOHq62SwTmrYzinQWqrx+s1TlAepJVAy9LVnL2b5dC4/3UK0ciWsuzrgyTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669986; c=relaxed/simple;
	bh=rqHO41EKYR78sYMFKSZ6MZnCmCDTrVi8b8mmw4mc0Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTRGYg+ANpr3JTXQsAJ5ogbil57wykmuRYOjnxm0/szI9aH1kaHtkIaFYBgbQMUQV3qCV8KW4sSnHyupxhDl/BlFjxCBGJYA2X5Zxqnc24jERkRLGXDYD1fMpuhW96hd+ilrASbNC4g3b57qDSUNDPbN9OaWwmWcjZqZ67WGLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgKsQwbN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgKsQwbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750669982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qL/kYN9yS4SBObrVY/PJDSjnopSDf8e6qrAUZBDY33w=;
	b=SgKsQwbNK7LlvQao2wQ374tOGpBS6Oum5IrizqZZxiZDyFCBR4uVDwEBNC5gufEBQHWzSW
	SmW8PBPKRm3gRwRip/08WSglORkRIedsgbGbaBlSYUWdFKU8fnz7GFGROAyFIdmQzcA90l
	NEz/YmngUtVw+gpxDAc+mTlt09Yzn48=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-zctD3C06O_mlJ-fbxI8lqg-1; Mon, 23 Jun 2025 05:13:00 -0400
X-MC-Unique: zctD3C06O_mlJ-fbxI8lqg-1
X-Mimecast-MFC-AGG-ID: zctD3C06O_mlJ-fbxI8lqg_1750669979
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311d670ad35so3696260a91.3
        for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 02:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669979; x=1751274779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qL/kYN9yS4SBObrVY/PJDSjnopSDf8e6qrAUZBDY33w=;
        b=hLttuVNK5mI740Wj0XTYmZAAPwdMVYujgwZEUYqb6i3zHaMiTbxQ7NC0vh2wupoZTQ
         HEPJ8MC2EQlpr18N3sCEGGRis++huqC/yhs/NgLKzIAXj3DrvkylXxve+YzVb21cxeyD
         wyT6jIgx811wkxC+KQqoIdl6WlpuB1orEnZVvVcurCXBCI0FvivSnvcO4OXD++3j/wT6
         19Lhj3qxjCs4lImsu0ULbhtY6UiP7uOXnDZpNryuxeLOEvlVmxQH/dCSPcRpF44ShGyL
         /nPA+QI3XSKliwUht+hQAe078yiB1O/F6VJt1AxPuksgQYlxztjmNIcFy7s5g9IZHJNH
         RrTw==
X-Gm-Message-State: AOJu0YyODWdN80rzXlNKLSludGM272U7JVuzSfLX9sdpUGVyJih/yyiA
	PYB3QmnG6dXLQQRYovS84vECNe5lvTr5bdQam0guczj5PYSBre5XYJ0UaKkLhXChvOy2j9b6Hjo
	rFJjsxJRNZll30sZVIV69kfntReAIZEMxBYrFw7cl3Wk7WVwpQNErZoQnPJas1EAkkE+4+0HwaT
	MRMFm0nJM/s5ISId7txvaHgeo+5R7pL4C3H1HOVrXKiiOxIksBZg==
X-Gm-Gg: ASbGncss0BZ97/W6ZPGIBeazoE0sU++6gY2jswoMk/1K9mMnMLY+taIOQwoZmiU+gMk
	jgevHpITh3HIQ2lK1J/rsa/P2GR1DwW106IxeN2n9m9Oqm078+zFt6mjxrP1Q0GlytUUsZbxRRt
	l3Qgva
X-Received: by 2002:a17:90b:5546:b0:311:c1ec:7cfb with SMTP id 98e67ed59e1d1-3159d8c7d18mr17099115a91.21.1750669978629;
        Mon, 23 Jun 2025 02:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSBVlgy9IpIdRixGRUBXM3EFAWu5c1RJJND/TpMZq21Yvb7sItH+FXMvGc95upO67sJbNj5R8v++sjvH7w4Cw=
X-Received: by 2002:a17:90b:5546:b0:311:c1ec:7cfb with SMTP id
 98e67ed59e1d1-3159d8c7d18mr17099081a91.21.1750669978183; Mon, 23 Jun 2025
 02:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com>
 <aFjR1M2RwGn8y9Rs@fedora>
In-Reply-To: <aFjR1M2RwGn8y9Rs@fedora>
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 23 Jun 2025 17:12:46 +0800
X-Gm-Features: Ac12FXy05DSsNigC_IDKNHnZD3jXQUPQ6p1wOGZiy6TlLIpw0cEE5ZAYnVOHtE0
Message-ID: <CAGVVp+V-X6vEz1sbvenTBeXJa_8OZTaV3MwPOhhR5aOjmWm50Q@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000001
To: Ming Lei <ming.lei@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Hi Changhui,
>
> On Mon, Jun 23, 2025 at 10:58:24AM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > the following kernel panic was triggered by ubdsrv  generic/002,
> > please help check and let me know if you need any info/test, thanks.
> >
> > commit HEAD:
> >
> > commit 2589cd05008205ee29f5f66f24a684732ee2e3a3
> > Merge: 98d0347fe8fb e1c75831f682
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Wed Jun 18 05:11:50 2025 -0600
> >
> >     Merge branch 'io_uring-6.16' into for-next
> >
> >     * io_uring-6.16:
> >       io_uring: fix potential page leak in io_sqe_buffer_register()
> >       io_uring/sqpoll: don't put task_struct on tctx setup failure
> >       io_uring: remove duplicate io_uring_alloc_task_context() definiti=
on
>
> The above branch has been merged to v6.16-rc3, can you reproduce it with =
-rc3?
>
> I tried to duplicate in my test VM, not succeed with -rc3.
>
> ...
>
> > [ 7044.064528] BUG: kernel NULL pointer dereference, address: 000000000=
0000001
> > [ 7044.071507] #PF: supervisor read access in kernel mode
> > [ 7044.076653] #PF: error_code(0x0000) - not-present page
> > [ 7044.081801] PGD 462c42067 P4D 462c42067 PUD 462c43067 PMD 0
> > [ 7044.087488] Oops: Oops: 0000 [#1] SMP NOPTI
> > [ 7044.091685] CPU: 13 UID: 0 PID: 367 Comm: kworker/13:1H Not tainted
> > 6.16.0-rc2+ #1 PREEMPT(voluntary)
> > [ 7044.100991] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> > 2.22.2 09/12/2024
> > [ 7044.108565] Workqueue: kblockd blk_mq_requeue_work
> > [ 7044.113374] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
>
> Can you share where the above line points to source line if it can be
> reproduced in -rc3?
>
> gdb> l *(__io_req_task_work_add+0x18)
>
>
> Thanks,
> Ming
>

now successfully reproduced on v6.16-rc3, more loop tests are needed
to trigger this issue=EF=BC=8C

[ 8898.102836] BUG: kernel NULL pointer dereference, address: 0000000000000=
001
[ 8898.109848] #PF: supervisor read access in kernel mode
[ 8898.115011] #PF: error_code(0x0000) - not-present page
[ 8898.120161] PGD 80000001bcd7b067 P4D 80000001bcd7b067 PUD 1ee49f067 PMD =
0
[ 8898.127043] Oops: Oops: 0000 [#1] SMP PTI
[ 8898.131065] CPU: 2 UID: 0 PID: 47056 Comm: kworker/2:2H Not tainted
6.16.0-rc3 #1 PREEMPT(voluntary)
[ 8898.140283] Hardware name: Dell Inc. PowerEdge R340/045M96, BIOS
2.17.3 09/12/2024
[ 8898.147860] Workqueue: kblockd blk_mq_requeue_work
[ 8898.152658] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
[ 8898.157895] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 66 0f 1f 00 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 6f 60
48 89 fb <f6> 45 01 20 0f 84 8e 00 00 00 31 c0 f6 47 48 0c 0f 94 c0 21
c6 41
[ 8898.176650] RSP: 0018:ffffd28e08d03c50 EFLAGS: 00010206
[ 8898.181882] RAX: ffffffffc0dc73d0 RBX: ffff8d64218c35c0 RCX: ffff8d676ee=
1e828
[ 8898.189025] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8d64218=
c35c0
[ 8898.196165] RBP: 0000000000000000 R08: 0000000000010000 R09: ffff8d6402d=
42600
[ 8898.203308] R10: ffff8d6400c1d8c0 R11: fefefefefefefeff R12: ffff8d64218=
c35c0
[ 8898.210448] R13: ffffd28e08d03cc8 R14: 0000000000000000 R15: ffff8d64209=
01310
[ 8898.217592] FS:  0000000000000000(0000) GS:ffff8d67cd7c5000(0000)
knlGS:0000000000000000
[ 8898.225685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8898.231441] CR2: 0000000000000001 CR3: 00000001951b8003 CR4: 00000000003=
726f0
[ 8898.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 8898.245720] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 8898.252876] Call Trace:
[ 8898.255335]  <TASK>
[ 8898.257450]  ublk_queue_rq+0x50/0x90 [ublk_drv]
[ 8898.261989]  blk_mq_dispatch_rq_list+0x13c/0x510
[ 8898.266620]  __blk_mq_sched_dispatch_requests+0x118/0x1a0
[ 8898.272027]  ? xa_find_after+0xfc/0x190
[ 8898.275876]  blk_mq_sched_dispatch_requests+0x2d/0x70
[ 8898.280937]  blk_mq_run_hw_queue+0x26a/0x2e0
[ 8898.285216]  blk_mq_run_hw_queues+0x7f/0x140
[ 8898.289498]  blk_mq_requeue_work+0x19f/0x1e0
[ 8898.293782]  process_one_work+0x188/0x340
[ 8898.297820]  worker_thread+0x257/0x3a0
[ 8898.301578]  ? __pfx_worker_thread+0x10/0x10
[ 8898.305871]  kthread+0xf9/0x240
[ 8898.309022]  ? __pfx_kthread+0x10/0x10
[ 8898.312785]  ? __pfx_kthread+0x10/0x10
[ 8898.316549]  ret_from_fork+0xed/0x110
[ 8898.320220]  ? __pfx_kthread+0x10/0x10
[ 8898.323981]  ret_from_fork_asm+0x1a/0x30
[ 8898.327919]  </TASK>
[ 8898.330118] Modules linked in: ublk_drv rpcsec_gss_krb5 auth_rpcgss
nfsv4 dns_resolver nfs lockd grace nfs_localio netfs sunrpc ipmi_ssif
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common intel_pmc_core_pltdrv intel_pmc_core
pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec
intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel kvm platform_profile dell_wmi dell_smbios iTCO_wdt irqbypass
dell_wmi_descriptor iTCO_vendor_support rapl sparse_keymap rfkill
intel_cstate mgag200 tg3 mei_me dcdbas intel_uncore i2c_algo_bit
pcspkr mei i2c_i801 idma64 i2c_smbus ie31200_edac acpi_power_meter
intel_pch_thermal ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg
fuse loop dm_multipath nfnetlink xfs sd_mod ahci libahci megaraid_sas
libata ghash_clmulni_intel video pinctrl_cannonlake wmi dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: ublk_drv]
[ 8898.409843] CR2: 0000000000000001
[ 8898.413172] ---[ end trace 0000000000000000 ]---
[ 8898.510831] pstore: backend (erst) writing error (-19)
[ 8898.515985] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
[ 8898.521221] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 66 0f 1f 00 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 6f 60
48 89 fb <f6> 45 01 20 0f 84 8e 00 00 00 31 c0 f6 47 48 0c 0f 94 c0 21
c6 41
[ 8898.539975] RSP: 0018:ffffd28e08d03c50 EFLAGS: 00010206
[ 8898.545208] RAX: ffffffffc0dc73d0 RBX: ffff8d64218c35c0 RCX: ffff8d676ee=
1e828
[ 8898.552348] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8d64218=
c35c0
[ 8898.559492] RBP: 0000000000000000 R08: 0000000000010000 R09: ffff8d6402d=
42600
[ 8898.566631] R10: ffff8d6400c1d8c0 R11: fefefefefefefeff R12: ffff8d64218=
c35c0
[ 8898.573775] R13: ffffd28e08d03cc8 R14: 0000000000000000 R15: ffff8d64209=
01310
[ 8898.580913] FS:  0000000000000000(0000) GS:ffff8d67cd7c5000(0000)
knlGS:0000000000000000
[ 8898.589011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8898.594763] CR2: 0000000000000001 CR3: 00000001951b8003 CR4: 00000000003=
726f0
[ 8898.601906] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 8898.609047] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 8898.616191] Kernel panic - not syncing: Fatal exception
[ 8898.621466] Kernel Offset: 0x1dc00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 8898.646077] ---[ end Kernel panic - not syncing: Fatal exception ]---


(gdb) l *(__io_req_task_work_add+0x18)
0xffffffff81907668 is in __io_req_task_work_add (io_uring/io_uring.c:1251).
1246            io_fallback_tw(tctx, false);
1247    }
1248
1249    void __io_req_task_work_add(struct io_kiocb *req, unsigned flags)
1250    {
1251            if (req->ctx->flags & IORING_SETUP_DEFER_TASKRUN)
1252                    io_req_local_work_add(req, flags);
1253            else
1254                    io_req_normal_work_add(req);
1255    }
(gdb)


Thanks,
Changhui

