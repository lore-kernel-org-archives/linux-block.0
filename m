Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDB1428E5
	for <linux-block@vger.kernel.org>; Fri, 26 Jul 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026928; cv=none; b=Jyiq0xKReTjki8uLTeBIWfdyiLQDK/aT7TX5ZrmP7LfYwgmhUyqRCLA2X+Y5nlk7fS2ujglFzgnbnbQXb01x5JDjxYUr6hhsu3F7/fBPEASlMr46Vp7vnfci12rOw28lVWciINjAL5Twfla6cAbP/3nl9x7Civ0sYdxVFxfDGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026928; c=relaxed/simple;
	bh=0ptgAo76sEALm0wWfTfRkIhC3WoPOl25PxfbjjWdvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=scdnDlpSKI0wdYH+iETIm81MgNOzL5fIwVxLvyXVRtcEp8DJf/Dfi3eyM5fHz2rOkbFWzmCdkn777OZx4f/f6Foa9n76V4qCIi/ArEPpLkTho4IufwnelTj+4iagyrfy1JRcxPQ53Oyt/ngHNcuh9YR0fCQseKOjzR0G+6V40uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDRxJUgT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDRxJUgT"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7d26c2297eso197471266b.2
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2024 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722026925; x=1722631725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBMgfixy+x8J4chK+XEr8yM6u1+DycWp9/E02fNR+AA=;
        b=VDRxJUgTZSHxpnVMdJh+/y8vRSXieitfNd4ynNT2knNOe48yEifRLYAnAHLyklnsY8
         wY+jhL4Qbw7qBpYw4KD/aqBvdHZ7fSJ0q8s3NzEZDuq5kmwfaoVwQEZTSysTA9/ioFr0
         HxtZqBzhW8zka5xdgzrvVnJufSXwJ3GGhz31p4RHhu2rEndFRiiPLKnECyBxMDwVfIPm
         DB+vCJjQnP35qMjv/WU11fdOUB1csLsUjvBBXYXVLWlmKKV+ldPW/ZEGdjq44ONOh87P
         iOqF8LpnepqQdhW7FLukNJ0IAgx9G8+FOqUeZI1exFM+M7x0bGFuqeYXLoZyyM5A0QcV
         ZsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026925; x=1722631725;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBMgfixy+x8J4chK+XEr8yM6u1+DycWp9/E02fNR+AA=;
        b=YAHLZm3wTkhAmEnpFt8LPtK1WdAbggoMfUktw1mVv2NS8wehUgwrVtb752fGrgLFLY
         pPKhP8+26tZ1Kq6U44kYoG/GWbWldMJggl6KMk0wFul7lgb2a4mLlRU9hGbtO6OiszdN
         NjnmzyE6pA8sPW4eqaFC5c1pvYIqismNHkE1dMH0NVmy1VLMVklZHk9UywJpGt60UGIZ
         /ZS72hRuV29Af5WdhPkpeg9eQLeWX2ucX3EZbBbtZ9loccoJDqe02uxtJ3Dsy/uXFXkT
         IopnO9XCVTlGlfbhInn5/5Ak0gQTrbnNrm8WGgidgkqfgsnE2vHlLu5uYeLzwrgatYTT
         SH/g==
X-Forwarded-Encrypted: i=1; AJvYcCWkFvZGgReG+ed8ivIXZNALBF4QodljEUQO8YIsBRsgGIPp3qcfC5NtP3tM/WIE+0frJr318Ou5XGYL+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXr1cNIExXOERqSXsYdgmfVS04WkyTlH5vtcOnX1wBzP9YNeg
	76YiHO2NMUJASbF/YWbmcNKqI69HtPMffQ/uEY1u/Asg5wg+QNUs
X-Google-Smtp-Source: AGHT+IH/Wk3yKHVOGm6Q2V0uGvjeJYCJriHVdyxX3OVHO2TxkE0uWiwh2D6R3c+mhA8SO2IVFuazNQ==
X-Received: by 2002:a17:907:72cc:b0:a7a:9d74:21c3 with SMTP id a640c23a62f3a-a7d400a1a61mr52676966b.35.1722026924592;
        Fri, 26 Jul 2024 13:48:44 -0700 (PDT)
Received: from shift.daheim (p200300d5ff30930050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff30:9300:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2302dsm212952766b.39.2024.07.26.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:48:44 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=shift.localnet)
	by shift.daheim with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <chunkeey@gmail.com>)
	id 1sXSkR-00000000zGU-3SKI;
	Fri, 26 Jul 2024 22:48:43 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk, dlemoal@kernel.org, jasowang@redhat.com,
 kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, martin.petersen@oracle.com, mst@redhat.com,
 pbonzini@redhat.com, sagi@grimberg.me, stefanha@redhat.com,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
Date: Fri, 26 Jul 2024 22:48:43 +0200
Message-ID: <2011786.tdWV9SEqCh@shift>
In-Reply-To: <20240213073425.1621680-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

got a WARNING splatch (=> boot harddrive is inaccessible - device fails to boot) 

------------[ cut here ]------------
WARNING: CPU: 0 PID: 29 at block/blk-settings.c:185 blk_validate_limits+0x154/0x294
Modules linked in:
CPU: 0 PID: 29 Comm: kworker/u4:2 Tainted: G        W          6.10.0+ #1
Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
Workqueue: async async_run_entry_fn
NIP:  c02f1f00 LR: c02eef3c CTR: 00000000
REGS: c114bbc0 TRAP: 0700   Tainted: G        W           (6.10.0+)
MSR:  0002b000 <CE,EE,FP,ME>  CR: 84000008  XER: 00000000

GPR00: c02eef28 c114bcb0 c116cf40 c114bda8 00000082 ffffffff ffffffff 00000200
GPR08: 00000200 0000ffff 00001fff c114bc80 44000008 00000000 c00433f0 c119b440
GPR16: 00000000 00000000 00000000 00000000 c105d505 c1101880 c11b6250 00000001
GPR24: 00000000 c0ab0000 c114bda8 ffffffff c0a1eb68 00000000 00000014 c1b683d0
NIP [c02f1f00] blk_validate_limits+0x154/0x294
LR [c02eef3c] blk_alloc_queue+0x80/0x1f0
Call Trace:
[c114bcb0] [c02ffa54] blk_alloc_queue_stats+0x20/0x48 (unreliable)
[c114bcc0] [c02eef28] blk_alloc_queue+0x6c/0x1f0
[c114bcf0] [c02fde24] blk_mq_alloc_queue+0x50/0xa8
[c114bd90] [c04393b4] scsi_alloc_sdev+0x190/0x2b8
[c114be40] [c04395a8] scsi_probe_and_add_lun+0xcc/0x2a0
[c114bea0] [c043a008] __scsi_add_device+0xe4/0x134
[c114bee0] [c045296c] ata_scsi_scan_host+0x84/0x27c
[c114bf30] [c0048158] async_run_entry_fn+0x34/0xcc
[c114bf50] [c003c800] process_scheduled_works+0x170/0x244
[c114bf90] [c003cc48] worker_thread+0x184/0x1d4
[c114bfc0] [c00434bc] kthread+0xcc/0xd0
[c114bff0] [c000c210] start_kernel_thread+0x10/0x14
Code: 81430050 7c085040 40810008 91030050 81430004 2c0a0000 40820010 3940ffff 91430004 48000014 280a3ffe 41a1000c <0fe00000> 48000130 80c30008 81430020
---[ end trace 0000000000000000 ]---
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured

---

This is due to this patch adds
| /*
|   * By default there is no limit on the segment boundary alignment,
|   * but if there is one it can't be smaller than the page size as
|   * that would break all the normal I/O patterns.
|   */
|   if (!lim->seg_boundary_mask)
|           lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
|   if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1)) <----- this warning gets triggered
|          return -EINVAL;

My guess is that this is caused by the kernel has a 16K page size.

CONFIG_HAVE_PAGE_SIZE_16KB=y
CONFIG_PAGE_SIZE_16KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=14

This worked fine (sata driver is sata_dwc_460ex.c) in the past (and using 16K pages was
slightly faster than 4k pages)... and yes: using a 4K page size works (as in: device boots again).

Regards,
Christian


