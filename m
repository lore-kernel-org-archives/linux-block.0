Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD541E515
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157537; cv=none; b=uSvDWxtQR8pzHzElQOG23omhu8SD54NKQ9rCoHUh+jVumi6VLXpPbtn4CRs86X+sY41YmnvH58UHaBI5C6WUhCuGePQjX5M9PyCjCNHcRWjwBW74GBu0rhYIFuZ81TEP5w0cQNCguH6COFheZElPNkYUWqiKXDX2VwbDW4E/gO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157537; c=relaxed/simple;
	bh=ob21lybJrdERUbqkYpjIHA94wyFzwUG+tzNd5PyOx7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyugzLZkax7lwENiojxYex05yODRt3a3hqYsBIdVX15QbMJugqtLZVuKxpZtMK6ukcBdzz+cXfisKmnM3emyaQ4tuii+V4TZi5lBQs0Rr1hSDeRmzfoSv20Hihs3Toe7KKBqqh7TYREU6jCuiXmBtu8WOcBl1zG7W9i/v18DjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=egmwlRTu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="egmwlRTu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20792913262so60555315ad.3
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 22:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727157535; x=1727762335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRtIYDanldq3DTAtfPE2b78bokU628Re5ejpctfqrkE=;
        b=egmwlRTuiyKC4XEhCx+Qz0uk55Zvaok1L5Df5M4EldpRMyulwqUqWz8FUQBV4sfUzX
         CwlQAW7k7UJQyfmwwyIOr+2RfhHGyxm3RfGTAUipxBcQie+Rmmju4AN1FK9SBcmzJRfe
         PqQsDohF3QEP8o7nTmucUZGtfCognaKbz0dKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727157535; x=1727762335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRtIYDanldq3DTAtfPE2b78bokU628Re5ejpctfqrkE=;
        b=m9LdzEXo9JWiE7uw1Ratt02KnP3pq3pAXR6skBV/5azJsCIt/Pvu40Dwe5ecY8hIjd
         mzVj5fxaKH2SCFOoXOG3tbjJ310e91id4Og4eg2cVa4YGJ785CcU2aNYj8zzC82vrYIb
         qhsia7vLF4mMZVMQgWLPQpd2tpARjHuoKYsmQF54ge8lfVUl0avHo73iFyM1jtaIa+JS
         tagS89K2Zv03JPJ4kuVT9K8Vwi+UnEHrCrvJJa6hRO3oCuJPAA4oUPbf7tqSkKi7QQnb
         MZPwD2uzqMmq5gsFZgWW2tpNYSe4ghou4q88C8VWKm5ov6iJAOxn1yTQ9Ebp9ACVsc+t
         MX4g==
X-Forwarded-Encrypted: i=1; AJvYcCUhR2sracv3Eair17RoEeH1RcALQKh0JuRiUGgOSqFZffYHDhiRLvX+y0qQ04hZIyH/THnBwibG5ZyxXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4+8FRrSjCVhh3/cB1NIzsZYsj2tRnQ4YA76mM5g7LXrifFKa
	XYrhZh733kewUa+VvMtm3yrqVdQH3SV+WGJ9e1bO6gXrznyECpUYUqEaFf2jcQ==
X-Google-Smtp-Source: AGHT+IEb2Cn0zNdg8UplHAxAAyvpzeRYOYRjPnX0YOgSQ3eHhbrWgDCH7EhJ/T20eSMR4UZqEpLKFw==
X-Received: by 2002:a17:902:db05:b0:1fb:62e8:ae98 with SMTP id d9443c01a7336-208d833b445mr215821195ad.3.1727157534724;
        Mon, 23 Sep 2024 22:58:54 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1726745sm4172335ad.111.2024.09.23.22.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:58:54 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:58:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924055850.GN38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
 <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
 <20240924054951.GM38742@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924054951.GM38742@google.com>

On (24/09/24 14:49), Sergey Senozhatsky wrote:
> On (24/09/24 07:21), Christophe JAILLET wrote:
> [..]
> > > kfree_const() will not work if zram is built as a module. It works
> > > only for .rodata for kernel image. [1]
> > >
> > > 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> > >
> >
> > If so, then it is likely that it is not correctly used elsewhere.
> >
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/dax/kmem.c#L289
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/firmware/arm_scmi/bus.c#L341
> > https://elixir.bootlin.com/linux/v6.11/source/drivers/input/touchscreen/chipone_icn8505.c#L379
>
> icn8505_probe_acpi() uses kfree_const(subsys)...
>
> subsys is returned from acpi_get_subsystem_id() which only
> does
> 		sub = kstrdup(obj->string.pointer, GFP_KERNEL);
>
> However, if acpi_get_subsystem_id() returns an error then
> icn8505_probe_acpi() does
>
> 		subsys = "unknown";
>
> and I suspect that kfree_const(subsys) can, in fact, explode?

A trivial test to replicate icn8505_probe_acpi() error path

(zram built as a module)

---
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d3329a67e805..5cd65dd7dafa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2719,11 +2719,21 @@ static void destroy_devices(void)
        cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
 }

+static void boom(void)
+{
+       char *str = "unknown";
+
+       pr_err(":: kfree_const() %s\n", str);
+       kfree_const(str);
+}
+
 static int __init zram_init(void)
 {
        struct zram_table_entry zram_te;
        int ret;

+       boom();
+
        BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > sizeof(zram_te.flags) * 8);

        ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
---


[   15.494947] zram: :: kfree_const() unknown
[..]
[   15.498085] WARNING: CPU: 5 PID: 420 at mm/slub.c:4690 free_large_kmalloc+0x18/0xb0
[   15.500393] Modules linked in: zram(+) 842_decompress 842_compress zsmalloc zstd_compress lz4hc_compress lz4_compress zlib_deflate
[   15.503405] CPU: 5 UID: 0 PID: 420 Comm: modprobe Tainted: G                 N 6.11.0-next-20240920+ #727
[   15.506013] Tainted: [N]=TEST
[   15.506792] RIP: 0010:free_large_kmalloc+0x18/0xb0
[..]
[   15.531487] Call Trace:
[   15.532102]  <TASK>
[   15.532616]  ? __warn+0x12d/0x340
[   15.533409]  ? free_large_kmalloc+0x18/0xb0
[   15.534397]  ? free_large_kmalloc+0x18/0xb0
[   15.535426]  ? report_bug+0x170/0x380
[   15.536365]  ? handle_bug+0x5c/0xa0
[   15.537206]  ? exc_invalid_op+0x16/0x40
[   15.538155]  ? asm_exc_invalid_op+0x16/0x20
[   15.539189]  ? free_large_kmalloc+0x18/0xb0
[   15.540194]  init_module+0x25/0xffb [zram]
[   15.541173]  do_one_initcall+0x130/0x450
[   15.542143]  ? __cfi_init_module+0x5/0x5 [zram]
[   15.543282]  ? stack_depot_save_flags+0x25/0x700
[   15.544413]  ? stack_trace_save+0xb3/0x150
[   15.545428]  ? kasan_save_track+0x3c/0x60
[   15.546401]  ? kasan_save_track+0x2b/0x60
[   15.547364]  ? __kasan_kmalloc+0x6e/0x80
[   15.548350]  ? do_init_module+0x16e/0x890
[   15.549348]  ? __se_sys_finit_module+0x513/0x7e0
[   15.550437]  ? do_syscall_64+0x71/0x110
[   15.551385]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   15.552662]  ? stack_depot_save_flags+0x25/0x700
[   15.553751]  ? stack_trace_save+0xb3/0x150
[   15.554754]  ? __create_object+0x62/0x110
[   15.555767]  ? do_raw_spin_unlock+0x5a/0x950
[   15.556778]  ? __create_object+0x62/0x110
[   15.557727]  ? _raw_spin_unlock_irqrestore+0x31/0x40
[   15.558928]  ? __create_object+0x62/0x110
[   15.559947]  ? kasan_unpoison+0x49/0x70
[   15.560855]  ? __asan_register_globals+0x54/0x70
[   15.561976]  do_init_module+0x36a/0x890
[   15.562940]  __se_sys_finit_module+0x513/0x7e0
[   15.564034]  do_syscall_64+0x71/0x110
[   15.564948]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[..]
[   15.894538] kernel BUG at include/linux/mm.h:1140!
[   15.895727] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[   15.897003] CPU: 5 UID: 0 PID: 420 Comm: modprobe Tainted: G    B   W        N 6.11.0-next-20240920+ #727
[   15.899215] Tainted: [B]=BAD_PAGE, [W]=WARN, [N]=TEST
[   15.900395] RIP: 0010:free_large_kmalloc+0xaa/0xb0
[..]
[   15.924239] Call Trace:
[   15.924836]  <TASK>
[   15.925343]  ? __die_body+0x66/0xb0
[   15.926183]  ? die+0xa0/0xc0
[   15.926873]  ? do_trap+0xf4/0x2e0
[   15.927671]  ? free_large_kmalloc+0xaa/0xb0
[   15.928665]  ? do_error_trap+0xfc/0x180
[   15.929567]  ? free_large_kmalloc+0xaa/0xb0
[   15.930550]  ? handle_invalid_op+0x4f/0x60
[   15.931529]  ? free_large_kmalloc+0xaa/0xb0
[   15.932513]  ? exc_invalid_op+0x2f/0x40
[   15.933422]  ? asm_exc_invalid_op+0x16/0x20
[   15.934413]  ? free_large_kmalloc+0xaa/0xb0
[   15.935410]  init_module+0x25/0xffb [zram]
[   15.936375]  do_one_initcall+0x130/0x450
[   15.937306]  ? __cfi_init_module+0x5/0x5 [zram]
[   15.938550]  ? stack_depot_save_flags+0x25/0x700
[   15.939799]  ? stack_trace_save+0xb3/0x150
[   15.940786]  ? kasan_save_track+0x3c/0x60
[   15.941755]  ? kasan_save_track+0x2b/0x60
[   15.942729]  ? __kasan_kmalloc+0x6e/0x80
[   15.943697]  ? do_init_module+0x16e/0x890
[   15.944665]  ? __se_sys_finit_module+0x513/0x7e0
[   15.945782]  ? do_syscall_64+0x71/0x110
[   15.946716]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   15.947978]  ? stack_depot_save_flags+0x25/0x700
[   15.949091]  ? stack_trace_save+0xb3/0x150
[   15.950082]  ? __create_object+0x62/0x110
[   15.951052]  ? do_raw_spin_unlock+0x5a/0x950
[   15.952094]  ? __create_object+0x62/0x110
[   15.953064]  ? _raw_spin_unlock_irqrestore+0x31/0x40
[   15.954255]  ? __create_object+0x62/0x110
[   15.955221]  ? kasan_unpoison+0x49/0x70
[   15.956154]  ? __asan_register_globals+0x54/0x70
[   15.957261]  do_init_module+0x36a/0x890
[   15.958199]  __se_sys_finit_module+0x513/0x7e0
[   15.959282]  do_syscall_64+0x71/0x110
[   15.960172]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
