Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEED3A1E67
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767194440; cv=none; b=em+PEJvmtibTSnTe2c9ZuDcDleih/BdRhRe701Gm0qVr7xMUEs+x0e1HTGrgm/b6LCvF+2R+fXh6QZuUWTmmhhSOKEXL6GeGxeNnJCLiJKiE37VhuUjd47UyeRjQhLTd3OkBwl+IgU2pNrhAdl6dodDrqR3EjUJ2v4gQz92Tio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767194440; c=relaxed/simple;
	bh=B72fp/FL9ToAtzKoErt5U2CdERFyBi90uuAmuWsmILY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XLZvTsgZwM/37MCQZ773rtEhgbNYeTE0TXUv73NLs4R8c9WmnojomZ9uR6kcMOLaiE+h5mxOkmzYNOQLg4pL8ztTkBZMtjuw96qjjjoHzl6CaT+KC0SzV9ivHqy4BuxRmf/rxGszj/kiaBZlF3eiqMOuTmX9YaOIqve9UAP/Wog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOiS5fon; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EANAzDhb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOiS5fon";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EANAzDhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767194437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sP7w9mwoC0sWUxD8iwBfG1sVmiPRIXdoiMDwxe28xg0=;
	b=cOiS5fonBD99UaTsnztjEUwezEI7ptdaZK/+hBBNOzZwsnecn3lyYI0haE7kwVkD2f+D9g
	87gCGzrp0izyssKq1Ajv4XiNEUysFgDoANLqoc/tN6rd4isHN098eHSj7y6jlmBzD44GxK
	rEsxq9TmkdZn7bLag41pS49Z5YSzR5k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-CwqHAkrcO9CdtO4GGvZqeA-1; Wed, 31 Dec 2025 10:20:35 -0500
X-MC-Unique: CwqHAkrcO9CdtO4GGvZqeA-1
X-Mimecast-MFC-AGG-ID: CwqHAkrcO9CdtO4GGvZqeA_1767194434
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-37f98ab7cb3so41592071fa.0
        for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 07:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767194434; x=1767799234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sP7w9mwoC0sWUxD8iwBfG1sVmiPRIXdoiMDwxe28xg0=;
        b=EANAzDhbQibr8kz4O+iwD3sf61RlDiVeoym5LBBXbSpElzthT5d0A8JRh/TCb8uDTE
         hHk6AR46pNkqaYL1YKiTS+A/gs2GJR01GOrpEpGhFcfg7nUHkcu97xTbf1RZsVfeAi+9
         eVIW6C+Y42TxGYHSdYziNanGAB4eAHlDUGd8/byG3bXP9O+lJH45019Y2IvthYK4dVT/
         p6qxATNDaMa5ibqyOxLztlGCExqgyb4z1ehNNRKF06hllNNJ2wJZPTgIgHC+/XcJlWcm
         LZZr/Popwi37S/veCWQNv/mhkhQ/SxoFb+uuZ8dtp+ULsALu1kXauvHI4M1X2Y3rJmSo
         TXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767194434; x=1767799234;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP7w9mwoC0sWUxD8iwBfG1sVmiPRIXdoiMDwxe28xg0=;
        b=mglIInGsOn3uQYATDdZOiLvQHps8MtLSx+50x+rb1Dp9rwYryzhVGiVXGcqHDHbG5G
         Q/6/VGHkFgln/TonEB3Y3g0wfTILm2eexe14JUUlQRqe3R4Y4b5TOwBcpczGTJy0YQiy
         wj08PGpJrDp8cF8m+lhlFLnOoc3TNLQcHvJ0NpbM+m7FD1w0AWyuzOR38RH8BXCTqSFC
         vLbj52tKo8nkwrmZ87lmdmiztzdjASm8kpo2sq3hiePdChw7fnnNwXgYKwUhn7RjIj04
         NcerpSNYj+sBCg7IDQQHAPdmnkEw6gEmo7vf+fuShuOB1sF12nU+yssm5M4qxqvduFG4
         cn3w==
X-Gm-Message-State: AOJu0Yxixw90bz1MbUYM+NZhBPJOO05DEEmFkqKQdMzxh9DC5khEZhVw
	RWewTlFE6iMqeVdBXNE+miogWkMro4ST2inDvQWvc9a5YwOfXx3F4AAkTFqj0MdpDV7QJbyrJ6n
	Kz3coStCkXzMbGWO6T7zOqNrs3Jbc26UOduLj7WugvtvHRZ/yzWRafB6SRM3Uc91yr4Y0CrlBjV
	Ub3+MG+z3kdUBKD8OgVoVeK0G35PiNGyrxnWFqVuc=
X-Gm-Gg: AY/fxX48EHLHZTM1+QZzym3Oqr+JdTgiBX9JbL43UBXUyytywpVFBhSXelqBadrWa48
	VFUA97sPvNSWuJ0N9Bvdo56AZ4P6jg3seiVsxE8ZhVvZbV9sKrIbfpbrehF2XXldMYZ5tS6ovEQ
	nOwEBTGEbWIm7nBVudgYlD7lYpoP9/g7RfWqpv21JY0gyRMKsUz3Nn+m0dr/1dYvIt02s=
X-Received: by 2002:a05:651c:1b08:b0:37a:2d23:9e81 with SMTP id 38308e7fff4ca-381215aa991mr94142251fa.16.1767194434082;
        Wed, 31 Dec 2025 07:20:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6438JA5gfSC+lA5GVdL+6o9AnZDftfsGigmtqiY3TFGNk8n1D0gdsZ8QnivA0OYsCoqTEgkq/RxbH3vPFhCk=
X-Received: by 2002:a05:651c:1b08:b0:37a:2d23:9e81 with SMTP id
 38308e7fff4ca-381215aa991mr94142171fa.16.1767194433634; Wed, 31 Dec 2025
 07:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 31 Dec 2025 23:20:21 +0800
X-Gm-Features: AQt7F2oQL8sPzX7jS-e_Ah3yyuDh1tT4fYGol2pfQ9xB4RafWrv8yavqSTasMNs
Message-ID: <CAHj4cs_i5rq40TgMEfNB6M+PVeU2YZ1z_WZ6Qc9DWa+hGZ8Q0g@mail.gmail.com>
Subject: [bug report] Oops: general protection fault observed with blktests
 nvme/fc nvme/031
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"

Hi

I reproduced this Oops issue with blktests nvme/fc nvme/031 on the
latest blktests nvme/fc nvme/031.
Please help check it and let me know if you need any info/test, thanks.

reproducer:
[ 5483.833251] Oops: general protection fault, probably for
non-canonical address 0x134a05bd4da73752: 0000 [#1] SMP KASAN NOPTI
[ 5483.844475] CPU: 3 UID: 0 PID: 104919 Comm: kworker/3:7 Kdump:
loaded Tainted: G W 6.19.0-rc2+ #2 PREEMPT(voluntary)
[ 5483.844485] Tainted: [W]=WARN
[ 5483.844488] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.21.1 09/24/2025
[ 5483.844492] Workqueue: events nvme_fc_handle_ls_rqst_work [nvme_fc]
[ 5483.873465] RIP: 0010:srso_safe_ret+0x5/0x20
[ 5483.877745] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 b8 48 8d
64 24 08 <c3> cc cc 0f ae e8 e8 f0 ff ff ff 0f 0b 66 66 2e 0f 1f 84 00
00 00
[ 5483.896492] RSP: 0018:ffffc9000d5bfb10 EFLAGS: 00010246
[ 5483.901726] RAX: 134a05bd4da73752 RBX: ffff888259a64758 RCX: 0000000000000000
[ 5483.908859] RDX: 1ffff1104b34c8ee RSI: ffff88824f116800 RDI: ffff888259a64758
[ 5483.915991] RBP: ffff88824f116940 R08: 0000000000000003 R09: 0000000000000000
[ 5483.923122] R10: ffffffffaf4ec167 R11: 6d766e20656d766e R12: 0000000000000000
[ 5483.930255] R13: ffff88825eb56800 R14: ffff88824f116800 R15: ffffffffc19f8820
[ 5483.937389] FS: 0000000000000000(0000) GS:ffff88886dcc4000(0000)
knlGS:0000000000000000
[ 5483.945483] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5483.951228] CR2: 00007f8b14040e3c CR3: 0000000786678000 CR4: 0000000000350ef0
[ 5483.958361] Call Trace:
[ 5483.960814] <TASK>
[ 5483.962921] ? fcloop_t2h_xmt_ls_rsp+0x2d2/0x3d0 [nvme_fcloop]
[ 5483.968766] ? __pfx_fcloop_t2h_xmt_ls_rsp+0x10/0x10 [nvme_fcloop]
[ 5483.974948] ? nvme_fc_xmt_ls_rsp+0x156/0x1c0 [nvme_fc]
[ 5483.980191] ? nvme_fc_handle_ls_rqst_work+0x355/0x1180 [nvme_fc]
[ 5483.986294] ? rcu_is_watching+0x15/0xb0
[ 5483.990227] ? srso_return_thunk+0x5/0x5f
[ 5483.994246] ? process_one_work+0xd8b/0x1320
[ 5483.998534] ? __pfx_process_one_work+0x10/0x10
[ 5484.003073] ? srso_return_thunk+0x5/0x5f
[ 5484.007102] ? srso_return_thunk+0x5/0x5f
[ 5484.011123] ? assign_work+0x16c/0x240
[ 5484.014884] ? srso_return_thunk+0x5/0x5f
[ 5484.018910] ? worker_thread+0x5f3/0xfe0
[ 5484.022854] ? __pfx_worker_thread+0x10/0x10
[ 5484.027130] ? kthread+0x3b4/0x770
[ 5484.030544] ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 5484.035344] ? srso_return_thunk+0x5/0x5f
[ 5484.039359] ? __pfx_kthread+0x10/0x10
[ 5484.043118] ? lock_acquire+0x10b/0x140
[ 5484.046959] ? calculate_sigpending+0x3d/0x90
[ 5484.051327] ? srso_return_thunk+0x5/0x5f
[ 5484.055347] ? rcu_is_watching+0x15/0xb0
[ 5484.059272] ? srso_return_thunk+0x5/0x5f
[ 5484.063285] ? __pfx_kthread+0x10/0x10
[ 5484.067042] ? ret_from_fork+0x4ce/0x710
[ 5484.070974] ? __pfx_ret_from_fork+0x10/0x10
[ 5484.075258] ? srso_return_thunk+0x5/0x5f
[ 5484.079276] ? __switch_to+0x528/0xf50
[ 5484.083037] ? __switch_to_asm+0x39/0x70
[ 5484.086972] ? __pfx_kthread+0x10/0x10
[ 5484.090734] ? ret_from_fork_asm+0x1a/0x30
[ 5484.094855] </TASK>
[ 5484.097049] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc
nvme_fabrics rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd
grace nfs_localio netfs platform_profile dell_wmi dell_smbios
sparse_keymap amd_atl intel_rapl_msr rfkill intel_rapl_common video
amd64_edac dcdbas edac_mce_amd kvm_amd vfat fat cdc_ether usbnet kvm
mii irqbypass mgag200 rapl wmi_bmof dell_wmi_descriptor i2c_algo_bit
pcspkr acpi_cpufreq i2c_piix4 ptdma i2c_smbus ipmi_ssif k10temp
acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg
loop fuse xfs sd_mod nvme ahci nvme_core libahci tg3
ghash_clmulni_intel nvme_keyring libata ccp nvme_auth mpt3sas hkdf
raid_class scsi_transport_sas sp5100_tco wmi sunrpc dm_mirror
dm_region_hash dm_log dm_mod nfnetlink [last unloaded: nvmet]



-- 
Best Regards,
  Yi Zhang

