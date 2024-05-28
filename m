Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E344C87
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872773; cv=none; b=KnCLTS/sx16RTHWCNet99DuWTPUNKbqMDsfp6XFXYEAiRv5Wlg0VDkKCptvt1NApuXezvUpfvkQnm+46cmVfDhCRSp9hTZU4nkuCmjoGtRJppB8mrVwTxGPaLWndSHeES8DwpbfyGElB4XoP8DmfSjmVpCJ5PgMXwpAw8XbpfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872773; c=relaxed/simple;
	bh=DS4CinmS5NhhvcFvqcc1PRc0k1RkSciE4FtXUUX6P94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3zjyo07qrmTFHnX1mF6HWvfw/M2/U5TVD+A9J4vxlOtMLuqAuo4pQFvtTnaygAaU6j3Ytei9Mg2qdlwehUvNUadOy3Esw8n2cGYDbaUe60cpa8OsHPJCP06Uyz3edEfSW+hG1svHl5URpL+m5SeH32WDp6msBcF4YIb3rsgqwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Kp0t7lGa; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Kp0t7lGa"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1CB831C0DAD;
	Tue, 28 May 2024 07:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1716872440;
	bh=DS4CinmS5NhhvcFvqcc1PRc0k1RkSciE4FtXUUX6P94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kp0t7lGagTLNobtAhiPc4wiYVvExIjI2XKNmFlXsV3TJh45zyqHCOnKYP8NFkdTvr
	 u556+XAvdgxBae9UCTaD9YBoD9Pt9FvmM4oIf5dWUESutS9Tupbe9j+V14xNU6mznX
	 eiOUInKX6c5ffhC08w1r/FLceuVc78j4t93ttlFeR95Tp27KoJ0uyYWkNkq9JfodOU
	 /gTQZVhgYxEydgONmqJUSu2OzYUx/G1oUh8WHC1t3Z5430nnFwmChKWem+qQEDt157
	 3zubd8MJbmyZ48eP4tl4vOHZcrNkZ8YoWFmDpGNyhos/Xo5vt7cyn5KxlkSZCQ0IsF
	 bV18JVpKgazLw==
Date: Tue, 28 May 2024 07:00:39 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yi Zhang <yi.zhang@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>
Cc: linux-block <linux-block@vger.kernel.org>, iommu@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	suravee.suthikulpanit@amd.com
Subject: Re: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
Message-ID: <ZlVk95sNtdkzZ8bE@8bytes.org>
References: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>

Adding Vasant.

On Tue, May 28, 2024 at 10:23:10AM +0800, Yi Zhang wrote:
> Hello
> I found this regression panic issue on the latest 6.10-rc1 and it
> cannot be reproduced on 6.9, please help check and let me know if you
> need any info/testing for it, thanks.
> 
> reproducer
> # cat config
> TEST_DEVS=(/dev/nvme0n1 /dev/nvme1n1)
> # ./check block/008
> block/008 => nvme0n1 (do IO while hotplugging CPUs)
>     read iops  131813   ...
>     runtime    32.097s  ...
> 
> [  973.823246] run blktests block/008 at 2024-05-27 22:11:38
> [  977.485983] kernel tried to execute NX-protected page - exploit
> attempt? (uid: 0)
> [  977.493463] BUG: unable to handle page fault for address: ffffffffb3d5e310
> [  977.500334] #PF: supervisor instruction fetch in kernel mode
> [  977.505992] #PF: error_code(0x0011) - permissions violation
> [  977.511567] PGD 719225067 P4D 719225067 PUD 719226063 PMD 71a5ff063
> PTE 8000000719d5e163
> [  977.519662] Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
> [  977.524541] CPU: 4 PID: 42 Comm: cpuhp/4 Not tainted
> 6.10.0-0.rc1.17.eln136.x86_64 #1
> [  977.532366] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
> 2.13.3 09/12/2023
> [  977.540017] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
> [  977.545329] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
> 00 00
> [  977.564076] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
> [  977.569301] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
> [  977.576433] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
> [  977.583567] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
> [  977.590698] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
> [  977.597833] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
> [  977.604963] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
> knlGS:0000000000000000
> [  977.613050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  977.618795] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
> [  977.625927] Call Trace:
> [  977.628376]  <TASK>
> [  977.630480]  ? srso_return_thunk+0x5/0x5f
> [  977.634491]  ? show_trace_log_lvl+0x255/0x2f0
> [  977.638851]  ? show_trace_log_lvl+0x255/0x2f0
> [  977.643213]  ? cpuhp_invoke_callback+0x122/0x410
> [  977.647830]  ? __die_body.cold+0x8/0x12
> [  977.651669]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [  977.656979]  ? page_fault_oops+0x146/0x160
> [  977.661080]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [  977.666392]  ? exc_page_fault+0x152/0x160
> [  977.670405]  ? asm_exc_page_fault+0x26/0x30
> [  977.674590]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [  977.679905]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [  977.685215]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [  977.690527]  cpuhp_invoke_callback+0x122/0x410
> [  977.694977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [  977.699593]  cpuhp_thread_fun+0x98/0x140
> [  977.703521]  smpboot_thread_fn+0xdd/0x1d0
> [  977.707533]  kthread+0xd2/0x100
> [  977.710677]  ? __pfx_kthread+0x10/0x10
> [  977.714431]  ret_from_fork+0x34/0x50
> [  977.718009]  ? __pfx_kthread+0x10/0x10
> [  977.721763]  ret_from_fork_asm+0x1a/0x30
> [  977.725692]  </TASK>
> [  977.727879] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
> dns_resolver nfs lockd grace netfs sunrpc vfat fat dm_multipath
> ipmi_ssif amd_atl intel_rapl_msr intel_rapl_common amd64_edac
> edac_mce_amd dell_wmi sparse_keymap rfkill video kvm_amd dcdbas kvm
> dell_smbios dell_wmi_descriptor wmi_bmof rapl mgag200 pcspkr
> acpi_cpufreq i2c_algo_bit acpi_power_meter ptdma k10temp i2c_piix4
> ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs sd_mod sg ahci
> crct10dif_pclmul nvme libahci crc32_pclmul crc32c_intel mpt3sas
> ghash_clmulni_intel libata nvme_core tg3 ccp nvme_auth raid_class
> t10_pi scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash
> dm_log dm_mod
> [  977.786224] CR2: ffffffffb3d5e310
> [  977.789544] ---[ end trace 0000000000000000 ]---
> [  977.883220] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
> [  977.888532] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
> 00 00
> [  977.907277] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
> [  977.912503] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
> [  977.919633] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
> [  977.926767] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
> [  977.933900] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
> [  977.941030] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
> [  977.948163] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
> knlGS:0000000000000000
> [  977.956251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  977.961995] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
> [  977.969129] Kernel panic - not syncing: Fatal exception
> [  977.974439] Kernel Offset: 0x30400000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  978.087528] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> -- 
> Best Regards,
>   Yi Zhang
> 
