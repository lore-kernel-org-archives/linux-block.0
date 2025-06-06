Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828874A0A
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180688; cv=none; b=lUn5aHudIYBWb+QwDXbx8bLqO+gMlE4+sboeAfnjknSlFRjMRFLoE4KwfGwKmOAauM/cl1bDQ0IRrTCfzmz+NU5IE3qk14LtjEg087AVP732P+BaFL+bOdLovyWAk6lx3Yx8TlfATGJJvGHVVs0XK2hI7ozswe8O5sNljorbzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180688; c=relaxed/simple;
	bh=qGUbfeg4/e+WfGxksvHOxL80eVigT/8rsxGQJhhwvWk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U/HAyfWFCoqZaqfOgqFF9r3rZKMmTwkgHKSFYuDhxSudq3BJglMxRQrmsTymThWA4OiZH9QXZej/dxISev9U7tAnYusLEe+2XdlAO1vrEGHF/shu7+tDv4e3vvLFOdeXRG/NA/Q34sFz+aOxrHNM24ysjZEyjp2DLoKzszGQKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xy2Cfpid; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy2Cfpid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749180684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=3W2zmzBO2j0FzDyGDvgt+4uIWA7RiivIPoHGg3NGh0Q=;
	b=Xy2CfpidKBhaukR5PJMFrm6WVLa24L/4qAHt8LUiDS2iUW62bQ2ZwQmS+kGmZLQ5scZbxG
	m/AmO5LRv+bnHc84kjxq1TzXi7VUCizhOOuiWNPVWycnKyRXKZ0A00ohivyL9cwNUiNlaC
	NZHihcdij88/YdSvE+tyKoX6zeVS3N4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-WbFcZSvQPh2cUVPJoUjLpw-1; Thu, 05 Jun 2025 23:31:22 -0400
X-MC-Unique: WbFcZSvQPh2cUVPJoUjLpw-1
X-Mimecast-MFC-AGG-ID: WbFcZSvQPh2cUVPJoUjLpw_1749180681
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a87d56f8aso3760921fa.1
        for <linux-block@vger.kernel.org>; Thu, 05 Jun 2025 20:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749180680; x=1749785480;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3W2zmzBO2j0FzDyGDvgt+4uIWA7RiivIPoHGg3NGh0Q=;
        b=rxLioO8n+Szsw81H1QwgraSHjBAdMcuBPa1lKW18bcfAr2kjAxfDoLKwNhujWSZYgG
         vktSh4JBhnRLnr4n1B9X4NkbGK02ujE+6f7ZedzYOOKTg+VjRmCJbgMLnps5S3WKjR6u
         dW4jpjSRSiylyFHKy4WVediD7fe9FWqbe/in5VIcAjsOSaOD3jwyTCBuV2ChO4iy8atM
         N0WH/yTXWe/JrnJuajFcY/ucFYerr0JbqHM+6+L1/XC5v04D8tliWEGucMvPmuwCZhVL
         hM/e6O+z0wURE9zmrmgEY9cpwQMJVvGZRuKu2c3YvkHDHrc6LJDPMfKR66Rkhg9Y6U5Z
         q9Nw==
X-Gm-Message-State: AOJu0Yz8JZKr6ESgyGEY/n64gXxofLi/8dKHLfqOl+lrdyl31n93TcyR
	iXwNIeS/IwPSFuZ0SD6ORj0PDIw/TRfmr3QR5mgMW1U4DTmDq7GUq0twUJ5wenCv3FxDg3CO3K3
	ug0mA4yCdG8osBDqIt83Zt7rKsSgiH0hyuFlmidfnfOsooz0YJyCEXhkYM6WMLMzEI5ywm5ZOeq
	IJXYJPDopDZWKTupud/g6PLE5SqjmHHE+DBIQby6kKG/5zsQoySrqL
X-Gm-Gg: ASbGnctWeu0dhpIvh8GOy1q1mnrQVWzztRcrFmlStEZX0KI/hvI64KeiAqV/Q3ypIsc
	4YtypNpC7dk+d+DtEyTC+G6kxFAJIzslzsRAa+BRi14bbmTxtMT+XTdjIGc8SmccZIvU9LA==
X-Received: by 2002:a2e:8085:0:b0:32a:8030:6ff8 with SMTP id 38308e7fff4ca-32adfc00236mr3228071fa.10.1749180679577;
        Thu, 05 Jun 2025 20:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwV/6XKTdwtFpVybSePu6xsqiLMYmGgfxVcc+9SmIBnkLNqWMbaRF89Im2YvP2ul7gWLaNlWlzMXDoR8gvOdc=
X-Received: by 2002:a2e:8085:0:b0:32a:8030:6ff8 with SMTP id
 38308e7fff4ca-32adfc00236mr3227961fa.10.1749180678411; Thu, 05 Jun 2025
 20:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 6 Jun 2025 11:31:06 +0800
X-Gm-Features: AX0GCFvao_-DZwkI7lJqEWPIImBiLLZB3-y5uFPGnzuLKEe7eVk5wPGmIVbh-_U
Message-ID: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144 bdev_count_inflight_rw+0x26e/0x410
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hello

The following WARNING was triggered by blktests nvme/fc nvme/012,
please help check and let me know if you need any info/test, thanks.

commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
'block-6.16' into for-next

[ 2679.835074] run blktests nvme/012 at 2025-06-05 19:50:45
[ 2681.492049] loop0: detected capacity change from 0 to 2097152
[ 2681.678145] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2682.883261] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 2682.895317] (NULL device *): {0:0} Association created
[ 2682.902895] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2682.970869] nvme nvme0: NVME-FC{0}: controller connect complete
[ 2682.970996] nvme nvme0: NVME-FC{0}: new ctrl: NQN
"blktests-subsystem-1", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 2685.498124] XFS (nvme0n1): Mounting V5 Filesystem
3f19217c-d3fd-42af-9dbe-aa5dce6bb607
[ 2685.567936] XFS (nvme0n1): Ending clean mount
[ 2746.161840] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 2746.163061] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010007a/x00000000
[ 2746.163126] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001000ba/x00000000
[ 2746.163175] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001000fa/x00000000
[ 2746.163220] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010013a/x00000000
[ 2746.163265] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010017a/x00000000
[ 2746.163308] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001001ba/x00000000
[ 2746.163352] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001001fa/x00000000
[ 2746.163396] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d8618/x00000000
[ 2746.163441] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000d9d88/x00000000
[ 2746.163486] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00014be0/x00000000
[ 2746.163531] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001bb168/x00000000
[ 2746.163585] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0006b620/x00000000
[ 2746.163639] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000b6688/x00000000
[ 2746.164885] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000581c0/x00000000
[ 2746.166593] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001468c0/x00000000
[ 2746.166681] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00080780/x00000000
[ 2746.166732] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00147338/x00000000
[ 2746.166780] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000acee8/x00000000
[ 2746.166826] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00016e20/x00000000
[ 2746.166872] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0019add0/x00000000
[ 2746.166916] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001bdab8/x00000000
[ 2746.166960] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000ea0f8/x00000000
[ 2746.167005] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00006328/x00000000
[ 2746.170320] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 2746.173629] nvme nvme0: NVME-FC{0}: resetting controller
[ 2746.175966] block nvme0n1: no usable path - requeuing I/O
[ 2746.177234] block nvme0n1: no usable path - requeuing I/O
[ 2746.177571] block nvme0n1: no usable path - requeuing I/O
[ 2746.177916] block nvme0n1: no usable path - requeuing I/O
[ 2746.178228] block nvme0n1: no usable path - requeuing I/O
[ 2746.178576] block nvme0n1: no usable path - requeuing I/O
[ 2746.179173] block nvme0n1: no usable path - requeuing I/O
[ 2746.179476] block nvme0n1: no usable path - requeuing I/O
[ 2746.179807] block nvme0n1: no usable path - requeuing I/O
[ 2746.180146] block nvme0n1: no usable path - requeuing I/O
[ 2746.232899] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 2746.238446] (NULL device *): {0:1} Association created
[ 2746.239620] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2746.259174] (NULL device *): {0:0} Association deleted
[ 2746.296717] nvme nvme0: NVME-FC{0}: controller connect complete
[ 2755.870750] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 2755.873263] nvmet: ctrl 1 fatal error occurred!
[ 2769.422990] (NULL device *): Disconnect LS failed: No Association
[ 2769.424288] (NULL device *): {0:0} Association freed
[ 2801.582208] perf: interrupt took too long (2527 > 2500), lowering
kernel.perf_event_max_sample_rate to 79000
[ 2830.657742] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000a06a8/x00000000
[ 2830.657865] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000994d0/x00000000
[ 2830.657916] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000263b8/x00000000
[ 2830.657965] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000ecf10/x00000000
[ 2830.658010] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00054418/x00000000
[ 2830.658071] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001f42f0/x00000000
[ 2830.658088] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 2830.658119] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000bb588/x00000000
[ 2830.659087] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000fd620/x00000000
[ 2830.659134] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000d66b0/x00000000
[ 2830.659189] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00188488/x00000000
[ 2830.659233] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00086fd0/x00000000
[ 2830.659276] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001a0950/x00000000
[ 2830.659345] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00136340/x00000000
[ 2830.659390] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0013dc60/x00000000
[ 2830.659433] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00193530/x00000000
[ 2830.659500] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d3ff0/x00000000
[ 2830.659545] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00101455/x00000000
[ 2830.659589] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00101495/x00000000
[ 2830.659650] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001014d5/x00000000
[ 2830.659758] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00101515/x00000000
[ 2830.659842] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00101555/x00000000
[ 2830.659889] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00101595/x00000000
[ 2830.659904] nvme nvme0: NVME-FC{0}: resetting controller
[ 2830.659941] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001015d5/x00000000
[ 2830.660321] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 2830.660348] nvme_ns_head_submit_bio: 81 callbacks suppressed
[ 2830.660362] block nvme0n1: no usable path - requeuing I/O
[ 2830.661765] block nvme0n1: no usable path - requeuing I/O
[ 2830.662070] block nvme0n1: no usable path - requeuing I/O
[ 2830.662367] block nvme0n1: no usable path - requeuing I/O
[ 2830.662660] block nvme0n1: no usable path - requeuing I/O
[ 2830.663046] block nvme0n1: no usable path - requeuing I/O
[ 2830.663337] block nvme0n1: no usable path - requeuing I/O
[ 2830.663627] block nvme0n1: no usable path - requeuing I/O
[ 2830.663976] block nvme0n1: no usable path - requeuing I/O
[ 2830.664288] block nvme0n1: no usable path - requeuing I/O
[ 2830.700704] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 2830.706376] (NULL device *): {0:0} Association created
[ 2830.707571] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2830.725113] (NULL device *): {0:1} Association deleted
[ 2830.745872] ------------[ cut here ]------------
[ 2830.746780] WARNING: CPU: 49 PID: 1020 at block/genhd.c:146
bdev_count_inflight_rw+0x2a6/0x410
[ 2830.747730] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc
nvme_fabrics nvme_core nvme_keyring nvme_auth rfkill sunrpc
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel vfat
[ 2830.748536] nvme nvme0: NVME-FC{0}: controller connect complete
[ 2830.749958]  fat kvm irqbypass iTCO_wdt rapl iTCO_vendor_support
intel_cstate intel_uncore pcspkr bnx2x mgag200 i2c_i801 tg3 i2c_smbus
lpc_ich i2c_algo_bit hpilo ioatdma mdio dca ipmi_ssif ipmi_si acpi_tad
acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dax_pmem sg
fuse loop nfnetlink xfs nd_pmem sr_mod sd_mod cdrom
ghash_clmulni_intel hpsa scsi_transport_sas hpwdt ahci libahci libata
wmi nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod [last
unloaded: nvmet]
[ 2830.752807] CPU: 49 UID: 0 PID: 1020 Comm: kworker/49:1H Not
tainted 6.15.0+ #2 PREEMPT(lazy)
[ 2830.753650] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
Gen9, BIOS P89 10/05/2016
[ 2830.754291] Workqueue: kblockd nvme_requeue_work [nvme_core]
[ 2830.755188] RIP: 0010:bdev_count_inflight_rw+0x2a6/0x410
[ 2830.755503] Code: fa 48 c1 ea 03 0f b6 14 02 4c 89 f8 83 e0 07 83
c0 03 38 d0 7c 08 84 d2 0f 85 59 01 00 00 41 c7 07 00 00 00 00 e9 75
ff ff ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 0f
b6 14
[ 2830.756887] RSP: 0018:ffffc9000ad973e8 EFLAGS: 00010286
[ 2830.757221] RAX: 00000000ffffffff RBX: 0000000000000048 RCX: ffffffffa9b9ee56
[ 2830.758007] RDX: 0000000000000000 RSI: 0000000000000048 RDI: ffffffffac36b380
[ 2830.758831] RBP: ffffe8ffffa33758 R08: 0000000000000000 R09: fffff91ffff466fd
[ 2830.759609] R10: ffffe8ffffa337ef R11: 0000000000000001 R12: ffff888121d16200
[ 2830.760405] R13: dffffc0000000000 R14: ffffc9000ad97474 R15: ffffc9000ad97470
[ 2830.761226] FS:  0000000000000000(0000) GS:ffff888440550000(0000)
knlGS:0000000000000000
[ 2830.761724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2830.762472] CR2: 000055aa8905b038 CR3: 0000000bfae7a001 CR4: 00000000003726f0
[ 2830.763293] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2830.764124] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2830.764921] Call Trace:
[ 2830.765087]  <TASK>
[ 2830.765625]  bdev_count_inflight+0x6d/0xa0
[ 2830.765921]  ? __pfx_bdev_count_inflight+0x10/0x10
[ 2830.766604]  update_io_ticks+0x1bd/0x210
[ 2830.789758]  ? __pfx_update_io_ticks+0x10/0x10
[ 2830.823941]  ? nvme_fc_map_data+0x1d0/0x860 [nvme_fc]
[ 2830.861999]  bdev_start_io_acct+0x31/0xe0
[ 2830.893416]  nvme_mpath_start_request+0x222/0x390 [nvme_core]
[ 2830.934768]  nvme_fc_start_fcp_op+0xc4c/0xfe0 [nvme_fc]
[ 2830.973158]  ? trace_nvme_setup_cmd+0x149/0x1b0 [nvme_core]
[ 2831.011196]  ? __pfx_nvme_fc_start_fcp_op+0x10/0x10 [nvme_fc]
[ 2831.050102]  ? nvme_fc_queue_rq+0x1b6/0x4c0 [nvme_fc]
[ 2831.085274]  __blk_mq_issue_directly+0xe1/0x1c0
[ 2831.117939]  ? __pfx___blk_mq_issue_directly+0x10/0x10
[ 2831.153586]  ? blk_mq_request_issue_directly+0xc6/0x190
[ 2831.189705]  blk_mq_issue_direct+0x16b/0x690
[ 2831.220964]  ? lock_acquire+0x10b/0x150
[ 2831.249564]  blk_mq_dispatch_queue_requests+0x31c/0x640
[ 2831.267274]  blk_mq_flush_plug_list+0x187/0x6a0
[ 2831.267940]  ? trace_block_plug+0x15e/0x1e0
[ 2831.268164]  ? blk_add_rq_to_plug+0x2cf/0x460
[ 2831.268799]  ? rcu_is_watching+0x15/0xb0
[ 2831.269033]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
[ 2831.269316]  ? blk_mq_submit_bio+0x10cc/0x1bc0
[ 2831.269969]  __blk_flush_plug+0x27b/0x4d0
[ 2831.270200]  ? find_held_lock+0x32/0x90
[ 2831.270426]  ? __pfx___blk_flush_plug+0x10/0x10
[ 2831.271079]  ? percpu_ref_put_many.constprop.0+0x7a/0x1b0
[ 2831.271380]  __submit_bio+0x49b/0x600
[ 2831.271594]  ? __pfx___submit_bio+0x10/0x10
[ 2831.271843]  ? raw_spin_rq_lock_nested+0x2e/0x130
[ 2831.272506]  ? __submit_bio_noacct+0x16d/0x5b0
[ 2831.273157]  __submit_bio_noacct+0x16d/0x5b0
[ 2831.273805]  ? find_held_lock+0x32/0x90
[ 2831.274035]  ? local_clock_noinstr+0xd/0xe0
[ 2831.274251]  ? __pfx___submit_bio_noacct+0x10/0x10
[ 2831.274901]  ? ktime_get+0x164/0x200
[ 2831.275127]  ? lockdep_hardirqs_on+0x78/0x100
[ 2831.275777]  ? ktime_get+0xb0/0x200
[ 2831.276382]  submit_bio_noacct_nocheck+0x4e1/0x630
[ 2831.302650]  ? __pfx___might_resched+0x10/0x10
[ 2831.334528]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[ 2831.371424]  ? should_fail_bio+0xb5/0x150
[ 2831.400963]  ? submit_bio_noacct+0x9ba/0x1b30
[ 2831.432384]  nvme_requeue_work+0xa6/0xd0 [nvme_core]
[ 2831.467097]  process_one_work+0xd8b/0x1320
[ 2831.497417]  ? __pfx_process_one_work+0x10/0x10
[ 2831.529776]  ? assign_work+0x16c/0x240
[ 2831.557932]  worker_thread+0x5f3/0xfe0
[ 2831.586080]  ? __kthread_parkme+0xb4/0x200
[ 2831.616411]  ? __pfx_worker_thread+0x10/0x10
[ 2831.647363]  kthread+0x3b4/0x770
[ 2831.672690]  ? local_clock_noinstr+0xd/0xe0
[ 2831.703340]  ? __pfx_kthread+0x10/0x10
[ 2831.732902]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 2831.766864]  ? rcu_is_watching+0x15/0xb0
[ 2831.796921]  ? __pfx_kthread+0x10/0x10
[ 2831.826375]  ret_from_fork+0x393/0x480
[ 2831.855873]  ? __pfx_kthread+0x10/0x10
[ 2831.885038]  ? __pfx_kthread+0x10/0x10
[ 2831.914099]  ret_from_fork_asm+0x1a/0x30
[ 2831.944085]  </TASK>
[ 2831.964399] irq event stamp: 55415
[ 2831.991755] hardirqs last  enabled at (55425): [<ffffffffa8cd533e>]
__up_console_sem+0x5e/0x80
[ 2832.047850] hardirqs last disabled at (55440): [<ffffffffa8cd5323>]
__up_console_sem+0x43/0x80
[ 2832.104417] softirqs last  enabled at (55438): [<ffffffffa8afce0b>]
handle_softirqs+0x62b/0x890
[ 2832.161018] softirqs last disabled at (55459): [<ffffffffa8afd1fd>]
__irq_exit_rcu+0xfd/0x250
[ 2832.216709] ---[ end trace 0000000000000000 ]---
[ 2840.350778] nvmet: ctrl 2 keep-alive timer (5 seconds) expired!
[ 2840.351593] nvmet: ctrl 2 fatal error occurred!
[ 2851.548112] (NULL device *): {0:1} Association freed
[ 2851.548216] (NULL device *): Disconnect LS failed: No Association
[ 2912.554772] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001e2628/x00000000
[ 2912.554869] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001f66b8/x00000000
[ 2912.554920] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001dcbe0/x00000000
[ 2912.554997] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001b3b88/x00000000
[ 2912.555105] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001efe68/x00000000
[ 2912.555121] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 2912.555196] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000f31d0/x00000000
[ 2912.556040] nvme nvme0: NVME-FC{0}: resetting controller
[ 2912.557078] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000c39c8/x00000000
[ 2912.557173] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000998e0/x00000000
[ 2912.557257] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000dd468/x00000000
[ 2912.557304] nvme_ns_head_submit_bio: 66 callbacks suppressed
[ 2912.557321] block nvme0n1: no usable path - requeuing I/O
[ 2912.557348] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00061990/x00000000
[ 2912.558132] block nvme0n1: no usable path - requeuing I/O
[ 2912.558501] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000ee800/x00000000
[ 2912.558732] block nvme0n1: no usable path - requeuing I/O
[ 2912.558755] block nvme0n1: no usable path - requeuing I/O
[ 2912.559093] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0000dff0/x00000000
[ 2912.559310] block nvme0n1: no usable path - requeuing I/O
[ 2912.559374] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000fba20/x00000000
[ 2912.559622] block nvme0n1: no usable path - requeuing I/O
[ 2912.559722] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000ce700/x00000000
[ 2912.559938] block nvme0n1: no usable path - requeuing I/O
[ 2912.559989] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00066cc0/x00000000
[ 2912.560240] block nvme0n1: no usable path - requeuing I/O
[ 2912.560309] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00080e00/x00000000
[ 2912.560543] block nvme0n1: no usable path - requeuing I/O
[ 2912.560603] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00102d93/x00000000
[ 2912.560920] block nvme0n1: no usable path - requeuing I/O
[ 2912.560973] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00102dd3/x00000000
[ 2912.561286] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00102e13/x00000000
[ 2912.561384] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00102e53/x00000000
[ 2912.561489] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00102e93/x00000000
[ 2912.561573] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 2912.590374] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 2912.595940] (NULL device *): {0:1} Association created
[ 2912.597107] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2912.623269] (NULL device *): {0:0} Association deleted
[ 2912.636244] nvme nvme0: NVME-FC{0}: controller connect complete
[ 2919.293060] perf: interrupt took too long (3266 > 3158), lowering
kernel.perf_event_max_sample_rate to 61000
[ 2922.270774] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 2922.271738] nvmet: ctrl 1 fatal error occurred!
[ 2934.302272] (NULL device *): {0:0} Association freed
[ 2934.302378] (NULL device *): Disconnect LS failed: No Association
[ 2995.509865] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 2995.509964] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00104d98/x00000000
[ 2995.510013] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00104dd8/x00000000
[ 2995.510062] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00104e18/x00000000
[ 2995.510108] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0019b148/x00000000
[ 2995.510154] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000e1688/x00000000
[ 2995.510213] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001941f8/x00000000
[ 2995.510243] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 2995.510264] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00057bd8/x00000000
[ 2995.511324] nvme nvme0: NVME-FC{0}: resetting controller
[ 2995.511353] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d6a18/x00000000
[ 2995.511672] nvme_ns_head_submit_bio: 137 callbacks suppressed
[ 2995.511736] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001c8c50/x00000000
[ 2995.512440] block nvme0n1: no usable path - requeuing I/O
[ 2995.512453] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001f8ae8/x00000000
[ 2995.512809] block nvme0n1: no usable path - requeuing I/O
[ 2995.512829] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00185638/x00000000
[ 2995.513122] block nvme0n1: no usable path - requeuing I/O
[ 2995.513152] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000be958/x00000000
[ 2995.513426] block nvme0n1: no usable path - requeuing I/O
[ 2995.513456] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00072188/x00000000
[ 2995.513766] block nvme0n1: no usable path - requeuing I/O
[ 2995.513797] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0006cfa0/x00000000
[ 2995.514076] block nvme0n1: no usable path - requeuing I/O
[ 2995.514101] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001b8d68/x00000000
[ 2995.514368] block nvme0n1: no usable path - requeuing I/O
[ 2995.514399] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000bbf70/x00000000
[ 2995.514648] block nvme0n1: no usable path - requeuing I/O
[ 2995.514679] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00049d80/x00000000
[ 2995.514990] block nvme0n1: no usable path - requeuing I/O
[ 2995.515005] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001ab7b8/x00000000
[ 2995.515291] block nvme0n1: no usable path - requeuing I/O
[ 2995.515323] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000aa258/x00000000
[ 2995.581458] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 2995.587043] (NULL device *): {0:0} Association created
[ 2995.588238] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2995.598095] (NULL device *): {0:1} Association deleted
[ 2995.629543] nvme nvme0: NVME-FC{0}: controller connect complete
[ 3006.238795] nvmet: ctrl 2 keep-alive timer (5 seconds) expired!
[ 3006.239676] nvmet: ctrl 2 fatal error occurred!
[ 3016.812134] (NULL device *): {0:1} Association freed
[ 3016.812234] (NULL device *): Disconnect LS failed: No Association
[ 3077.954779] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 3077.954930] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00107368/x00000000
[ 3077.956502] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 3077.956501] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001073a8/x00000000
[ 3077.957556] nvme nvme0: NVME-FC{0}: resetting controller
[ 3077.957592] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d98b8/x00000000
[ 3077.957995] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00013600/x00000000
[ 3077.958084] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000111f0/x00000000
[ 3077.958143] nvme_ns_head_submit_bio: 50 callbacks suppressed
[ 3077.958159] block nvme0n1: no usable path - requeuing I/O
[ 3077.958182] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000bae28/x00000000
[ 3077.959136] block nvme0n1: no usable path - requeuing I/O
[ 3077.959529] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d8c98/x00000000
[ 3077.959764] block nvme0n1: no usable path - requeuing I/O
[ 3077.959837] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0008cf40/x00000000
[ 3077.960077] block nvme0n1: no usable path - requeuing I/O
[ 3077.960143] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d3578/x00000000
[ 3077.960453] block nvme0n1: no usable path - requeuing I/O
[ 3077.960518] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00064990/x00000000
[ 3077.960773] block nvme0n1: no usable path - requeuing I/O
[ 3077.960853] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000b4710/x00000000
[ 3077.961078] block nvme0n1: no usable path - requeuing I/O
[ 3077.961139] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00085db8/x00000000
[ 3077.961368] block nvme0n1: no usable path - requeuing I/O
[ 3077.961435] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00069120/x00000000
[ 3077.961655] block nvme0n1: no usable path - requeuing I/O
[ 3077.961753] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0013bf18/x00000000
[ 3077.961974] block nvme0n1: no usable path - requeuing I/O
[ 3077.962012] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0014fa40/x00000000
[ 3077.962334] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000521c8/x00000000
[ 3077.962423] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00015478/x00000000
[ 3077.962519] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00006610/x00000000
[ 3078.007378] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 3078.013515] (NULL device *): {0:1} Association created
[ 3078.014685] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3078.023212] (NULL device *): {0:0} Association deleted
[ 3078.054495] nvme nvme0: NVME-FC{0}: controller connect complete
[ 3087.646802] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 3087.647785] nvmet: ctrl 1 fatal error occurred!
[ 3100.716095] (NULL device *): {0:0} Association freed
[ 3100.716200] (NULL device *): Disconnect LS failed: No Association
[ 3161.908938] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001f2700/x00000000
[ 3161.909035] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00037618/x00000000
[ 3161.909088] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001df730/x00000000
[ 3161.909137] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000bca30/x00000000
[ 3161.909200] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001e35c8/x00000000
[ 3161.909245] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001bd010/x00000000
[ 3161.909299] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00127fb0/x00000000
[ 3161.909334] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 3161.909350] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0016d498/x00000000
[ 3161.909418] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0008a318/x00000000
[ 3161.910296] nvme nvme0: NVME-FC{0}: resetting controller
[ 3161.910498] nvme_ns_head_submit_bio: 84 callbacks suppressed
[ 3161.910520] block nvme0n1: no usable path - requeuing I/O
[ 3161.910760] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000b5568/x00000000
[ 3161.911637] block nvme0n1: no usable path - requeuing I/O
[ 3161.911940] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001cb018/x00000000
[ 3161.912197] block nvme0n1: no usable path - requeuing I/O
[ 3161.912224] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001babe0/x00000000
[ 3161.912541] block nvme0n1: no usable path - requeuing I/O
[ 3161.912562] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000fad88/x00000000
[ 3161.912874] block nvme0n1: no usable path - requeuing I/O
[ 3161.912902] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00188490/x00000000
[ 3161.913200] block nvme0n1: no usable path - requeuing I/O
[ 3161.913229] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000d5000/x00000000
[ 3161.913530] block nvme0n1: no usable path - requeuing I/O
[ 3161.913559] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000c6df8/x00000000
[ 3161.913850] block nvme0n1: no usable path - requeuing I/O
[ 3161.913927] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 3161.914195] block nvme0n1: no usable path - requeuing I/O
[ 3161.914232] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00109ad8/x00000000
[ 3161.914675] block nvme0n1: no usable path - requeuing I/O
[ 3161.914696] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00109b18/x00000000
[ 3161.915023] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00109b58/x00000000
[ 3161.915068] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00109b98/x00000000
[ 3161.915112] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00109bd8/x00000000
[ 3161.956466] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 3161.962211] (NULL device *): {0:0} Association created
[ 3161.963374] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3161.975270] (NULL device *): {0:1} Association deleted
[ 3162.006074] nvme nvme0: NVME-FC{0}: controller connect complete
[ 3172.126859] nvmet: ctrl 2 keep-alive timer (5 seconds) expired!
[ 3172.127623] nvmet: ctrl 2 fatal error occurred!
[ 3184.377203] (NULL device *): {0:1} Association freed
[ 3184.377314] (NULL device *): Disconnect LS failed: No Association
[ 3245.358575] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000b4340/x00000000
[ 3245.358682] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0000a050/x00000000
[ 3245.358821] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0002b1e8/x00000000
[ 3245.358881] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00033980/x00000000
[ 3245.358933] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00051468/x00000000
[ 3245.359006] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001f3dc0/x00000000
[ 3245.359032] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 3245.359057] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000d1f18/x00000000
[ 3245.359972] nvme nvme0: NVME-FC{0}: resetting controller
[ 3245.360010] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000915c0/x00000000
[ 3245.360351] nvme_ns_head_submit_bio: 82 callbacks suppressed
[ 3245.360374] block nvme0n1: no usable path - requeuing I/O
[ 3245.360400] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00081080/x00000000
[ 3245.361245] block nvme0n1: no usable path - requeuing I/O
[ 3245.361264] block nvme0n1: no usable path - requeuing I/O
[ 3245.361652] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d41e8/x00000000
[ 3245.361914] block nvme0n1: no usable path - requeuing I/O
[ 3245.361937] block nvme0n1: no usable path - requeuing I/O
[ 3245.361950] block nvme0n1: no usable path - requeuing I/O
[ 3245.361964] block nvme0n1: no usable path - requeuing I/O
[ 3245.361977] block nvme0n1: no usable path - requeuing I/O
[ 3245.364224] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00089910/x00000000
[ 3245.364281] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001938d0/x00000000
[ 3245.364332] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00146ae0/x00000000
[ 3245.364383] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001692d0/x00000000
[ 3245.364435] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001f23b0/x00000000
[ 3245.364488] block nvme0n1: no usable path - requeuing I/O
[ 3245.364497] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0009ec68/x00000000
[ 3245.364545] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010c6f2/x00000000
[ 3245.364874] block nvme0n1: no usable path - requeuing I/O
[ 3245.365277] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010c732/x00000000
[ 3245.365322] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010c772/x00000000
[ 3245.365350] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010c7b2/x00000000
[ 3245.365377] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010c7f2/x00000000
[ 3245.365406] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 3245.399397] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 3245.404662] (NULL device *): {0:1} Association created
[ 3245.405845] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3245.414713] (NULL device *): {0:0} Association deleted
[ 3245.439156] nvme nvme0: NVME-FC{0}: controller connect complete
[ 3255.070828] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[ 3255.071589] nvmet: ctrl 1 fatal error occurred!
[ 3270.991000] (NULL device *): {0:0} Association freed
[ 3270.991124] (NULL device *): Disconnect LS failed: No Association
[ 3287.286065] perf: interrupt took too long (4088 > 4082), lowering
kernel.perf_event_max_sample_rate to 48000
[ 3331.891056] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000bda00/x00000000
[ 3331.891152] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001543d8/x00000000
[ 3331.891202] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00074e10/x00000000
[ 3331.891252] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0001a388/x00000000
[ 3331.891319] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001b2360/x00000000
[ 3331.891376] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00169330/x00000000
[ 3331.891421] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001d0e70/x00000000
[ 3331.891431] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[ 3331.891473] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000d1d28/x00000000
[ 3331.892414] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x001cfc50/x00000000
[ 3331.892497] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000abb28/x00000000
[ 3331.892581] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0002ee28/x00000000
[ 3331.892673] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0008a438/x00000000
[ 3331.892801] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0015e2d8/x00000000
[ 3331.892901] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x000d12b8/x00000000
[ 3331.893010] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00159e58/x00000000
[ 3331.893096] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x00097190/x00000000
[ 3331.893115] nvme nvme0: NVME-FC{0}: resetting controller
[ 3331.893158] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
(I/O Cmd) w10/11: x00000000/x00000000
[ 3331.893514] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010f20c/x00000000
[ 3331.893558] nvme_ns_head_submit_bio: 93 callbacks suppressed
[ 3331.893572] block nvme0n1: no usable path - requeuing I/O
[ 3331.893575] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010f24c/x00000000
[ 3331.893617] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010f28c/x00000000
[ 3331.894339] block nvme0n1: no usable path - requeuing I/O
[ 3331.894678] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
(I/O Cmd) w10/11: x0010f2cc/x00000000
[ 3331.894982] block nvme0n1: no usable path - requeuing I/O
[ 3331.895321] block nvme0n1: no usable path - requeuing I/O
[ 3331.895611] block nvme0n1: no usable path - requeuing I/O
[ 3331.895933] block nvme0n1: no usable path - requeuing I/O
[ 3331.896290] block nvme0n1: no usable path - requeuing I/O
[ 3331.896594] block nvme0n1: no usable path - requeuing I/O
[ 3331.896913] block nvme0n1: no usable path - requeuing I/O
[ 3331.897251] block nvme0n1: no usable path - requeuing I/O
[ 3331.937837] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 3331.943499] (NULL device *): {0:0} Association created
[ 3331.944725] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3331.976229] (NULL device *): {0:1} Association deleted
[ 3331.984385] nvme nvme0: NVME-FC{0}: controller connect complete
[ 3341.015948] ------------[ cut here ]------------
[ 3341.017039] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
bdev_count_inflight_rw+0x26e/0x410
[ 3341.018176] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc
nvme_fabrics nvme_core nvme_keyring nvme_auth rfkill sunrpc
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel vfat fat kvm irqbypass iTCO_wdt
rapl iTCO_vendor_support intel_cstate intel_uncore pcspkr bnx2x
mgag200 i2c_i801 tg3 i2c_smbus lpc_ich i2c_algo_bit hpilo ioatdma mdio
dca ipmi_ssif ipmi_si acpi_tad acpi_power_meter acpi_ipmi ipmi_devintf
ipmi_msghandler dax_pmem sg fuse loop nfnetlink xfs nd_pmem sr_mod
sd_mod cdrom ghash_clmulni_intel hpsa scsi_transport_sas hpwdt ahci
libahci libata wmi nfit libnvdimm dm_mirror dm_region_hash dm_log
dm_mod [last unloaded: nvmet]
[ 3341.022670] CPU: 3 UID: 0 PID: 522 Comm: kworker/u289:34 Tainted: G
       W           6.15.0+ #2 PREEMPT(lazy)
[ 3341.023677] Tainted: [W]=WARN
[ 3341.024351] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
Gen9, BIOS P89 10/05/2016
[ 3341.024868] Workqueue: loop0 loop_rootcg_workfn [loop]
[ 3341.025232] RIP: 0010:bdev_count_inflight_rw+0x26e/0x410
[ 3341.025556] Code: 00 41 8b 47 04 85 c0 78 59 48 83 c4 30 5b 5d 41
5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 5b d4 fd ff 4d 8d 77 04 e9 7c
ff ff ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 0f
b6 14
[ 3341.027096] RSP: 0018:ffffc900058d6c90 EFLAGS: 00010286
[ 3341.027466] RAX: 0000000000000003 RBX: 0000000000000048 RCX: ffffffffa9b9ee56
[ 3341.028304] RDX: 00000000ffffffff RSI: 0000000000000048 RDI: ffffffffac36b380
[ 3341.029153] RBP: ffffe8ffffa0c600 R08: 0000000000000000 R09: fffff91ffff418d2
[ 3341.030067] R10: ffffe8ffffa0c697 R11: 0000000000000001 R12: ffff8881e2be9880
[ 3341.030975] R13: dffffc0000000000 R14: ffffc900058d6d1c R15: ffffc900058d6d18
[ 3341.031845] FS:  0000000000000000(0000) GS:ffff888439550000(0000)
knlGS:0000000000000000
[ 3341.032328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3341.033131] CR2: 000055aa896e5068 CR3: 0000000bfae7a006 CR4: 00000000003726f0
[ 3341.033996] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3341.034915] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3341.035805] Call Trace:
[ 3341.035991]  <TASK>
[ 3341.036585]  bdev_count_inflight+0x6d/0xa0
[ 3341.036918]  ? __pfx_bdev_count_inflight+0x10/0x10
[ 3341.037658]  update_io_ticks+0x1bd/0x210
[ 3341.037997]  ? __pfx_update_io_ticks+0x10/0x10
[ 3341.038854]  ? find_held_lock+0x32/0x90
[ 3341.039131]  ? local_clock_noinstr+0xd/0xe0
[ 3341.039437]  bdev_start_io_acct+0x31/0xe0
[ 3341.039720]  dm_io_acct+0x101/0x510 [dm_mod]
[ 3341.040570]  ? bio_associate_blkg+0xf9/0x1e0
[ 3341.041666]  dm_submit_bio_remap+0x52/0x380 [dm_mod]
[ 3341.042205]  dm_split_and_process_bio+0x369/0x1520 [dm_mod]
[ 3341.042666]  ? __lock_acquire+0x57c/0xbd0
[ 3341.042993]  ? __pfx_dm_split_and_process_bio+0x10/0x10 [dm_mod]
[ 3341.054346]  dm_submit_bio+0x130/0x460 [dm_mod]
[ 3341.088843]  ? local_clock_noinstr+0xd/0xe0
[ 3341.121535]  ? __pfx_dm_submit_bio+0x10/0x10 [dm_mod]
[ 3341.158880]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 3341.193695]  ? __submit_bio_noacct+0x16d/0x5b0
[ 3341.227517]  __submit_bio+0x3bd/0x600
[ 3341.255891]  ? __pfx___submit_bio+0x10/0x10
[ 3341.286439]  ? rcu_is_watching+0x15/0xb0
[ 3341.315563]  ? __submit_bio_noacct+0x16d/0x5b0
[ 3341.347325]  __submit_bio_noacct+0x16d/0x5b0
[ 3341.378388]  ? find_held_lock+0x32/0x90
[ 3341.406774]  ? local_clock_noinstr+0xd/0xe0
[ 3341.437031]  ? __pfx___submit_bio_noacct+0x10/0x10
[ 3341.470525]  ? ktime_get+0x164/0x200
[ 3341.497850]  ? lockdep_hardirqs_on+0x78/0x100
[ 3341.529043]  ? rcu_is_watching+0x15/0xb0
[ 3341.557891]  submit_bio_noacct_nocheck+0x4e1/0x630
[ 3341.591401]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[ 3341.628047]  ? should_fail_bio+0xb5/0x150
[ 3341.657364]  ? submit_bio_noacct+0x9ba/0x1b30
[ 3341.688554]  xfs_submit_ioend+0x181/0x3e0 [xfs]
[ 3341.721154]  iomap_submit_ioend+0x97/0x240
[ 3341.751291]  ? __pfx_xfs_map_blocks+0x10/0x10 [xfs]
[ 3341.785620]  iomap_add_to_ioend+0x30b/0xa90
[ 3341.815876]  ? __pfx___folio_start_writeback+0x10/0x10
[ 3341.851253]  iomap_writepage_map_blocks+0x34d/0x4b0
[ 3341.885587]  ? rcu_is_watching+0x15/0xb0
[ 3341.914441]  iomap_writepage_map+0x502/0x1130
[ 3341.945625]  ? rcu_is_watching+0x15/0xb0
[ 3341.974472]  ? __pfx_iomap_writepage_map+0x10/0x10
[ 3342.008342]  ? writeback_iter+0x136/0x720
[ 3342.037668]  iomap_writepages+0xf2/0x190
[ 3342.044509]  ? local_clock_noinstr+0xd/0xe0
[ 3342.044762]  ? __pfx_iomap_writepages+0x10/0x10
[ 3342.045412]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 3342.046072]  ? xfs_vm_writepages+0xc0/0x140 [xfs]
[ 3342.047168]  xfs_vm_writepages+0xe6/0x140 [xfs]
[ 3342.048224]  ? __pfx_xfs_vm_writepages+0x10/0x10 [xfs]
[ 3342.048946]  ? lock_acquire.part.0+0xbd/0x260
[ 3342.049598]  ? find_held_lock+0x32/0x90
[ 3342.049834]  ? local_clock_noinstr+0xd/0xe0
[ 3342.050063]  do_writepages+0x21f/0x560
[ 3342.050281]  ? __pfx_do_writepages+0x10/0x10
[ 3342.050936]  ? _raw_spin_unlock+0x2d/0x50
[ 3342.051176]  ? wbc_attach_and_unlock_inode.part.0+0x389/0x720
[ 3342.051943]  filemap_fdatawrite_wbc+0xcf/0x120
[ 3342.052596]  __filemap_fdatawrite_range+0xa7/0xe0
[ 3342.053262]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[ 3342.053568]  ? __up_write+0x1b3/0x4f0
[ 3342.053850]  ? __lock_acquire+0x57c/0xbd0
[ 3342.054093]  file_write_and_wait_range+0x95/0x110
[ 3342.072359]  xfs_file_fsync+0x15d/0x870 [xfs]
[ 3342.105328]  ? local_clock_noinstr+0xd/0xe0
[ 3342.110862] nvmet: ctrl 2 keep-alive timer (5 seconds) expired!
[ 3342.137782]  ? __pfx_xfs_file_fsync+0x10/0x10 [xfs]
[ 3342.179648] nvmet: ctrl 2 fatal error occurred!
[ 3342.215534]  ? mark_held_locks+0x40/0x70
[ 3342.215553]  loop_process_work+0x68b/0xf70 [loop]
[ 3342.314888]  process_one_work+0xd8b/0x1320
[ 3342.346102]  ? __pfx_process_one_work+0x10/0x10
[ 3342.380018]  ? assign_work+0x16c/0x240
[ 3342.409265]  worker_thread+0x5f3/0xfe0
[ 3342.438574]  ? __pfx_worker_thread+0x10/0x10
[ 3342.470813]  kthread+0x3b4/0x770
[ 3342.497590]  ? local_clock_noinstr+0x45/0xe0
[ 3342.529996]  ? __pfx_kthread+0x10/0x10
[ 3342.554641]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 3342.555303]  ? rcu_is_watching+0x15/0xb0
[ 3342.555539]  ? __pfx_kthread+0x10/0x10
[ 3342.555780]  ret_from_fork+0x393/0x480
[ 3342.556006]  ? __pfx_kthread+0x10/0x10
[ 3342.556218]  ? __pfx_kthread+0x10/0x10
[ 3342.556496]  ret_from_fork_asm+0x1a/0x30
[ 3342.556775]  </TASK>
[ 3342.556944] irq event stamp: 15317467
[ 3342.557159] hardirqs last  enabled at (15317475):
[<ffffffffa8cd533e>] __up_console_sem+0x5e/0x80
[ 3342.558026] hardirqs last disabled at (15317490):
[<ffffffffa8cd5323>] __up_console_sem+0x43/0x80
[ 3342.558921] softirqs last  enabled at (15317504):
[<ffffffffa8afce0b>] handle_softirqs+0x62b/0x890
[ 3342.559800] softirqs last disabled at (15317515):
[<ffffffffa8afd1fd>] __irq_exit_rcu+0xfd/0x250
[ 3342.560684] ---[ end trace 0000000000000000 ]-----
Best Regards,
  Yi Zhang

