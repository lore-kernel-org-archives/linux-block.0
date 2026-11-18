Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995638;
	b=0szKEEC6OEAY7O4W4NFwpmgi7BogXufqefSswjJDhDr39QXLJARJ0wJ+lpuhG9m+j6/M
	 0ebA4INccJaCZUI5HymfFCjia3m4K6L7obOTfNHDIJdL1M9CtjlNKeWB5h7XoFqnKk3cy
	 Y8Wyq1Fm4Ix6LcEw/XlY+LCRLDAgZ4fL4fxiYf74eMUOctBNAoSjqZtmxHoZ+UZU1Kz2H
	 h79Ybgm7aMg2gg428u+Wg4VEnj/PUh1hfVfbxm4jQz/seM6OpQPcC2qZ8eWg5XylRQEwG
	 S4BPMqbZveQrNRofTGIbz6NkRsG0T7I/SiT7CWDigrqkINGO3xU6EVzETJf5UYciy9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jOQdwFFmcdU2t3MoRBuiPs+2TwOTpuyDjeUAWF0EYFA=;
	b=O5oItFVuS77qpyHYmhdFXMYsydp9Mx7lVh4846VuPEnUx0uwld4laDLClt5S13tSHyu1
	 n1C1hxWeFQ1XcW/VhKavDdYzd6asgKVYTsKjioh7vIvwY5Wif1ff/KzpB7tDMFaneqqDo
	 TsEaRwHkyWa72Iz1T0HxWCwwMllq1XyfmYmz8lhphmZP2k8cBGe5YZHYFmZ+jfyyt1Alr
	 py3QPxAnxJoc22rc7uCegkeexWbxf9l5zKzso7XDeEMmL6eJPMrfQfeiie3ReIUaeV+du
	 VgUQzeW1tffP/GJiqmr1SUZm0joH5JrVGXMHuFhiIMPvDqgu9lKI5JEf3BkGvKDE3Ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=H2pOIoxq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED4606A320
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45ED4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=H2pOIoxq
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8784a3284so1305642a12.1
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 01:53:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794995636; cv=none;
        d=google.com; s=arc-20260327;
        b=dLGWd/Z/f3Ki1rLfpQiM8FmaWe2qwGZrGxLd7mGk8wMbEYkdTLlaFf6PDfR0eztfRL
         zoOdxU8NIMu06NWlqnmAjKhj/CFmdaUQXwWc0YZ+ya3WAmZPn4OrdHmUkNUREQC3L1od
         aONpfQRM69EXXm/YxAidqFDWCyPO4TGQkpCu9uivKlGndoLolBILdJfXEg9OqXck0LZF
         kgjDyEvCidEJBq6lY03VGEbqHSAzs+eUNuX935vz7cPmcsIRtGDfA0/+XVYtWf9niYDo
         8jyg+ywV60CUVSlgtfiIurOpbjnAr4GHHxVaTkOLSO6cDP0QlmnS0x/MQF4m/+BiNqlz
         nbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jOQdwFFmcdU2t3MoRBuiPs+2TwOTpuyDjeUAWF0EYFA=;
        fh=QpNw7PzLi5p8YqWD1DF9Bp6/W87TNlcHhm70/HvXun0=;
        b=gWp5d1GtC6yrGe2Xi82hx/azpcKwEYsHCgZ/d2caAd9Uo/ZHDvynQiae5YEROF2/Ip
         2EHHShMTmufN35oGpFZH/wmb0d7QrEXJmb1ycDqrI7qlyqc7tgCLkr3BHeGi/WRvqNlA
         mH0P8966ZTpEPPkuxCsnnm0WiBy4BWx6vDsY7hoQyhu4JJ6DVsvxWmJQ1jzUyhhSIv76
         L1RMqin7DoGb1BUdPRXyC8FSNpNC/wyh8zraQ6ybGgXsdg3GzFPp9f/p4XsBhx/VVpwx
         P+29nNUfmTxS03aAF3CVI3shFrkbPNvUJfUELr0pMTZkjyn67YDpt2zmT9rN+UpFLLmh
         x/7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1794995636; x=1795600436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOQdwFFmcdU2t3MoRBuiPs+2TwOTpuyDjeUAWF0EYFA=;
        b=H2pOIoxqPswoPleCarndVFfGIljsWoTlHBNxVXGE2SKZb2xTWx5+3G/ykUEtwpCO3O
         vqMSD2+Y87PGrZNyJRwoI2EtTmSLLvr5NCNyTOXSOJVTawUSQktUvuBGWAPv6tizhSKp
         loWE4oL59PDgutci1nGhbQTZ20P8Zkq3mpbQ4j2qbvHl/FNlBSr6XX/y61qPy/nyjas9
         IpdQDTaEu1g9jQjCtS6x3VreD9dK8wTfCuxmu31oaiMgq4RGtSwdR5DwECv+ufntCqp9
         Shuc+sKhiuNYREtqQWILWjKJ4KxyJM00VjpR7ECtlrzfWR2cUldtBbosuKwbsVCRJwMH
         yzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794995636; x=1795600436;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOQdwFFmcdU2t3MoRBuiPs+2TwOTpuyDjeUAWF0EYFA=;
        b=GNr/WnTv4gOmZ4k+FhYIiSMhxCNL+B6X3B9TK/gYcwbWSp4fmiKz3+UU92J13h8tVR
         aQJcjFKuwsTr7owIqU74TBRAjd2TiiohmabDECpzWyfqCrkcvr0RQj5Jhykl/18Z+unl
         9eUP+i8QcjYjsD6oDjxsOS9wxZjh5I8zXWtDOWKlmgAmruD/FrYVMBf30LkaAi4EcZAu
         Z52+hyOfPmhDdPXdtWdLOB5ul8FxseKW/0FRk43WmUS11f3dvwCIsBxoPl9wO1adDiUZ
         9NLqdgHvm20kpOs55Egx5wkg7UurJ50mxc1R1x6gXGnIUO7hDODeWfbg84RBHNOId8ka
         KUOQ==
X-Forwarded-Encrypted: i=1; AL+hErED9/xonqQ/MQYvcyzv6BizO2IK87Ab09Mc2/LY3Dxc04qV6tGbPi9Xpc5OiWU17MbneLa95k8FQ9/QZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9TrIQ7VBKV7tyyMHZLGZ64BG4hAbXU5p+FMnZIKuY5u5ej/Rpy
	2JynribjPNdrttjL9DU/HLwb1Mr76KuaREv5BoGXoDVBj0jcM6Mlzqzv8aO4+rwkjDNURKDCc7r
	IMkp1E7hqmlO29RQkhcUeVZc6Z8ix2PLnPZmDhywtIiTYRwT+r8+gJkny+g==
X-Gm-Gg: AYBFou0QXtKAOSbnMyq5o6HNShcUFIS6Wr0sN5HynOTOm/WZkZHJgqzyMeDQXxMl+n/
	U59Ju2oeLS+bm9FhBpDLEi57LMBtHF9ZhCmzeSWSasyuOPl61vzDUCpDi7UQiBrcUjpah4nNv4b
	Nz3xAbQMR1cEg8fQDkSejhRzeOnardhave5l9kZksL/d8y5tf4UxD1q+luyCnwcK82K1lQ9KHiT
	wq1wWYe5dzfAsGPujdLzPgyTO+fYk1tm0QlDu+Q75eMFuHQXSIP3CEbv0OKwnj/EjFQDOhlrfYf
	IJ6TVxudlY/0sahR7bAHxfkUSlHhFG7cgKMsNtxXMzeJzuu3iua6CaDf3dhuKu2B5nDVAu7XpXH
	hvM97W4JItBJU0Ql+6Nag8AyGbRAP3xdzrM6E2L0/pqOkSeF9VKOuLQwTTnTYDIsviGGbsGEENj
	DB3bUkdMmD1xVp5JqryyKVAun6/5yMLg+2sNyAxj02gRU7H5Q7s1WYVsiSSc6gDalsdIfdHli3Z
	Bgx23zLqcBi6V8sMrWG9uz7
X-Received: by 2002:a05:6402:210d:b0:6b8:6d8e:bf1 with SMTP id
 4fb4d7f45d1cf-6b887f208bbmr1500440a12.25.1794995635626; Wed, 18 Nov 2026
 01:53:55 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105202939.3104321-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20261105202939.3104321-1-shuangpeng.kernel@gmail.com>
From: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date: Wed, 18 Nov 2026 10:53:44 +0100
X-Gm-Features: AclHuK8hhZDh4YS1kG5ohrpKCRFfNpHez4ilI0r2l5cGXVd9OXlKYmFjusqU4og
Message-ID: <CAJpMwyhqnaqHjeF0_3MsEZj1-TG0dG-ksuJrbrOgbSLMPAOo+A@mail.gmail.com>
Subject: Re: [BUG] RDMA/rtrs-clt: KASAN use-after-free in rtrs_clt_query
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:29=E2=80=AFPM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> Hi Kernel Maintainers,
>
> I hit the following report while testing current upstream kernel:

Thanks Shuangpeng.
I am looking into this, and will send a patch soon.

>
> KASAN: slab-use-after-free in rtrs_clt_query
>
> on commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d (2026-11-03)
>
> The reproducer triggers this report. It uses the supported RTRS path disc=
onnect
> and RNBD force unmap_device sysfs interfaces.
>
> To help trigger the bug more reliably, we applied a minimal diagnostic pa=
tch
> that only adds delays and print statements.
>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/5409f0d93ab7414fcb6d97ac799fe28f
>
> For context, I previously reported a related but distinct RTRS client
> use-after-free in the same subsystem:
> Link: https://lore.kernel.org/linux-rdma/20260921033339.1320291-1-shuangp=
eng.kernel@gmail.com/
>
> I'm happy to test debug patches or provide additional information.
>
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in rtrs_clt_query (drivers/infiniband/ulp=
/rtrs/rtrs-clt.c:59 drivers/infiniband/ulp/rtrs/rtrs-clt.c:3140)
> Read of size 4 at addr ffff88810228d2f8 by task kworker/1:0/24
>
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 199=
6), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Workqueue: rtrs_client_wq rtrs_clt_reconnect_work
> Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
> kasan_report (mm/kasan/report.c:595)
> rtrs_clt_query (drivers/infiniband/ulp/rtrs/rtrs-clt.c:59 drivers/infinib=
and/ulp/rtrs/rtrs-clt.c:3140)
> rnbd_clt_link_ev (drivers/block/rnbd/rnbd-clt.c:691 drivers/block/rnbd/rn=
bd-clt.c:731)
> init_path (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2161 drivers/infiniband=
/ulp/rtrs/rtrs-clt.c:2677)
> rtrs_clt_reconnect_work (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2709)
> process_scheduled_works (kernel/workqueue.c:3495 kernel/workqueue.c:3578)
> worker_thread (kernel/workqueue.c:3659)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> </TASK>
>
> Allocated by task 306 on cpu 1 at 11.590323s:
> kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
> __kasan_kmalloc (mm/kasan/common.c:409 mm/kasan/common.c:426)
> alloc_path (include/linux/slab.h:991 include/linux/slab.h:1312 drivers/in=
finiband/ulp/rtrs/rtrs-clt.c:1540)
> rtrs_clt_open (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2871)
> rnbd_clt_map_device (drivers/block/rnbd/rnbd-clt.c:1288 drivers/block/rnb=
d/rnbd-clt.c:1571)
> rnbd_clt_map_device_store (drivers/block/rnbd/rnbd-clt-sysfs.c:612)
> kernfs_fop_write_iter (fs/kernfs/file.c:345)
> vfs_write (fs/read_write.c:595 fs/read_write.c:687)
> ksys_write (fs/read_write.c:739)
> do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c=
:84)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> Freed by task 306 on cpu 1 at 47.089348s:
> kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
> kasan_save_free_info (mm/kasan/generic.c:584)
> __kasan_slab_free (mm/kasan/common.c:264 mm/kasan/common.c:296)
> kfree (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:6630 mm/slub.c:=
6923)
> kobject_put (lib/kobject.c:689 lib/kobject.c:720 include/linux/kref.h:65 =
lib/kobject.c:737)
> rtrs_clt_close (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2940)
> free_sess (drivers/block/rnbd/rnbd-clt.c:770 drivers/block/rnbd/rnbd-clt.=
c:786)
> rnbd_clt_put_dev (drivers/block/rnbd/rnbd-clt.c:49 drivers/block/rnbd/rnb=
d-clt.c:62)
> rnbd_clt_unmap_device (drivers/block/rnbd/rnbd-clt.c:1723)
> rnbd_clt_unmap_dev_store (drivers/block/rnbd/rnbd-clt-sysfs.c:334)
> kernfs_fop_write_iter (fs/kernfs/file.c:345)
> vfs_write (fs/read_write.c:595 fs/read_write.c:687)
> ksys_write (fs/read_write.c:739)
> do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c=
:84)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> Last potentially related work creation:
> kasan_save_stack (mm/kasan/common.c:57)
> kasan_record_aux_stack (mm/kasan/generic.c:556)
> insert_work (kernel/workqueue.c:2356)
> __queue_work (kernel/workqueue.c:2546)
> queue_work_on (kernel/workqueue.c:2599)
> rtrs_clt_close_conns (include/linux/workqueue.h:700 drivers/infiniband/ul=
p/rtrs/rtrs-clt.c:1963)
> rtrs_clt_disconnect_store (drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c:2=
59)
> kernfs_fop_write_iter (fs/kernfs/file.c:345)
> vfs_write (fs/read_write.c:595 fs/read_write.c:687)
> ksys_write (fs/read_write.c:739)
> do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c=
:84)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> The buggy address belongs to the object at ffff88810228d000
> which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 760 bytes inside of
> freed 2048-byte region [ffff88810228d000, ffff88810228d800)
>
> Best,
> Shuangpeng



--=20

Regards
-Haris
