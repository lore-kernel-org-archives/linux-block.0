Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443201CEADB
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429268; cv=none; b=oWtFXolw7zLSyIF62FqGUb2VYlvbd85XhaISrCNwN1l5jv+sVOViwjCq85A5/N/M6BzcHA79EHxK55QedGgvcZ1dAmO/ibpX39LtplTDUk8EyHugXtsabEJRpTU2s2XpRMJft4XbDQsi/0UAjc9Yx9PerUjjuF1dJ0Biik/X/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429268; c=relaxed/simple;
	bh=aqJ7o45uLI1xpgyYbjoPhrdUjpPTrJcW/vLjLTwncq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i37ZpZMq3xRUmhuEXldY3ls+AunaOL/vxCu0zDaBhJmooUklZdgPSE+FimZ4YuVS656lUtUBm93XkOA2qfwsju9fAvJJW03/fE1FWIOualhCSgx68HALHrleJNqXe9OGPz1HF96l7XFH/0jQNlfxhU20jpB3ABjGQS9EJalpauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=cG0J4XLM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="cG0J4XLM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so8178265e9.3
        for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1753429261; x=1754034061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geFlVrKcmvRJLzb8sXS57LgdgI6n9+ZSaP8tv34lg8w=;
        b=cG0J4XLMjMZI3TwUNmCSdLm2QsHbjycB+vz8+qgaLal2ovfwYH2Vxvk+OB351kji6o
         VDDLnyZT8IzGKiv9eWXkRou1to9oIH9Ioj97wYGd+aKRMOQD3CjA35EKCHsHBHEu4HYP
         JcPP8I5dc0KHpER8VKdQkAu1/mytyFTiScsehLAUJi71sAgLGZrfhL1qP26KkhIiPWj6
         c6xO5qe7PXzEoTa22OIRxTSMhzlkUxHQ1CUne/9B4PX3+S5CZZSe7PZEqNjjhr46ZjSu
         u6rvsNzCEF+mIaJmVQq9pc1D/i6EaOc2C96FAiEk//wV9kCHwhhsvCs7anKVE+99mHbI
         thfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429261; x=1754034061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geFlVrKcmvRJLzb8sXS57LgdgI6n9+ZSaP8tv34lg8w=;
        b=YNJta0JDENvf9G6o2E4TrT/IjWoc0GXhiqJg7GKl6IF0vy3nKU5jPi5d+45rPMll9C
         BTsqfrGMG+puP6ZC6Zhl9LMfxR9tuOHpjUoi4o9aDDevdbEnMt6J2V14FBPtpYIWhgj7
         WrSB7+uMLE77PT3pBXxsHx/KjgtCUE8P1hxwN4wcdzz52RMLxCvJ2BVxg/JK5IfW7P94
         7ByBMJzwyjhXVzketQRBIGiQgwXwVoSXcSkdgveWwVCnOGvRlmY6VNXX8etEl4RA2Oo1
         faYI4dpm5+BIxHHShMw6mEaqiXYjdcXUPKk1Q658UqjJCHNDhnlyvlhSFLmPMS9R8y22
         sOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoNT0uFqDKXjSjlmvUt68giMDaiJYSi1rKhGO2H75LvSxSBOz6kLktp4KoXe6Q4NVTxCxInzxD1n+j6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YweeT/ADzBWIF0GTMX22ywAW2ocGvzXmVMVbkpQ8zFnhhPYD6qT
	E6WCW5nCrZc7FCml3J7E4hN08p6n1/rmpJElY/szjahU5jxDlL/fnY5p9RVe3ZgdTwQd4Vue9CE
	oNdcj
X-Gm-Gg: ASbGncuQNDiG3dcgpyQL6gqV2GQ6kL+374ELN6IAO3KKbBENryJwh7LBVfW/6eX6Sdv
	g5dIvczZWS96dOILQsltiLLyOiMz33yg+8Yhn3jV7EXskaKPdPJBb+Ps4cE9Bnv1INZpzk8R2LT
	yjMpi9lO5BKxaItvfSMy3ipyV7GvYXQzd5Gc+JYIK/yFMOWU1FoHopF/sQVMJkaAK/O8HdiXBkv
	4u17sV5JAPQU1rp8PsXfzfrOpyg4RTtUVGqt2WwG1d4iA3qj+lv7YWQZ8onfbFSqH4JO8fhL0pg
	zKoZZ7LXcDVeamTL0CmqmPgR1T7TBAnyPmbA6Qv+RkoXf6HSn2KXj2i9943xok9wk2HDL1Cdfki
	CsojrLmq0VYj1lrkMJED763owr9mSBoJBZGvhFtYtZ1aU66GatBc8PKtXDjA4U/ycPhQwaXgAe/
	DiZvVA
X-Google-Smtp-Source: AGHT+IEHtbgcabUemcTafs+n5e0ykTLXXiwVK2KwfhR2UaxAmNtIR4UJHESfaXYLJ9A4IcENAjWgnQ==
X-Received: by 2002:a05:600c:6306:b0:458:6733:fb59 with SMTP id 5b1f17b1804b1-4587644b044mr6657085e9.19.1753429261319;
        Fri, 25 Jul 2025 00:41:01 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6d2c1sm4255598f8f.23.2025.07.25.00.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:41:00 -0700 (PDT)
Date: Fri, 25 Jul 2025 08:40:59 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Phillip Potter <phil@philpotter.co.uk>, axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-ID: <aIM1Cx-YLm3nky58@equinox>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
 <eyejjkuzdzl7qlq3os534ckt3jsvvnvp76pyqcrpzcignj3oms@w7cvw6oht5lk>
 <aICXICNEcwutw9C4@equinox>
 <nlskide2ahqj4gn4jvvazhhmdajqsacz5ch3zukgg2fbfmw2dk@tkyujyzz4pks>
 <3a5hhkymroystnc2ztkyejgyvfsaamfrlwwoagorymonftlkln@7qzlqyaq4zpa>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5hhkymroystnc2ztkyejgyvfsaamfrlwwoagorymonftlkln@7qzlqyaq4zpa>

On Thu, Jul 24, 2025 at 04:51:34PM +0900, Sergey Senozhatsky wrote:
> On (25/07/24 12:54), Sergey Senozhatsky wrote:
> > On (25/07/23 09:02), Phillip Potter wrote:
> > > On Wed, Jul 23, 2025 at 10:14:32AM +0900, Sergey Senozhatsky wrote:
> > > > On (25/07/23 00:18), Phillip Potter wrote:
> > > > > [..] I plan to do more digging regarding this, hopefully
> > > > > this weekend when I have some free time, as I'd really love to replicate
> > > > > the original crash.
> > > > 
> > > > I waiting for LG GP65NB60 shipment (arriving today/tomorrow), which
> > > > shows up in crash reports (it should have CDC_MRW_W.)  So I'll be able
> > > > to run some tests soon.
> > > 
> > > Had to fake it with mine by forcing open the relevant code path for the
> > > check to be done. It still didn't crash, so I'll be interested to see
> > > your results
> > 
> > 100% reproducible (at least on 6.6 LTS) with LG GP65.
> 
> And unpatched 6.12 LTS sometimes UAFs
> 
> [  106.092832] ==================================================================
> [  106.092866] BUG: KASAN: slab-use-after-free in sr_packet+0x179/0x1c0 [sr_mod]
> [  106.092903] Read of size 8 at addr ffff888002a6c154 by task cros-disks/1958
> 
> [  106.092943] CPU: 2 UID: 213 PID: 1958 Comm: cros-disks Not tainted 6.12.24-kasan-00964-g86abb5aa35ec
> [  106.092969] Call Trace:
> [  106.092976]  <TASK>
> [  106.092983]  dump_stack_lvl+0x85/0xc0
> [  106.093007]  print_address_description+0x72/0x210
> [  106.093023]  print_report+0x4e/0x60
> [  106.093037]  kasan_report+0x131/0x170
> [  106.093052]  ? sr_packet+0x179/0x1c0 [sr_mod f28dbac28d644b5cb94db24e267ca134450739a2]
> [  106.093075]  sr_packet+0x179/0x1c0 [sr_mod f28dbac28d644b5cb94db24e267ca134450739a2]
> [  106.093095]  cdrom_mrw_exit+0xea/0x2e0 [cdrom 2d8b336738c9be415c8730ee14c0fc4e4c0367db]
> [  106.093120]  sr_free_disk+0x9a/0xc0 [sr_mod f28dbac28d644b5cb94db24e267ca134450739a2]
> [  106.093138]  disk_release+0x248/0x280
> [  106.093156]  device_release+0x94/0x190
> [  106.093172]  kobject_put+0x177/0x1f0
> [  106.093187]  blkdev_release+0x11/0x20
> [  106.093201]  __fput+0x1a7/0x7c0
> [  106.093221]  task_work_run+0x107/0x180
> [  106.093240]  resume_user_mode_work+0x4e/0x50
> [  106.093254]  syscall_exit_to_user_mode+0x63/0xb0
> [  106.093268]  do_syscall_64+0x76/0xe0
> [  106.093818]  </TASK>
> 
> [  106.094277] Allocated by task 12:
> [  106.094295]  kasan_save_track+0x3a/0x80
> [  106.094318]  __kasan_kmalloc+0x75/0x90
> [  106.094339]  __kmalloc_noprof+0x18e/0x310
> [  106.094360]  scsi_alloc_sdev+0x117/0x9d0
> [  106.094383]  scsi_probe_and_add_lun+0x168/0x3670
> [  106.094405]  __scsi_scan_target+0x121/0x7a0
> [  106.094426]  scsi_scan_host_selected+0x291/0x4f0
> [  106.094448]  do_scan_async+0x21b/0x710
> [  106.094469]  async_run_entry_fn+0x97/0x360
> [  106.094490]  process_scheduled_works+0x757/0xe20
> [  106.094512]  worker_thread+0xb4c/0x1150
> [  106.094533]  kthread+0x274/0x300
> [  106.094553]  ret_from_fork+0x3b/0x70
> [  106.094576]  ret_from_fork_asm+0x11/0x20
> 
> [  106.094611] Freed by task 1958:
> [  106.094628]  kasan_save_track+0x3a/0x80
> [  106.094649]  kasan_save_free_info+0x46/0x60
> [  106.094670]  __kasan_slab_free+0x37/0x50
> [  106.094690]  kfree+0x103/0x300
> [  106.094710]  scsi_device_dev_release+0x95d/0x9d0
> [  106.094732]  device_release+0x94/0x190
> [  106.094753]  kobject_put+0x177/0x1f0
> [  106.094773]  scsi_device_put+0x7f/0x90
> [  106.094793]  bdev_release+0x46a/0x570
> [  106.094818]  blkdev_release+0x11/0x20
> [  106.094836]  __fput+0x1a7/0x7c0
> [  106.094856]  task_work_run+0x107/0x180
> [  106.094880]  resume_user_mode_work+0x4e/0x50
> [  106.094900]  syscall_exit_to_user_mode+0x63/0xb0
> [  106.094920]  do_syscall_64+0x76/0xe0
> [  106.094940]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> 
> 
> The patched one doesn't.

Fantastic news. Thanks for testing this, and for your other testing
too, much appreciated. Have a great weekend.

Regards,
Phil
