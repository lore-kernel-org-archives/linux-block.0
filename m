Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC439463
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754542038; cv=none; b=BRUxn6804Bmc/BjyXcbpz1HHy+C0yX+f6FEJXf0GyXe12GU9z4J5Wm8azxVeor9tJGJT/XCBEkVL50TiTYnSXjVVZ45EQsKMD+I2n1Ga24OEwuYBe9GEdWuzmYpPlN2FRzDaGgVKQuWKIs+pmRTk0/b9S4YV0F5kueX310azSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754542038; c=relaxed/simple;
	bh=fIpc9TcZLI7+G5Feao0JEnwN0K7d0phvq49Jzgn9wTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGXXvutE0/uya6cOv1IrOYvQucELNI2RB4HTisyMp7bC/31N29zPFG/RP3sFqRXuC1p8fQKerSyg8gkP6leTmdR0V0DYlZgojoytyebAs6P6LxZUKKrcjdfAUG+uxXooxaj/a7NmUpDMlMkpE+ZssBRPrKyMbZIyRBN8p9mvJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TACgGjsu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TACgGjsu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so749417a91.3
        for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754542036; x=1755146836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vlQLgpMIPslnn3hQtJTPn0usG3F027Ib7OnTFoeFLBA=;
        b=TACgGjsuqY8o/6q+vlr5JD1sVTpBBIxy6bVBdsbDrZxHfXPUCYJpeXzPd/lDbUacJf
         LCNDPOFhA95q6K24Fv1VGldBSfvvd38k5tugoTDo+2bYH6mrh19l78sIVFvIw40Qgxn2
         rMstJ8SzOtjn+O6tLdHsI6QmyVnJ3f+kjBhC9UEXFLgs/Z4TUE6Rh7/kLKU+R1khKDxh
         ViRsJaJoQUdQP50Wbx/Vf6HOUNlaEdNRM4flsJ0nWRvFf/MZLiBTGm+Yqq7Gr/eCEKWP
         SjtSnwNgimupqZwGBgz6xwWgVkFBsal0k113vTfWBmZRF5TKLLQtUpl/DdWqtbVeSSNf
         AbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754542036; x=1755146836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlQLgpMIPslnn3hQtJTPn0usG3F027Ib7OnTFoeFLBA=;
        b=o2126widBctoG2bLOjelTW4v5cokCjEEDWFHifL+39AEeOgpxr/IvSEpGEmvMc4J5l
         wWJi2d2y8BuoRncJO1iCcsPZT48V1/Mg8IKTJ5dM8ExoqdJdG5qNdXS9MfHyvGKI4GGI
         Hufwk+i8J+Ntos6p1xSBI7XbXj07DM5t9dm40UUotncEiyZb0b09NVBUuIpRnjKoHJ1j
         B9g6qu8vJk5/UAcHGEfkCRdPXiSqqq+F27tWdYc+EwtKact+/OhK7/80uDdbsNvfAMy4
         aZ2CCV16YBSxiytrlDfn6DhuJaHCIiXSD89jA51ou7RuG6s9BO16pd5WWoRwMpwxBgp2
         TTMQ==
X-Gm-Message-State: AOJu0YwwBYNlYOZ1LNHxrR1qw8CS4Jrq4w7vV7xi+ns8BlWCfb2WqsBq
	OHTVKjWHEFnHnHlc3GZhCSYO2vqT3I86IY3JehQSWegCXYXVRX0DXiS6UdjVzusdAnc=
X-Gm-Gg: ASbGncuKJPKWzzAxrJoJfV/vqhWN3TyWQWkUtOdE3O47pxtdd2g5rxAHRcFBudxUAF6
	xi2Up4WVttfE3k9gVaiKh5MHtsDwHWe+OWhLCQKDWNQiE7YICswIHyERaxVJMU+wcHjoDl8FCBR
	2mZIeW7vLDBubc4kUzFU/uLp2sNUCBvFfY+XU8fBNqc0Vt0AppEt+/wMftMeVTKnH6PvbzhhEnh
	vjToUfrFlG8Yr16NlTC1kT8Hn1loLkgEQRQ5CWRz2RoPRwlV8VFqeMOPOS/46I+aCFREdBcYHn+
	jzbSTYJMIumwhIDWYDXMMjpM2Natp7LB4zn7B8Ar22dMhlOy94WB3BYhV1nWs7xocrL15B1sYcM
	NK0TaJrYlhMWBI0tbot8DtwygYJo=
X-Google-Smtp-Source: AGHT+IFUP7dlE4sVpZ3v1ufrrSMy4+GgZPUi/DJ1NHLKMRVCNAZX52noXuplhuquSE1VrGT/nCVhDg==
X-Received: by 2002:a17:90b:3e86:b0:31e:c8fc:e62a with SMTP id 98e67ed59e1d1-32167593e1emr7326656a91.35.1754542035514;
        Wed, 06 Aug 2025 21:47:15 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::eb28])
        by smtp.googlemail.com with UTF8SMTPSA id 41be03b00d2f7-b422bb0a4b0sm14744943a12.59.2025.08.06.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 21:47:14 -0700 (PDT)
Date: Wed, 6 Aug 2025 21:47:13 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug report][regression] blktests nvme/005 lead kernel panic on
 the latest linux-block/for-next
Message-ID: <20250807044713.GA1064239-mkhalfella@purestorage.com>
References: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
 <CAHj4cs-8kE-zBZF6smU4YfxaV7M7BoRG_7m6UE175HLYB_ZubQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs-8kE-zBZF6smU4YfxaV7M7BoRG_7m6UE175HLYB_ZubQ@mail.gmail.com>

Hello Yi,

Thank you for reporting this issue. Looks like this is a regression
introduced by 528589947c180 ("nvmet: initialize discovery subsys after
debugfs is initialized") as you pointed out. nvmet_exit() should exit
discovery subsystem first before destroying debugfs. I will send a patch
with the fix shortly.

Thank,
Mohamed Khalfella

On 2025-08-07 11:20:08 +0800, Yi Zhang wrote:
> I just reviewed the recent commits merged to linux-block/for-next,
> seems it was introduced from the below commit:
> 
> 528589947c18 nvmet: initialize discovery subsys after debugfs is initialized
> 
> On Wed, Aug 6, 2025 at 11:49 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hello
> >
> > I found this panic issue on the latest linux-block/for-next, please
> > help check it and let me know if you need any info/testing for it,
> > thanks
> >
> > commit: 20c74c073217 (HEAD -> for-next, origin/for-next) Merge branch
> > 'block-6.17' into for-next
> > reproducer: blktests nvme/loop or nvme/tcp nvme/005
> >
> > console log:
> > [  341.092092] loop: module loaded
> > [  341.246981] run blktests nvme/005 at 2025-08-06 15:32:53
> > [  341.537716] loop0: detected capacity change from 0 to 2097152
> > [  341.594066] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  341.679693] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [  341.931127] nvmet: Created nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [  341.959026] nvme nvme1: creating 80 I/O queues.
> > [  342.105359] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> > [  342.256079] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
> > 127.0.0.1:4420, hostnqn:
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > [  342.850745] nvmet: Created nvm controller 2 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [  342.858886] nvme nvme1: creating 80 I/O queues.
> > [  343.254225] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> > [  343.539107] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> > [  343.711101] block nvme1n1: no available path - failing I/O
> > [  343.711476] block nvme1n1: no available path - failing I/O
> > [  343.711691] Buffer I/O error on dev nvme1n1, logical block 262143,
> > async page read
> > [  348.367529] Unable to handle ker
> > ** replaying previous printk message **
> > [  348.367529] Unable to handle kernel paging request at virtual
> > address dfff800000000032
> > [  348.367589] KASAN: null-ptr-deref in range
> > [0x0000000000000190-0x0000000000000197]
> > [  348.367593] Mem abort info:
> > [  348.367595]   ESR = 0x0000000096000005
> > [  348.367597]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [  348.367601]   SET = 0, FnV = 0
> > [  348.367603]   EA = 0, S1PTW = 0
> > [  348.367606]   FSC = 0x05: level 1 translation fault
> > [  348.367608] Data abort info:
> > [  348.367610]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > [  348.367612]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [  348.367615]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [  348.367618] [dfff800000000032] address between user and kernel address ranges
> > [  348.367758] Internal error: Oops: 0000000096000005 [#1]  SMP
> > [  348.444121] Modules linked in: loop nvmet(-) rfkill sunrpc mlx5_ib
> > ib_uverbs macsec mgag200 acpi_ipmi ib_core ipmi_ssif arm_spe_pmu
> > i2c_algo_bit mlx5_fwctl fwctl ipmi_devintf ipmi_msghandler arm_cmn
> > arm_dmc620_pmu vfat fat arm_dsu_pmu cppc_cpufreq fuse xfs mlx5_core
> > nvme nvme_core mlxfw nvme_keyring ghash_ce tls sbsa_gwdt nvme_auth
> > hpwdt psample pci_hyperv_intf i2c_designware_platform xgene_hwmon
> > i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod [last
> > unloaded: nvmet_tcp]
> > [  348.486730] CPU: 53 UID: 0 PID: 7580 Comm: modprobe Not tainted
> > 6.16.0+ #3 PREEMPT_{RT,(full)}
> > [  348.495418] Hardware name: HPE ProLiant RL300 Gen11/ProLiant RL300
> > Gen11, BIOS 1.60 03/07/2024
> > [  348.504018] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [  348.510969] pc : kasan_byte_accessible+0xc/0x20
> > [  348.515492] lr : __kasan_check_byte+0x20/0x70
> > [  348.519839] sp : ffff8000c07679d0
> > [  348.523142] x29: ffff8000c07679d0 x28: ffff0800b09d29b0 x27: 0000000000000190
> > [  348.530269] x26: ffffd1b95babfe28 x25: 0000000000000000 x24: 0000000000000002
> > [  348.537395] x23: 0000000000000001 x22: 0000000000000000 x21: ffffd1b95b1e89dc
> > [  348.544521] x20: 0000000000000190 x19: 0000000000000190 x18: 0000000000000000
> > [  348.551647] x17: ffffd1b922a23714 x16: ffffd1b95bc6e288 x15: ffffd1b95b2e9248
> > [  348.558773] x14: ffffd1b922a236a8 x13: ffffd1b95d7d5c2c x12: ffff7000180ecf1b
> > [  348.565900] x11: 1ffff000180ecf1a x10: ffff7000180ecf1a x9 : 0000000000000035
> > [  348.573026] x8 : ffff07ffdb8e0000 x7 : 0000000000000000 x6 : ffffd1b95babfe28
> > [  348.580152] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> > [  348.587278] x2 : 0000000000000000 x1 : dfff800000000000 x0 : 0000000000000032
> > [  348.594405] Call trace:
> > [  348.596840]  kasan_byte_accessible+0xc/0x20 (P)
> > [  348.601361]  lock_acquire.part.0+0x5c/0x2b8
> > [  348.605536]  lock_acquire+0x9c/0x190
> > [  348.609102]  down_write_nested+0x70/0xc0
> > [  348.613015]  __simple_recursive_removal+0x80/0x4b8
> > [  348.617797]  simple_recursive_removal+0x1c/0x30
> > [  348.622317]  debugfs_remove+0x60/0x90
> > [  348.625971]  nvmet_debugfs_subsys_free+0x3c/0x60 [nvmet]
> > [  348.631289]  nvmet_subsys_free+0x50/0x108 [nvmet]
> > [  348.635995]  nvmet_subsys_put+0x8c/0x100 [nvmet]
> > [  348.640614]  nvmet_exit_discovery+0x20/0x38 [nvmet]
> > [  348.645492]  nvmet_exit+0x1c/0x68 [nvmet]
> > [  348.649502]  __do_sys_delete_module.constprop.0+0x298/0x548
> > [  348.655065]  __arm64_sys_delete_module+0x38/0x58
> > [  348.659672]  invoke_syscall.constprop.0+0x78/0x1f0
> > [  348.664455]  do_el0_svc+0x164/0x1e0
> > [  348.667933]  el0_svc+0x54/0x180
> > [  348.671065]  el0t_64_sync_handler+0xa0/0xe8
> > [  348.675239]  el0t_64_sync+0x1ac/0x1b0
> > [  348.678892] Code: d65f03c0 d343fc00 d2d00001 f2fbffe1 (38616800)
> > [  348.684976] ---[ end trace 0000000000000000 ]---
> > [  348.689583] Kernel panic - not syncing: Oops: Fatal exception
> > [  348.695319] SMP: stopping secondary CPUs
> > [  348.699383] Kernel Offset: 0x51b8daeb0000 from 0xffff800080000000
> > [  348.705465] PHYS_OFFSET: 0x80000000
> > [  348.708941] CPU features: 0x10000,00002e00,048098a1,0441720b
> > [  348.714590] Memory Limit: none
> > [  348.892994] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
> 
> 
> 
> --
> Best Regards,
>   Yi Zhang
> 
