Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CD4C7E
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713230749; cv=none; b=rIvI3PBIEF+jJSxeRWv/6M0HYJTeWUkyo6ESRdXVKvCCtZVa8aCGtnubwIDBsH0ZNOEqkt16rwTJpchR5k6xoyVStOXWfmdBetcvdERk68/41xZD2z81G0dzC5OhLGaIVZHozuO0+phU4tFNirud/M0sjZsPkbf4JtHIVbLpw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713230749; c=relaxed/simple;
	bh=4g87yPDSVVd4CpHV6CQtxiOua1Gs/FKgYGHNpUspGY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GytOTM2rR+CEEAlys8B0zeRh3qoGs4vetkApBbFAgCecBSOVe6Wxta2W7UrxW0gO13TOnH45klOtJpPn+2yg1kNRHyHdfKk0dHjsRhKB3K8KF53XxacXSa04jhBjPyAIAYOPl3Te8o62n4sZJpS3gX9Yn674YzvjYmsT3g8RLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aim5Luib; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aim5Luib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713230746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+czBvi4mDC6g5uH6Fm3gRVQzOA6eJGwQkRIFqjWsKk=;
	b=Aim5LuibevVvWNe1ntmwBL8bSXTNFZkmRZDwZXvuFC1EvkZuF9hXz6mSHcR+1atHR+evxu
	+K1+GSYo3Su84OZVq5Wvdxz7Wi2c/jMVSA6ktWj2228mb/hg7EWE/o8uPpAANeED0hwg9P
	kz3p8dZwH90ngrsXlT8p1LK4q7QkirE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-t-ZsXbsTOoKm7c2s3I_nSQ-1; Mon, 15 Apr 2024 21:25:44 -0400
X-MC-Unique: t-ZsXbsTOoKm7c2s3I_nSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E00D1805BE0;
	Tue, 16 Apr 2024 01:25:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D7F22166B31;
	Tue, 16 Apr 2024 01:25:41 +0000 (UTC)
Date: Tue, 16 Apr 2024 09:25:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Changhui Zhong <czhong@redhat.com>,
	Linux Block Devices <linux-block@vger.kernel.org>
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at
 io_uring/io_uring.c:2835 io_ring_exit_work+0x2b6/0x2e0
Message-ID: <Zh3TjqD1763LzXUj@fedora>
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
 <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Apr 15, 2024 at 08:28:05AM -0600, Jens Axboe wrote:
> On 4/15/24 3:14 AM, Changhui Zhong wrote:
> > Hello,
> > 
> > repo:https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> > branch:for-next
> > commit HEAD:f2738f2440eb573094ef6f09cca915ae37f2f8bc
> > 
> > hit this issue on recent upstream，reproduced with ubdsrv, trigger this
> > issue on "running generic/005" and "running generic/006",
> > 
> > # cd ubdsrv
> > # make test T=generic
> > 
> > [  993.347470] WARNING: CPU: 13 PID: 4628 at io_uring/io_uring.c:2835
> > io_ring_exit_work+0x2b6/0x2e0
> > [  993.357304] Modules linked in: ext4 mbcache jbd2 rfkill sunrpc
> > dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
> > intel_uncore_frequency_common i10nm_edac nfit libnvdimm
> > x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif
> > rapl intel_cstate mgag200 iTCO_wdt dax_hmem iTCO_vendor_support
> > cxl_acpi mei_me i2c_algo_bit cxl_core i2c_i801 drm_shmem_helper
> > isst_if_mmio isst_if_mbox_pci drm_kms_helper intel_uncore mei einj
> > ioatdma pcspkr i2c_smbus isst_if_common intel_vsec intel_pch_thermal
> > ipmi_si dca ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter drm
> > fuse xfs libcrc32c sd_mod t10_pi sg ahci crct10dif_pclmul libahci
> > crc32_pclmul crc32c_intel libata tg3 ghash_clmulni_intel wmi dm_mirror
> > dm_region_hash dm_log dm_mod
> > [  993.431516] CPU: 13 PID: 4628 Comm: kworker/u96:2 Not tainted 6.9.0-rc3+ #1
> > [  993.439297] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> > BIOS AFE120G-1.40 09/20/2022
> > [  993.449015] Workqueue: iou_exit io_ring_exit_work
> > [  993.454275] RIP: 0010:io_ring_exit_work+0x2b6/0x2e0
> > [  993.459729] Code: 89 e7 e8 6d de ff ff 48 8b 44 24 58 65 48 2b 04
> > 25 28 00 00 00 75 2e 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc
> > cc cc cc <0f> 0b 41 be 60 ea 00 00 e9 45 fe ff ff 0f 0b e9 1d ff ff ff
> > e8 c1
> > [  993.480695] RSP: 0018:ff70b0c247657dd0 EFLAGS: 00010287
> > [  993.486533] RAX: 00000001000a94c0 RBX: ff26a781c5b48448 RCX: 0000000000000000
> > [  993.494506] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff26a781c5b48040
> > [  993.502475] RBP: ff70b0c247657e60 R08: 0000000000000000 R09: ffffffffbb254ca0
> > [  993.510445] R10: 0000000000000000 R11: 0000000000000000 R12: ff26a781c5b48000
> > [  993.518415] R13: ff26a781c5b48040 R14: 0000000000000032 R15: 0000000000000000
> > [  993.526387] FS:  0000000000000000(0000) GS:ff26a784efa80000(0000)
> > knlGS:0000000000000000
> > [  993.535427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  993.541848] CR2: 00007ff5a794f004 CR3: 000000003ea20006 CR4: 0000000000771ef0
> > [  993.549820] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  993.557790] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  993.565761] PKRU: 55555554
> > [  993.568787] Call Trace:
> > [  993.571523]  <TASK>
> > [  993.573871]  ? __warn+0x7f/0x130
> > [  993.577486]  ? io_ring_exit_work+0x2b6/0x2e0
> > [  993.582259]  ? report_bug+0x18a/0x1a0
> > [  993.586358]  ? handle_bug+0x3c/0x70
> > [  993.590262]  ? exc_invalid_op+0x14/0x70
> > [  993.594551]  ? asm_exc_invalid_op+0x16/0x20
> > [  993.599234]  ? io_ring_exit_work+0x2b6/0x2e0
> > [  993.604006]  ? try_to_wake_up+0x21e/0x600
> > [  993.608490]  process_one_work+0x193/0x3d0
> > [  993.612969]  worker_thread+0x2fc/0x410
> > [  993.617161]  ? __pfx_worker_thread+0x10/0x10
> > [  993.621934]  kthread+0xdc/0x110
> > [  993.625448]  ? __pfx_kthread+0x10/0x10
> > [  993.629640]  ret_from_fork+0x2d/0x50
> > [  993.633640]  ? __pfx_kthread+0x10/0x10
> > [  993.637830]  ret_from_fork_asm+0x1a/0x30
> > [  993.642219]  </TASK>
> > [  993.644661] ---[ end trace 0000000000000000 ]---
> 
> I can't reproduce this here, fwiw. Ming, something you've seen?

I just test against the latest for-next/block(-rc4 based), and still can't
reproduce it. There was such RH internal report before, and maybe not
ublk related.

Changhui, if the issue can be reproduced in your machine, care to share
your machine for me to investigate a bit?

Thanks,
Ming

