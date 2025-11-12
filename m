Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB472FF15A
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940019; cv=none; b=gT+jB3MjgyUs6s8oC+cpphLcLBhazb/5RIHcHzxpWWwb8gpN8pi0/Dmh25YObuZJZYsSAKynsKC13N03LF15eUGCwAAnb3djkX4l/BQ8rBcCujPt2cU0y1GXMk0QOa5GEkISwhU0deNNmqHp6SNpdDcpKlE0kpJhLk8aTr5uq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940019; c=relaxed/simple;
	bh=68jmzRtexqtpWz2yD+8V+hKDasTjyjhiXz5itbAiM28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR0VTNzCd/w9iI4JSCdjsB+oYXICRwWbUert1CAQhSUCUPA7x4mkBh2WFRf4YdPGcqbB46ZkIuKwm/J5gns2tk1qL8qQDHvGAOZ3VSmRpM5xOLzD3WBOkO++QArdVZ8W0fwZ4gSaHm8mO39m0Yk8b2GgF1W5++5HZIY0jta5MbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwLIsL+4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWtSpF2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwLIsL+4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWtSpF2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX0m+lK7z4qb+XpJGjgIGDVGjQ3EPj1/oKnAIIixJI0=;
	b=KwLIsL+4yswY+Qm3g1WQnBaxqlszMhwQy8VCQQGJhZC5Lj1Bu5KjyEuW6NMax5AHv87ZkW
	+UmpzLYvMXMCyERcWeDy3U6LIuLdG3K9dABLRNsdJx2uXCUf+kbrCAjMtLRxfSK+pgDg5d
	dIBXDjXjY6oAOdxBamuSFH5aMVYO82g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-KOAvwhBMOC2yALoq3xt7fA-1; Wed, 12 Nov 2025 04:33:34 -0500
X-MC-Unique: KOAvwhBMOC2yALoq3xt7fA-1
X-Mimecast-MFC-AGG-ID: KOAvwhBMOC2yALoq3xt7fA_1762940013
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29848363458so15492055ad.2
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 01:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762940013; x=1763544813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX0m+lK7z4qb+XpJGjgIGDVGjQ3EPj1/oKnAIIixJI0=;
        b=WWtSpF2Y9pCIVoU8wBq+aIwwBDkXXbuY0ajBMqc3xbcZePBiAQUleqjUV81+NQ5SjU
         kKCiKunLsqueuDgJcOxzc6kCUL60vTQ3bf7hCBWv51ByNMH2mKbEV/T/+CpJZ92+QpVz
         hop+uNgHwZWxrIlIALDutxrplLV5V+8hQWqj5ZILYidiS5vdC0Iyb0JZIwPMG38u5kSD
         8biiVIYAx5e+ux0NUqWs+Eap1eYkgKIVedxhwmW4p5V1AMc7gaAf20UYZyKGkMH9yjNG
         +rSSwIO3yyCDDW2dBOJMIPCu4/6NeG2YUGfVLXKpXJN6t49wjWp1SLMSqHbLEWOAujpP
         e77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940013; x=1763544813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oX0m+lK7z4qb+XpJGjgIGDVGjQ3EPj1/oKnAIIixJI0=;
        b=f30mdaZ3tU03/mwm8P8jH6qZQUIWwJQxv3UaDSexMFdjgYrh6m3EZBxqciul+AUllf
         45jw2/4/jX/TlYeoGyG5DDPKiVpzBV9lfg2ZsUwbA+CvakdiQ2WyQyf3myThzYsgHw+l
         1PSwOfQIQ1GlCjF9CBaaeBaNp0W53y2XMR297jSTtYCzOYc3Pb/NY6Zy5XMwkjaXQ++v
         qxakGII67e0VQ0tIP8Ah6936E53sZRe5T6EuPP3AvjDxC1LDUZf5AxuFSJwNIYQ0Hw2S
         cVVhppNzRfHH9PyRTB04hI/TFUpMV8UWLiqsT+dgjGMgCxmWvmgXL1iuQuY/SNQlcH9m
         qjPA==
X-Gm-Message-State: AOJu0YyGRHnwoWLbpmAmQlZA71YrnnDsc/AOz1zdgDpadDxiwey96ce2
	x3GfBb9ZA+CUO2s2UEFW0MY9t3Ui/DF/xh8+J+WUAIdt/TNFYA9IpWITLxNqQYcVaYayCGa3WCr
	TdbqnTrKeiazYp1+yulK59x0yqlPTzGdymi/RL7q1nYd6GvST3zYlySiU6wNG7em8UzmRRdJ8M2
	zyvc2SjVnCukOzMxfvv7Gw9Mhxm/ZudwaoR1YRe5pmFF/Xd4+BKQ==
X-Gm-Gg: ASbGncvTjvFy7PvJUp75B+oe3lME+QboWYjNEkxqVtP+FN5UnvCM9JmFH5LZR5O45pC
	2s6ENbbrGkFJcUilHUkHotj8eDwV+nsHODagyM++5GKoYIA6NiTvgB829GJUao1nhI4XDSOMpoE
	T1JxfcdBlVj7FgW/djQ61lun7Erq00vBNwRBREqqgHYqG2SlJELnqBSdPTZiJnVihcgKybJqNOs
	q+ELI8HxJr7kEkozru+PKAGOAG9qh/NIZ5VKfyGUgdCtt6i93EiQ1AxOGc=
X-Received: by 2002:a17:902:ce06:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2984ed929eamr29067215ad.14.1762940013012;
        Wed, 12 Nov 2025 01:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHpH1CEtSNOJ7m1jHoTctvAYJ+tzfUDtba/AGK5+qGvf8Tv6Rqm5erGqKRnyPC6s3cdh/fxYESFIjvd8bKCVY=
X-Received: by 2002:a17:902:ce06:b0:290:ac36:2ed6 with SMTP id
 d9443c01a7336-2984ed929eamr29066965ad.14.1762940012592; Wed, 12 Nov 2025
 01:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+VqVnvGeneUoTbYvBv2cw6GwQRrR3B-iQ-_9rVfyumoKA@mail.gmail.com>
In-Reply-To: <CAGVVp+VqVnvGeneUoTbYvBv2cw6GwQRrR3B-iQ-_9rVfyumoKA@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 12 Nov 2025 17:33:20 +0800
X-Gm-Features: AWmQ_bmIVMUklOtR9zJvUAvC4E8Sg6Z1EUwIcdglMtASzPe9pcqXVG61Y2O1_v4
Message-ID: <CAGVVp+Wo9nReFJYyERZxa8a9Jp7nogce=A8GS3GENHUi42mC_Q@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000050
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:02=E2=80=AFPM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> the following kernel panic was triggered,
> please help check and let me know if you need any info/test, thanks.
>
> repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/
> branch: for-next
> INFO: HEAD of cloned kernel
> commit 9d5d227cc571e4dde525aa4fa00bb049c436a9b9
> Merge: 6e2eeb8123bc 6d7e3870af11
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Nov 11 08:39:32 2025 -0700
>
>     Merge branch 'for-6.19/block' into for-next
>
>     * for-6.19/block:
>       blk-mq-dma: fix kernel-doc function name for integrity DMA iterator
>
> reproducer:
> # cat repro.sh
> #!/bin/bash
>
> for i in {0..3};do
>         dd if=3D/dev/zero bs=3D1M count=3D2000 of=3Dfile$i.img
>         sleep 1
>         device=3D$(losetup -fP --show file$i.img)
>         devices+=3D" $device"
>         eval "dev$i=3D$device"
>         sleep 1
>         mkfs -t xfs -f $device
> done
>
> echo "dev list: $dev0 ,$dev1 ,$dev2 ,$dev3"
> pvcreate -y $devices
> vgcreate  black_bird $devices
>
> lvcreate --type raid0 --stripesize 64k -i 3 \
>         -n non_synced_primary_raid_3legs_1 -L 1G \
>         black_bird $dev0:0-300 $dev1:0-300 \
>         $dev2:0-300 $dev3:0-300
>
>
> dmesg log:
> [  375.341923] BUG: kernel NULL pointer dereference, address: 00000000000=
00050
> [  375.349711] #PF: supervisor read access in kernel mode
> [  375.355450] #PF: error_code(0x0000) - not-present page
> [  375.361178] PGD 1366f3067 P4D 0
> [  375.364783] Oops: Oops: 0000 [#1] SMP NOPTI
> [  375.369454] CPU: 15 UID: 0 PID: 9991 Comm: lvcreate Kdump: loaded
> Tainted: G S                  6.18.0-rc5+ #1 PREEMPT(voluntary)
> [  375.382561] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [  375.386938] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> BIOS AFE118M-1.32 06/29/2022
> [  375.396647] RIP: 0010:create_strip_zones+0x3c/0x7d0 [raid0]
> [  375.402872] Code: 49 89 fc 55 53 48 89 f3 48 83 ec 48 48 8b 3d 63
> 86 2a f3 48 89 74 24 38 be c0 0d 00 00 e8 9c c5 f9 f1 49 89 c6 49 8b
> 44 24 78 <48> 8b 40 50 8b a8 b0 00 00 00 48 c7 03 f4 ff ff ff 4d 85 f6
> 0f 84
> [  375.423830] RSP: 0018:ff6856f988a0fa10 EFLAGS: 00010246
> [  375.429655] RAX: 0000000000000000 RBX: ff6856f988a0fa90 RCX: 000000000=
0000000
> [  375.437620] RDX: 0000000000000000 RSI: ffffffffc14cc7f4 RDI: ff20815ae=
89bdc60
> [  375.445586] RBP: ffffffffc16407c5 R08: 0000000000000020 R09: 000000000=
0000000
> [  375.453552] R10: ff6856f988a0fa10 R11: fefefefefefefeff R12: ff20815af=
4df6058
> [  375.461516] R13: ffffffffc160b0c0 R14: ff20815ae89bdc40 R15: 000000000=
0000000
> [  375.469480] FS:  00007f4bf7188940(0000) GS:ff20815e3a471000(0000)
> knlGS:0000000000000000
> [  375.478514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  375.484926] CR2: 0000000000000050 CR3: 0000000128c76004 CR4: 000000000=
0773ef0
> [  375.492892] PKRU: 55555554
> [  375.495912] Call Trace:
> [  375.498641]  <TASK>
> [  375.500986]  raid0_run+0x10d/0x150 [raid0]
> [  375.505559]  md_run+0x2bb/0x790
> [  375.509068]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  375.514906]  raid_ctr+0x492/0xcdb [dm_raid]
> [  375.519579]  dm_table_add_target+0x193/0x3c0 [dm_mod]
> [  375.525240]  populate_table+0x9a/0xd0 [dm_mod]
> [  375.530214]  ? __pfx_table_load+0x10/0x10 [dm_mod]
> [  375.535571]  table_load+0xc9/0x230 [dm_mod]
> [  375.540250]  ctl_ioctl+0x1a0/0x300 [dm_mod]
> [  375.544933]  dm_ctl_ioctl+0xe/0x20 [dm_mod]
> [  375.549612]  __x64_sys_ioctl+0x96/0xe0
> [  375.553800]  ? syscall_trace_enter+0xfe/0x1a0
> [  375.558664]  do_syscall_64+0x7f/0x810
> [  375.562757]  ? __rseq_handle_notify_resume+0x35/0x60
> [  375.568301]  ? arch_exit_to_user_mode_prepare.isra.0+0xa2/0xd0
> [  375.574816]  ? do_syscall_64+0xb1/0x810
> [  375.579100]  ? clear_bhb_loop+0x30/0x80
> [  375.583382]  ? clear_bhb_loop+0x30/0x80
> [  375.587665]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  375.593303] RIP: 0033:0x7f4bf74464bf
> [  375.597294] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
> 00 00
> [  375.618244] RSP: 002b:00007ffef26ed6d0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  375.626695] RAX: ffffffffffffffda RBX: 00005583edb4f810 RCX: 00007f4bf=
74464bf
> [  375.634660] RDX: 00005583edb4f8f0 RSI: 00000000c138fd09 RDI: 000000000=
0000003
> [  375.642625] RBP: 00007ffef26ed8b0 R08: 00005583eadfbbb8 R09: 00007ffef=
26ed580
> [  375.650588] R10: 0000000000000007 R11: 0000000000000246 R12: 00005583e=
ad95d8c
> [  375.658553] R13: 00005583edb4f9a0 R14: 00005583ead95d8c R15: 000000000=
0000020
> [  375.666517]  </TASK>
> [  375.668955] Modules linked in: raid0 dm_raid raid456
> async_raid6_recov async_memcpy async_pq async_xor xor async_tx
> raid6_pq tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd
> grace nfs_localio netfs rfkill intel_rapl_msr intel_rapl_common
> intel_uncore_frequency intel_uncore_frequency_common i10nm_edac
> skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp
> coretemp kvm_intel kvm ipmi_ssif irqbypass rapl intel_cstate cdc_ether
> iTCO_wdt usbnet mgag200 dax_hmem iTCO_vendor_support cxl_acpi cxl_port
> cxl_core mii isst_if_mmio intel_uncore i2c_i801 isst_if_mbox_pci
> i2c_algo_bit mei_me intel_th_gth ioatdma einj pcspkr i2c_smbus
> isst_if_common intel_th_pci intel_pch_thermal mei intel_vsec intel_th
> dca ipmi_si acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler
> acpi_pad sg fuse loop xfs sd_mod ahci libahci libata
> ghash_clmulni_intel tg3 wmi sunrpc dm_mirror dm_region_hash dm_log
> dm_multipath dm_mod nfnetlink
>
>
> Best Regards,
> Changhui

