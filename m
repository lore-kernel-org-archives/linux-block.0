Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EC189
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754536830; cv=none; b=AmZhoUSaCgWFDFB0ct/jRfo8LWc/tFNNcVJvqBSIu0c6B0k6Yxalf23qng/5QtLpVUAeRRxSHAM4mVR8Rhnv9m0nxH13Pcw5jg1Uijw/frPmpSrkeUMcKcQ/HG8e8PjISwg+NGxEwDC9Xu4oZYgbAjjLSs1cA0lAzbo1C8M4qWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754536830; c=relaxed/simple;
	bh=uFHlZ0QC8NMgjruvdv6F5kIzYGiTcfHJxIbnAwUKi/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRNmxZma8moZ9zaScfrMtGq44MzzQJLJfV+jXMfsg0zbEOY4ia03O3tlHonae5gUjO0+tFEt7768kEEEb8m0n8a23Nyw6sQFCpUDoqHojh7o5+llooPw9hNrckAZUmtN+emZC5Xdlaoc/ceEs1i0+adtliPuC8p8P/9URjti11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDcSdbLk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDcSdbLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754536827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTadTqrG8iNwOc+yT0n1n8HObBfxydvZi6TVc/fADw8=;
	b=HDcSdbLk+fsGJXx+VWA0QdVp87+KxVL0lx+x2S9+iMfLRGGkkDPEGXkZDcLlMFYVu042dc
	HqIGlBQiJH6Jq8I5OBPSppmmg2QNQMKOjFxW9ZoubXko6D4tEo04qvwd+41HRZc99THTWc
	sS/WlyUeU6EYdlEilaGIzoRdh7bcjyU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-IbVfAogiNi2ZjI9UaEHAVA-1; Wed, 06 Aug 2025 23:20:26 -0400
X-MC-Unique: IbVfAogiNi2ZjI9UaEHAVA-1
X-Mimecast-MFC-AGG-ID: IbVfAogiNi2ZjI9UaEHAVA_1754536824
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3323682d9bbso3139351fa.0
        for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 20:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754536822; x=1755141622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTadTqrG8iNwOc+yT0n1n8HObBfxydvZi6TVc/fADw8=;
        b=LjJtfbRKeRH1JzyTbO2/YmDaBgEd61RHI0d1VnRqncZuJ6Z/qZYgIM8MWQlNgXT5FC
         O3yoX0Gv9thQtuBk8Q7IPhbsipdfkyyLPWbYvXuUUuCO7Ui81yh03o52ezD95uvpq10t
         BGsw0b7FrKnQbwA8h8I0BGvMVJ8D5cs+T4fnJz8zeZgj3k46NFYsjGDjvB/JmUIJ3Tk+
         +2uuXjL4QEv1gJnYfuvxTrA513B+4yjvQDe72YvKGBlmKC0ja2BAG/P7BljGTbR1N7/M
         bumXscE6iaLPfty9LopdH8kMUMFOPOUtT9q/e57aSsuvVljA3I1MKhKBIDm4KisVqEFk
         4Ouw==
X-Gm-Message-State: AOJu0YxqusTEyDoOhnEZZtfu9FbaDDrQ8mR81V9GM6HQvPmYsKBcliON
	uRWOb7Np4kNkE6+9lBV+RlPpTxpyfjqtiXJPkNxEiJNyUaUIZDC9+B0yygeyXbmkJpL8PtYV6wQ
	CK1uQ4kS03u4MGquQwrAnC8rJc0zJ1U9log/LJAo7OEMF7tANhqSVYXwQ2k79CzWhNBnwWvSTtm
	YlMfh0gVupIb0wOtUKje7YVSppjtcy08/2nLxmuff7tFvIzaM=
X-Gm-Gg: ASbGncsZXIpxpBn6lpGEP13l9LjPia3qJxs7Psl+P6vaXM9gTxUOT5xosTuJZ8WXuVA
	MFWI5J/k2GX6ud3XEZ3BAFTDdKcznb4GrJfp0zxfyppNuFHGTutlXdhnaLC1yZh2GqhKjYrnT5N
	tbgxNmfwKZlcvgllvVZK2R6g==
X-Received: by 2002:a05:651c:4098:b0:332:625e:c8ff with SMTP id 38308e7fff4ca-3338e9f8933mr2175871fa.34.1754536821856;
        Wed, 06 Aug 2025 20:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqoH2qeCEWvqpRj+dUrTq2UQg2n7vBLXFTyHrCs7NNbXfiOBhpHUQiIA8nOK1vwdsd3RAN/Dm3tg2U3dFHXHs=
X-Received: by 2002:a05:651c:4098:b0:332:625e:c8ff with SMTP id
 38308e7fff4ca-3338e9f8933mr2175791fa.34.1754536821298; Wed, 06 Aug 2025
 20:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
In-Reply-To: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 7 Aug 2025 11:20:08 +0800
X-Gm-Features: Ac12FXyfuXbjN26YxB7rXc_DBSnELdCR8b_KAFCtcZ5AimSl0r9lZMhze4EXQwg
Message-ID: <CAHj4cs-8kE-zBZF6smU4YfxaV7M7BoRG_7m6UE175HLYB_ZubQ@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/005 lead kernel panic on
 the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Maurizio Lombardi <mlombard@redhat.com>, Jens Axboe <axboe@kernel.dk>, mkhalfella@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just reviewed the recent commits merged to linux-block/for-next,
seems it was introduced from the below commit:

528589947c18 nvmet: initialize discovery subsys after debugfs is initialize=
d

On Wed, Aug 6, 2025 at 11:49=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hello
>
> I found this panic issue on the latest linux-block/for-next, please
> help check it and let me know if you need any info/testing for it,
> thanks
>
> commit: 20c74c073217 (HEAD -> for-next, origin/for-next) Merge branch
> 'block-6.17' into for-next
> reproducer: blktests nvme/loop or nvme/tcp nvme/005
>
> console log:
> [  341.092092] loop: module loaded
> [  341.246981] run blktests nvme/005 at 2025-08-06 15:32:53
> [  341.537716] loop0: detected capacity change from 0 to 2097152
> [  341.594066] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  341.679693] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  341.931127] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  341.959026] nvme nvme1: creating 80 I/O queues.
> [  342.105359] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> [  342.256079] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [  342.850745] nvmet: Created nvm controller 2 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  342.858886] nvme nvme1: creating 80 I/O queues.
> [  343.254225] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> [  343.539107] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [  343.711101] block nvme1n1: no available path - failing I/O
> [  343.711476] block nvme1n1: no available path - failing I/O
> [  343.711691] Buffer I/O error on dev nvme1n1, logical block 262143,
> async page read
> [  348.367529] Unable to handle ker
> ** replaying previous printk message **
> [  348.367529] Unable to handle kernel paging request at virtual
> address dfff800000000032
> [  348.367589] KASAN: null-ptr-deref in range
> [0x0000000000000190-0x0000000000000197]
> [  348.367593] Mem abort info:
> [  348.367595]   ESR =3D 0x0000000096000005
> [  348.367597]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  348.367601]   SET =3D 0, FnV =3D 0
> [  348.367603]   EA =3D 0, S1PTW =3D 0
> [  348.367606]   FSC =3D 0x05: level 1 translation fault
> [  348.367608] Data abort info:
> [  348.367610]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> [  348.367612]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [  348.367615]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [  348.367618] [dfff800000000032] address between user and kernel address=
 ranges
> [  348.367758] Internal error: Oops: 0000000096000005 [#1]  SMP
> [  348.444121] Modules linked in: loop nvmet(-) rfkill sunrpc mlx5_ib
> ib_uverbs macsec mgag200 acpi_ipmi ib_core ipmi_ssif arm_spe_pmu
> i2c_algo_bit mlx5_fwctl fwctl ipmi_devintf ipmi_msghandler arm_cmn
> arm_dmc620_pmu vfat fat arm_dsu_pmu cppc_cpufreq fuse xfs mlx5_core
> nvme nvme_core mlxfw nvme_keyring ghash_ce tls sbsa_gwdt nvme_auth
> hpwdt psample pci_hyperv_intf i2c_designware_platform xgene_hwmon
> i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod [last
> unloaded: nvmet_tcp]
> [  348.486730] CPU: 53 UID: 0 PID: 7580 Comm: modprobe Not tainted
> 6.16.0+ #3 PREEMPT_{RT,(full)}
> [  348.495418] Hardware name: HPE ProLiant RL300 Gen11/ProLiant RL300
> Gen11, BIOS 1.60 03/07/2024
> [  348.504018] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  348.510969] pc : kasan_byte_accessible+0xc/0x20
> [  348.515492] lr : __kasan_check_byte+0x20/0x70
> [  348.519839] sp : ffff8000c07679d0
> [  348.523142] x29: ffff8000c07679d0 x28: ffff0800b09d29b0 x27: 000000000=
0000190
> [  348.530269] x26: ffffd1b95babfe28 x25: 0000000000000000 x24: 000000000=
0000002
> [  348.537395] x23: 0000000000000001 x22: 0000000000000000 x21: ffffd1b95=
b1e89dc
> [  348.544521] x20: 0000000000000190 x19: 0000000000000190 x18: 000000000=
0000000
> [  348.551647] x17: ffffd1b922a23714 x16: ffffd1b95bc6e288 x15: ffffd1b95=
b2e9248
> [  348.558773] x14: ffffd1b922a236a8 x13: ffffd1b95d7d5c2c x12: ffff70001=
80ecf1b
> [  348.565900] x11: 1ffff000180ecf1a x10: ffff7000180ecf1a x9 : 000000000=
0000035
> [  348.573026] x8 : ffff07ffdb8e0000 x7 : 0000000000000000 x6 : ffffd1b95=
babfe28
> [  348.580152] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 000000000=
0000000
> [  348.587278] x2 : 0000000000000000 x1 : dfff800000000000 x0 : 000000000=
0000032
> [  348.594405] Call trace:
> [  348.596840]  kasan_byte_accessible+0xc/0x20 (P)
> [  348.601361]  lock_acquire.part.0+0x5c/0x2b8
> [  348.605536]  lock_acquire+0x9c/0x190
> [  348.609102]  down_write_nested+0x70/0xc0
> [  348.613015]  __simple_recursive_removal+0x80/0x4b8
> [  348.617797]  simple_recursive_removal+0x1c/0x30
> [  348.622317]  debugfs_remove+0x60/0x90
> [  348.625971]  nvmet_debugfs_subsys_free+0x3c/0x60 [nvmet]
> [  348.631289]  nvmet_subsys_free+0x50/0x108 [nvmet]
> [  348.635995]  nvmet_subsys_put+0x8c/0x100 [nvmet]
> [  348.640614]  nvmet_exit_discovery+0x20/0x38 [nvmet]
> [  348.645492]  nvmet_exit+0x1c/0x68 [nvmet]
> [  348.649502]  __do_sys_delete_module.constprop.0+0x298/0x548
> [  348.655065]  __arm64_sys_delete_module+0x38/0x58
> [  348.659672]  invoke_syscall.constprop.0+0x78/0x1f0
> [  348.664455]  do_el0_svc+0x164/0x1e0
> [  348.667933]  el0_svc+0x54/0x180
> [  348.671065]  el0t_64_sync_handler+0xa0/0xe8
> [  348.675239]  el0t_64_sync+0x1ac/0x1b0
> [  348.678892] Code: d65f03c0 d343fc00 d2d00001 f2fbffe1 (38616800)
> [  348.684976] ---[ end trace 0000000000000000 ]---
> [  348.689583] Kernel panic - not syncing: Oops: Fatal exception
> [  348.695319] SMP: stopping secondary CPUs
> [  348.699383] Kernel Offset: 0x51b8daeb0000 from 0xffff800080000000
> [  348.705465] PHYS_OFFSET: 0x80000000
> [  348.708941] CPU features: 0x10000,00002e00,048098a1,0441720b
> [  348.714590] Memory Limit: none
> [  348.892994] ---[ end Kernel panic - not syncing: Oops: Fatal exception=
 ]---
>
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang

