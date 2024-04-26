Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4F13AD25
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117605; cv=none; b=fWxux3UEpQckmRsGDPWAYNF8YQons2OB8VY3ZhSAcWmXdYor9mnYIhreD3oWYoklAhDAinPRnm92sAtIEDPUPg75c62PDmmOnE7bw+upBIFeMnsyfS4dePOCbeFYnkQbh8E/TOZus83kW63JcAiGLXNFXD+dBSQPKhtJsE1WZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117605; c=relaxed/simple;
	bh=RnlAjQvFBDmLYGmCZqOIhSViF/EF6dlNtBnRTNEU5Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJLa7PTK562tqjGp4DDoucDzuUUTNCb85C1ol+dR1w3IXBZl0iVE9Yk0iILvQVmzHrBg9nzmrcB4i3oiAPALU4rvl16CLwoFvyvFfZCpL61i03K5fVPE9iwusFnARJJDqoch8itY1tlHGuVmWXpOtcnW16R7kENbnNg7iNMF5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NI+jOONv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NI+jOONv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714117602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/IiereUFZ6n/QzjoW+O6B0CiSY57+7xCBHmSKJ1t/w=;
	b=NI+jOONvx9wkB/tC/HHGcR2LEpwxidt9hFNTBxaJS/VEj9O/3Fj34HmGFme3cdn+aLxQ28
	+03f5LomXIHjIx023SlmNxmhI4w0L1rRSD28u5h6lmJ+nLB3YBIPfC5NAjz5/8RNP80uVh
	obdbnQuvob7XMU0srct3wAj1jFE2s/k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-l4rN16b_NhSR53BHjBFXJg-1; Fri, 26 Apr 2024 03:46:40 -0400
X-MC-Unique: l4rN16b_NhSR53BHjBFXJg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c670f70a37so1965166a12.2
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 00:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117599; x=1714722399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/IiereUFZ6n/QzjoW+O6B0CiSY57+7xCBHmSKJ1t/w=;
        b=w7kS5cxqQtAKg3sZmysLC50IJGEUCphR7zUD+PlQvR0yoLghGeBGwIWRMJuvxjVC8u
         SxhtrdlvW0cM/+L0onOtCR9/KNUxO3fevTp/7pghwVuEhGS2KV6llHDjI9a48g0MRVkA
         r9NHwSyBr8H90HLgzSVQsKEYZ96Ks+U73+cMd0utlA3YKGjTOrrgi5qNh9/g+s7EvEdB
         xEuMYHtBME2dr3ekj1lP794PU6iZ66J2ykqBpHuUqZ21Ao6ny7RUmaDLw6giR4HGKFMP
         eBAlNZlmrrwKp1oLlCYVciRpQMVJk1qe9KTdQxOGoqAQGDow0OFCKU+P+CWGImu7Q/CG
         kB6w==
X-Gm-Message-State: AOJu0Yw/iArupf3ZfLgU0OfGvL6+Ev6+lDx1wBBuH5Gu8wibKYqgJMwU
	ZO1IO3ItdmjyDpJHkIgKtQdByZVdQmV0WWNVbit44Jn3oVYH/X84do4U9w4G9g9bg/0vE5Aw/by
	9nQDEdu2skWlOslFf69RexxrwBK7M9vOpv3vFseq2M7u0mKDeC8FeIlS2kKmx+p2b2N7UU/tnO8
	scKCZbTIarEH5KjuRHZAgJsBCe0xDsVwV40W3vp1AL3hRurrVJVwM=
X-Received: by 2002:a05:6a21:9983:b0:1ae:100f:8a93 with SMTP id ve3-20020a056a21998300b001ae100f8a93mr2920842pzb.12.1714117599154;
        Fri, 26 Apr 2024 00:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ/uhuXA/IsqnR+L97BjJaH/0lQI2AaTdlur16OTi5LrFir2ofqcHwnlenPbap6gmi+xOyUX87wBB6qfI/3J4=
X-Received: by 2002:a05:6a21:9983:b0:1ae:100f:8a93 with SMTP id
 ve3-20020a056a21998300b001ae100f8a93mr2920831pzb.12.1714117598887; Fri, 26
 Apr 2024 00:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+WphhHnf_2ai2GDcRG9EwRxfDLCYYNUw3Hxho7VE7fFRg@mail.gmail.com>
In-Reply-To: <CAGVVp+WphhHnf_2ai2GDcRG9EwRxfDLCYYNUw3Hxho7VE7fFRg@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Fri, 26 Apr 2024 15:46:28 +0800
Message-ID: <CAGVVp+XrXk0GAcHYjqz9YB4bfkFOJOU0RtMRo-kkUDvUWebx+Q@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:queue_zone_wplugs_show+0x42/0x100
To: Linux Block Devices <linux-block@vger.kernel.org>, linux-mm@kvack.org
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:20=E2=80=AFPM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> Hello,
>
> I hit the kernel panic on recent upstream, please help check it and
> let me know if you need any info/testing for it, thanks.
>
>
> repo:https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.gi=
t
> branch:for-next
> commit HEAD: 12c12fbada5caa262656a46483167b553036a273
>
> reproducer:
> # cd /sys/kernel/debug/block && find  . -type f   -exec grep -aH . {} \;
>
> dmesg:
> [   29.745943] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [   29.752906] #PF: supervisor read access in kernel mode
> [   29.758044] #PF: error_code(0x0000) - not-present page
> [   29.763186] PGD 0 P4D 0
> [   29.765723] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   29.770085] CPU: 29 PID: 2248 Comm: grep Not tainted 6.9.0-rc4+ #1
> [   29.776263] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> 2.19.1 06/04/2023
> [   29.783830] RIP: 0010:queue_zone_wplugs_show+0x42/0x100
> [   29.789064] Code: 47 68 48 89 44 24 10 e8 ec cf b7 ff 48 c7 44 24
> 08 00 00 00 00 48 8b 44 24 10 48 8b 4c 24 08 48 8b 80 b8 02 00 00 48
> 8d 04 c8 <4c> 8b 38 4d 85 ff 74 6a 49 8d 7f 24 31 db 48 89 3c 24 e8 37
> 25 6d
> [   29.807810] RSP: 0018:ffffa7e68750bcb8 EFLAGS: 00010202
> [   29.813035] RAX: 0000000000000000 RBX: ffff8dae04c76528 RCX: 000000000=
0000000
> [   29.820169] RDX: ffff8dae1505a0c0 RSI: ffff8dae04c76528 RDI: ffff8dacb=
76c5fe0
> [   29.827302] RBP: ffff8dae04c76528 R08: ffffa7e68750bcb0 R09: ffff8daa8=
60cbdb8
> [   29.834433] R10: ffffa7e68750bd08 R11: ffff8dae0319c000 R12: ffffa7e68=
750bd98
> [   29.841567] R13: ffffa7e68750bd70 R14: ffff8dae04c76550 R15: 000000000=
0000001
> [   29.848697] FS:  00007f553ea21740(0000) GS:ffff8db1efd00000(0000)
> knlGS:0000000000000000
> [   29.856784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.862532] CR2: 0000000000000000 CR3: 000000048e000003 CR4: 000000000=
07706f0
> [   29.869664] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   29.876794] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   29.883928] PKRU: 55555554
> [   29.886642] Call Trace:
> [   29.889095]  <TASK>
> [   29.891201]  ? __die+0x20/0x70
> [   29.894268]  ? page_fault_oops+0x75/0x170
> [   29.898281]  ? exc_page_fault+0x64/0x150
> [   29.902208]  ? asm_exc_page_fault+0x22/0x30
> [   29.906395]  ? queue_zone_wplugs_show+0x42/0x100
> [   29.911012]  ? queue_zone_wplugs_show+0x24/0x100
> [   29.915632]  seq_read_iter+0x11d/0x4d0
> [   29.919383]  seq_read+0xfd/0x140
> [   29.922619]  full_proxy_read+0x59/0x80
> [   29.926379]  vfs_read+0xa7/0x340
> [   29.929611]  ? syscall_exit_work+0xff/0x130
> [   29.933804]  ? syscall_exit_to_user_mode+0x78/0x200
> [   29.938686]  ? do_syscall_64+0x87/0x160
> [   29.942523]  ? __count_memcg_events+0x49/0xb0
> [   29.946882]  ksys_read+0x5f/0xe0
> [   29.950115]  do_syscall_64+0x7b/0x160
> [   29.953783]  ? do_user_addr_fault+0x330/0x6b0
> [   29.958140]  ? clear_bhb_loop+0x45/0xa0
> [   29.961979]  ? clear_bhb_loop+0x45/0xa0
> [   29.965819]  ? clear_bhb_loop+0x45/0xa0
> [   29.969660]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   29.974713] RIP: 0033:0x7f553e8fd9b2
> [   29.978291] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ea 1d 0c 00 e8 c5
> fd 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
> 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
> 54 24
> [   29.997036] RSP: 002b:00007fff66c83ba8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [   30.004601] RAX: ffffffffffffffda RBX: 0000000000018000 RCX: 00007f553=
e8fd9b2
> [   30.011736] RDX: 0000000000018000 RSI: 000055caa25d0000 RDI: 000000000=
0000003
> [   30.018866] RBP: 000055caa25d0000 R08: 0000000000019000 R09: 000000000=
0000001
> [   30.026000] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff6=
6c83c70
> [   30.033134] R13: 0000000000000003 R14: 0000000000000000 R15: 000000000=
0000003
> [   30.040267]  </TASK>
> [   30.042457] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
> dns_resolver nfs lockd grace netfs rfkill sunrpc vfat fat dm_multipath
> intel_rapl_msr intel_rapl_common intel_uncore_frequency ipmi_ssif
> intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200
> rapl i2c_algo_bit iTCO_wdt drm_shmem_helper iTCO_vendor_support
> intel_cstate acpi_ipmi drm_kms_helper ipmi_si dcdbas intel_uncore
> mei_me i2c_i801 dell_smbios ipmi_devintf mei dell_wmi_descriptor
> wmi_bmof pcspkr i2c_smbus lpc_ich intel_pch_thermal ipmi_msghandler
> joydev acpi_power_meter drm fuse xfs libcrc32c sd_mod sg ahci
> crct10dif_pclmul nvme libahci crc32_pclmul crc32c_intel bnxt_en
> nvme_core libata ghash_clmulni_intel megaraid_sas tg3 t10_pi wmi
> dm_mirror dm_region_hash dm_log dm_mod
> [   30.115078] CR2: 0000000000000000
> [   30.118398] ---[ end trace 0000000000000000 ]---
> [   30.130544] RIP: 0010:queue_zone_wplugs_show+0x42/0x100
> [   30.135772] Code: 47 68 48 89 44 24 10 e8 ec cf b7 ff 48 c7 44 24
> 08 00 00 00 00 48 8b 44 24 10 48 8b 4c 24 08 48 8b 80 b8 02 00 00 48
> 8d 04 c8 <4c> 8b 38 4d 85 ff 74 6a 49 8d 7f 24 31 db 48 89 3c 24 e8 37
> 25 6d
> [   30.154518] RSP: 0018:ffffa7e68750bcb8 EFLAGS: 00010202
> [   30.159743] RAX: 0000000000000000 RBX: ffff8dae04c76528 RCX: 000000000=
0000000
> [   30.166875] RDX: ffff8dae1505a0c0 RSI: ffff8dae04c76528 RDI: ffff8dacb=
76c5fe0
> [   30.174010] RBP: ffff8dae04c76528 R08: ffffa7e68750bcb0 R09: ffff8daa8=
60cbdb8
> [   30.181142] R10: ffffa7e68750bd08 R11: ffff8dae0319c000 R12: ffffa7e68=
750bd98
> [   30.188274] R13: ffffa7e68750bd70 R14: ffff8dae04c76550 R15: 000000000=
0000001
> [   30.195408] FS:  00007f553ea21740(0000) GS:ffff8db1efd00000(0000)
> knlGS:0000000000000000
> [   30.203495] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   30.209239] CR2: 0000000000000000 CR3: 000000048e000003 CR4: 000000000=
07706f0
> [   30.216371] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   30.223505] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   30.230636] PKRU: 55555554
> [   30.233351] Kernel panic - not syncing: Fatal exception
> [   30.238599] Kernel Offset: 0x28200000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   30.257215] ---[ end Kernel panic - not syncing: Fatal exception ]---
>

This issue has been fixed by
https://lore.kernel.org/linux-block/CAGVVp+UyW8a8MNeet66UWUhgB0+gBWCh=3D_wb=
N=3D18tpbQO6_EKg@mail.gmail.com/T/#t

