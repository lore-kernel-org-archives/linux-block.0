Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A418B12
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343501; cv=none; b=d9SnqJU/p0qy0j7V4cTQNlgVi68Glc7brov94fFbdbTHrMkPMKO/9WEy0vAkWNRHb7wRwqLfTt50LGlezsIzyMqf69XIRwXGRnaHauovVtHwnG6XBpqE2rHaxh7oVQPWdnbLvXpmorzZlIcYD2nMsna2RC37STaJp/6LwdPpJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343501; c=relaxed/simple;
	bh=qkKIbRwznJ23s+ciyR95YYSvxyey87h9sJSo/HeoEjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7EPgCL9LUbxMKglZ2zETe2xE2uqioz/pewsTlWMIwutCxz16+Kuyo3hc5nEgxWdHcZiAtdmyPhpqpkNhOqqHlA5Ql97hdAaikz78tBnzgSb1zssBuRfBzcFk2PhZudNi5JWVRU9BPElH4c7iaxdq8+iTxSShbOEArKnE6QvFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B7WIMIaV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7WIMIaV"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748e378ba4fso931329b3a.1
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753343499; x=1753948299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQs6oTZwtnZz9YvKorlgolw18u2IKJkd8cjA14d4Wg8=;
        b=B7WIMIaVcd0vZx4XzyMAiUxGYmN3m4Rvq9ijFeWfoYoUj2b1gHh0wPzusPcWp1KDV/
         eyeLsCfFwsLx6gu29mM0IYDTWWbM8N8Y+NfXdzqOeIaO88yyuOkMRbrM3/CZfydwTEZ9
         TONEKIrOsihee5cg3DmVssMdZ934zC+aISlXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343499; x=1753948299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQs6oTZwtnZz9YvKorlgolw18u2IKJkd8cjA14d4Wg8=;
        b=Gkt3I3Sg+9xTwjxCQ41/0nHMO1VcjFrZOczb7csDc9sLQzubtzuK27COnUmwwffq+K
         iCBeinr0ycEaB6+reT7HggeazZeJnV22BcXAUn25AK83Nu4+aLM7hlQlax1QADpDtsRe
         t2SyuvOce589cdOQlh0sGiHT88c7MYhmxcUWCAwRY4FWo2v38RnRd/M10nWXB4hljnHM
         Lfu93xkD7Sy/YCqT1xn7L5eNMo4C9T30ms/QmdzmaAHZ+Bn013G4+CC+ZJYNVkvxBy19
         PEXeVm5Hz5ePiPG9AZMcQK+ycc5hPendemL833kbeh9DPuPYbdxrIgO3tPs04bo5aMe6
         gfhg==
X-Forwarded-Encrypted: i=1; AJvYcCUYs/LrOHwz55HERbLmqXK3noNByibgFCQJ7o7pntisziVkkpr0wuKcqgQyEa7X8gntBOx3dYSc4oJTDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/dBSX6VBXLcX8a9X+h05JCF+JrhFPgo/kEooK+tFuCNTcnw6
	DQQ2eUlak2GBRcEyw2hpeptQ3uDjG5ECIXRMBtvqpRA59lrpCeEUdO57Q8Wxc5hOVQ==
X-Gm-Gg: ASbGnct+FXUOt6GQiFHugc0zR3HrycYL0yaaC4lXpI/4jAET8TRuwI0Euf46a5nxyZK
	ZaGJd+VJqjS/m6yTXR5OQ4oHBxHzaxL2uWOQ9EwWCoWvF/637+LMKAwmgTeERKnkAs3PbPkP2Lx
	qLaPAxYWHy5PJe8HKX1fUj/VuT3hK+XjRkpX7aKX4L4yEACh3mTh0sJY0xjLX92Y33Kdoj0MRyA
	sIbNy4tIEC5OgtZeaG3SaiCQFVVdDerQlAmcADP1gMqVk5D6vg79Pq3G2aRGk3hqMo7B/hnSRrc
	2XCeCSo6XCr+tAWFLG2vAcaJY2E9qv6MqH8DzKj/qyYuEhprWIvrnKRgCEufmUeTmd0ribwLH12
	0t0x8ZmXcN5OZrrD3LZbtkGdKog==
X-Google-Smtp-Source: AGHT+IFwusbgbIx7WaUEDsqqbYftkiWAdWClsyd2jRKn52Y5n1gYe0E2zzjynQ1RJ0AKbnjKcx3eAg==
X-Received: by 2002:a05:6a21:6814:b0:232:7628:9959 with SMTP id adf61e73a8af0-23d48fb256cmr10144829637.8.1753343498936;
        Thu, 24 Jul 2025 00:51:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5448:3bed:88e3:eec5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb77fcbsm1030336b3a.11.2025.07.24.00.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:51:38 -0700 (PDT)
Date: Thu, 24 Jul 2025 16:51:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-ID: <3a5hhkymroystnc2ztkyejgyvfsaamfrlwwoagorymonftlkln@7qzlqyaq4zpa>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
 <eyejjkuzdzl7qlq3os534ckt3jsvvnvp76pyqcrpzcignj3oms@w7cvw6oht5lk>
 <aICXICNEcwutw9C4@equinox>
 <nlskide2ahqj4gn4jvvazhhmdajqsacz5ch3zukgg2fbfmw2dk@tkyujyzz4pks>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nlskide2ahqj4gn4jvvazhhmdajqsacz5ch3zukgg2fbfmw2dk@tkyujyzz4pks>

On (25/07/24 12:54), Sergey Senozhatsky wrote:
> On (25/07/23 09:02), Phillip Potter wrote:
> > On Wed, Jul 23, 2025 at 10:14:32AM +0900, Sergey Senozhatsky wrote:
> > > On (25/07/23 00:18), Phillip Potter wrote:
> > > > [..] I plan to do more digging regarding this, hopefully
> > > > this weekend when I have some free time, as I'd really love to replicate
> > > > the original crash.
> > > 
> > > I waiting for LG GP65NB60 shipment (arriving today/tomorrow), which
> > > shows up in crash reports (it should have CDC_MRW_W.)  So I'll be able
> > > to run some tests soon.
> > 
> > Had to fake it with mine by forcing open the relevant code path for the
> > check to be done. It still didn't crash, so I'll be interested to see
> > your results
> 
> 100% reproducible (at least on 6.6 LTS) with LG GP65.

And unpatched 6.12 LTS sometimes UAFs

[  106.092832] ==================================================================
[  106.092866] BUG: KASAN: slab-use-after-free in sr_packet+0x179/0x1c0 [sr_mod]
[  106.092903] Read of size 8 at addr ffff888002a6c154 by task cros-disks/1958

[  106.092943] CPU: 2 UID: 213 PID: 1958 Comm: cros-disks Not tainted 6.12.24-kasan-00964-g86abb5aa35ec
[  106.092969] Call Trace:
[  106.092976]  <TASK>
[  106.092983]  dump_stack_lvl+0x85/0xc0
[  106.093007]  print_address_description+0x72/0x210
[  106.093023]  print_report+0x4e/0x60
[  106.093037]  kasan_report+0x131/0x170
[  106.093052]  ? sr_packet+0x179/0x1c0 [sr_mod f28dbac28d644b5cb94db24e267ca134450739a2]
[  106.093075]  sr_packet+0x179/0x1c0 [sr_mod f28dbac28d644b5cb94db24e267ca134450739a2]
[  106.093095]  cdrom_mrw_exit+0xea/0x2e0 [cdrom 2d8b336738c9be415c8730ee14c0fc4e4c0367db]
[  106.093120]  sr_free_disk+0x9a/0xc0 [sr_mod f28dbac28d644b5cb94db24e267ca134450739a2]
[  106.093138]  disk_release+0x248/0x280
[  106.093156]  device_release+0x94/0x190
[  106.093172]  kobject_put+0x177/0x1f0
[  106.093187]  blkdev_release+0x11/0x20
[  106.093201]  __fput+0x1a7/0x7c0
[  106.093221]  task_work_run+0x107/0x180
[  106.093240]  resume_user_mode_work+0x4e/0x50
[  106.093254]  syscall_exit_to_user_mode+0x63/0xb0
[  106.093268]  do_syscall_64+0x76/0xe0
[  106.093818]  </TASK>

[  106.094277] Allocated by task 12:
[  106.094295]  kasan_save_track+0x3a/0x80
[  106.094318]  __kasan_kmalloc+0x75/0x90
[  106.094339]  __kmalloc_noprof+0x18e/0x310
[  106.094360]  scsi_alloc_sdev+0x117/0x9d0
[  106.094383]  scsi_probe_and_add_lun+0x168/0x3670
[  106.094405]  __scsi_scan_target+0x121/0x7a0
[  106.094426]  scsi_scan_host_selected+0x291/0x4f0
[  106.094448]  do_scan_async+0x21b/0x710
[  106.094469]  async_run_entry_fn+0x97/0x360
[  106.094490]  process_scheduled_works+0x757/0xe20
[  106.094512]  worker_thread+0xb4c/0x1150
[  106.094533]  kthread+0x274/0x300
[  106.094553]  ret_from_fork+0x3b/0x70
[  106.094576]  ret_from_fork_asm+0x11/0x20

[  106.094611] Freed by task 1958:
[  106.094628]  kasan_save_track+0x3a/0x80
[  106.094649]  kasan_save_free_info+0x46/0x60
[  106.094670]  __kasan_slab_free+0x37/0x50
[  106.094690]  kfree+0x103/0x300
[  106.094710]  scsi_device_dev_release+0x95d/0x9d0
[  106.094732]  device_release+0x94/0x190
[  106.094753]  kobject_put+0x177/0x1f0
[  106.094773]  scsi_device_put+0x7f/0x90
[  106.094793]  bdev_release+0x46a/0x570
[  106.094818]  blkdev_release+0x11/0x20
[  106.094836]  __fput+0x1a7/0x7c0
[  106.094856]  task_work_run+0x107/0x180
[  106.094880]  resume_user_mode_work+0x4e/0x50
[  106.094900]  syscall_exit_to_user_mode+0x63/0xb0
[  106.094920]  do_syscall_64+0x76/0xe0
[  106.094940]  entry_SYSCALL_64_after_hwframe+0x55/0x5d


The patched one doesn't.
