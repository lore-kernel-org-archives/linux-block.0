Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B5295D87
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929767; cv=none; b=F7SLhvdkGn7JVlmteYcW2zlPpqz6U6t7TptnwjXxg09DG5353mU+JJTx7F6Dxu9DrG/3YllQ6h1YmGLWFPOX7p6NSul6qIYzIaB41R2AbJgaZOa0DB9pofR534GqmdQHSyXuUBTYaF6hoHBZqVCm33OofYMV8T+g0iUDbI3aVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929767; c=relaxed/simple;
	bh=lX0Y6RU19QHoODfn0hrMLp9oWB23xCsfkb6vrnCcaDM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gPp0MxF9DdcueUvB/HcD1UnxtSPJz3fp24DVZjcNEv3Vaws6fhNoLFv+3k6/nVYgc66D9d72lHEt0MiuQiVs2/zhRZGBGPXAIAnTQMxK1u8AhipkVRTluyeCOHu3nQJf/0X0MxBQ7S3Q2Ls2vPntcm1/miC/+KItcc2FQKuz0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eu0O6PzP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eu0O6PzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750929764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=qfGttJZdgUcck+fXfK85zIliPH+l/j6ygcjkW8H8D0U=;
	b=Eu0O6PzPBO2CM6njRa8D07M75mN9WuO+D0Yigz6yQWor3wMuYQQDSpAeUrSVEcQq12/2sY
	1clF/VxLP/ASnzAdnQjnWzPzgkA41Yo+H3EDNYKa4f5dMXUYiNysqmfSan7gyv7vAT/3f/
	zRehTD0x/LItv+iAQKDYa/polx8fI48=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-rZxFFW9QON-CtXJKzNV3bQ-1; Thu, 26 Jun 2025 05:22:41 -0400
X-MC-Unique: rZxFFW9QON-CtXJKzNV3bQ-1
X-Mimecast-MFC-AGG-ID: rZxFFW9QON-CtXJKzNV3bQ_1750929760
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-553addbf0beso431487e87.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 02:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750929759; x=1751534559;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfGttJZdgUcck+fXfK85zIliPH+l/j6ygcjkW8H8D0U=;
        b=VP5rFymerpNRIl24/JFenNeDdFEqTrd/pl1xqH0XeALl8qL1xJ6s4o1n7ua+mQqGUZ
         +uAk7AAgipW1eg+N81NshI4T2VVKZcklQs0lNR1XwqUZ2P74vp6MKAXooWtvurjwgWX1
         eha+jXCO1Pbmx5vagElifB449EDNvepWxuKdMzKGGLb5dg2aDdTefjSecpByb7DnHISG
         HOzT8nFXt0XLxH5I9M9c9/zh/VviBBNPYzY4h7UXn1V514ts/0UyEG0S6iOLgqkJhbtz
         vYFfWTQ93+/mlm2sii9opIUiLfyB5ln6nKLjikeKgAEBkhWxUOO6lpU8R2V1sY3NriKm
         Ag3w==
X-Gm-Message-State: AOJu0YxeV6McycSTGQo+3sYeW4SyKjIcfzCFdfaL4uUM+wc4z/so6mmD
	TliJiVnm/HoZ5kT5hcnjyYRXM1umEWDVe04SC/EGAMN9bqe0BTZnYLbc12MMkc40kuuL60Q4A14
	s19VdX2WHQFK6n6vsTzGUVOU803ML0PINsMzUCMoLcfUGtw/m0cWULuwKLHTjMo/C6VzBuipoU5
	Z3YYk2YhtA7G7tgEuP8iyHzHpXtrmuYrXKqI7cNbNV32oWsiI0WJ+i
X-Gm-Gg: ASbGncuMsaxBb77577rSG2nRImuXPCrk1xVkoGe3a3YGXf1S0IjGnKDP6Y7ELBa+pkC
	koidDESDkMktaFemZ6KSUwHDm8+/1qsW/ifjFGQZMwaHzRdakPU9zAJN9xc8BAr4z5PFIrtecq4
	5AYrYA
X-Received: by 2002:a05:6512:2209:b0:553:2bf2:e303 with SMTP id 2adb3069b0e04-554fde579b0mr1993962e87.30.1750929759189;
        Thu, 26 Jun 2025 02:22:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJCv7PxAk1OxTCzrJjOCJj547K3qlhVVKjaIvpswLQXMaA0wAQTdQPtoCYH36SJKmw3/Tl9FtOfB25qsjB2D8=
X-Received: by 2002:a05:6512:2209:b0:553:2bf2:e303 with SMTP id
 2adb3069b0e04-554fde579b0mr1993948e87.30.1750929758578; Thu, 26 Jun 2025
 02:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 26 Jun 2025 17:22:26 +0800
X-Gm-Features: Ac12FXyZY6PWoJ469n-rRorQweZ37YuubtX1XQlAXOwJ1un6yDnDyU1xf_rE56c
Message-ID: <CAHj4cs8ejtqzdP=wC6Kjh9SA8q_NpG2sF_Mo1oprLP5U7Y-xeQ@mail.gmail.com>
Subject: [bug report] watchdog: BUG: soft lockup - CPU#47 stuck for 26s!
 [find:48492] triggered by blktests throtl/006
To: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello

The issue below was triggered by blktests throtl/006 on the latest
linux-block/for-next, please help check it and let me know if you need
any test/info, thanks.

commit: 9b3f9dc4b07e (HEAD -> for-next, origin/for-next) Merge branch
'for-6.17/block' into for-next

[ 8725.795546] run blktests throtl/006 at 2025-06-26 05:08:28
[ 8726.092039] null_blk: disk dev_nullb created
[ 8789.211527] EXT4-fs (dev_nullb): mounted filesystem
d4000821-4311-4fd7-b872-35e68c3efb74 r/w with ordered data mode. Quota
mode: none.
[ 8794.584324] EXT4-fs (dev_nullb): unmounting filesystem
d4000821-4311-4fd7-b872-35e68c3efb74.
[ 8821.751593] watchdog: BUG: soft lockup - CPU#47 stuck for 26s! [find:48492]
[ 8821.751602] Modules linked in: null_blk nbd ext4 crc16 mbcache jbd2
loop tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd
grace netfs rfkill sunrpc dm_multipath intel_rapl_msr
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
skx_edac skx_edac_common x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm mgag200 irqbypass i2c_algo_bit iTCO_wdt
cdc_ether rapl drm_client_lib iTCO_vendor_support usbnet ipmi_ssif
mei_me drm_shmem_helper intel_cstate dell_smbios platform_profile
dcdbas intel_uncore wmi_bmof dell_wmi_descriptor pcspkr mii
drm_kms_helper i2c_i801 mei i2c_smbus lpc_ich intel_pch_thermal
acpi_power_meter ipmi_si acpi_ipmi dax_pmem ipmi_devintf
ipmi_msghandler drm fuse xfs sd_mod sg nd_pmem nd_btt ahci
ghash_clmulni_intel libahci bnxt_en megaraid_sas tg3 libata wmi nfit
libnvdimm dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
scsi_debug]
[ 8821.751702] irq event stamp: 16082150
[ 8821.751704] hardirqs last  enabled at (16082149):
[<ffffffffb085ff69>] _raw_spin_unlock_irqrestore+0x59/0x70
[ 8821.751714] hardirqs last disabled at (16082150):
[<ffffffffb08391db>] sysvec_apic_timer_interrupt+0xb/0xd0
[ 8821.751720] softirqs last  enabled at (16081878):
[<ffffffffae01f7c8>] handle_softirqs+0x5f8/0x920
[ 8821.751727] softirqs last disabled at (16081637):
[<ffffffffae01fc9b>] __irq_exit_rcu+0x11b/0x270
[ 8821.751733] CPU: 47 UID: 0 PID: 48492 Comm: find Tainted: G
    L      6.16.0-rc3+ #4 PREEMPT(voluntary)
[ 8821.751740] Tainted: [L]=SOFTLOCKUP
[ 8821.751742] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.22.2 09/12/2024
[ 8821.751744] RIP: 0010:_raw_spin_unlock_irqrestore+0x3d/0x70
[ 8821.751748] Code: 74 24 10 e8 25 da 96 fd 48 89 ef e8 7d 48 97 fd
81 e3 00 02 00 00 75 29 9c 58 f6 c4 02 75 35 48 85 db 74 01 fb bf 01
00 00 00 <e8> 6e 3e 86 fd 65 8b 05 d7 10 e2 02 85 c0 74 0e 5b 5d c3 cc
cc cc
[ 8821.751751] RSP: 0018:ffffc900215bf998 EFLAGS: 00000206
[ 8821.751755] RAX: 0000000000000002 RBX: 0000000000000200 RCX: 0000000000000006
[ 8821.751757] RDX: 0000000000000000 RSI: ffffffffb1606f3d RDI: 0000000000000001
[ 8821.751759] RBP: ffffffffb6105538 R08: 0000000000000001 R09: 0000000000000001
[ 8821.751761] R10: ffffffffb2688aa7 R11: 0000000000000000 R12: ffff88ac203ba000
[ 8821.751763] R13: dffffc0000000000 R14: 000000000000001c R15: ffff88ac203bb000
[ 8821.751766] FS:  00007fec1d2ac800(0000) GS:ffff88c7f45a7000(0000)
knlGS:0000000000000000
[ 8821.751769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8821.751771] CR2: 00007fec1d2a6000 CR3: 0000002b71442003 CR4: 00000000007726f0
[ 8821.751773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8821.751775] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8821.751777] PKRU: 55555554
[ 8821.751778] Call Trace:
[ 8821.751780]  <TASK>
[ 8821.751783]  __debug_check_no_obj_freed+0x252/0x510
[ 8821.751801]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
[ 8821.751809]  ? __radix_tree_delete+0xa8/0x2e0
[ 8821.751821]  ? rcu_is_watching+0x11/0xb0
[ 8821.751832]  __free_frozen_pages+0x3c0/0x12d0
[ 8821.751849]  null_free_page+0x79/0xa0 [null_blk]
[ 8821.751863]  null_free_device_storage+0x129/0x230 [null_blk]
[ 8821.751881]  ? __pfx_null_free_device_storage+0x10/0x10 [null_blk]
[ 8821.751908]  ? null_del_dev.part.0+0x2a6/0x480 [null_blk]
[ 8821.751928]  nullb_device_release+0x1d/0x50 [null_blk]
[ 8821.751939]  config_item_cleanup+0xe7/0x210
[ 8821.751948]  configfs_rmdir+0x616/0x9e0
[ 8821.751955]  ? __pfx_may_link+0x10/0x10
[ 8821.751966]  ? __pfx_configfs_rmdir+0x10/0x10
[ 8821.751968]  ? __pfx_down_write+0x10/0x10
[ 8821.751984]  vfs_rmdir+0x1a1/0x590
[ 8821.751994]  do_rmdir+0x240/0x2d0
[ 8821.752001]  ? __pfx_do_rmdir+0x10/0x10
[ 8821.752018]  ? getname_flags.part.0+0xfd/0x490
[ 8821.752029]  __x64_sys_unlinkat+0xb5/0xf0
[ 8821.752036]  do_syscall_64+0x8c/0x3d0
[ 8821.752048]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 8821.752052] RIP: 0033:0x7fec1d0ffbcb
[ 8821.752057] Code: 73 01 c3 48 8b 0d 4d 92 0f 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07 01 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1d 92 0f 00 f7 d8 64 89
01 48
[ 8821.752059] RSP: 002b:00007ffe6f4cac58 EFLAGS: 00000206 ORIG_RAX:
0000000000000107
[ 8821.752062] RAX: ffffffffffffffda RBX: 0000000000000200 RCX: 00007fec1d0ffbcb
[ 8821.752065] RDX: 0000000000000200 RSI: 0000562dcf4945a0 RDI: 0000000000000005
[ 8821.752067] RBP: 0000562dcf4945a0 R08: 0000000000000001 R09: 0000000000000000
[ 8821.752069] R10: 00000000ffffffff R11: 0000000000000206 R12: 0000562dcf48a920
[ 8821.752071] R13: 0000000000000000 R14: 0000000000000005 R15: 0000562dcf4944a0
[ 8821.752092]  </TASK>


-- 
Best Regards,
  Yi Zhang

