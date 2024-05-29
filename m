Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7F15B141
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963434; cv=none; b=UI1XIAeRxAP+hxxMb7kIiCByb1q0dQ+FQtNx4KMFbXrhod+oiQOztZLTQyad57jFvGnd0ZyhPx4fBZMndqYAzN/ITN10K0SILFAXvwWWm/Ww2bmUKUlfHAE/KWq6DwLnA1c0vdNGGMEHBeTKyCN6DLyMQvB2MCkShr7Iek5eXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963434; c=relaxed/simple;
	bh=A8kS2ZbDVWsSlNvrnby7gF0c6itU2ISthS3R3K+qzk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kii37FTsElQ3b8ka5GTFOKYXvRhwz0eF5zf9ZQ08p0QGxRDvdt6oD0SZRyDFFoqYrdenNYJtCLH8hZ9t3CKP7yTwAX32JcJ2676CjQ8jdGH8WZxY8NeQ65pp072OALeQMZBFeQmZhHCEq1yKSbaMRvRo00LB23tm+5U2BKNG+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fal6T2QM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fal6T2QM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716963431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5paZU4KSy2IWAsk9m6iwn/iocJ3BmVOxJGPMVKIU38=;
	b=Fal6T2QMSqljdQL8tW4d0+xcmcFyE2kRpoQ6OyQDMf/JXWVtE3UM2cGIoo/hL+sotjZx3z
	aRDkns2BfNg6OsnjeNd01DJ9cR8VCyMsLuWVzPsJUsktIMKO70tFK1RmjaLmy0bRHyBMPu
	S4Ipao1UrxNFgFMsiCsOdpz4ooLqzko=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-8_x4v_8bN02KuW4rpWWuwQ-1; Wed, 29 May 2024 02:17:09 -0400
X-MC-Unique: 8_x4v_8bN02KuW4rpWWuwQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2bf5bd50e7fso1497874a91.3
        for <linux-block@vger.kernel.org>; Tue, 28 May 2024 23:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716963428; x=1717568228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5paZU4KSy2IWAsk9m6iwn/iocJ3BmVOxJGPMVKIU38=;
        b=LhA6CBfebEsEhlumYzJMCwMymapxSWX5JH6L7IAHIo0PhLGoqZCezpx8d7ehH5rGek
         kYgkGFfW9ju2CFjIF/jDy1MSU1LvkGEMnRPPw7PRZQapMTXnHcmgnJ3Xsv9dqQRMZzD8
         w9CHyFM9gvTXPWmTcNHEGragFumzgpc+My3HYTXhtMuXYS0VyYStYkY9Lq4vH1G5KYdD
         pzFYIIh87sOxdououJIQq+hbJ8JFtRu3t/YP0PtC3NQIDtICYT8e7ldSyOBCaueZZ49Q
         wL9zV7oTaA7uZSlOsgye/xhiC38DUoRElZlrA2ZFnFyrE+rM7cDCuFG6EdlTM64dYc+s
         kNmA==
X-Forwarded-Encrypted: i=1; AJvYcCUcT2+uzy7caZfp1LYozL3HKorDprIQ9t/UMhuVmMspvIVHmt+bxDNjjxOGfx43N94IFtoUcXgTxOt5mglfpHQIsgXKBb1BfNyiTIA=
X-Gm-Message-State: AOJu0YwN3fB8rDzaMoDgxzoFydgUKGCnkkml4o4PlRn1X+SYRwVRRlE4
	xFPNnNJnxmydrr2/esG6/FETWq709fmUFpmxPTDvFy3eLBD9oi4sEDRph0clCPAjbUhhAwzsJL/
	9GsLLb/KKdtzgFpjWrauW0kxYEbXgeqvZoyGRT09/KevNlo/mtkonjHAurZWgv4hl9sWo58Glih
	kR30OMm3dAhJCbrfLpPwBZkxzl0KljvSFGwC4=
X-Received: by 2002:a17:90a:8a15:b0:2bb:a88:8efd with SMTP id 98e67ed59e1d1-2bf5e185872mr12357956a91.12.1716963428381;
        Tue, 28 May 2024 23:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7fZgR2Y0ByRJtLJPZPZsO4oppSpHeeqn47/snhDMY+cihCoRX5m+Ddb2wnYujmCX4SudLjEcGF9GIO7M8TbY=
X-Received: by 2002:a17:90a:8a15:b0:2bb:a88:8efd with SMTP id
 98e67ed59e1d1-2bf5e185872mr12357944a91.12.1716963427903; Tue, 28 May 2024
 23:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
 <ZlVk95sNtdkzZ8bE@8bytes.org> <77c7eb43-2321-484d-a1bf-50ddd907db17@amd.com> <80ceceba-ac9c-4ab7-a0e3-bdb9336a86e6@amd.com>
In-Reply-To: <80ceceba-ac9c-4ab7-a0e3-bdb9336a86e6@amd.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 29 May 2024 14:16:55 +0800
Message-ID: <CAHj4cs9W=OEZTPqi6jx4Hinebz8VCJBpngHnr5LO-+xqWMrG2g@mail.gmail.com>
Subject: Re: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-block <linux-block@vger.kernel.org>, iommu@lists.linux.dev, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 1:40=E2=80=AFAM Vasant Hegde <vasant.hegde@amd.com>=
 wrote:
>
> Hi Yi,
>
>
> On 5/28/2024 11:00 PM, Vasant Hegde wrote:
> > Hi Yi,
> >
> >
> > On 5/28/2024 10:30 AM, Joerg Roedel wrote:
> >> Adding Vasant.
> >>
> >> On Tue, May 28, 2024 at 10:23:10AM +0800, Yi Zhang wrote:
> >>> Hello
> >>> I found this regression panic issue on the latest 6.10-rc1 and it
> >>> cannot be reproduced on 6.9, please help check and let me know if you
> >>> need any info/testing for it, thanks.
> >
> > I have tried to reproduce this issue on my system. So far I am not able=
 to
> > reproduce it.
> >
> > Will you be able to bisect the kernel?
>
> I see that below patch touched this code path. Can you revert below patch=
 and
> test it again?

Yes, the panic cannot be reproduced now after revert this patch.

>
> commit d74169ceb0d2e32438946a2f1f9fc8c803304bd6
> Author: Dimitri Sivanich <sivanich@hpe.com>
> Date:   Wed Apr 24 15:16:29 2024 +0800
>
>     iommu/vt-d: Allocate DMAR fault interrupts locally
>
> -Vasant
>
> >
> >>>
> >>> reproducer
> >>> # cat config
> >>> TEST_DEVS=3D(/dev/nvme0n1 /dev/nvme1n1)
> >>> # ./check block/008
> >>> block/008 =3D> nvme0n1 (do IO while hotplugging CPUs)
> >>>     read iops  131813   ...
> >>>     runtime    32.097s  ...
> >>>
> >>> [  973.823246] run blktests block/008 at 2024-05-27 22:11:38
> >>> [  977.485983] kernel tried to execute NX-protected page - exploit
> >>> attempt? (uid: 0)
> >>> [  977.493463] BUG: unable to handle page fault for address: ffffffff=
b3d5e310
> >>> [  977.500334] #PF: supervisor instruction fetch in kernel mode
> >>> [  977.505992] #PF: error_code(0x0011) - permissions violation
> >>> [  977.511567] PGD 719225067 P4D 719225067 PUD 719226063 PMD 71a5ff06=
3
> >>> PTE 8000000719d5e163
> >>> [  977.519662] Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
> >>> [  977.524541] CPU: 4 PID: 42 Comm: cpuhp/4 Not tainted
> >>> 6.10.0-0.rc1.17.eln136.x86_64 #1
> >>> [  977.532366] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
> >>> 2.13.3 09/12/2023
> >>> [  977.540017] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
> >
> > amd_iommu_enable_faulting() just returns zero.
> >
> > -Vasant
> >
> >
> >>> [  977.545329] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
> >>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4=
0
> >>> 00 00
> >>> [  977.564076] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
> >>> [  977.569301] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 00000=
00000000000
> >>> [  977.576433] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 00000=
00000000004
> >>> [  977.583567] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8=
f398664ece0
> >>> [  977.590698] R10: 0000000000000000 R11: 0000000000000008 R12: 00000=
000000000c0
> >>> [  977.597833] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8=
f40df020848
> >>> [  977.604963] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
> >>> knlGS:0000000000000000
> >>> [  977.613050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [  977.618795] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 00000=
00000350ef0
> >>> [  977.625927] Call Trace:
> >>> [  977.628376]  <TASK>
> >>> [  977.630480]  ? srso_return_thunk+0x5/0x5f
> >>> [  977.634491]  ? show_trace_log_lvl+0x255/0x2f0
> >>> [  977.638851]  ? show_trace_log_lvl+0x255/0x2f0
> >>> [  977.643213]  ? cpuhp_invoke_callback+0x122/0x410
> >>> [  977.647830]  ? __die_body.cold+0x8/0x12
> >>> [  977.651669]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> >>> [  977.656979]  ? page_fault_oops+0x146/0x160
> >>> [  977.661080]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> >>> [  977.666392]  ? exc_page_fault+0x152/0x160
> >>> [  977.670405]  ? asm_exc_page_fault+0x26/0x30
> >>> [  977.674590]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> >>> [  977.679905]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> >>> [  977.685215]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> >>> [  977.690527]  cpuhp_invoke_callback+0x122/0x410
> >>> [  977.694977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> >>> [  977.699593]  cpuhp_thread_fun+0x98/0x140
> >>> [  977.703521]  smpboot_thread_fn+0xdd/0x1d0
> >>> [  977.707533]  kthread+0xd2/0x100
> >>> [  977.710677]  ? __pfx_kthread+0x10/0x10
> >>> [  977.714431]  ret_from_fork+0x34/0x50
> >>> [  977.718009]  ? __pfx_kthread+0x10/0x10
> >>> [  977.721763]  ret_from_fork_asm+0x1a/0x30
> >>> [  977.725692]  </TASK>
> >>> [  977.727879] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
> >>> dns_resolver nfs lockd grace netfs sunrpc vfat fat dm_multipath
> >>> ipmi_ssif amd_atl intel_rapl_msr intel_rapl_common amd64_edac
> >>> edac_mce_amd dell_wmi sparse_keymap rfkill video kvm_amd dcdbas kvm
> >>> dell_smbios dell_wmi_descriptor wmi_bmof rapl mgag200 pcspkr
> >>> acpi_cpufreq i2c_algo_bit acpi_power_meter ptdma k10temp i2c_piix4
> >>> ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs sd_mod sg ahc=
i
> >>> crct10dif_pclmul nvme libahci crc32_pclmul crc32c_intel mpt3sas
> >>> ghash_clmulni_intel libata nvme_core tg3 ccp nvme_auth raid_class
> >>> t10_pi scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash
> >>> dm_log dm_mod
> >>> [  977.786224] CR2: ffffffffb3d5e310
> >>> [  977.789544] ---[ end trace 0000000000000000 ]---
> >>> [  977.883220] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
> >>> [  977.888532] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
> >>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4=
0
> >>> 00 00
> >>> [  977.907277] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
> >>> [  977.912503] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 00000=
00000000000
> >>> [  977.919633] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 00000=
00000000004
> >>> [  977.926767] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8=
f398664ece0
> >>> [  977.933900] R10: 0000000000000000 R11: 0000000000000008 R12: 00000=
000000000c0
> >>> [  977.941030] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8=
f40df020848
> >>> [  977.948163] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
> >>> knlGS:0000000000000000
> >>> [  977.956251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [  977.961995] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 00000=
00000350ef0
> >>> [  977.969129] Kernel panic - not syncing: Fatal exception
> >>> [  977.974439] Kernel Offset: 0x30400000 from 0xffffffff81000000
> >>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> >>> [  978.087528] ---[ end Kernel panic - not syncing: Fatal exception ]=
---
> >>>
> >>> --
> >>> Best Regards,
> >>>   Yi Zhang
> >>>
>


--=20
Best Regards,
  Yi Zhang

