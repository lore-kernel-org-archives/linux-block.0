Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04F1C27
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572053; cv=none; b=R7Wu8mfJdjwe+vsAiQECPcFJ7drIYsbA9Zp1tWh4ZNVLAg4xSDvBLwGw9mK+D8FseZwo+sMg1P8nrAZqltHTurIL9/MTq5NslfXk1h1Sz5N53/YsFeikid1vnr8Q34OghxQ226KTP81QJWCdoZfokNRKILyIaWw29maXZH6WPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572053; c=relaxed/simple;
	bh=W/BWlqIjzIWJtdDuuoWdKbdI5xQZHy4ofGL+a9e1FdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWnievqk/NK7qwAJ77L4fJwubRdxYbsLeYuWap+vYkCp98PjrmtoB0NB44aOJwpoBQGDB0Uwxo+T/+biRew5Ypt5Erap49MGa3Ae48mNbf6+Cyxgfgv47iYmdO0ONhefJSjv1JIPhs+vI8+SOjAIGa2//lJOEibFVkeCuVn65QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ogx1pi5Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ogx1pi5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717572049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1OiLZwvrLhI65a/ZS1P0zf6w9nhBoENbO3UVYg39Pg=;
	b=Ogx1pi5Y+fLA9V1IMa0v3XAmZHnVVBrhp/gXVR3n2JlS2STzOV0Kk3mZeWZGkU0A41XS19
	J5C3YlCF3/m78IiwaE6c/4IWHoKpsKyD4QsGk4mXF93mnOTWgghEtM6kKdyAsVGpknqavQ
	0X+v7gwn5Y6/tusDPHgNc/uO/iW1Ly0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-23_7G42dNKK-iVKbhsUL4g-1; Wed, 05 Jun 2024 03:20:47 -0400
X-MC-Unique: 23_7G42dNKK-iVKbhsUL4g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1e6fc4122so1922469a91.0
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2024 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717572046; x=1718176846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1OiLZwvrLhI65a/ZS1P0zf6w9nhBoENbO3UVYg39Pg=;
        b=jb5kDX7dlQTSQNV9w/0oGhUNexKwJ3K2HF/1ITTxxv//wIiC6Xxzi3jYcZ2VXVSPyX
         N+swEoKmmPE9auBUO/VWYsP0rKR9BZZchrkkBe+i8EhKwk2V5hcFZ98ah9qreeGNTZPo
         QTGzatvgF53FG1bijOiblKuCEB8FmjKYKZQvuiComHP1y0sirxFbqLvM1kU9gainq7KF
         pX84VAuWlXq+SFjxp040KM2221En+XGGspm0xfKcdHJDXJR1kyJ6qKkNXIZ0crUFxx63
         QbxDRZwFTDIlnvNRjozXsxOQg2vDl1+lMdpecgrixvZwCUuD2+qhaQGjMcK5VU5szWZo
         ni3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKiEwp+gZubVuxZv6BnvYI/HLzCiI7ZzfkC3665EhTwp5AJ7jLNmBYc89CcpUlnXDkuni8XepsjqA8NSK6RV3lPeW3q06JNCXrwu8=
X-Gm-Message-State: AOJu0YwGKZ/17bQynFd6SXyXw3gBIQwdlhU2tp6ABUI6xOgw7tq1c0t+
	rPfpN1wiC7yCicYLCyg+sWUoZjGvRX7apwfHU/DVb+dXVOZb/SpUaPBxCfspnBJSCmD7POuFsD3
	wqdgUsprWzinKZzUtYydfxoe6EFAkJxXSAHdUDQ4I/sAO1c25onkmAvoUhGDQW2/jSlNNetNHDl
	OHVCFxX/nkHe810CLZgP+fOUbJBCPvGuTO15M=
X-Received: by 2002:a17:90b:318:b0:2c2:7dd5:eb3c with SMTP id 98e67ed59e1d1-2c27dd5eb3emr1646485a91.44.1717572046385;
        Wed, 05 Jun 2024 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj9koHi0lnKIXYgbG7cvbgkc5/lsD8IvM3U96eXfXTstwiqgbPW6s0iyzaoyH0zhafWMiKhhX/EG/myKPiaY4=
X-Received: by 2002:a17:90b:318:b0:2c2:7dd5:eb3c with SMTP id
 98e67ed59e1d1-2c27dd5eb3emr1646465a91.44.1717572045907; Wed, 05 Jun 2024
 00:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora> <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com> <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
In-Reply-To: <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 5 Jun 2024 15:20:34 +0800
Message-ID: <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
To: Li Nan <linan666@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, ZiyangZhang@linux.alibaba.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:41=E2=80=AFAM Li Nan <linan666@huaweicloud.com> wr=
ote:
>
>
>
> =E5=9C=A8 2024/6/4 9:32, Changhui Zhong =E5=86=99=E9=81=93:
> > On Mon, Jun 3, 2024 at 10:20=E2=80=AFAM Li Nan <linan666@huaweicloud.co=
m> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/6/3 8:39, Ming Lei =E5=86=99=E9=81=93:
> >>
> >> [...]
> >>
> >>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>>> index 4e159948c912..99b621b2d40f 100644
> >>>> --- a/drivers/block/ublk_drv.c
> >>>> +++ b/drivers/block/ublk_drv.c
> >>>> @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_devi=
ce *ub, struct ublk_queue *ubq)
> >>>>    {
> >>>>       int i;
> >>>>
> >>>> -    WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> >>>> +    if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))=
))
> >>>> +            return;
> >>>
> >>> Yeah, it is one bug. However, it could be addressed by adding the che=
ck in
> >>> ublk_ctrl_start_recovery() and return immediately in case of NULL ubq=
->ubq_daemon,
> >>> what do you think about this way?
> >>>
> >>
> >> Check ub->nr_queues_ready seems better. How about:
> >>
> >> @@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct
> >> ublk_device *ub,
> >>           mutex_lock(&ub->mutex);
> >>           if (!ublk_can_use_recovery(ub))
> >>                   goto out_unlock;
> >> +       if (!ub->nr_queues_ready)
> >> +               goto out_unlock;
> >>           /*
> >>            * START_RECOVERY is only allowd after:
> >>            *
> >>
> >>>
> >>> Thanks,
> >>> Ming
> >>
> >> --
> >> Thanks,
> >> Nan
> >>
> >
> >
> > Hi,Nan
> >
> > After applying your new patch, I did not trigger "NULL pointer
> > dereference" and "Warning",
> > but hit task hung "Call Trace" info, please check
> >
> > [13617.812306] running generic/004
> > [13622.293674] blk_print_req_error: 91 callbacks suppressed
> > [13622.293681] I/O error, dev ublkb4, sector 233256 op 0x1:(WRITE)
> > flags 0x8800 phys_seg 1 prio class 0
> > [13622.308145] I/O error, dev ublkb4, sector 233256 op 0x0:(READ)
> > flags 0x0 phys_seg 2 prio class 0
> > [13622.316923] I/O error, dev ublkb4, sector 233264 op 0x1:(WRITE)
> > flags 0x8800 phys_seg 1 prio class 0
> > [13622.326048] I/O error, dev ublkb4, sector 233272 op 0x0:(READ)
> > flags 0x0 phys_seg 1 prio class 0
> > [13622.334828] I/O error, dev ublkb4, sector 233272 op 0x1:(WRITE)
> > flags 0x8800 phys_seg 1 prio class 0
> > [13622.343954] I/O error, dev ublkb4, sector 233312 op 0x0:(READ)
> > flags 0x0 phys_seg 1 prio class 0
> > [13622.352733] I/O error, dev ublkb4, sector 233008 op 0x0:(READ)
> > flags 0x0 phys_seg 1 prio class 0
> > [13622.361514] I/O error, dev ublkb4, sector 233112 op 0x0:(READ)
> > flags 0x0 phys_seg 1 prio class 0
> > [13622.370292] I/O error, dev ublkb4, sector 233192 op 0x1:(WRITE)
> > flags 0x8800 phys_seg 1 prio class 0
> > [13622.379419] I/O error, dev ublkb4, sector 233120 op 0x0:(READ)
> > flags 0x0 phys_seg 1 prio class 0
> > [13641.069695] INFO: task fio:174413 blocked for more than 122 seconds.
> > [13641.076061]       Not tainted 6.10.0-rc1+ #1
> > [13641.080338] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [13641.088164] task:fio             state:D stack:0     pid:174413
> > tgid:174413 ppid:174386 flags:0x00004002
> > [13641.088168] Call Trace:
> > [13641.088170]  <TASK>
> > [13641.088171]  __schedule+0x221/0x670
> > [13641.088177]  schedule+0x23/0xa0
> > [13641.088179]  io_schedule+0x42/0x70
> > [13641.088181]  blk_mq_get_tag+0x118/0x2b0
> > [13641.088185]  ? gup_fast_pgd_range+0x280/0x370
> > [13641.088188]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [13641.088192]  __blk_mq_alloc_requests+0x194/0x3a0
> > [13641.088194]  blk_mq_submit_bio+0x241/0x6c0
> > [13641.088196]  __submit_bio+0x8a/0x1f0
> > [13641.088199]  submit_bio_noacct_nocheck+0x168/0x250
> > [13641.088201]  ? submit_bio_noacct+0x45/0x560
> > [13641.088203]  __blkdev_direct_IO_async+0x167/0x1a0
> > [13641.088206]  blkdev_write_iter+0x1c8/0x270
> > [13641.088208]  aio_write+0x11c/0x240
> > [13641.088212]  ? __rq_qos_issue+0x21/0x40
> > [13641.088214]  ? blk_mq_start_request+0x34/0x1a0
> > [13641.088216]  ? io_submit_one+0x68/0x380
> > [13641.088218]  ? kmem_cache_alloc_noprof+0x4e/0x320
> > [13641.088221]  ? fget+0x7c/0xc0
> > [13641.088224]  ? io_submit_one+0xde/0x380
> > [13641.088226]  io_submit_one+0xde/0x380
> > [13641.088228]  __x64_sys_io_submit+0x80/0x160
> > [13641.088229]  do_syscall_64+0x79/0x150
> > [13641.088233]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > [13641.088237]  ? do_io_getevents+0x8b/0xe0
> > [13641.088238]  ? syscall_exit_work+0xf3/0x120
> > [13641.088241]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > [13641.088243]  ? do_syscall_64+0x85/0x150
> > [13641.088245]  ? do_syscall_64+0x85/0x150
> > [13641.088247]  ? blk_mq_flush_plug_list.part.0+0x108/0x160
> > [13641.088249]  ? rseq_get_rseq_cs+0x1d/0x220
> > [13641.088252]  ? rseq_ip_fixup+0x6d/0x1d0
> > [13641.088254]  ? blk_finish_plug+0x24/0x40
> > [13641.088256]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > [13641.088258]  ? do_syscall_64+0x85/0x150
> > [13641.088260]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > [13641.088262]  ? do_syscall_64+0x85/0x150
> > [13641.088264]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > [13641.088266]  ? do_syscall_64+0x85/0x150
> > [13641.088268]  ? do_syscall_64+0x85/0x150
> > [13641.088270]  ? do_syscall_64+0x85/0x150
> > [13641.088272]  ? clear_bhb_loop+0x45/0xa0
> > [13641.088275]  ? clear_bhb_loop+0x45/0xa0
> > [13641.088277]  ? clear_bhb_loop+0x45/0xa0
> > [13641.088279]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [13641.088281] RIP: 0033:0x7ff92150713d
> > [13641.088283] RSP: 002b:00007ffca1ef81f8 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000000d1
> > [13641.088285] RAX: ffffffffffffffda RBX: 00007ff9217e2f70 RCX: 00007ff=
92150713d
> > [13641.088286] RDX: 000055863b694fe0 RSI: 0000000000000010 RDI: 00007ff=
92164d000
> > [13641.088287] RBP: 00007ff92164d000 R08: 00007ff91936d000 R09: 0000000=
000000180
> > [13641.088288] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000010
> > [13641.088289] R13: 0000000000000000 R14: 000055863b694fe0 R15: 0000558=
63b6970c0
> > [13641.088291]  </TASK>
> >
> > Thanks=EF=BC=8C
> > Changhui
> >
>
> After applying the previous patch, will the test environment continue to
> execute test cases after WARN?

a few days ago=EF=BC=8Ctest with the previous patch, the test environment
continued to execute test cases after WARN,
and I terminated the test when I observed a WARN=EF=BC=8Cso I did not obser=
ve
the subsequent situation.

> I am not sure whether this issue has always
> existed but was not tested becasue of WARN, or whether the new patch
> introduced it.

today=EF=BC=8C I re-test previous patch=EF=BC=8C and let it run for a long =
time=EF=BC=8CI
observed WARN and task hung=EF=BC=8C
looks this issue already existed and not introduced by new patch.

[ 3443.311492] ------------[ cut here ]------------
[ 3443.316128] WARNING: CPU: 0 PID: 35703 at
drivers/block/ublk_drv.c:2633
ublk_ctrl_start_recovery.constprop.0+0x60/0x1a0
[ 3443.326911] Modules linked in: ext4 mbcache jbd2 loop tls rfkill
sunrpc dm_multipath intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common isst_if_common
skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel kvm mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper
dcdbas rapl ipmi_ssif iTCO_wdt iTCO_vendor_support intel_cstate
intel_uncore wmi_bmof i2c_i801 acpi_power_meter mei_me ipmi_si
dell_smbios acpi_ipmi mei ipmi_devintf intel_pch_thermal
dell_wmi_descriptor i2c_smbus ipmi_msghandler pcspkr lpc_ich drm fuse
xfs libcrc32c sd_mod sr_mod t10_pi cdrom sg ahci crct10dif_pclmul
crc32_pclmul libahci crc32c_intel tg3 libata ghash_clmulni_intel
megaraid_sas wmi dm_mirror dm_region_hash dm_log dm_mod [last
unloaded: null_blk]
[ 3443.395899] CPU: 0 PID: 35703 Comm: iou-wrk-35689 Not tainted 6.10.0-rc1=
+ #1
[ 3443.402951] Hardware name: Dell Inc. PowerEdge R740/06WXJT, BIOS
2.13.3 12/13/2021
[ 3443.410516] RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x60/0x1a0
[ 3443.416964] Code: 85 48 01 00 00 66 41 83 7c 24 1c 02 0f 85 3b 01
00 00 66 41 83 7c 24 18 00 0f 84 b8 00 00 00 45 31 ed 41 be ff ff ff
ff eb 15 <0f> 0b 41 0f b7 44 24 18 41 83 c5 01 41 39 c5 0f 8d 98 00 00
00 44
[ 3443.435711] RSP: 0018:ffffb66a45517ce0 EFLAGS: 00010246
[ 3443.440936] RAX: 0000000000000002 RBX: ffff9c59054ce000 RCX: 00000000000=
00000
[ 3443.448069] RDX: ffff9c58c84f0000 RSI: ffffffffb644ee00 RDI: 00000000000=
00000
[ 3443.455203] RBP: ffff9c5905b65468 R08: 0000000000000000 R09: ffffffffb68=
e35e0
[ 3443.462334] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c5905b=
65000
[ 3443.469468] R13: 0000000000000000 R14: 00000000ffffffff R15: ffff9c58c99=
d4080
[ 3443.476601] FS:  00007f00c7e51740(0000) GS:ffff9c5c2fe00000(0000)
knlGS:0000000000000000
[ 3443.484688] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3443.490433] CR2: 00007f2379adb584 CR3: 0000000109a36005 CR4: 00000000007=
706f0
[ 3443.497567] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 3443.504702] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 3443.511840] PKRU: 55555554
[ 3443.514552] Call Trace:
[ 3443.517007]  <TASK>
[ 3443.519112]  ? __warn+0x7f/0x120
[ 3443.522352]  ? ublk_ctrl_start_recovery.constprop.0+0x60/0x1a0
[ 3443.528184]  ? report_bug+0x18a/0x1a0
[ 3443.531851]  ? handle_bug+0x3c/0x70
[ 3443.535344]  ? exc_invalid_op+0x14/0x70
[ 3443.539182]  ? asm_exc_invalid_op+0x16/0x20
[ 3443.543371]  ? ublk_ctrl_start_recovery.constprop.0+0x60/0x1a0
[ 3443.549210]  ublk_ctrl_uring_cmd+0x4f7/0x6c0
[ 3443.553484]  ? pick_next_task_fair+0x41/0x520
[ 3443.557843]  ? put_prev_entity+0x1c/0xa0
[ 3443.561778]  io_uring_cmd+0x9a/0x1b0
[ 3443.565367]  io_issue_sqe+0x18f/0x3f0
[ 3443.569030]  io_wq_submit_work+0x9b/0x390
[ 3443.573045]  io_worker_handle_work+0x165/0x360
[ 3443.577499]  io_wq_worker+0xcb/0x2f0
[ 3443.581077]  ? finish_task_switch.isra.0+0x203/0x290
[ 3443.586045]  ? finish_task_switch.isra.0+0x203/0x290
[ 3443.591018]  ? __pfx_io_wq_worker+0x10/0x10
[ 3443.595204]  ret_from_fork+0x2d/0x50
[ 3443.598786]  ? __pfx_io_wq_worker+0x10/0x10
[ 3443.602980]  ret_from_fork_asm+0x1a/0x30
[ 3443.606906]  </TASK>
[ 3443.609097] ---[ end trace 0000000000000000 ]---




[ 3933.596384] INFO: task fio:35336 blocked for more than 491 seconds.
[ 3933.602659]       Tainted: G        W          6.10.0-rc1+ #1
[ 3933.608405] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 3933.616233] task:fio             state:D stack:0     pid:35336
tgid:35336 ppid:35327  flags:0x00004002
[ 3933.616239] Call Trace:
[ 3933.616241]  <TASK>
[ 3933.616244]  __schedule+0x221/0x670
[ 3933.616253]  schedule+0x23/0xa0
[ 3933.616257]  io_schedule+0x42/0x70
[ 3933.616261]  blk_mq_get_tag+0x118/0x2b0
[ 3933.616268]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 3933.616275]  __blk_mq_alloc_requests+0x194/0x3a0
[ 3933.616280]  blk_mq_submit_bio+0x241/0x6c0
[ 3933.616284]  __submit_bio+0x8a/0x1f0
[ 3933.616288]  ? bio_associate_blkg_from_css+0xca/0x320
[ 3933.616294]  submit_bio_noacct_nocheck+0x168/0x250
[ 3933.616298]  __blkdev_direct_IO_async+0x167/0x1a0
[ 3933.616303]  blkdev_read_iter+0xa2/0x130
[ 3933.616308]  aio_read+0xf2/0x1b0
[ 3933.616315]  ? rseq_get_rseq_cs+0x1d/0x220
[ 3933.616320]  ? rseq_ip_fixup+0x6d/0x1d0
[ 3933.616324]  ? kmem_cache_alloc_noprof+0x4e/0x320
[ 3933.616329]  ? fget+0x7c/0xc0
[ 3933.616335]  ? io_submit_one+0xde/0x380
[ 3933.616338]  io_submit_one+0xde/0x380
[ 3933.616341]  __x64_sys_io_submit+0x80/0x160
[ 3933.616345]  do_syscall_64+0x79/0x150
[ 3933.616352]  ? clear_bhb_loop+0x45/0xa0
[ 3933.616358]  ? clear_bhb_loop+0x45/0xa0
[ 3933.616361]  ? clear_bhb_loop+0x45/0xa0
[ 3933.616364]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 3933.616368] RIP: 0033:0x7fb92c70713d
[ 3933.616372] RSP: 002b:00007ffee155c528 EFLAGS: 00000246 ORIG_RAX:
00000000000000d1
[ 3933.616375] RAX: ffffffffffffffda RBX: 00007fb92c941f70 RCX: 00007fb92c7=
0713d
[ 3933.616377] RDX: 000055b09201e360 RSI: 0000000000000010 RDI: 00007fb92c8=
9f000
[ 3933.616379] RBP: 00007fb92c89f000 R08: 00007fb92c8d4000 R09: 00000000000=
00080
[ 3933.616381] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00010
[ 3933.616382] R13: 0000000000000000 R14: 000055b09201e360 R15: 000055b0920=
1d240
[ 3933.616386]  </TASK>

