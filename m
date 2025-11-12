Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420482BE02C
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938199; cv=none; b=pC5KGB+q//ROGfx5CnTbyNfsr8mGVOKQ7+GyO6Ywzncnk7MuCxdCGts4wKDQvP4jxhnd9DJwmiqWka5kJ2w/E1hPFauoIG9amNCf0WVQgDvd7YqbDa4FWw4yjiyRZXIn7diyAjJIEtVp2Xh1XyyPojpbWAtEMHBnLAOV5bICiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938199; c=relaxed/simple;
	bh=Ow7vIAjU+SiZpQTtMA6TzsfJUo5tFGjQa3z0lhIdVHw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bcw4Q6DW7VPIELa9ZMNg074hUoOLbxfOCa4QLX9aG2BFqZge4hOHMEsmCRdvrghlsHLHHpUo4WL4c6T+3bnTmm+fyp5KmcgB1y6FXmyRjiq9h19rxfmQTkRr3boF9MkY1xJMO8JvKw5GSHo1sBxjbQr/4O8hie5LFArgEiVJaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8Y+dJh7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUmmQzsD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8Y+dJh7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUmmQzsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762938196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=OVs3UnRzUFvqS/kxOOixa8C/mKBiUCs2Wodz5uBDZAI=;
	b=L8Y+dJh7h5i3xSoVTF2y3YAjQuKSoMDBr7BLGVYAIm135RVXNXpDiUvQQZy3j/R9f+bTu+
	P0CLAQhGTwWk9fOo6BHYmRBP7QpAT9d9Abbm7h3RK0ATuMbGagr5verLMz+q2gaHl68lfq
	1EwmWAL4Y1aQl/y0YX8kzEndlSlRftQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-RF_00e5xNMClL-DSMzjK1Q-1; Wed, 12 Nov 2025 04:03:14 -0500
X-MC-Unique: RF_00e5xNMClL-DSMzjK1Q-1
X-Mimecast-MFC-AGG-ID: RF_00e5xNMClL-DSMzjK1Q_1762938194
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e66542afso13802655ad.3
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762938193; x=1763542993; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OVs3UnRzUFvqS/kxOOixa8C/mKBiUCs2Wodz5uBDZAI=;
        b=NUmmQzsD7bDEolP9E6WXfVnCDlIv68+5fH66T4R3lFDdIhK6VrrZyZt17qlvlOs9Iz
         Gy7ipD3turISZhH6HlI2BLRKrrNthlgrNBtGbFkKbDAZJZA1f4pN8E3YWQytFkkzrLH5
         Zkmc70Q6A2pU5xfkvBfxdxRQWaXEVpq9rZcRk1MlhkasWicMyzEvhNtMtP0/b+AlUUrl
         Q3lExIr7fR5aBtoqnlxst4S/J6exWMjdx8vyUiMQYTEZNIIPbwa9SoZKWjPm/36X87Tb
         MfD1k/inVQGQd1OCipKwSDBgiFCcFWNxPb81WUrR5+vq4w0OOBWp2FpqTIIoj5G67mv2
         yENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938193; x=1763542993;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVs3UnRzUFvqS/kxOOixa8C/mKBiUCs2Wodz5uBDZAI=;
        b=T8XmwkaX8FxrAdUzEbOpP3bU1HcEMZjTXisBKhgo5p/yzqPAH7DcbC97RRxeKkh7CZ
         hYYz1X9ux+U6DI2HR2B7Nbxxl9EMjxf1PAL7IeS9Wej6g8cjkueMcSeidUY6r4kVSrzS
         TMYQsZRBaI/CLceXzsAY2xnlbmTFPOgl/Nj1fPkZ19jl8UNZJJpJ7/ya8mU4KYiKI94G
         ByGNNcr4TwRRnIW/AgfjtRfj88Ph6i94Uy54Kt5SIeqDOJhAlLfOmlkz3ustuJTGeOpa
         IiqtCzMosH3vXfIaCBWhwaMtshjyTktPNBTjY5QSHATX9WxVMR/JeqPN9DetRJnhNCIr
         BnzA==
X-Gm-Message-State: AOJu0Yw+3FnfcMc9UagSZvqHmSdKWtCVVMSKRNJXfKbboFe2BVFS6Ye2
	RB0nFlZXLmBAJU6qB47BqrVNyA/zUhQ9VPiicX3eBgy1PaRmb1mL745/q63CGTCYz8Gg0klcOL+
	cPSvhQFUOZ27+cOXLGWTShPaoF22j3fZuN+YdRCE8osv6vnUSWEdVh1UmttMZflHKyh1btyQq6U
	in3FUFNZc8sm4ec+NBfw26GpMrlXNovRQlnj7rKmbl2jh8KZTX9ndC
X-Gm-Gg: ASbGncvdSGwjUNdQ67IjL88ZYt18GdLVeFdTDXFohJJcE/Hkg4XiFyC80ZGVulEFeom
	Al6XDhKxzsD1mPyBfCuvdyyLK3WUfETqvBwxNv9RPX/wy7G0sBRJBVXW2+0GTU6/n93TLZmaFQo
	n7dJmwWvQJoP7MnVZQ6ud9Qn6MRhSYMpDb6AF8o+xst2KGYNVbQDAAOwPfTMhLRMlHASyU1cdFm
	20dkwvab/FEY3ckPHRbJ2azANU542qT3pxeDDvVhxLfiGfWY7pAvTUi6A==
X-Received: by 2002:a17:903:2c0f:b0:297:fc22:3ab2 with SMTP id d9443c01a7336-2984edcaca4mr28998485ad.36.1762938193316;
        Wed, 12 Nov 2025 01:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECk0fNHyMkvyVM/g+yV1M1DFlZNXlXxGh79YGHDHADJAAzOQCHjI+rb1dfFUi3IVHxXtMIr7kw4JpeYThdaV0=
X-Received: by 2002:a17:903:2c0f:b0:297:fc22:3ab2 with SMTP id
 d9443c01a7336-2984edcaca4mr28998145ad.36.1762938192837; Wed, 12 Nov 2025
 01:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 12 Nov 2025 17:02:59 +0800
X-Gm-Features: AWmQ_bnOl8RhDoCvXBNpIhkWFxt-WaHOblA7VVk9m5lUvGJmhyoD9jJsAEcT_Hc
Message-ID: <CAGVVp+VqVnvGeneUoTbYvBv2cw6GwQRrR3B-iQ-_9rVfyumoKA@mail.gmail.com>
Subject: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000050
To: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

the following kernel panic was triggered,
please help check and let me know if you need any info/test, thanks.

repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/
branch: for-next
INFO: HEAD of cloned kernel
commit 9d5d227cc571e4dde525aa4fa00bb049c436a9b9
Merge: 6e2eeb8123bc 6d7e3870af11
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Nov 11 08:39:32 2025 -0700

    Merge branch 'for-6.19/block' into for-next

    * for-6.19/block:
      blk-mq-dma: fix kernel-doc function name for integrity DMA iterator

reproducer:
# cat repro.sh
#!/bin/bash

for i in {0..3};do
        dd if=/dev/zero bs=1M count=2000 of=file$i.img
        sleep 1
        device=$(losetup -fP --show file$i.img)
        devices+=" $device"
        eval "dev$i=$device"
        sleep 1
        mkfs -t xfs -f $device
done

echo "dev list: $dev0 ,$dev1 ,$dev2 ,$dev3"
pvcreate -y $devices
vgcreate  black_bird $devices

lvcreate --type raid0 --stripesize 64k -i 3 \
        -n non_synced_primary_raid_3legs_1 -L 1G \
        black_bird $dev0:0-300 $dev1:0-300 \
        $dev2:0-300 $dev3:0-300


dmesg log:
[  375.341923] BUG: kernel NULL pointer dereference, address: 0000000000000050
[  375.349711] #PF: supervisor read access in kernel mode
[  375.355450] #PF: error_code(0x0000) - not-present page
[  375.361178] PGD 1366f3067 P4D 0
[  375.364783] Oops: Oops: 0000 [#1] SMP NOPTI
[  375.369454] CPU: 15 UID: 0 PID: 9991 Comm: lvcreate Kdump: loaded
Tainted: G S                  6.18.0-rc5+ #1 PREEMPT(voluntary)
[  375.382561] Tainted: [S]=CPU_OUT_OF_SPEC
[  375.386938] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE118M-1.32 06/29/2022
[  375.396647] RIP: 0010:create_strip_zones+0x3c/0x7d0 [raid0]
[  375.402872] Code: 49 89 fc 55 53 48 89 f3 48 83 ec 48 48 8b 3d 63
86 2a f3 48 89 74 24 38 be c0 0d 00 00 e8 9c c5 f9 f1 49 89 c6 49 8b
44 24 78 <48> 8b 40 50 8b a8 b0 00 00 00 48 c7 03 f4 ff ff ff 4d 85 f6
0f 84
[  375.423830] RSP: 0018:ff6856f988a0fa10 EFLAGS: 00010246
[  375.429655] RAX: 0000000000000000 RBX: ff6856f988a0fa90 RCX: 0000000000000000
[  375.437620] RDX: 0000000000000000 RSI: ffffffffc14cc7f4 RDI: ff20815ae89bdc60
[  375.445586] RBP: ffffffffc16407c5 R08: 0000000000000020 R09: 0000000000000000
[  375.453552] R10: ff6856f988a0fa10 R11: fefefefefefefeff R12: ff20815af4df6058
[  375.461516] R13: ffffffffc160b0c0 R14: ff20815ae89bdc40 R15: 0000000000000000
[  375.469480] FS:  00007f4bf7188940(0000) GS:ff20815e3a471000(0000)
knlGS:0000000000000000
[  375.478514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  375.484926] CR2: 0000000000000050 CR3: 0000000128c76004 CR4: 0000000000773ef0
[  375.492892] PKRU: 55555554
[  375.495912] Call Trace:
[  375.498641]  <TASK>
[  375.500986]  raid0_run+0x10d/0x150 [raid0]
[  375.505559]  md_run+0x2bb/0x790
[  375.509068]  ? __pfx_autoremove_wake_function+0x10/0x10
[  375.514906]  raid_ctr+0x492/0xcdb [dm_raid]
[  375.519579]  dm_table_add_target+0x193/0x3c0 [dm_mod]
[  375.525240]  populate_table+0x9a/0xd0 [dm_mod]
[  375.530214]  ? __pfx_table_load+0x10/0x10 [dm_mod]
[  375.535571]  table_load+0xc9/0x230 [dm_mod]
[  375.540250]  ctl_ioctl+0x1a0/0x300 [dm_mod]
[  375.544933]  dm_ctl_ioctl+0xe/0x20 [dm_mod]
[  375.549612]  __x64_sys_ioctl+0x96/0xe0
[  375.553800]  ? syscall_trace_enter+0xfe/0x1a0
[  375.558664]  do_syscall_64+0x7f/0x810
[  375.562757]  ? __rseq_handle_notify_resume+0x35/0x60
[  375.568301]  ? arch_exit_to_user_mode_prepare.isra.0+0xa2/0xd0
[  375.574816]  ? do_syscall_64+0xb1/0x810
[  375.579100]  ? clear_bhb_loop+0x30/0x80
[  375.583382]  ? clear_bhb_loop+0x30/0x80
[  375.587665]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  375.593303] RIP: 0033:0x7f4bf74464bf
[  375.597294] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
00 00
[  375.618244] RSP: 002b:00007ffef26ed6d0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  375.626695] RAX: ffffffffffffffda RBX: 00005583edb4f810 RCX: 00007f4bf74464bf
[  375.634660] RDX: 00005583edb4f8f0 RSI: 00000000c138fd09 RDI: 0000000000000003
[  375.642625] RBP: 00007ffef26ed8b0 R08: 00005583eadfbbb8 R09: 00007ffef26ed580
[  375.650588] R10: 0000000000000007 R11: 0000000000000246 R12: 00005583ead95d8c
[  375.658553] R13: 00005583edb4f9a0 R14: 00005583ead95d8c R15: 0000000000000020
[  375.666517]  </TASK>
[  375.668955] Modules linked in: raid0 dm_raid raid456
async_raid6_recov async_memcpy async_pq async_xor xor async_tx
raid6_pq tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd
grace nfs_localio netfs rfkill intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common i10nm_edac
skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm ipmi_ssif irqbypass rapl intel_cstate cdc_ether
iTCO_wdt usbnet mgag200 dax_hmem iTCO_vendor_support cxl_acpi cxl_port
cxl_core mii isst_if_mmio intel_uncore i2c_i801 isst_if_mbox_pci
i2c_algo_bit mei_me intel_th_gth ioatdma einj pcspkr i2c_smbus
isst_if_common intel_th_pci intel_pch_thermal mei intel_vsec intel_th
dca ipmi_si acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler
acpi_pad sg fuse loop xfs sd_mod ahci libahci libata
ghash_clmulni_intel tg3 wmi sunrpc dm_mirror dm_region_hash dm_log
dm_multipath dm_mod nfnetlink


Best Regards,
Changhui

