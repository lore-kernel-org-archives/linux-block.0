Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0F74E25
	for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191291; cv=none; b=hCLiNTOwPXvasaBPNv6Q2iqx1ZcHqpW7ooJc1MChu8w1P8wGaUEegVpC/uxlC3U7vzP3MbP0Xxilol4ENYXBUuQUNs0K7gad+Rfg2rM57GNfVKyml1F62d9QUkHQMXh1eI5snDGB3Bw8axvQSYuih+vK3iukJ6Bdth2rB2vwuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191291; c=relaxed/simple;
	bh=C9k/67mNDu9JZZVlkC9+YGlA+Pct1REeiGOvVkMO3pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud1/n5OqY9R0kTNNCjRnkT2JJNfUPak8DaL2//A8wijA3pv5GqTHSOVa8dNL1Oc9+Eia8IcsqN1hF4dM9KLwiRsgy4JKzrNKowpazlsOFo3VwifIzVuLTKa8++xsumitmFUx/zRbwCI6brSlPL8hhC+wX4zNENniTc4+L4hkGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZwaRd+QA; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZwaRd+QA"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso51928639f.1
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713191287; x=1713796087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRTtIzWUyjRN105mYcVMSMyn4DDl5DBhcJ+d/09l5DA=;
        b=ZwaRd+QAV1Zg7nCnYoPm+xsW2fjhoj2IwOdp6t5ZsiWBbmQ2TnJfQmvogfG68PUDEq
         oSOp8FeA43rwUUvHfHP88+AGpvWHAG3cRjPSDQHVpXf9HdMPS8xKqCmoq0llg1cE8Vyh
         KZ322nXqc+KVuhIlHOBd8zKahTPP/qeKqJXlckJn6QFUqJR/UA4c1LhtwdvyHLdMGieb
         OTiejAPZI9NG7TDloOX8zbHa0TXUJz58ckG+Eh0xnEXggEEoUvGOhKwYhxZWTKQcwVoi
         E4KU/geNfQAv8dsMeMv2kBw5pGdZ3XzPNNe5qX3XZm6xzB1zXfCyEcmpMQ/WDQ5Vl9qW
         1Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191287; x=1713796087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRTtIzWUyjRN105mYcVMSMyn4DDl5DBhcJ+d/09l5DA=;
        b=GIiWv64sel7UINSbUtdfywCB3okYRT5/9Rj3QhUGARZOcSUfpiE2NWkjE61WkOLkcC
         FgoUgClGyiTm65fAaV6gGseVcWMJx+nb7WDxcA703WhM1FhUW92v0ve0KAI/ZqcJtiGH
         Z37Uzq59t8ACXnE8/QXgS3kbfWgj99DGtm453E0M6cgjmsM0//M96XtMi8vVe9xdaLAd
         WHPXyKRdmsCEIGJLecvzJlBkThZre9+mGyv2DvRQ/TzK4hz07AB0j07p8OeIuYHvhTWa
         3fbwu9B4cKAlNDrgTVAQSU+pl5D8KMcA0yBQJdVuFmlQ4Q5bwkSpnQtQ2Zxd7w/x3anQ
         n5og==
X-Forwarded-Encrypted: i=1; AJvYcCUUWdtxEYapIxJtvCuN98JZK1CQ3n9PNOlGhucq5AmU6MLTA1bCL0a6wIsBdf929Ngmm7Khb1Mbap4aGlk6Sn0sC52V3uFAnrikiSs=
X-Gm-Message-State: AOJu0Yw7bYpEWc/EhjMqrCddfTDfQKa2HOJiPrFIHzAu9PF/KUhUmWFt
	bdoXuRMNic/YENEJsZl8HV2UXn7n6ZI47zl2xfQhVj+Tc3DLGCuJP5ifRBzOc6/qg97h4KqSzB3
	Z
X-Google-Smtp-Source: AGHT+IFS4o4jmGBf7fTJRFTFvKYCXRsjG7/VSIpfAgV2pmxk5gnwG+fVz4MURdY5JJ2zdnPuVAiw0g==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr10548400iov.2.1713191286983;
        Mon, 15 Apr 2024 07:28:06 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f17-20020a05660215d100b007d5e05cef76sm2852977iow.33.2024.04.15.07.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:28:06 -0700 (PDT)
Message-ID: <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk>
Date: Mon, 15 Apr 2024 08:28:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at io_uring/io_uring.c:2835
 io_ring_exit_work+0x2b6/0x2e0
Content-Language: en-US
To: Changhui Zhong <czhong@redhat.com>,
 Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/24 3:14 AM, Changhui Zhong wrote:
> Hello,
> 
> repo:https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> branch:for-next
> commit HEAD:f2738f2440eb573094ef6f09cca915ae37f2f8bc
> 
> hit this issue on recent upstream，reproduced with ubdsrv, trigger this
> issue on "running generic/005" and "running generic/006",
> 
> # cd ubdsrv
> # make test T=generic
> 
> [  993.347470] WARNING: CPU: 13 PID: 4628 at io_uring/io_uring.c:2835
> io_ring_exit_work+0x2b6/0x2e0
> [  993.357304] Modules linked in: ext4 mbcache jbd2 rfkill sunrpc
> dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common i10nm_edac nfit libnvdimm
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif
> rapl intel_cstate mgag200 iTCO_wdt dax_hmem iTCO_vendor_support
> cxl_acpi mei_me i2c_algo_bit cxl_core i2c_i801 drm_shmem_helper
> isst_if_mmio isst_if_mbox_pci drm_kms_helper intel_uncore mei einj
> ioatdma pcspkr i2c_smbus isst_if_common intel_vsec intel_pch_thermal
> ipmi_si dca ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter drm
> fuse xfs libcrc32c sd_mod t10_pi sg ahci crct10dif_pclmul libahci
> crc32_pclmul crc32c_intel libata tg3 ghash_clmulni_intel wmi dm_mirror
> dm_region_hash dm_log dm_mod
> [  993.431516] CPU: 13 PID: 4628 Comm: kworker/u96:2 Not tainted 6.9.0-rc3+ #1
> [  993.439297] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> BIOS AFE120G-1.40 09/20/2022
> [  993.449015] Workqueue: iou_exit io_ring_exit_work
> [  993.454275] RIP: 0010:io_ring_exit_work+0x2b6/0x2e0
> [  993.459729] Code: 89 e7 e8 6d de ff ff 48 8b 44 24 58 65 48 2b 04
> 25 28 00 00 00 75 2e 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc
> cc cc cc <0f> 0b 41 be 60 ea 00 00 e9 45 fe ff ff 0f 0b e9 1d ff ff ff
> e8 c1
> [  993.480695] RSP: 0018:ff70b0c247657dd0 EFLAGS: 00010287
> [  993.486533] RAX: 00000001000a94c0 RBX: ff26a781c5b48448 RCX: 0000000000000000
> [  993.494506] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff26a781c5b48040
> [  993.502475] RBP: ff70b0c247657e60 R08: 0000000000000000 R09: ffffffffbb254ca0
> [  993.510445] R10: 0000000000000000 R11: 0000000000000000 R12: ff26a781c5b48000
> [  993.518415] R13: ff26a781c5b48040 R14: 0000000000000032 R15: 0000000000000000
> [  993.526387] FS:  0000000000000000(0000) GS:ff26a784efa80000(0000)
> knlGS:0000000000000000
> [  993.535427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  993.541848] CR2: 00007ff5a794f004 CR3: 000000003ea20006 CR4: 0000000000771ef0
> [  993.549820] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  993.557790] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  993.565761] PKRU: 55555554
> [  993.568787] Call Trace:
> [  993.571523]  <TASK>
> [  993.573871]  ? __warn+0x7f/0x130
> [  993.577486]  ? io_ring_exit_work+0x2b6/0x2e0
> [  993.582259]  ? report_bug+0x18a/0x1a0
> [  993.586358]  ? handle_bug+0x3c/0x70
> [  993.590262]  ? exc_invalid_op+0x14/0x70
> [  993.594551]  ? asm_exc_invalid_op+0x16/0x20
> [  993.599234]  ? io_ring_exit_work+0x2b6/0x2e0
> [  993.604006]  ? try_to_wake_up+0x21e/0x600
> [  993.608490]  process_one_work+0x193/0x3d0
> [  993.612969]  worker_thread+0x2fc/0x410
> [  993.617161]  ? __pfx_worker_thread+0x10/0x10
> [  993.621934]  kthread+0xdc/0x110
> [  993.625448]  ? __pfx_kthread+0x10/0x10
> [  993.629640]  ret_from_fork+0x2d/0x50
> [  993.633640]  ? __pfx_kthread+0x10/0x10
> [  993.637830]  ret_from_fork_asm+0x1a/0x30
> [  993.642219]  </TASK>
> [  993.644661] ---[ end trace 0000000000000000 ]---

I can't reproduce this here, fwiw. Ming, something you've seen?

-- 
Jens Axboe


