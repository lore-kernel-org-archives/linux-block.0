Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124A1B6D08
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750912907; cv=none; b=Ck0AN7eRmJZo0YrLp4Eynjw8MZJc2Ts8HQy7JPlR2KDua6jKRxoqpwOtTQNl8A9EfEdcAMVsPxg9S25zhen5qt3o7X7Jah51ouAwHb+MwKIUrN5Y9wo2suWTtLMYWF/kK93y4U/twzo7kbSQi5Zv+8hxPWRxNEq+r3vOZh0Z5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750912907; c=relaxed/simple;
	bh=KMmyiwNs0dvt+nGviNpO2LbvUlgFTZSb0ldlsEpUmgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbFJ0JmxPPgfdkbxaGqCsdbXOUF4LQUES6gkgvP5nuPIZjy/lTMjp4lkiL50If4EcB9RKQxo4/BWq4/uE46yPSXzrNYY2YZnEQ+V9Y6kSgWzpih6jSNvpM1cXosAU5iy+Ap1nKERDb7ZacLTWo6uEt6uxQtPNiHo7xiUHtFk9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfkOXyGP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfkOXyGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750912902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USCOXCoyizmVMS1nEox+nQnEJllbvckzTYHVUQ8KwYw=;
	b=GfkOXyGPLuZjLhtUC/Sct5cTsi5apoSGYjRT4VyIho07qerQbq0ja2VYze7e4sDAv/hj1E
	DKdVwF5nQlYatj4DPxD4tWZSSQy9nNDvUw9Ia9fw3WDe8/F8LckJziKzXCTyluJaKmrBB/
	DIlOXX4+pxkkpMiHet1G23nihq1BSkw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-pDI8dNNtP022d4e18CRqfw-1; Thu, 26 Jun 2025 00:41:40 -0400
X-MC-Unique: pDI8dNNtP022d4e18CRqfw-1
X-Mimecast-MFC-AGG-ID: pDI8dNNtP022d4e18CRqfw_1750912899
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32cbc4a763eso1582731fa.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 21:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750912898; x=1751517698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USCOXCoyizmVMS1nEox+nQnEJllbvckzTYHVUQ8KwYw=;
        b=qH6dqQofqPdUMCctDXXTJ9tZab5qqleY2XqRWnb1thGKkmAaDJw8+SEDVon1YzZSE9
         mPFveFJOFNSDbC8DsNRNwvqA2r6CN1FFSVLQxuhUcnocfvsXSr44FVFiZnjT1HpDYWWS
         pEQoXoWaO0G79lwr10qgbQ07qbgzjFdaBQmMqwO1dJcylvRcbPlH1j0g/Wu+0dIG46+x
         E7KB9MIYT5CCD7clnQbBFJkiz5Cp+2gNouxrxspyCPDidf6DMsgHHAcpW/6k6wRF9flk
         jRA35lJh7/Q2xTV6Qu0MIxsrd6QrEkumXpR/DgQrMdhKI2BDt7CRkk/b/05qJzxeJFHq
         A10A==
X-Forwarded-Encrypted: i=1; AJvYcCVAb1otyh2KQurzEZWVke8W1LQlpspavwrvoBiXuaoo5o29Ul4jK0TrWswD8kCIfWOoGsqy0waGdEnG/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpwU0cWY7UpLsxSkXcnc3lBScMpDE5kWUIEg17lf+hbypIu9W
	zzwSaGtncj/2sLVUCwK+QaHg+Nggy2yfXBQNHJyjBEsSfvR+thdnnV09NoTYE272mPM+R3J0gNf
	e5aNTW5w3zyCp8fs9j1vEIenzywE0OkEVL4AFD36vfHASjymAn04S1iVylWpWRBy0YP/HQhBMtN
	68BryX8W9pNQnAP81xyx5lRo3r17jSmDKfW3GfNDc=
X-Gm-Gg: ASbGncsP7m7Uv5roVktlbaUySpsJLxtU4O5t1Sn3eLCsTcGaZdB42H/X3lenS69JVCJ
	7y87wT3E9dm8RBDqYpidlx+SXbDYmBZUnWYfcblx3JuDP04iVaY6SPwGs81ACtzFZWfvOV6g1+R
	q7qpEO
X-Received: by 2002:a05:651c:f0b:b0:32b:7284:88 with SMTP id 38308e7fff4ca-32cc6497155mr9481531fa.7.1750912897682;
        Wed, 25 Jun 2025 21:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtsbqMmhUQDt3g/lzDAdNNkxTBoru/S0YT53I4ao37Pj6PTGdEtaqF1QaveXbM6nUgWJ79NXRNI5pAmP+QcLM=
X-Received: by 2002:a05:651c:f0b:b0:32b:7284:88 with SMTP id
 38308e7fff4ca-32cc6497155mr9481451fa.7.1750912897010; Wed, 25 Jun 2025
 21:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com> <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
 <aFTfQpsUiD1Hw3zU@mozart.vkv.me> <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
In-Reply-To: <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 26 Jun 2025 12:41:24 +0800
X-Gm-Features: Ac12FXwVhrQSkzcoVpHc2oLKhn6ivN0RCkYzP7E6RYXdDw0kLKji6YD38t9jrMg
Message-ID: <CAHj4cs_+dauobyYyP805t33WMJVzOWj=7+51p4_j9rA63D9sog@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144 bdev_count_inflight_rw+0x26e/0x410
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>, 
	linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu

Seems both the original and new warning are triggered, here is the full log=
:

[  957.877438] run blktests nvme/012 at 2025-06-25 23:58:12
[  958.533643] loop0: detected capacity change from 0 to 2097152
[  958.642850] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  959.512306] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[  959.519831] (NULL device *): {0:0} Association created
[  959.523618] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  959.582072] nvme nvme0: NVME-FC{0}: controller connect complete
[  959.582621] nvme nvme0: NVME-FC{0}: new ctrl: NQN
"blktests-subsystem-1", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  960.197452] nvme nvme1: NVME-FC{1}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  960.204257] (NULL device *): {0:1} Association created
[  960.205846] nvmet: Created discovery controller 2 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  960.218038] nvme nvme1: NVME-FC{1}: controller connect complete
[  960.218468] nvme nvme1: NVME-FC{1}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  960.249003] nvme nvme1: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  960.672600] (NULL device *): {0:1} Association deleted
[  960.690869] XFS (nvme0n1): Mounting V5 Filesystem
4cf8fd97-5f8e-48ea-b8d3-450aac8dc021
[  960.755721] XFS (nvme0n1): Ending clean mount
[  960.893903] (NULL device *): {0:1} Association freed
[  960.894140] (NULL device *): Disconnect LS failed: No Association
[ 1021.580164] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000d60a0/x00000000
[ 1021.580790] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001bcae8/x00000000
[ 1021.580868] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0001af68/x00000000
[ 1021.580941] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000c2200/x00000000
[ 1021.581011] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00005838/x00000000
[ 1021.581163] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00131fa0/x00000000
[ 1021.581260] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00144de0/x00000000
[ 1021.581327] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001f8408/x00000000
[ 1021.581343] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 1021.581393] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00076308/x00000000
[ 1021.590801] nvme nvme0: NVME-FC{0}: resetting controller
[ 1021.590861] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0003be10/x00000000
[ 1021.596242] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001cbf78/x00000000
[ 1021.596427] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0004d428/x00000000
[ 1021.596472] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001d1700/x00000000
[ 1021.596506] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0015de58/x00000000
[ 1021.596536] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000008c0/x00000000
[ 1021.596567] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001f22a0/x00000000
[ 1021.596615] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00100072/x00000000
[ 1021.596672] block nvme0n1: no usable path - requeuing I/O
[ 1021.596674] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001000b2/x00000000
[ 1021.602131] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001000f2/x00000000
[ 1021.602141] block nvme0n1: no usable path - requeuing I/O
[ 1021.602157] block nvme0n1: no usable path - requeuing I/O
[ 1021.607588] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00100132/x00000000
[ 1021.613050] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00100172/x00000000
[ 1021.613084] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001001b2/x00000000
[ 1021.613119] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001001f2/x00000000
[ 1021.613151] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(Flush) w10/11: x00000000/x00000000
[ 1021.613198] block nvme0n1: no usable path - requeuing I/O
[ 1021.618681] block nvme0n1: no usable path - requeuing I/O
[ 1021.624099] block nvme0n1: no usable path - requeuing I/O
[ 1021.629514] block nvme0n1: no usable path - requeuing I/O
[ 1021.634935] block nvme0n1: no usable path - requeuing I/O
[ 1021.640351] block nvme0n1: no usable path - requeuing I/O
[ 1021.645775] block nvme0n1: no usable path - requeuing I/O
[ 1022.169519] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 1022.169566] ------------[ cut here ]------------
[ 1022.174594] WARNING: CPU: 12 PID: 466 at block/blk-core.c:1071
bdev_end_io_acct+0x494/0x5c0
[ 1022.176221] (NULL device *): {0:1} Association created
[ 1022.183010] Modules linked in: loop nvme_fcloop nvmet_fc nvmet
nvme_fc nvme_fabrics nvme_core nvme_keyring nvme_auth rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common skx_edac skx_edac_common
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200
irqbypass iTCO_wdt i2c_algo_bit rapl cdc_ether iTCO_vendor_support
drm_client_lib mei_me drm_shmem_helper dell_smbios usbnet intel_cstate
platform_profile dcdbas intel_uncore dell_wmi_descriptor wmi_bmof
pcspkr mii ipmi_ssif drm_kms_helper i2c_i801 mei lpc_ich i2c_smbus
intel_pch_thermal ipmi_si acpi_power_meter acpi_ipmi dax_pmem
ipmi_devintf ipmi_msghandler drm fuse xfs sd_mod sg nd_pmem nd_btt
ahci libahci ghash_clmulni_intel bnxt_en libata tg3 megaraid_sas wmi
nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod
[ 1022.183834] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1022.223500] ------------[ cut here ]------------
[ 1022.223572] WARNING: CPU: 42 PID: 2014 at block/genhd.c:146
bdev_count_inflight_rw+0x2a6/0x410
[ 1022.223596] Modules linked in: loop nvme_fcloop nvmet_fc nvmet
nvme_fc nvme_fabrics nvme_core nvme_keyring nvme_auth rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common skx_edac skx_edac_common
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200
irqbypass iTCO_wdt i2c_algo_bit rapl cdc_ether iTCO_vendor_support
drm_client_lib mei_me drm_shmem_helper dell_smbios usbnet intel_cstate
platform_profile dcdbas intel_uncore dell_wmi_descriptor wmi_bmof
pcspkr mii ipmi_ssif drm_kms_helper i2c_i801 mei lpc_ich i2c_smbus
intel_pch_thermal ipmi_si acpi_power_meter acpi_ipmi dax_pmem
ipmi_devintf ipmi_msghandler drm fuse xfs sd_mod sg nd_pmem nd_btt
ahci libahci ghash_clmulni_intel bnxt_en libata tg3 megaraid_sas wmi
nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod
[ 1022.224168] CPU: 42 UID: 0 PID: 2014 Comm: fio Not tainted
6.16.0-rc3.yu+ #2 PREEMPT(voluntary)
[ 1022.224185] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.22.2 09/12/2024
[ 1022.224194] RIP: 0010:bdev_count_inflight_rw+0x2a6/0x410
[ 1022.224207] Code: fa 48 c1 ea 03 0f b6 14 02 4c 89 f8 83 e0 07 83
c0 03 38 d0 7c 08 84 d2 0f 85 59 01 00 00 41 c7 07 00 00 00 00 e9 75
ff ff ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 0f
b6 14
[ 1022.224219] RSP: 0018:ffffc9000e2578c8 EFLAGS: 00010286
[ 1022.224234] RAX: 00000000ffffffff RBX: 0000000000000030 RCX: ffffffffb00=
90a46
[ 1022.224243] RDX: 0000000000000000 RSI: 0000000000000030 RDI: ffffffffb26=
e42c0
[ 1022.224252] RBP: ffffe8ffffa4e440 R08: 0000000000000000 R09: fffff91ffff=
49c9a
[ 1022.224262] R10: ffffe8ffffa4e4d7 R11: 0000000000000000 R12: ffff88a9227=
76e40
[ 1022.224270] R13: dffffc0000000000 R14: ffffc9000e257984 R15: ffffc9000e2=
57980
[ 1022.224280] FS:  00007feaa0b15640(0000) GS:ffff889c401a7000(0000)
knlGS:0000000000000000
[ 1022.224291] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1022.224300] CR2: 0000562e119e6018 CR3: 00000005a21ca003 CR4: 00000000007=
726f0
[ 1022.224309] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1022.224318] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1022.224326] PKRU: 55555554
[ 1022.224333] Call Trace:
[ 1022.224342]  <TASK>
[ 1022.224383]  part_stat_show+0x9e/0x290
[ 1022.224401]  ? rcu_is_watching+0x11/0xb0
[ 1022.224422]  ? trace_contention_end+0x150/0x1c0
[ 1022.224447]  ? __pfx_part_stat_show+0x10/0x10
[ 1022.224478]  ? __lock_acquire+0x6f1/0xc00
[ 1022.224528]  ? find_held_lock+0x32/0x90
[ 1022.224541]  ? local_clock_noinstr+0x9/0xc0
[ 1022.224565]  ? __lock_release+0x1a2/0x2c0
[ 1022.224619]  dev_attr_show+0x3f/0xc0
[ 1022.224636]  ? __asan_memset+0x20/0x50
[ 1022.224656]  sysfs_kf_seq_show+0x1a4/0x3b0
[ 1022.224693]  seq_read_iter+0x40b/0x1090
[ 1022.224747]  ? rw_verify_area+0x2fd/0x520
[ 1022.224777]  vfs_read+0x74e/0xc30
[ 1022.224798]  ? __pfx___mutex_lock+0x10/0x10
[ 1022.224816]  ? find_held_lock+0x32/0x90
[ 1022.224838]  ? __pfx_vfs_read+0x10/0x10
[ 1022.224866]  ? __fget_files+0x195/0x2e0
[ 1022.224885]  ? __fget_files+0x195/0x2e0
[ 1022.224954]  ksys_read+0xf3/0x1d0
[ 1022.224975]  ? __pfx_ksys_read+0x10/0x10
[ 1022.225064]  do_syscall_64+0x8c/0x3d0
[ 1022.225108]  ? __x64_sys_openat+0x11e/0x1e0
[ 1022.225134]  ? __pfx___x64_sys_openat+0x10/0x10
[ 1022.225178]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1022.225193]  ? lockdep_hardirqs_on+0x78/0x100
[ 1022.225211]  ? do_syscall_64+0x16e/0x3d0
[ 1022.225223]  ? lockdep_hardirqs_on+0x78/0x100
[ 1022.225241]  ? do_syscall_64+0x16e/0x3d0
[ 1022.225256]  ? do_syscall_64+0x16e/0x3d0
[ 1022.225285]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1022.225297] RIP: 0033:0x7feac08fe30c
[ 1022.225312] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08
e8 19 8b f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 6f 8b f8
ff 48
[ 1022.225322] RSP: 002b:00007feaa0b148a0 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 1022.225338] RAX: ffffffffffffffda RBX: 00007feab4000b60 RCX: 00007feac08=
fe30c
[ 1022.225347] RDX: 0000000000001000 RSI: 00007feab4001280 RDI: 00000000000=
00007
[ 1022.225356] RBP: 00007feac09f65e0 R08: 0000000000000000 R09: 00000000000=
00077
[ 1022.225364] R10: 0000000000000063 R11: 0000000000000246 R12: 00007feab40=
00b60
[ 1022.225373] R13: 0000000000000d68 R14: 00007feac09f59e0 R15: 00000000000=
00d68
[ 1022.225441]  </TASK>
[ 1022.225449] irq event stamp: 64865
[ 1022.225456] hardirqs last  enabled at (64871): [<ffffffffaf1f6ee1>]
console_trylock_spinning+0x221/0x260
[ 1022.225473] hardirqs last disabled at (64876): [<ffffffffaf1f6e91>]
console_trylock_spinning+0x1d1/0x260
[ 1022.225486] softirqs last  enabled at (63932): [<ffffffffaf01f7c8>]
handle_softirqs+0x5f8/0x920
[ 1022.225502] softirqs last disabled at (63923): [<ffffffffaf01fc9b>]
__irq_exit_rcu+0x11b/0x270
[ 1022.225513] ---[ end trace 0000000000000000 ]---
[ 1022.263295] CPU: 12 UID: 0 PID: 466 Comm: kworker/12:1H Tainted: G
      W           6.16.0-rc3.yu+ #2 PREEMPT(voluntary)
[ 1022.291560] nvme nvme0: NVME-FC{0}: controller connect complete
[ 1022.356344] Tainted: [W]=3DWARN
[ 1022.356348] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.22.2 09/12/2024
[ 1022.356352] Workqueue: kblockd blk_mq_run_work_fn
[ 1022.744652] RIP: 0010:bdev_end_io_acct+0x494/0x5c0
[ 1022.749466] Code: 22 fd ff ff 48 c7 44 24 08 10 00 00 00 41 be 30
00 00 00 48 c7 04 24 50 00 00 00 e9 c3 fb ff ff 0f 1f 44 00 00 e9 f5
fd ff ff <0f> 0b 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc
cc 48
[ 1022.768235] RSP: 0018:ffffc9000f9f78e8 EFLAGS: 00010297
[ 1022.773484] RAX: 00000000ffffffff RBX: ffff88a922776e64 RCX: ffffffffb00=
3853f
[ 1022.780632] RDX: ffffed15244eedcd RSI: 0000000000000004 RDI: ffff88a9227=
76e64
[ 1022.787784] RBP: ffffe8d448a4e440 R08: 0000000000000001 R09: ffffed15244=
eedcc
[ 1022.794934] R10: ffff88a922776e67 R11: 0000000000000000 R12: ffff88a9227=
76e68
[ 1022.802101] R13: 0000000000000001 R14: 0000000000000028 R15: 00000000000=
07e42
[ 1022.809251] FS:  0000000000000000(0000) GS:ffff889c3c5a7000(0000)
knlGS:0000000000000000
[ 1022.817352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1022.823114] CR2: 0000562e119bd048 CR3: 0000003661478001 CR4: 00000000007=
726f0
[ 1022.830265] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1022.837418] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1022.844561] PKRU: 55555554
[ 1022.847293] Call Trace:
[ 1022.849762]  <TASK>
[ 1022.851898]  nvme_end_req+0x4d/0x70 [nvme_core]
[ 1022.856494]  nvme_failover_req+0x3bd/0x530 [nvme_core]
[ 1022.861692]  nvme_fail_nonready_command+0x12c/0x170 [nvme_core]
[ 1022.867666]  nvme_fc_queue_rq+0x463/0x720 [nvme_fc]
[ 1022.872573]  ? flush_busy_ctx+0x2bd/0x410
[ 1022.876612]  ? __pfx_nvme_fc_queue_rq+0x10/0x10 [nvme_fc]
[ 1022.882040]  ? _raw_spin_unlock+0x29/0x50
[ 1022.886075]  ? flush_busy_ctx+0x2bd/0x410
[ 1022.890112]  blk_mq_dispatch_rq_list+0x358/0x1260
[ 1022.894846]  ? __pfx_blk_mq_flush_busy_ctxs+0x10/0x10
[ 1022.899914]  ? __pfx_blk_mq_dispatch_rq_list+0x10/0x10
[ 1022.905077]  ? __lock_acquire+0x6f1/0xc00
[ 1022.909119]  __blk_mq_sched_dispatch_requests+0x2dd/0x480
[ 1022.914543]  ? __pfx___blk_mq_sched_dispatch_requests+0x10/0x10
[ 1022.920484]  ? rcu_is_watching+0x11/0xb0
[ 1022.924437]  blk_mq_sched_dispatch_requests+0xa6/0x140
[ 1022.929597]  blk_mq_run_work_fn+0x1bb/0x2a0
[ 1022.933803]  process_one_work+0x8ca/0x1950
[ 1022.937956]  ? __pfx_process_one_work+0x10/0x10
[ 1022.942517]  ? assign_work+0x16c/0x240
[ 1022.946292]  worker_thread+0x58d/0xcf0
[ 1022.950080]  ? __pfx_worker_thread+0x10/0x10
[ 1022.954376]  kthread+0x3d5/0x7a0
[ 1022.957632]  ? __pfx_kthread+0x10/0x10
[ 1022.961411]  ? rcu_is_watching+0x11/0xb0
[ 1022.965362]  ? __pfx_kthread+0x10/0x10
[ 1022.969144]  ret_from_fork+0x403/0x510
[ 1022.972932]  ? __pfx_kthread+0x10/0x10
[ 1022.976701]  ret_from_fork_asm+0x1a/0x30
[ 1022.980671]  </TASK>
[ 1022.982879] irq event stamp: 4185
[ 1022.986216] hardirqs last  enabled at (4195): [<ffffffffaf1f438b>]
__up_console_sem+0x6b/0x80
[ 1022.994753] hardirqs last disabled at (4204): [<ffffffffaf1f4370>]
__up_console_sem+0x50/0x80
[ 1023.003288] softirqs last  enabled at (4140): [<ffffffffaf01f7c8>]
handle_softirqs+0x5f8/0x920
[ 1023.011932] softirqs last disabled at (4135): [<ffffffffaf01fc9b>]
__irq_exit_rcu+0x11b/0x270
[ 1023.020463] ---[ end trace 0000000000000000 ]---
[ 1023.042643] (NULL device *): {0:0} Association deleted
[ 1031.553369] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 1031.560460] nvmet: ctrl 1 fatal error occurred!
[ 1032.690809] (NULL device *): {0:0} Association freed
[ 1032.690915] (NULL device *): Disconnect LS failed: No Association
[ 1092.492635] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 0 fctype 1
(Flush) w10/11: x00000000/x00000000
[ 1092.492757] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001615e0/x00000000
[ 1092.492833] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001ee528/x00000000
[ 1092.492903] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000d9608/x00000000
[ 1092.492971] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001e6fc0/x00000000
[ 1092.493078] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001ce330/x00000000
[ 1092.493113] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 1092.493278] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00194c58/x00000000
[ 1092.501618] nvme nvme0: NVME-FC{0}: resetting controller
[ 1092.501646] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00036808/x00000000
[ 1092.507031] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00098858/x00000000
[ 1092.507083] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001d6af0/x00000000
[ 1092.507143] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00037110/x00000000
[ 1092.507211] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00028738/x00000000
[ 1092.507256] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000cb2f8/x00000000
[ 1092.507294] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001db548/x00000000
[ 1092.507294] nvme_ns_head_submit_bio: 53 callbacks suppressed
[ 1092.507319] block nvme0n1: no usable path - requeuing I/O
[ 1092.507332] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00164e88/x00000000
[ 1092.507370] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000c6a58/x00000000
[ 1092.513146] block nvme0n1: no usable path - requeuing I/O
[ 1092.518453] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00063908/x00000000
[ 1092.518473] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00101de4/x00000000
[ 1092.523917] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00101e24/x00000000
[ 1092.523927] block nvme0n1: no usable path - requeuing I/O
[ 1092.523939] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00101e64/x00000000
[ 1092.529353] block nvme0n1: no usable path - requeuing I/O
[ 1092.529362] block nvme0n1: no usable path - requeuing I/O
[ 1092.529370] block nvme0n1: no usable path - requeuing I/O
[ 1092.529379] block nvme0n1: no usable path - requeuing I/O
[ 1092.529387] block nvme0n1: no usable path - requeuing I/O
[ 1092.529395] block nvme0n1: no usable path - requeuing I/O
[ 1092.529407] block nvme0n1: no usable path - requeuing I/O
[ 1092.567521] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00101ea4/x00000000
[ 1092.567544] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00101ee4/x00000000
[ 1092.567565] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00101f24/x00000000
[ 1092.567586] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00101f64/x00000000
[ 1092.586616] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 1092.589236] (NULL device *): {0:0} Association created
[ 1092.590346] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1092.617739] (NULL device *): {0:1} Association deleted
[ 1092.618501] nvme nvme0: NVME-FC{0}: controller connect complete
[ 1101.692537] nvmet: ctrl 2 keep-alive timer (5 seconds) expired!
[ 1101.698582] nvmet: ctrl 2 fatal error occurred!
[ 1108.581555] (NULL device *): {0:1} Association freed
[ 1108.581673] (NULL device *): Disconnect LS failed: No Association
[ 1169.292656] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000ac410/x00000000
[ 1169.292773] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00022280/x00000000
[ 1169.292902] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00165558/x00000000
[ 1169.292975] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001e6be8/x00000000
[ 1169.293045] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00075aa0/x00000000
[ 1169.293121] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00096d28/x00000000
[ 1169.293190] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0016a1c8/x00000000
[ 1169.293210] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 1169.293285] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0018cc08/x00000000
[ 1169.301731] nvme nvme0: NVME-FC{0}: resetting controller
[ 1169.301750] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000e80b0/x00000000
[ 1169.307114] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001f0150/x00000000
[ 1169.307162] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0013c950/x00000000
[ 1169.307201] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001bcb50/x00000000
[ 1169.307245] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000ab668/x00000000
[ 1169.307290] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000f07f8/x00000000
[ 1169.307332] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00158748/x00000000
[ 1169.307371] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0002aea8/x00000000
[ 1169.307413] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(Flush) w10/11: x00000000/x00000000
[ 1169.307479] nvme_ns_head_submit_bio: 73 callbacks suppressed
[ 1169.307498] block nvme0n1: no usable path - requeuing I/O
[ 1169.318700] block nvme0n1: no usable path - requeuing I/O
[ 1169.324148] block nvme0n1: no usable path - requeuing I/O
[ 1169.329577] block nvme0n1: no usable path - requeuing I/O
[ 1169.335085] block nvme0n1: no usable path - requeuing I/O
[ 1169.340499] block nvme0n1: no usable path - requeuing I/O
[ 1169.345913] block nvme0n1: no usable path - requeuing I/O
[ 1169.351327] block nvme0n1: no usable path - requeuing I/O
[ 1169.356747] block nvme0n1: no usable path - requeuing I/O
[ 1169.362161] block nvme0n1: no usable path - requeuing I/O
[ 1169.388582] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 1169.395335] (NULL device *): {0:1} Association created
[ 1169.396654] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1169.404023] (NULL device *): {0:0} Association deleted
[ 1169.424767] nvme nvme0: NVME-FC{0}: controller connect complete
[ 1178.485216] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 1178.491269] nvmet: ctrl 1 fatal error occurred!
[ 1199.495733] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00165558/x00000000
[ 1199.495846] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00022280/x00000000
[ 1199.495921] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001e6be8/x00000000
[ 1199.495992] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00075aa0/x00000000
[ 1199.496059] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00096d28/x00000000
[ 1199.496141] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0016a1c8/x00000000
[ 1199.496217] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0018cc08/x00000000
[ 1199.496229] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 1199.496285] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001bcb50/x00000000
[ 1199.504778] nvme nvme0: NVME-FC{0}: resetting controller
[ 1199.505035] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000ab668/x00000000
[ 1199.510168] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000f07f8/x00000000
[ 1199.510209] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00158748/x00000000
[ 1199.510245] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0002aea8/x00000000
[ 1199.510287] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000e80b0/x00000000
[ 1199.510341] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001f0150/x00000000
[ 1199.510378] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0013c950/x00000000
[ 1199.510416] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000ac410/x00000000
[ 1199.510453] nvme nvme0: NVME-FC{0.2}: io timeout: opcode 0 fctype 1
(Flush) w10/11: x00000000/x00000000
[ 1199.548601] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 1199.550025] nvme_ns_head_submit_bio: 31 callbacks suppressed
[ 1199.550033] block nvme0n1: no usable path - requeuing I/O
[ 1199.555063] (NULL device *): {0:2} Association created
[ 1199.562849] nvmet: Created nvm controller 3 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1199.568924] block nvme0n1: no usable path - requeuing I/O
[ 1199.570148] (NULL device *): {0:1} Association deleted
[ 1199.574360] block nvme0n1: no usable path - requeuing I/O
[ 1199.574369] block nvme0n1: no usable path - requeuing I/O
[ 1199.574376] block nvme0n1: no usable path - requeuing I/O
[ 1199.574383] block nvme0n1: no usable path - requeuing I/O
[ 1199.574393] block nvme0n1: no usable path - requeuing I/O
[ 1199.574402] block nvme0n1: no usable path - requeuing I/O
[ 1199.574412] block nvme0n1: no usable path - requeuing I/O
[ 1199.574422] block nvme0n1: no usable path - requeuing I/O
[ 1199.606289] nvme nvme0: NVME-FC{0}: controller connect complete
[ 1199.851981] (NULL device *): {0:1} Association freed
[ 1199.852095] (NULL device *): Disconnect LS failed: No Association
[ 1199.865367] (NULL device *): {0:0} Association freed
[ 1199.865419] (NULL device *): Disconnect LS failed: No Association
[ 1260.424514] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001b5a00/x00000000
[ 1260.424632] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0014b5c0/x00000000
[ 1260.424708] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00122cf8/x00000000
[ 1260.424778] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000ac538/x00000000
[ 1260.424846] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000b6890/x00000000
[ 1260.424933] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001ddb68/x00000000
[ 1260.425009] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0006e720/x00000000
[ 1260.425021] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 1260.425076] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000c8948/x00000000
[ 1260.433557] nvme nvme0: NVME-FC{0}: resetting controller
[ 1260.438935] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00038560/x00000000
[ 1260.438966] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000c0480/x00000000
[ 1260.438995] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000e2948/x00000000
[ 1260.439025] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001ceff8/x00000000
[ 1260.439061] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0000de28/x00000000
[ 1260.439091] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000a3530/x00000000
[ 1260.439120] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000a9450/x00000000
[ 1260.439149] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0019be38/x00000000
[ 1260.439168] nvme_ns_head_submit_bio: 25 callbacks suppressed
[ 1260.439185] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(Flush) w10/11: x00000000/x00000000
[ 1260.439185] block nvme0n1: no usable path - requeuing I/O
[ 1260.444904] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00103fb5/x00000000
[ 1260.444933] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00103ff5/x00000000
[ 1260.450361] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00104035/x00000000
[ 1260.450382] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00103eb5/x00000000
[ 1260.450403] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00103ef5/x00000000
[ 1260.450423] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00103f35/x00000000
[ 1260.450445] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00103f75/x00000000
[ 1260.450515] block nvme0n1: no usable path - requeuing I/O
[ 1260.456040] block nvme0n1: no usable path - requeuing I/O
[ 1260.461481] block nvme0n1: no usable path - requeuing I/O
[ 1260.466899] block nvme0n1: no usable path - requeuing I/O
[ 1260.472327] block nvme0n1: no usable path - requeuing I/O
[ 1260.477737] block nvme0n1: no usable path - requeuing I/O
[ 1260.483157] block nvme0n1: no usable path - requeuing I/O
[ 1260.488570] block nvme0n1: no usable path - requeuing I/O
[ 1260.493987] block nvme0n1: no usable path - requeuing I/O
[ 1260.502057] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 1260.509561] (NULL device *): {0:0} Association created
[ 1260.511108] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1260.516897] (NULL device *): {0:2} Association deleted
[ 1260.552786] nvme nvme0: NVME-FC{0}: controller connect complete
[ 1270.637574] nvmet: ctrl 3 keep-alive timer (5 seconds) expired!
[ 1270.643622] nvmet: ctrl 3 fatal error occurred!
[ 1286.221388] (NULL device *): {0:2} Association freed
[ 1286.221515] (NULL device *): Disconnect LS failed: No Association
[ 1346.424230] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(Flush) w10/11: x00000000/x00000000
[ 1346.424294] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001d1d40/x00000000
[ 1346.424344] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001868b0/x00000000
[ 1346.424377] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001c6038/x00000000
[ 1346.424409] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000e5e20/x00000000
[ 1346.424441] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x001df538/x00000000
[ 1346.424483] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000103b8/x00000000
[ 1346.424516] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0018bb20/x00000000
[ 1346.424547] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0002de48/x00000000
[ 1346.424597] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000759d0/x00000000
[ 1346.424652] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x0012e340/x00000000
[ 1346.424685] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00055a20/x00000000
[ 1346.424719] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00074eb8/x00000000
[ 1346.424753] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 1346.424764] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00168cb0/x00000000
[ 1346.424867] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00045f98/x00000000
[ 1346.433288] nvme nvme0: NVME-FC{0}: resetting controller
[ 1346.433319] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x000fe478/x00000000
[ 1346.438737] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(Write) w10/11: x00153c98/x00000000
[ 1346.438905] nvme_ns_head_submit_bio: 49 callbacks suppressed
[ 1346.438922] block nvme0n1: no usable path - requeuing I/O
[ 1346.450290] block nvme0n1: no usable path - requeuing I/O
[ 1346.455823] block nvme0n1: no usable path - requeuing I/O
[ 1346.461263] block nvme0n1: no usable path - requeuing I/O
[ 1346.466683] block nvme0n1: no usable path - requeuing I/O
[ 1346.472095] block nvme0n1: no usable path - requeuing I/O
[ 1346.477510] block nvme0n1: no usable path - requeuing I/O
[ 1346.482926] block nvme0n1: no usable path - requeuing I/O
[ 1346.488343] block nvme0n1: no usable path - requeuing I/O
[ 1346.493759] block nvme0n1: no usable path - requeuing I/O
[ 1346.512987] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 1346.519457] (NULL device *): {0:1} Association created
[ 1346.520786] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1346.534750] (NULL device *): {0:0} Association deleted
[ 1346.550214] nvme nvme0: NVME-FC{0}: controller connect complete
[ 1356.646385] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 1356.652430] nvmet: ctrl 1 fatal error occurred!
[ 1359.532517] (NULL device *): {0:0} Association freed
[ 1359.532642] (NULL device *): Disconnect LS failed: No Association
[ 1419.047820] XFS (nvme0n1): Unmounting Filesystem
4cf8fd97-5f8e-48ea-b8d3-450aac8dc021
[ 1419.259166] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1419.452477] (NULL device *): {0:1} Association deleted
[ 1419.608635] (NULL device *): {0:1} Association freed
[ 1419.608751] (NULL device *): Disconnect LS failed: No Association
[ 1420.231038] nvme_fc: nvme_fc_create_ctrl:
nn-0x10001100ab000001:pn-0x20001100ab000001 -
nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[ 1426.441719] Key type psk unregistered
[ 1429.557488] Key type psk registered

On Fri, Jun 20, 2025 at 2:47=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/06/20 12:10, Calvin Owens =E5=86=99=E9=81=93:
> > I dumped all the similar WARNs I've seen here (blk-warn-%d.txt):
> >
> >      https://github.com/jcalvinowens/lkml-debug-616/tree/master
>
> These reports also contain both request-based and bio-based disk, I
> think perhaps following concurrent scenario is possible:
>
> While bdev_count_inflight is interating all cpu, some IOs are issued
> from traversed cpu and then completed from the cpu that is not traversed
> yet.
>
> cpu0
>                 cpu1
>                 bdev_count_inflight
>                  //for_each_possible_cpu
>                  // cpu0 is 0
>                  infliht +=3D 0
> // issue a io
> blk_account_io_start
> // cpu0 inflight ++
>
>                                 cpu2
>                                 // the io is done
>                                 blk_account_io_done
>                                 // cpu2 inflight --
>                  // cpu 1 is 0
>                  inflight +=3D 0
>                  // cpu2 is -1
>                  inflight +=3D -1
>                  ...
>
> In this case, the total inflight will be -1.
>
> Yi and Calvin,
>
> Can you please help testing the following patch, it add a WARN_ON_ONCE()
> using atomic operations, if the new warning is not reporduced while
> the old warning is reporduced, I think it can be confirmed the above
> analyze is correct, and I will send a revert for the WARN_ON_ONCE()
> change in bdev_count_inflight().
>
> Thanks,
> Kuai
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f2..2b033caa74e8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1035,6 +1035,8 @@ unsigned long bdev_start_io_acct(struct
> block_device *bdev, enum req_op op,
>          part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
>          part_stat_unlock();
>
> +       atomic_inc(&bdev->inflight[op_is_write(op)]);
> +
>          return start_time;
>   }
>   EXPORT_SYMBOL(bdev_start_io_acct);
> @@ -1065,6 +1067,8 @@ void bdev_end_io_acct(struct block_device *bdev,
> enum req_op op,
>          part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
>          part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
>          part_stat_unlock();
> +
> +       WARN_ON_ONCE(atomic_dec_return(&bdev->inflight[op_is_write(op)])
> < 0);
>   }
>   EXPORT_SYMBOL(bdev_end_io_acct);
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..ff15276d277f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -658,6 +658,8 @@ static void blk_account_io_merge_request(struct
> request *req)
>                  part_stat_local_dec(req->part,
>                                      in_flight[op_is_write(req_op(req))])=
;
>                  part_stat_unlock();
> +
> +
> WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(re=
q))])
> < 0);
>          }
>   }
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..94e728ff8bb6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1056,6 +1056,8 @@ static inline void blk_account_io_done(struct
> request *req, u64 now)
>                  part_stat_local_dec(req->part,
>                                      in_flight[op_is_write(req_op(req))])=
;
>                  part_stat_unlock();
> +
> +
> WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(re=
q))])
> < 0);
>          }
>   }
>
> @@ -1116,6 +1118,8 @@ static inline void blk_account_io_start(struct
> request *req)
>          update_io_ticks(req->part, jiffies, false);
>          part_stat_local_inc(req->part,
> in_flight[op_is_write(req_op(req))]);
>          part_stat_unlock();
> +
> +       atomic_inc(&req->part->inflight[op_is_write(req_op(req))]);
>   }
>
>   static inline void __blk_mq_end_request_acct(struct request *rq, u64 no=
w)
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 3d1577f07c1c..a81110c07426 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -43,6 +43,7 @@ struct block_device {
>          sector_t                bd_nr_sectors;
>          struct gendisk *        bd_disk;
>          struct request_queue *  bd_queue;
> +       atomic_t                inflight[2];
>          struct disk_stats __percpu *bd_stats;
>          unsigned long           bd_stamp;
>          atomic_t                __bd_flags;     // partition number + fl=
ags
>


--=20
Best Regards,
  Yi Zhang

