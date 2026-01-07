Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F193A3A0B04
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804026; cv=none; b=I8ReqVKHSBzODGw+TIiIYVnA0oZgyyeggX6XvS7LbKxb8gS7Oo7OdL+W7GU1XRHrJxGSdbfXl0r1CKkr804ERWuxsnMp6XFreAk1UEQuZJB8ahyfuyXumC8/to/f8nafQm4lFc95nv44hHqTrXuTfMeakVvMTeGQu0jfEildCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804026; c=relaxed/simple;
	bh=sHqTSdLgr2Iyc+vbDsFhZMrdwEniiJ1YzF6DrA5eNvA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PtKHhSzVs3FRy5x0bHiAcVQMdr+2CKSujkLXFlADyFMdgLsqr2tgf9ba0I8K3MbjQEQWwbma0FFpjBAX66QyOIYQeY9S/uSyDrGdaqNQRqlz3dTJXKp9i8y22VMImsWh9J+3+N/odh3ZyP7Cf39e9Lv3nqA76A1yDUfi0MikAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQBTr+jX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfqlbKEN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQBTr+jX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfqlbKEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767804008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DARZ946lFDxoye1S+K396gTzOetkTzubXKCE3eNOsL8=;
	b=GQBTr+jX67+LGV4M5l40kt1mv6dXSISeRGy/z58wQ6uhoQaHA4kFNuo8hlHN0mZCAfmkCO
	Fp/glHD2MV3PPFki/xCLjD0/TFq84yA+c3RyYwGdJQR9qmWcupVuHFNqsqLQ9CRwEqmoLQ
	Pq4qA61FtTlmf6Yj+zdEjplz0bBJgos=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-4xfyBpXJNv-3pzjyNFK8eA-1; Wed, 07 Jan 2026 11:40:07 -0500
X-MC-Unique: 4xfyBpXJNv-3pzjyNFK8eA-1
X-Mimecast-MFC-AGG-ID: 4xfyBpXJNv-3pzjyNFK8eA_1767804006
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38302f5aba6so3878961fa.1
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 08:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767804005; x=1768408805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DARZ946lFDxoye1S+K396gTzOetkTzubXKCE3eNOsL8=;
        b=BfqlbKENFUYODy2yVGKpiOtjojExQtDCAG6iTnc+lMg0nOrC7Z2o+/TAq1cAGGEWG6
         /BsMRs0QE5/HPAaQn2qQLt4+nsW7YNtHtHROfZMjyyK4UuIpB7Ke+LZm877o8MTUlxdI
         VpM16RmqSOFvZNrPlJiGdRfLpc8e/wiCclxjqjZjMLfZ3xo2aQfXzYD7o4gaotzlyf/H
         J3xuzOhndsVyeAsnxRzDBXLxClIceRd3diJjQje1eMVCJQ79KBOXvXMzvxrIA/E3Dyyv
         tzS3YDccu2mrv5NnLLb5A4+MFifWGeIGXeYyAh14rOt/97cjkXjnTlAgG23Ar51Jrigu
         LIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767804005; x=1768408805;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DARZ946lFDxoye1S+K396gTzOetkTzubXKCE3eNOsL8=;
        b=AyDvF1hJSRYEIMopc/VesdvEKrv557QI0hrahDCbXke9ZW72uNQsm2DIXzIqNEvQxT
         WJ4yIID2iBw1F5yfBLP6R9GAqCmWUJkoIhe81xJt6lySQ2TKgEc7ou9+04EcdwqFCkvp
         7+qgME/NAj1FRo162dDfI2qv2zAYxWe7Y5HXfeJiEATnzDR5dGtYH0HD0xi7YHRzvzy6
         3SXCFSLkwXlb3/DSD1hboJi4jSwrPLNNdUw4NdevaYIl/LhbQ06SrlTaGL3n8fUJbGe+
         FLgbdTB9xizwrbmw/zWeVDN3kJbT0/zqt5y72YIcaa+Y85N3aPOUwqTuYaOZRWhBuCXd
         wvuA==
X-Gm-Message-State: AOJu0YwcuMitnL3FrWlKBGk3rfgzak9jDUcrl/K7Ao+JI28ZL6sypS8k
	0VCSKqMjmuljcyk6FzUkw61IH2Z5go3qcqOKPaCqk+kh8HKkuncceDAV1HNLEmayNBJZ4suJmcT
	jgS61ly20Bs+wMaA5oyYxcxcwCbnrwFdkNt3iZc5Rar5KTK0cLUilUuBbaYhPrIg6PpB89LmjFa
	b/Rq9hQ3GPrXyNcZg7y11Nfpn6hcQrbN/BFOUwGmLip/UvnR2uHitXNIQ=
X-Gm-Gg: AY/fxX5RK9H6HPUHq9JRqRIaFZ/0obZeWaSzgSPjARbgEliI5Q3yzz7jN1x8sakJPyD
	GiRb5GgfWdQjfqgAh7Rv0vvjLrjmyEz8ssJkEWfosT/dGXeIICB3HgjlhKDe8xFeI9shTqJHOzG
	fsCKdMnd3Fb+gpad+2pJ39l1gF0e43fDtg9Zwl/2en1D1XNnswGUBIAYzoPJWLsryLjn8=
X-Received: by 2002:a2e:a556:0:b0:37a:34e2:88e7 with SMTP id 38308e7fff4ca-382ff70c1d1mr8955911fa.22.1767804004917;
        Wed, 07 Jan 2026 08:40:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe+7D3BSTYTk6FG6Z8YqNA4jvcdVuRr1bH/Taw54lY3LaJmUGIfbgKrI8r1XMNUUqG3o/Xa9PsD6LktAh7N4M=
X-Received: by 2002:a2e:a556:0:b0:37a:34e2:88e7 with SMTP id
 38308e7fff4ca-382ff70c1d1mr8955721fa.22.1767804004355; Wed, 07 Jan 2026
 08:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 8 Jan 2026 00:39:50 +0800
X-Gm-Features: AQt7F2q2hCfDNgMmygQFavuZILWA4tYdMGcwyAL-X90UMyDyRNuOMlShK9ZGRxM
Message-ID: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
Subject: [bug report] kernel BUG at lib/list_debug.c:32! triggered by blktests nvme/049
To: linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hi
The following issue[2] was triggered by blktests nvme/059 and it's
100% reproduced with commit[1]. Please help check it and let me know
if you need any info/test for it.
Seems it's one regression, I will try to test with the latest
linux-block/for-next and also bisect it tomorrow.

[1]
commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
Merge: 29cefd61e0c6 fcf463b92a08
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Jan 6 05:48:07 2026 -0700

    Merge branch 'for-7.0/blk-pvec' into for-next

    * for-7.0/blk-pvec:
      types: move phys_vec definition to common header
      nvme-pci: Use size_t for length fields to handle larger sizes
[2]
[16866.579229] run blktests nvme/049 at 2026-01-07 02:00:14
[16869.709147]  slab io_kiocb start ffff88825e6ad400 pointer offset 144 size 248
[16869.716399] list_add corruption. prev->next should be next
(ffff888200596100), but was 0000000000000000. (prev=ffff88825e6ad490).
[16869.728106] ------------[ cut here ]------------
[16869.732738] kernel BUG at lib/list_debug.c:32!
[16869.737209] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[16869.742790] CPU: 15 UID: 0 PID: 71799 Comm: fio Kdump: loaded Not
tainted 6.19.0-rc3+ #1 PREEMPT(voluntary)
[16869.752614] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.21.1 09/24/2025
[16869.760267] RIP: 0010:__list_add_valid_or_report+0xf9/0x130
[16869.765849] Code: 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c
02 00 75 3c 49 8b 55 00 4c 89 e9 48 89 de 48 c7 c7 40 6d f6 9e e8 67
e1 a1 fe <0f> 0b 4c 89 e7 e8 8d eb 78 ff e9 3c ff ff ff 4c 89 ef e8 80
eb 78
[16869.784600] RSP: 0018:ffffc9000aadf990 EFLAGS: 00010282
[16869.789835] RAX: 0000000000000075 RBX: ffff888200596100 RCX: 0000000000000000
[16869.796967] RDX: 0000000000000075 RSI: ffffffff9ef66980 RDI: fffff5200155bf24
[16869.804101] RBP: ffff88825e6adc10 R08: 0000000000000001 R09: fffff5200155bee6
[16869.811234] R10: ffffc9000aadf737 R11: 0000000000000001 R12: ffff888200596108
[16869.818366] R13: ffff88825e6ad490 R14: ffff88825e6ad490 R15: ffff88825e6adc10
[16869.825500] FS:  00007f01a51bb740(0000) GS:ffff88887f6c4000(0000)
knlGS:0000000000000000
[16869.833591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16869.839338] CR2: 00007f019cdb7430 CR3: 00000001eeeae000 CR4: 0000000000350ef0
[16869.846469] Call Trace:
[16869.848923]  <TASK>
[16869.851034]  io_issue_sqe+0x7eb/0xdd0
[16869.854707]  ? srso_return_thunk+0x5/0x5f
[16869.858725]  ? io_uring_cmd_prep+0x350/0x560
[16869.863012]  io_submit_sqes+0x475/0x1000
[16869.866942]  ? srso_return_thunk+0x5/0x5f
[16869.870969]  ? __pfx_io_submit_sqes+0x10/0x10
[16869.875332]  ? srso_return_thunk+0x5/0x5f
[16869.879352]  ? __fget_files+0x1b6/0x2f0
[16869.883208]  __do_sys_io_uring_enter+0x433/0x820
[16869.887829]  ? fput+0x4c/0xa0
[16869.890809]  ? __pfx___do_sys_io_uring_enter+0x10/0x10
[16869.895958]  ? srso_return_thunk+0x5/0x5f
[16869.899978]  ? srso_return_thunk+0x5/0x5f
[16869.903999]  ? rcu_is_watching+0x15/0xb0
[16869.907934]  ? srso_return_thunk+0x5/0x5f
[16869.911953]  ? trace_irq_enable.constprop.0+0x13d/0x190
[16869.917183]  ? srso_return_thunk+0x5/0x5f
[16869.921203]  ? syscall_trace_enter+0x13e/0x230
[16869.925656]  ? srso_return_thunk+0x5/0x5f
[16869.929685]  do_syscall_64+0x95/0x520
[16869.933363]  ? srso_return_thunk+0x5/0x5f
[16869.937380]  ? trace_irq_enable.constprop.0+0x13d/0x190
[16869.942608]  ? srso_return_thunk+0x5/0x5f
[16869.946628]  ? do_syscall_64+0x16d/0x520
[16869.950556]  ? __pfx_pgd_none+0x10/0x10
[16869.954408]  ? srso_return_thunk+0x5/0x5f
[16869.958424]  ? __handle_mm_fault+0x97e/0x11d0
[16869.962795]  ? __pfx_css_rstat_updated+0x10/0x10
[16869.967421]  ? __pfx___handle_mm_fault+0x10/0x10
[16869.972050]  ? srso_return_thunk+0x5/0x5f
[16869.976069]  ? rcu_is_watching+0x15/0xb0
[16869.979995]  ? srso_return_thunk+0x5/0x5f
[16869.984016]  ? trace_count_memcg_events+0x14f/0x1a0
[16869.988905]  ? srso_return_thunk+0x5/0x5f
[16869.992924]  ? count_memcg_events+0xe5/0x370
[16869.997198]  ? srso_return_thunk+0x5/0x5f
[16870.001218]  ? srso_return_thunk+0x5/0x5f
[16870.005232]  ? __up_read+0x2c5/0x700
[16870.008821]  ? __pfx___up_read+0x10/0x10
[16870.012756]  ? handle_mm_fault+0x452/0x8a0
[16870.016862]  ? do_user_addr_fault+0x274/0xa60
[16870.021229]  ? srso_return_thunk+0x5/0x5f
[16870.025241]  ? rcu_is_watching+0x15/0xb0
[16870.029172]  ? srso_return_thunk+0x5/0x5f
[16870.033189]  ? rcu_is_watching+0x15/0xb0
[16870.037114]  ? srso_return_thunk+0x5/0x5f
[16870.041126]  ? trace_irq_enable.constprop.0+0x13d/0x190
[16870.046353]  ? srso_return_thunk+0x5/0x5f
[16870.050368]  ? srso_return_thunk+0x5/0x5f
[16870.054387]  ? irqentry_exit+0x93/0x5f0
[16870.058229]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[16870.063288] RIP: 0033:0x558b6250d067
[16870.066876] Code: 24 94 00 00 00 85 f6 74 78 49 8b 44 24 20 41 8b
3c 24 45 31 c0 45 31 c9 41 ba 01 00 00 00 31 d2 44 8b 38 b8 aa 01 00
00 0f 05 <48> 89 c3 89 c5 85 c0 7e 90 89 c2 44 89 fe 4c 89 ef e8 c3 d6
ff ff
[16870.085630] RSP: 002b:00007ffc479b70b0 EFLAGS: 00000246 ORIG_RAX:
00000000000001aa
[16870.093205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000558b6250d067
[16870.100335] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000007
[16870.107468] RBP: 00007f019cdb6000 R08: 0000000000000000 R09: 0000000000000000
[16870.114601] R10: 0000000000000001 R11: 0000000000000246 R12: 0000558b9f3eab00
[16870.121734] R13: 00007f019cdb6000 R14: 0000558b62527000 R15: 0000000000000001
[16870.128882]  </TASK>
[16870.131077] Modules linked in: ext4 crc16 mbcache jbd2
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace
nfs_localio netfs platform_profile dell_wmi dell_smbios intel_rapl_msr
amd_atl intel_rapl_common sparse_keymap amd64_edac rfkill edac_mce_amd
video vfat dcdbas fat kvm_amd cdc_ether usbnet kvm mii irqbypass
mgag200 wmi_bmof dell_wmi_descriptor rapl i2c_algo_bit pcspkr
acpi_cpufreq ipmi_ssif ptdma i2c_piix4 k10temp i2c_smbus
acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg
loop fuse xfs sd_mod nvme ahci libahci nvme_core mpt3sas
ghash_clmulni_intel tg3 nvme_keyring ccp libata raid_class nvme_auth
hkdf scsi_transport_sas sp5100_tco wmi sunrpc dm_mirror dm_region_hash
dm_log dm_mod nfnetlink [last unloaded: nvmet]

-- 
Best Regards,
  Yi Zhang

