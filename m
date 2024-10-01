Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8051C8FCE
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798289; cv=none; b=MXPzFRWy/OOdM4XV5jy9BUMonl2hK+bJHHlqB3u4WLXSfzdEsPVo8VO0zLm5QisccKBmwzY6LCbaZFzi0XNyFwYckDU5JjlD/KUA4cgIAQSbsiqhtaAVtb3Ar77+iQPYqkP91EzmfHg3nQ7IaFxaPhdMYpglDuBOH4UENlwIomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798289; c=relaxed/simple;
	bh=OcWkJm01ShYq0u4NbzUAQVvk8uzdG2wrW+Mbjt0Ja6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9X4kajkYV2rYLL7y8NS3EtIJ1NB1A8E8yF1bCh1JxaKiZAdMP90qACI0h6VjICQ3ktW7qg+wi1tCRBS8nVUCDqzGrOj2BaBNhvcR5s/a/oDP8JESGTb1C87kshikegZafd6L6THr3EmSgAFC01YPIpWu4sbGsF6cbLPtuxRnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJSmQj9h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJSmQj9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727798286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1ld9KeZS4cXwKmq0ms9lx4WadfgwJ9uA+jC0io7Sy0=;
	b=FJSmQj9hPToTrmkJrwaUzbULBNI3akEHd4gsdx5zpyemiKaZBAF/eoxD9J3j1Y6hSX+cXs
	8S0p8yMmaerHGKGWufwu1sJ/iOgCrZNalIZqJU1Mx6YlBpuE0TDGmWZ9wVcM8uSnG4b3Dk
	7/zIFUz31WPOdbGKqZOMRpTuCFjyCko=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-WUAcCpd8OIaVBKbpWMBA5g-1; Tue, 01 Oct 2024 11:58:05 -0400
X-MC-Unique: WUAcCpd8OIaVBKbpWMBA5g-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-718f329aefdso6175666b3a.1
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2024 08:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798282; x=1728403082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1ld9KeZS4cXwKmq0ms9lx4WadfgwJ9uA+jC0io7Sy0=;
        b=BAj0xdEa0U3Kdkd1y0/CWO3yFC0XN8bpJG88RplAOhjS1/BnQT67Z072+IGIDlEyIo
         7i2uxJHq9MrqN0kRPFXRb/xth8F2Dbi/Ej7ROBV56oV6YhGWdgvEolXr+9RAK4VJQE+N
         282+wBypoEOfnqSddobELw3hS4HF43MCgzjfFY1zo6lNhEEO8/hbnyaxEFjzSeM09OBe
         W4ot+MgV7s/KMdDE+xKFi0bvT4hT2e1YkBy8wbyOqJNpm16iliIz0qYRaubjaXCKWSU3
         OqF4ApwT+EDEhuqEKDUOKfGpfbjpf6Y/KhxqgMUZYnLwj0a4uueXjKJ9RorB7BWi29Ga
         zpig==
X-Gm-Message-State: AOJu0Yxl0nPSDFzzxfHjsowsqywEXwW5nnf5OnhxnZ7+bZnd7y1sCc2F
	qgkTTvjH5I6TxJrQceoLHmeOIIXrvHGltOzXuzvXudilAqoETEcoLsUZnIgO6a4Sh8pV2E1rmu/
	iJRHXfL/Yag6rJYks1zHpnZx9I2sFSYk6ylWkplrrAlJ3K4XXAAbyJ2g9GmGxRdNqROQ+iN1e/t
	CnQYWhCu9IFKXlr0bhbcS908Qxbz4TU8CSPmc=
X-Received: by 2002:a05:6a20:cf84:b0:1cf:2293:b2d7 with SMTP id adf61e73a8af0-1d5db1dc224mr261960637.13.1727798281998;
        Tue, 01 Oct 2024 08:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSYO3LYhTpAC/TmvdGNYC15jdgl5T7o48mph4H0Z/Gq/fYo+ZF7IIt7dZQnansR/KWaQ43XuYiZ6eFiZo7ERk=
X-Received: by 2002:a05:6a20:cf84:b0:1cf:2293:b2d7 with SMTP id
 adf61e73a8af0-1d5db1dc224mr261945637.13.1727798281710; Tue, 01 Oct 2024
 08:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kzq-L468GfLKAENA@mail.gmail.com>
 <7109d82a-4e98-48be-b9a9-1d6208874f1f@linux.ibm.com>
In-Reply-To: <7109d82a-4e98-48be-b9a9-1d6208874f1f@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 1 Oct 2024 23:57:49 +0800
Message-ID: <CAHj4cs8dVmWnKw-B8c2MK95AcHpFyrCwTq7P2r9zk41WbcnPAg@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed after blktests block/001
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:57=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
>
>
> On 9/29/24 20:10, Yi Zhang wrote:
> > Hello
> >
> > The kmemleak issue was easily triggered during blktests block/001 on
> > the latest linux-block/for-next,
> > please help check it and let me know if you need any info/test for it, =
thanks.
> >
> >
> > $ cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffff888cc28666c0 (size 32):
> >   comm "modprobe", pid 11054, jiffies 4305180646
> >   hex dump (first 32 bytes):
> >     73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
> >     64 00 a6 02 7d c0 f5 04 00 00 00 00 00 00 00 00  d...}...........
> >   backtrace (crc 6250ed84):
> >     [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
> >     [<ffffffffb36513a6>] kstrdup+0x36/0x60
> >     [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
> >     [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
> >     [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
> >     [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
> >     [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
> >     [<ffffffffc36f45b8>] null_init+0x5a8/0xff0 [null_blk]
> >     [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
> >     [<ffffffffb30da9e8>] do_init_module+0x238/0x790
> >     [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
> >     [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
> >     [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
> >     [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
> >     [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > unreferenced object 0xffff888c82cf69c0 (size 32):
> >   comm "modprobe", pid 11104, jiffies 4305186132
> >   hex dump (first 32 bytes):
> >     73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
> >     64 00 ef 42 3d 89 fa 04 40 68 1d 36 00 ea ff ff  d..B=3D...@h.6....
> >   backtrace (crc 46e1640c):
> >     [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
> >     [<ffffffffb36513a6>] kstrdup+0x36/0x60
> >     [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
> >     [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
> >     [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
> >     [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
> >     [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
> >     [<ffffffffc36f65b8>] 0xffffffffc36f65b8
> >     [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
> >     [<ffffffffb30da9e8>] do_init_module+0x238/0x790
> >     [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
> >     [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
> >     [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
> >     [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
> >     [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > unreferenced object 0xffff888c49ee9700 (size 32):
> >   comm "modprobe", pid 12268, jiffies 4305219508
> >   hex dump (first 32 bytes):
> >     73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
> >     64 00 ce 89 f6 a8 04 c4 00 00 00 00 00 00 00 00  d...............
> >   backtrace (crc 267cbe53):
> >     [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
> >     [<ffffffffb36513a6>] kstrdup+0x36/0x60
> >     [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
> >     [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
> >     [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
> >     [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
> >     [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
> >     [<ffffffffc36f65b8>] 0xffffffffc36f65b8
> >     [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
> >     [<ffffffffb30da9e8>] do_init_module+0x238/0x790
> >     [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
> >     [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
> >     [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
> >     [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
> >     [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
> >
> >
> Apparently, the memory leak is detected in mm/slab code. I believe there'=
s no issue in the
> block layer code. After further debugging I found that the fix implemente=
d in commit
> 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")=
 caused the observed
> symptom. The fix implemented in 4ec10268ed98 caused a subtle side effect =
due to which while
> destroying the kmem cache, the code path would never get into sysfs_slab_=
release() function
> even though SLAB_SUPPORTS_SYSFS is defined and slab state is FULL. Due to=
 this side effect,
> we would never release kobject defined for kmem cache and leak the associ=
ated memory.
>
> The issue here's with the use of __is_defined() macro in kmem_cache_relea=
se(). The
> __is_defined() macro expands to __take_second_arg(arg1_or_junk 1, 0). If =
"arg1_or_junk" is
> defined to 1 then it expands to __take_second_arg(0, 1, 0) and returns 1.=
 If "arg1_or_junk"
> is NOT defined to any value then it expands to __take_second_arg(... 1, 0=
) and returns 0.
>
> In this particular issue, SLAB_SUPPORTS_SYSFS is defined without any asso=
ciated value and that
> causes __is_defined(SLAB_SUPPORTS_SYSFS) to always evaluate to 0 and henc=
e it would never invoke
> sysfs_slab_release().
>
> The following patch shall help fix this:

Thanks for the debug and fix, confirmed the issue was fixed with this chang=
e.

>
> diff --git a/mm/slab.h b/mm/slab.h
> index f22fb760b286..3e0a08ea4c42 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -310,7 +310,7 @@ struct kmem_cache {
>  };
>
>  #if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> -#define SLAB_SUPPORTS_SYSFS
> +#define SLAB_SUPPORTS_SYSFS 1
>  void sysfs_slab_unlink(struct kmem_cache *s);
>  void sysfs_slab_release(struct kmem_cache *s);
>  #else
>
> I will post the above patch in mm/slab mailing list.
>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang

