Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9626B2CE
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613771; cv=none; b=WM7ZmP11y4gVfR7R4uOJ+Ms8uaPNy/CUZDQEI7nowfrfa6g/lAqAhyY5PDlH86F2AL+4G7klp+uEfk9iXvfgeMxsBYJ5m0eg6cBhEHoDtwUYGC2AwYthozJDhBA32FrkbPALKmTnvoiQERqn7AKqGcZLZ/+vFLzKvza9kqjG0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613771; c=relaxed/simple;
	bh=ojgtRuSMrchmv2+mqR8zn++synThX7QAHTcbp4/UtYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvNRb62Wi7aRa2wW2vwXJaHyIdOqRBC/zjo+vs+ugQ3hFlYDRZ2F6TScID56rb2ZJODB875ZPAVg/rwJKldV60fPdXYvbCkng8+I4l0fsyLJUncm2EGAlO0/4d+HCwYzQ1J1PUknfxKBkx3P84SfQfybwk/ULTbq4v3D74kwWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlHtXuar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlHtXuar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5F4JPz+c5FGXsh7gHHznoRCaI8CkFCY7iGvyB5KPik=;
	b=JlHtXuarC5YcXFQTfTHDfsIZjMlI/ZsWFc0fwgNM8IzKBVCIiF4U7P8/znCqpAiPFLNS6E
	UixAOb9fjTeYcMJxmwIB81PcZwSPBBXS2iiSm+FAIiPGy+F1OvTHn2wRKLISuNjk/qgC7k
	lmYFc46SowC1GKmnlyVOu8629E0ztlQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-HwN9s3H3MmymaZ1JSIsyjg-1; Tue, 19 Aug 2025 10:29:26 -0400
X-MC-Unique: HwN9s3H3MmymaZ1JSIsyjg-1
X-Mimecast-MFC-AGG-ID: HwN9s3H3MmymaZ1JSIsyjg_1755613765
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3235e45b815so2800296a91.0
        for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 07:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613765; x=1756218565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5F4JPz+c5FGXsh7gHHznoRCaI8CkFCY7iGvyB5KPik=;
        b=GL0DIhd0GaYvdWD873Poq4ME9a7FyAojv1JbawblAem6mLRIg39OVvhWw7FTn6rNeS
         kwa7pNkG8/ZLsGQyz7HFqxneJGgWm/u21/RLT6T9pa+cavLzyGST3Fz1uZTg7iE3aoyB
         xubonUWXTBm4gff1WFJqwKYgWEyfLI70nn5xL6DsydOkFUXtvhvE6C9/TqRa2Wbth10L
         H5xH5dlFZ0TQLavyAxvk3n3vT+KbuA+/bQ7XTyNZlPCk8R3fCQCmsQrWgt2dtziB9rA9
         JQOYIHHqwICnGkMcjRpVYFY2wbssH6c0piMNK5PG8VKD2ceDaBMg/mJ7bVA8I2FOEXJN
         dH8g==
X-Gm-Message-State: AOJu0YzC+BXlJHDQOAO2JEZ0pUwHrXxhesPsbc54umnFUkm2y9VhVPn+
	vodlsESlOPKAmqwlHxtpbuCBgS6sEKVrGdnKhS9dsTCmuwoSovFf6W6MO/pgFOPT//z2dPLKGEk
	SVjH/wwHL9iNwFL9ygEAPt4iRzd1xeYmgAMjJw+j/XQbsPFPJ8xMlGlDQQdLcVCzzhSHNI/ad95
	wC1gjszmrNQzddJcyab9uLkaEfUGmcwj07KRtWkh8nnKjeyqtK2Q==
X-Gm-Gg: ASbGncvDdtFcc3zBVbtKXzbjNHWFM4rLZHjMTR3+b5Wh2dVKS3s7dMyWdZGoNYKgQCH
	7bXhbyrPC15T6fWfr4nJq+k7gLnWfpLixcx17lt1E+FLntv+dXcwsK0DAUOy0JXtH3AKLLNMRc+
	dw2iBCMLLSRqPG6/2sujsShw==
X-Received: by 2002:a17:90b:3ecb:b0:312:f0d0:bb0 with SMTP id 98e67ed59e1d1-3245e5924bemr4398965a91.12.1755613764798;
        Tue, 19 Aug 2025 07:29:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfIJrY1UUKzE/QfjPgAkv+GsxhsBR/anG0Wa8lr3ni5Dvq6uVJ3XdGZa0FLac/m2DDtOxnLQO1AOQ98ZgEXeM=
X-Received: by 2002:a17:90b:3ecb:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-3245e5924bemr4398807a91.12.1755613762775; Tue, 19 Aug 2025
 07:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=ksN6EcvyypAtFDOUf30A@mail.gmail.com>
In-Reply-To: <CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=ksN6EcvyypAtFDOUf30A@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 19 Aug 2025 22:29:11 +0800
X-Gm-Features: Ac12FXyimAfplpImlYleAXhvlS39MKG20FTHzOuVdIIVbCSdmOC4cTLuNVzjUxA
Message-ID: <CAGVVp+U7Sx+pf5ChXHhyWzT_WuyuOKsEtebo8_GjDkut5a0gXg@mail.gmail.com>
Subject: Re: [bug report] BUG zs_handle-zram0 (Tainted: G S ): Objects
 remaining on __kmem_cache_shutdown()
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ 5066.279543] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[ 5066.288672] BUG zspage-zram0 (Tainted: G S  B   W    L     ):
Objects remaining on __kmem_cache_shutdown()
[ 5066.299449] ------------------------------------------------------------=
-----------------
[ 5066.299449]
[ 5066.310226] Object 0x000000003141ad3c @offset=3D840
[ 5066.315476] Object 0x000000008aac8ad7 @offset=3D1848
[ 5066.320823] Slab 0x00000000cce340bd objects=3D73 used=3D2
fp=3D0x000000003f8c10b1
flags=3D0x17ffffc0000200(workingset|node=3D0|zone=3D2|lastcpupid=3D0x1fffff=
)
[ 5066.335286] ------------[ cut here ]------------
[ 5066.340439] WARNING: CPU: 5 PID: 2847 at mm/slub.c:1171
__slab_err.part.0+0x19/0x20
[ 5066.348985] Modules linked in: zram 842_decompress lz4hc_compress
842_compress lz4_compress zstd_compress tls rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_localio netfs
rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common i10nm_edac skx_edac_common nfit
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
mgag200 dax_hmem irqbypass cxl_acpi rapl cxl_port iTCO_wdt ipmi_ssif
intel_cstate cdc_ether iTCO_vendor_support cxl_core usbnet mei_me mii
i2c_algo_bit isst_if_mbox_pci intel_uncore einj isst_if_mmio
intel_th_gth i2c_i801 ioatdma mei pcspkr intel_th_pci isst_if_common
i2c_smbus intel_vsec intel_th dca intel_pch_thermal ipmi_si
acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler acpi_pad sg
loop fuse xfs sd_mod ahci libahci tg3 libata ghash_clmulni_intel wmi
sunrpc dm_mirror dm_region_hash dm_log dm_multipath dm_mod nfnetlink
[last unloaded: brd]
[ 5066.440862] CPU: 5 UID: 0 PID: 2847 Comm: bash Tainted: G S  B   W
  L      6.17.0-rc2+ #1 PREEMPT(voluntary)
[ 5066.452123] Tainted: [S]=3DCPU_OUT_OF_SPEC, [B]=3DBAD_PAGE, [W]=3DWARN,
[L]=3DSOFTLOCKUP
[ 5066.460379] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE118M-1.32 06/29/2022
[ 5066.470089] RIP: 0010:__slab_err.part.0+0x19/0x20
[ 5066.475330] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 0f 1f 44 00 00 e8 66 fc ff ff be 01 00 00 00 bf 05 00 00 00 e8 f7
83 10 00 <0f> 0b e9 10 c2 e7 00 48 c7 c7 3c 20 2f aa c6 05 6d 80 f3 01
01 e8
[ 5066.496286] RSP: 0018:ff7690a584a23c70 EFLAGS: 00010046
[ 5066.502116] RAX: 0000000000000000 RBX: ff462f22566d3700 RCX: 00000000000=
00027
[ 5066.510081] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000000=
00005
[ 5066.518046] RBP: ff462f22566d3700 R08: 0000000000000000 R09: ff7690a584a=
23af8
[ 5066.526009] R10: ffffffffaa922e28 R11: 0000000000000003 R12: ff7690a584a=
23c90
[ 5066.533975] R13: ff462f2260d55000 R14: ffdd3f4b84835540 R15: ff462f22564=
13900
[ 5066.541940] FS:  00007f9902945740(0000) GS:ff462f25c45fb000(0000)
knlGS:0000000000000000
[ 5066.550971] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5066.557383] CR2: 000055b941e4ad98 CR3: 0000000109ef6001 CR4: 00000000007=
73ef0
[ 5066.565346] PKRU: 55555554
[ 5066.568364] Call Trace:
[ 5066.571092]  <TASK>
[ 5066.573433]  __kmem_cache_shutdown.cold+0x1c/0x46
[ 5066.578686]  kmem_cache_destroy+0x3f/0x150
[ 5066.583257]  zs_destroy_pool+0xd0/0xf0
[ 5066.587443]  zram_reset_device+0xdb/0x1c0 [zram]
[ 5066.592597]  reset_store+0xa8/0x110 [zram]
[ 5066.597170]  kernfs_fop_write_iter+0x13b/0x1f0
[ 5066.602130]  vfs_write+0x25d/0x450
[ 5066.605926]  ksys_write+0x6b/0xe0
[ 5066.609625]  do_syscall_64+0x7f/0x980
[ 5066.613703]  ? do_syscall_64+0xb1/0x980
[ 5066.617985]  ? do_user_addr_fault+0x206/0x690
[ 5066.622847]  ? clear_bhb_loop+0x50/0xa0
[ 5066.627127]  ? clear_bhb_loop+0x50/0xa0
[ 5066.631408]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 5066.637047] RIP: 0033:0x7f9902a41894
[ 5066.641034] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 d8 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[ 5066.661991] RSP: 002b:00007fff33d6ab28 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 5066.670438] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9902a=
41894
[ 5066.678403] RDX: 0000000000000002 RSI: 0000556ee81a7570 RDI: 00000000000=
00001
[ 5066.686368] RBP: 0000556ee81a7570 R08: 0000000000000073 R09: 00000000fff=
fffff
[ 5066.694333] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[ 5066.702296] R13: 00007f9902b185c0 R14: 0000000000000002 R15: 00007f9902b=
15f00
[ 5066.710260]  </TASK>
[ 5066.712698] ---[ end trace 0000000000000000 ]---
[ 5066.717866] ------------[ cut here ]------------
[ 5066.723022] kmem_cache_destroy zspage-zram0: Slab cache still has
objects when called from zs_destroy_pool+0xd0/0xf0
[ 5066.723027] WARNING: CPU: 5 PID: 2847 at mm/slab_common.c:525
kmem_cache_destroy+0x13d/0x150
[ 5066.744196] Modules linked in: zram 842_decompress lz4hc_compress
842_compress lz4_compress zstd_compress tls rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_localio netfs
rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common i10nm_edac skx_edac_common nfit
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
mgag200 dax_hmem irqbypass cxl_acpi rapl cxl_port iTCO_wdt ipmi_ssif
intel_cstate cdc_ether iTCO_vendor_support cxl_core usbnet mei_me mii
i2c_algo_bit isst_if_mbox_pci intel_uncore einj isst_if_mmio
intel_th_gth i2c_i801 ioatdma mei pcspkr intel_th_pci isst_if_common
i2c_smbus intel_vsec intel_th dca intel_pch_thermal ipmi_si
acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler acpi_pad sg
loop fuse xfs sd_mod ahci libahci tg3 libata ghash_clmulni_intel wmi
sunrpc dm_mirror dm_region_hash dm_log dm_multipath dm_mod nfnetlink
[last unloaded: brd]
[ 5066.836081] CPU: 5 UID: 0 PID: 2847 Comm: bash Tainted: G S  B   W
  L      6.17.0-rc2+ #1 PREEMPT(voluntary)
[ 5066.847347] Tainted: [S]=3DCPU_OUT_OF_SPEC, [B]=3DBAD_PAGE, [W]=3DWARN,
[L]=3DSOFTLOCKUP
[ 5066.855606] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE118M-1.32 06/29/2022
[ 5066.865318] RIP: 0010:kmem_cache_destroy+0x13d/0x150
[ 5066.870862] Code: 00 85 ed 74 92 eb b1 e8 91 38 df ff eb 8f 48 8b
53 60 48 8b 4c 24 10 48 c7 c6 b0 03 c8 a9 48 c7 c7 60 35 25 aa e8 33
b6 d2 ff <0f> 0b e9 0e ff ff ff e9 47 f8 a9 00 0f 1f 80 00 00 00 00 90
90 90
[ 5066.891823] RSP: 0018:ff7690a584a23ce0 EFLAGS: 00010286
[ 5066.897659] RAX: 0000000000000000 RBX: ff462f2256413900 RCX: 00000000000=
00027
[ 5066.905629] RDX: ff462f256fb5c188 RSI: 0000000000000001 RDI: ff462f256fb=
5c180
[ 5066.913595] RBP: 0000000000000001 R08: 0000000000000000 R09: ff7690a584a=
23b58
[ 5066.921555] R10: ffffffffaa922e28 R11: 0000000000000003 R12: ff462f22a1e=
2c600
[ 5066.929522] R13: 00000000000000ff R14: ff462f23185d1000 R15: ff462f2255e=
d6320
[ 5066.937480] FS:  00007f9902945740(0000) GS:ff462f25c45fb000(0000)
knlGS:0000000000000000
[ 5066.946514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5066.952930] CR2: 000055b941e4ad98 CR3: 0000000109ef6001 CR4: 00000000007=
73ef0
[ 5066.960896] PKRU: 55555554
[ 5066.963918] Call Trace:
[ 5066.966649]  <TASK>
[ 5066.968994]  zs_destroy_pool+0xd0/0xf0
[ 5066.973183]  zram_reset_device+0xdb/0x1c0 [zram]
[ 5066.978341]  reset_store+0xa8/0x110 [zram]
[ 5066.982919]  kernfs_fop_write_iter+0x13b/0x1f0
[ 5066.987881]  vfs_write+0x25d/0x450
[ 5066.991682]  ksys_write+0x6b/0xe0
[ 5066.995384]  do_syscall_64+0x7f/0x980
[ 5066.999475]  ? do_syscall_64+0xb1/0x980
[ 5067.003758]  ? do_user_addr_fault+0x206/0x690
[ 5067.008613]  ? clear_bhb_loop+0x50/0xa0
[ 5067.012897]  ? clear_bhb_loop+0x50/0xa0
[ 5067.017181]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 5067.022823] RIP: 0033:0x7f9902a41894
[ 5067.026814] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 d8 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[ 5067.047765] RSP: 002b:00007fff33d6ab28 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 5067.056219] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9902a=
41894
[ 5067.064187] RDX: 0000000000000002 RSI: 0000556ee81a7570 RDI: 00000000000=
00001
[ 5067.072155] RBP: 0000556ee81a7570 R08: 0000000000000073 R09: 00000000fff=
fffff
[ 5067.080124] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[ 5067.088093] R13: 00007f9902b185c0 R14: 0000000000000002 R15: 00007f9902b=
15f00
[ 5067.096060]  </TASK>
[ 5067.098500] ---[ end trace 0000000000000000 ]---



On Tue, Aug 19, 2025 at 10:20=E2=80=AFPM Changhui Zhong <czhong@redhat.com>=
 wrote:
>
> Hello,
>
> the following bug and warning was triggered,
> please help check and let me know if you need any info/test, thanks.
>
> repo=EF=BC=9Ahttps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git
> branch=EF=BC=9Amaster
> INFO: HEAD of cloned kernel=EF=BC=9A
> commit be48bcf004f9d0c9207ff21d0edb3b42f253829e
> Merge: 074e461d9ed5 74857fdc5dd2
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Aug 18 09:17:42 2025 -0700
>
>     Merge tag 'for-6.17-rc2-tag' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
>
> reproducer:
> # modprobe zram
> # zramctl --find --size 4G --algorithm zstd
> # fio --name=3Dtest \
>         --filename=3D/dev/zram0 \
>         --rw=3Drandrw \
>         --bs=3D4k \
>         --ioengine=3Dlibaio \
>         --iodepth=3D16 \
>         --numjobs=3D4 \
>         --runtime=3D60 \
>         --time_based \
>         --group_reporting \
>         --direct=3D1
> # echo 1 > /sys/block/zram0/reset
>
> dmesg log:
> [ 4861.143371] zsmalloc: Class-80 fullness group 1 is not empty
> [ 4861.149696] zsmalloc: Class-112 fullness group 1 is not empty
> [ 4861.156121] zsmalloc: Class-144 fullness group 1 is not empty
> [ 4861.162541] zsmalloc: Class-160 fullness group 1 is not empty
> [ 4861.168963] zsmalloc: Class-176 fullness group 1 is not empty
> [ 4861.175379] zsmalloc: Class-192 fullness group 1 is not empty
> [ 4861.181797] zsmalloc: Class-224 fullness group 1 is not empty
> [ 4861.205986] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [ 4861.215123] BUG zs_handle-zram0 (Tainted: G S                 ):
> Objects remaining on __kmem_cache_shutdown()
> [ 4861.226193] ----------------------------------------------------------=
-------------------
> [ 4861.226193]
> [ 4861.236981] Object 0x00000000364c25c1 @offset=3D3336
> [ 4861.242331] Slab 0x0000000040c2ee59 objects=3D512 used=3D1
> fp=3D0x00000000ad7304d7
> flags=3D0x17ffffc0000200(workingset|node=3D0|zone=3D2|lastcpupid=3D0x1fff=
ff)
> [ 4861.256893] Disabling lock debugging due to kernel taint
> [ 4861.262831] ------------[ cut here ]------------
> [ 4861.267982] WARNING: CPU: 23 PID: 2847 at mm/slub.c:1171
> __slab_err.part.0+0x19/0x20
> [ 4861.276635] Modules linked in: zram 842_decompress lz4hc_compress
> 842_compress lz4_compress zstd_compress tls rpcsec_gss_krb5
> auth_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_localio netfs
> rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common i10nm_edac skx_edac_common nfit
> libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
> mgag200 dax_hmem irqbypass cxl_acpi rapl cxl_port iTCO_wdt ipmi_ssif
> intel_cstate cdc_ether iTCO_vendor_support cxl_core usbnet mei_me mii
> i2c_algo_bit isst_if_mbox_pci intel_uncore einj isst_if_mmio
> intel_th_gth i2c_i801 ioatdma mei pcspkr intel_th_pci isst_if_common
> i2c_smbus intel_vsec intel_th dca intel_pch_thermal ipmi_si
> acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler acpi_pad sg
> loop fuse xfs sd_mod ahci libahci tg3 libata ghash_clmulni_intel wmi
> sunrpc dm_mirror dm_region_hash dm_log dm_multipath dm_mod nfnetlink
> [last unloaded: brd]
> [ 4861.368551] CPU: 23 UID: 0 PID: 2847 Comm: bash Tainted: G S  B
>           6.17.0-rc2+ #1 PREEMPT(voluntary)
> [ 4861.379913] Tainted: [S]=3DCPU_OUT_OF_SPEC, [B]=3DBAD_PAGE
> [ 4861.385639] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> BIOS AFE118M-1.32 06/29/2022
> [ 4861.395350] RIP: 0010:__slab_err.part.0+0x19/0x20
> [ 4861.400604] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 0f 1f 44 00 00 e8 66 fc ff ff be 01 00 00 00 bf 05 00 00 00 e8 f7
> 83 10 00 <0f> 0b e9 10 c2 e7 00 48 c7 c7 3c 20 2f aa c6 05 6d 80 f3 01
> 01 e8
> [ 4861.421562] RSP: 0018:ff7690a584a23c70 EFLAGS: 00010046
> [ 4861.427387] RAX: 0000000000000000 RBX: ffdd3f4b88085780 RCX: 000000000=
0000027
> [ 4861.435345] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff462f256=
ffdc180
> [ 4861.443310] RBP: ff462f22566d3740 R08: 0000000000000000 R09: ff7690a58=
4a23ae8
> [ 4861.451276] R10: ffffffffaa922e28 R11: 0000000000000003 R12: ff7690a58=
4a23c90
> [ 4861.459242] R13: ff462f224a3f5000 R14: ffdd3f4b8428fd40 R15: ff462f225=
6412a00
> [ 4861.467207] FS:  00007f9902945740(0000) GS:ff462f25c4a7b000(0000)
> knlGS:0000000000000000
> [ 4861.476230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4861.482646] CR2: 0000556ee84d1f90 CR3: 0000000109ef6002 CR4: 000000000=
0773ef0
> [ 4861.490613] PKRU: 55555554
> [ 4861.493624] Call Trace:
> [ 4861.496354]  <TASK>
> [ 4861.498686]  __kmem_cache_shutdown.cold+0x1c/0x46
> [ 4861.503941]  kmem_cache_destroy+0x3f/0x150
> [ 4861.508517]  zs_destroy_pool+0xc4/0xf0
> [ 4861.512706]  zram_reset_device+0xdb/0x1c0 [zram]
> [ 4861.517866]  reset_store+0xa8/0x110 [zram]
> [ 4861.522443]  kernfs_fop_write_iter+0x13b/0x1f0
> [ 4861.527406]  vfs_write+0x25d/0x450
> [ 4861.531205]  ksys_write+0x6b/0xe0
> [ 4861.534907]  do_syscall_64+0x7f/0x980
> [ 4861.538996]  ? do_syscall_64+0xb1/0x980
> [ 4861.543279]  ? do_user_addr_fault+0x206/0x690
> [ 4861.548143]  ? clear_bhb_loop+0x50/0xa0
> [ 4861.552426]  ? clear_bhb_loop+0x50/0xa0
> [ 4861.556706]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 4861.562345] RIP: 0033:0x7f9902a41894
> [ 4861.566328] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 d8 0d 00 00 74 13 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
> 18 48
> [ 4861.587279] RSP: 002b:00007fff33d6ab28 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [ 4861.595729] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f990=
2a41894
> [ 4861.603693] RDX: 0000000000000002 RSI: 0000556ee81a7570 RDI: 000000000=
0000001
> [ 4861.611659] RBP: 0000556ee81a7570 R08: 0000000000000073 R09: 00000000f=
fffffff
> [ 4861.619616] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000002
> [ 4861.627580] R13: 00007f9902b185c0 R14: 0000000000000002 R15: 00007f990=
2b15f00
> [ 4861.635548]  </TASK>
> [ 4861.637985] ---[ end trace 0000000000000000 ]---
>
> Best Regards,
> Changhui

