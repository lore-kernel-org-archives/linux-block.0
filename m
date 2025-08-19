Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0C2EB85C
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613245; cv=none; b=VHmOBIe7JgV36Gjbl1FLRVHhz1cZmYg5tL2y1m5ewefvEvO6Sd2o6Hjmr2AlFg20qOy14lhE+Q7wkiSKYQte+GcqW3JuTyb96AUk5sD7HVNBpO7YPBZpazBfQX7Amb6pzoUzMt+ljChTiVQbT7Iuqzrnh4gDyaQVcyb+T3zJi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613245; c=relaxed/simple;
	bh=HKXdrh3CfwG2GnVt/ni1pyfSDpsfLctzDgX0xHUSlPE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I6zvURJwW0VpiYfdtNobUPYMsEFKfNRvk4ZUIoW+8XCouSV/4BDFL5xnJXWtgkq8KqbygaOuOeRfZxeOy8dfZdMSpfKLHTmrR4QrLuyXaZeIt6SXOm2JJM1CzHyzhXsIBJQohkxk+cs4rLsJfCrbsDg9AVejsai0dDwu3lT73nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gl2v+js0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gl2v+js0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sDIQjlMUSdOdSKvI46pnBA/l54nA9xgnR29MGytTfRM=;
	b=gl2v+js0KPKrP/tAgD95bWzeQy6vN6HQ0HnXxcf7lB9OAwCbXaFRdlPQLBu0xrP1piuOMS
	gEa3Jzw+BJrF3aOmlfyljxJTkaK1J1AvJXGdX05JZ0MvYIW5x+tdBx9XQ0vJfV4PeE/KfR
	HaNaudyokY/Wu0g2Oe6ZhD7FWldDZfo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-P6ueeJzUO_SrwyQmZDjtmA-1; Tue, 19 Aug 2025 10:20:40 -0400
X-MC-Unique: P6ueeJzUO_SrwyQmZDjtmA-1
X-Mimecast-MFC-AGG-ID: P6ueeJzUO_SrwyQmZDjtmA_1755613240
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581187c6so61813665ad.1
        for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 07:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613239; x=1756218039;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDIQjlMUSdOdSKvI46pnBA/l54nA9xgnR29MGytTfRM=;
        b=PiCngB3bVSfoqUFvZes0JtWGY3lThripod1iXznM3xMS6FucU5pZRhpWHZKmM3Bh1w
         XHIAVtxtclqYrlDktMy014XLS15MlfL33QEhLCpUH+peAa9/Z+NtHnDbdAhiCd3I2xdm
         ObLNkKtI/4jSloqXP0qih3qCONMaUe00zsHPYSN20YHp1/SLURQnFTYzcFWg+qzyJuOk
         /iwfcBi3x8uQYpl5aZIqdtlAU1FH/Oavnnnt+uMW2cIB+bvhb0wuXOfrOjNj+fKFgFWK
         TY7g7nud7tv/9QPK4u5o6RvD6aSNTGs9Loey+vQbA24m0WqhFkbxRXYnmI8TfL7UlV9W
         Rikg==
X-Gm-Message-State: AOJu0Yz/aQgRnr2dKIKHAzFxQRelnMQRh5GIwIqU9ULAUGtwxfzDhizB
	qysFMGqBPbChtqigxMAPxqzwa9qRY6pKXVoue0ss3EUV734XojQoaxU6OCPv0fpw1kz8jNIvE5v
	Liq1SBXqURPHAGg7CwQNBkzHCfpl50k3xhy9Y8ktTCURzTBPIf4ANodNXPQabBWlhFPke+DGX4N
	EHBaNyUt41opvMm1If5ExA7fc6QLEazYQdkRO+GSq4hm33AWN4Mg==
X-Gm-Gg: ASbGncsBGuVOVFcVjcYB+MxBtKEsMwixGaU8CT2vFz4yJitcXO8TKR//pp7NkqdPpAl
	GK64dXGuwKCy3jiFNGp5pArK7/T4JjoV7fNd8BjYxLkQjoyxLNcBLv5jpKL0YL3nTU/d9Kqfi1T
	hdhl3B74DOg8j/BbsLWYEzqA==
X-Received: by 2002:a17:902:fc8e:b0:242:fb7d:1d57 with SMTP id d9443c01a7336-245e04c4f44mr29164135ad.42.1755613239432;
        Tue, 19 Aug 2025 07:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ75d+3wWtjY6ja/3oVSiHhpoeztoHoYA3Yx/CAgzTbrDkT7uInY9nBHMnAxoTnQC37A94rrMf3Dp6oIaEGuY=
X-Received: by 2002:a17:902:fc8e:b0:242:fb7d:1d57 with SMTP id
 d9443c01a7336-245e04c4f44mr29163725ad.42.1755613238917; Tue, 19 Aug 2025
 07:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 19 Aug 2025 22:20:27 +0800
X-Gm-Features: Ac12FXyEDH2q8FeqBCXI3QgvcVaHlfW01L6U0yS9TFodTzjMxuF79IMU2e8tDAc
Message-ID: <CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=ksN6EcvyypAtFDOUf30A@mail.gmail.com>
Subject: [bug report] BUG zs_handle-zram0 (Tainted: G S ): Objects remaining
 on __kmem_cache_shutdown()
To: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

the following bug and warning was triggered,
please help check and let me know if you need any info/test, thanks.

repo=EF=BC=9Ahttps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git
branch=EF=BC=9Amaster
INFO: HEAD of cloned kernel=EF=BC=9A
commit be48bcf004f9d0c9207ff21d0edb3b42f253829e
Merge: 074e461d9ed5 74857fdc5dd2
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Aug 18 09:17:42 2025 -0700

    Merge tag 'for-6.17-rc2-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux

reproducer:
# modprobe zram
# zramctl --find --size 4G --algorithm zstd
# fio --name=3Dtest \
        --filename=3D/dev/zram0 \
        --rw=3Drandrw \
        --bs=3D4k \
        --ioengine=3Dlibaio \
        --iodepth=3D16 \
        --numjobs=3D4 \
        --runtime=3D60 \
        --time_based \
        --group_reporting \
        --direct=3D1
# echo 1 > /sys/block/zram0/reset

dmesg log:
[ 4861.143371] zsmalloc: Class-80 fullness group 1 is not empty
[ 4861.149696] zsmalloc: Class-112 fullness group 1 is not empty
[ 4861.156121] zsmalloc: Class-144 fullness group 1 is not empty
[ 4861.162541] zsmalloc: Class-160 fullness group 1 is not empty
[ 4861.168963] zsmalloc: Class-176 fullness group 1 is not empty
[ 4861.175379] zsmalloc: Class-192 fullness group 1 is not empty
[ 4861.181797] zsmalloc: Class-224 fullness group 1 is not empty
[ 4861.205986] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[ 4861.215123] BUG zs_handle-zram0 (Tainted: G S                 ):
Objects remaining on __kmem_cache_shutdown()
[ 4861.226193] ------------------------------------------------------------=
-----------------
[ 4861.226193]
[ 4861.236981] Object 0x00000000364c25c1 @offset=3D3336
[ 4861.242331] Slab 0x0000000040c2ee59 objects=3D512 used=3D1
fp=3D0x00000000ad7304d7
flags=3D0x17ffffc0000200(workingset|node=3D0|zone=3D2|lastcpupid=3D0x1fffff=
)
[ 4861.256893] Disabling lock debugging due to kernel taint
[ 4861.262831] ------------[ cut here ]------------
[ 4861.267982] WARNING: CPU: 23 PID: 2847 at mm/slub.c:1171
__slab_err.part.0+0x19/0x20
[ 4861.276635] Modules linked in: zram 842_decompress lz4hc_compress
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
[ 4861.368551] CPU: 23 UID: 0 PID: 2847 Comm: bash Tainted: G S  B
          6.17.0-rc2+ #1 PREEMPT(voluntary)
[ 4861.379913] Tainted: [S]=3DCPU_OUT_OF_SPEC, [B]=3DBAD_PAGE
[ 4861.385639] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE118M-1.32 06/29/2022
[ 4861.395350] RIP: 0010:__slab_err.part.0+0x19/0x20
[ 4861.400604] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 0f 1f 44 00 00 e8 66 fc ff ff be 01 00 00 00 bf 05 00 00 00 e8 f7
83 10 00 <0f> 0b e9 10 c2 e7 00 48 c7 c7 3c 20 2f aa c6 05 6d 80 f3 01
01 e8
[ 4861.421562] RSP: 0018:ff7690a584a23c70 EFLAGS: 00010046
[ 4861.427387] RAX: 0000000000000000 RBX: ffdd3f4b88085780 RCX: 00000000000=
00027
[ 4861.435345] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff462f256ff=
dc180
[ 4861.443310] RBP: ff462f22566d3740 R08: 0000000000000000 R09: ff7690a584a=
23ae8
[ 4861.451276] R10: ffffffffaa922e28 R11: 0000000000000003 R12: ff7690a584a=
23c90
[ 4861.459242] R13: ff462f224a3f5000 R14: ffdd3f4b8428fd40 R15: ff462f22564=
12a00
[ 4861.467207] FS:  00007f9902945740(0000) GS:ff462f25c4a7b000(0000)
knlGS:0000000000000000
[ 4861.476230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4861.482646] CR2: 0000556ee84d1f90 CR3: 0000000109ef6002 CR4: 00000000007=
73ef0
[ 4861.490613] PKRU: 55555554
[ 4861.493624] Call Trace:
[ 4861.496354]  <TASK>
[ 4861.498686]  __kmem_cache_shutdown.cold+0x1c/0x46
[ 4861.503941]  kmem_cache_destroy+0x3f/0x150
[ 4861.508517]  zs_destroy_pool+0xc4/0xf0
[ 4861.512706]  zram_reset_device+0xdb/0x1c0 [zram]
[ 4861.517866]  reset_store+0xa8/0x110 [zram]
[ 4861.522443]  kernfs_fop_write_iter+0x13b/0x1f0
[ 4861.527406]  vfs_write+0x25d/0x450
[ 4861.531205]  ksys_write+0x6b/0xe0
[ 4861.534907]  do_syscall_64+0x7f/0x980
[ 4861.538996]  ? do_syscall_64+0xb1/0x980
[ 4861.543279]  ? do_user_addr_fault+0x206/0x690
[ 4861.548143]  ? clear_bhb_loop+0x50/0xa0
[ 4861.552426]  ? clear_bhb_loop+0x50/0xa0
[ 4861.556706]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4861.562345] RIP: 0033:0x7f9902a41894
[ 4861.566328] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 d8 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[ 4861.587279] RSP: 002b:00007fff33d6ab28 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 4861.595729] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9902a=
41894
[ 4861.603693] RDX: 0000000000000002 RSI: 0000556ee81a7570 RDI: 00000000000=
00001
[ 4861.611659] RBP: 0000556ee81a7570 R08: 0000000000000073 R09: 00000000fff=
fffff
[ 4861.619616] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[ 4861.627580] R13: 00007f9902b185c0 R14: 0000000000000002 R15: 00007f9902b=
15f00
[ 4861.635548]  </TASK>
[ 4861.637985] ---[ end trace 0000000000000000 ]---

Best Regards,
Changhui

