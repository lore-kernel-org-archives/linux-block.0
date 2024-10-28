Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04318C92E
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094249; cv=none; b=pkx7GtFzCIir0qxhKui1X4BH7PQD/watd6T4luXjoE2Ij0CjWo65lUEERZw0m8O0soWZBu5tnvDu/kvR+xu/HOipT/2GDbu2kJhw0d20Tsi0aK9MfEpcr50Nd5Sm7qeF77r9AZcYGEljOxHrhpVaOlNEVdsAgys5iIrZoOuZeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094249; c=relaxed/simple;
	bh=ASb9x8T6t6+qhTIwxa3AcjoFGPWilDLcqgNMdBSd1bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA93DOkmRlGWfTn31Cdqwr6NFeEraYb5Fdsh3MUKMjwvOLx33NZl06BKFyeivB0MZ3EQxUxpR8IE2sGOLlEcVN3Tb2vQxzKwP8o9fjqMFpP6wPUedL3u8I14IuqwiIb0taKr7ATuYoHg+hvIQQXcn+MpfLxhjyjKtf7PCJBytu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UMqfP2gJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UMqfP2gJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so2460713a12.3
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2024 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730094246; x=1730699046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NOANPbkk9PC+XoCaUXn/UwFadzQggCKrFx7XXZXzTs8=;
        b=UMqfP2gJj+Kc1vsXQbeUQdlq0EogdENhHZio5aJkaeU4SBvbsKi95tMxlJQQzLiAi7
         bSHYiu0HxsQPNcwtdA6zpvXD43MCYf0zyeiwxI3otWg2hYfip9TH3FlQjn65SCVKiP5B
         cVDKSw8f6oWD2O/A4TpiffL1uGWmOajsGzzWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730094246; x=1730699046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOANPbkk9PC+XoCaUXn/UwFadzQggCKrFx7XXZXzTs8=;
        b=e1GkIWo7LGWVm+eu7Z+Hp/sjFidzJ7+NOMgh28ua2g7WeeWmutfC/I44DevDjMAN10
         6jBKX4C/qg1jfhjuvSupMgxtk0iUmW68pviK0nLoePzd6g5uTOVkdxVANld5kKX5RF7W
         vQzvAoekET/ls0acvAtMBDNCexjQayvGd/4cK5U2vFIHNQ58xwf9xV8gVb4Z50CaqwyX
         mVh2FCPcxI1+BFe9G5JvJusmHWiQDfpTeQFmX3IMYXukoUyJOs8idxsbU+dN1TTHYS3l
         YCJ9lu5VHrdxky7KgB0x+f+f9HIwMELiNXez17wnuubsq26hVXj0hCQSQKHZk0EDTCt/
         eYHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1wNQbPmDFK61IVyDTTdJOhPDbWWKf5AhH5LDZP+fVs06OA2bBCyOCU1FWlIaTZmrmWbhDIiHKLvxH7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/7hP8JRv1h6d9cIGQzTFCzuVCiYm23GdPSPDwgKsBX3JJo9w
	ETggZ8FXQ7EHxnH0ZestSnLRSRp2ER4grDT052uUd6eG0Rh3+I7oR71h/FgsPg==
X-Google-Smtp-Source: AGHT+IHC9vJc1Lj7/eP+eZ1QEEIK4MIIvx7ns5zrIZPSmc2RUjUFsWziYNqg9PYoaAncRjFVKxUz8w==
X-Received: by 2002:a05:6a20:361f:b0:1d9:c7df:3b1d with SMTP id adf61e73a8af0-1d9c7df3c73mr2232164637.12.1730094246386;
        Sun, 27 Oct 2024 22:44:06 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:33df:d367:fdc8:47a0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1eec0sm5093679b3a.143.2024.10.27.22.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 22:44:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:44:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241028054402.GT1279924@google.com>
References: <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
 <ZxOrGeZnI52LcGWF@fedora>
 <20241019125804.GF1279924@google.com>
 <ZxOvfpI6vgH5oXjg@fedora>
 <20241019135010.GG1279924@google.com>
 <ZxPKP8SEb7Y4ceOq@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxPKP8SEb7Y4ceOq@fedora>

On (24/10/19 23:03), Ming Lei wrote:
> On Sat, Oct 19, 2024 at 10:50:10PM +0900, Sergey Senozhatsky wrote:
> > On (24/10/19 21:09), Ming Lei wrote:
> > > On Sat, Oct 19, 2024 at 09:58:04PM +0900, Sergey Senozhatsky wrote:
> > > > On (24/10/19 20:50), Ming Lei wrote:
> > > > > On Sat, Oct 19, 2024 at 09:37:27PM +0900, Sergey Senozhatsky wrote:
> > [..]
> 
> Probably bio_queue_enter() waits for runtime PM, and the queue is in
> ->pm_only state, and BLK_MQ_REQ_PM isn't passed actually from
> ioctl_internal_command() <- scsi_set_medium_removal().

Sorry for the delay.

Another report.
I see lots of buffer I/O errors

<6>[ 364.268167] usb-storage 3-3:1.0: USB Mass Storage device detected
<6>[ 364.268551] scsi host3: usb-storage 3-3:1.0
<3>[ 364.274806] Buffer I/O error on dev sdc1, logical block 0, lost async page write
<5>[ 365.318424] scsi 3:0:0:0: Direct-Access VendorCo ProductCode 2.00 PQ: 0 ANSI: 4
<5>[ 365.319898] sd 3:0:0:0: [sdc] 122880000 512-byte logical blocks: (62.9 GB/58.6 GiB)
<5>[ 365.320077] sd 3:0:0:0: [sdc] Write Protect is off
<7>[ 365.320085] sd 3:0:0:0: [sdc] Mode Sense: 03 00 00 00
<4>[ 365.320255] sd 3:0:0:0: [sdc] No Caching mode page found
<4>[ 365.320262] sd 3:0:0:0: [sdc] Assuming drive cache: write through
<6>[ 365.322483] sdc: sdc1
<5>[ 365.323130] sd 3:0:0:0: [sdc] Attached SCSI removable disk
<6>[ 369.083225] usb 3-3: USB disconnect, device number 49

Then PM suspend/resume.

After resume

<7>[ 1338.847937] PM: resume of devices complete after 291.422 msecs
<6>[ 1338.854215] OOM killer enabled.
<6>[ 1338.854235] Restarting tasks ...
<6>[ 1338.854797] mei_hdcp 0000:00:16.0-(UUID: 7): bound 0000:00:02.0 (ops 0xffffffffb8f03e50)
<6>[ 1338.857745] mei_pxp 0000:00:16.0-(UUID: 2): bound 0000:00:02.0 (ops 0xffffffffb8f16a80)
<4>[ 1338.859663] done.
<5>[ 1338.859683] random: crng reseeded on system resumption
<12>[ 1338.868200] init: cupsd main process ended, respawning
<6>[ 1338.868541] Resume caused by IRQ 9, acpi
<6>[ 1338.868549] Resume caused by IRQ 98, chromeos-ec
<6>[ 1338.868555] PM: suspend exit

lots of buffer I/O errors again and eventually a deadlock.  The deadlock
happens much later than 120 seconds after resume, so I cannot directly
connect those events.

[..]
<6>[ 1859.660882] usb-storage 3-3:1.0: USB Mass Storage device detected
<6>[ 1859.661457] scsi host4: usb-storage 3-3:1.0
<3>[ 1859.668180] Buffer I/O error on dev sdd1, logical block 0, lost async page write
<5>[ 1860.697826] scsi 4:0:0:0: Direct-Access VendorCo ProductCode 2.00 PQ: 0 ANSI: 4
<5>[ 1860.699222] sd 4:0:0:0: [sdd] 122880000 512-byte logical blocks: (62.9 GB/58.6 GiB)
<5>[ 1860.699373] sd 4:0:0:0: [sdd] Write Protect is off
<7>[ 1860.699380] sd 4:0:0:0: [sdd] Mode Sense: 03 00 00 00
<4>[ 1860.699522] sd 4:0:0:0: [sdd] No Caching mode page found
<4>[ 1860.699526] sd 4:0:0:0: [sdd] Assuming drive cache: write through
<6>[ 1860.701393] sdd: sdd1
<5>[ 1860.701886] sd 4:0:0:0: [sdd] Attached SCSI removable disk
<6>[ 1862.077109] usb 3-3: USB disconnect, device number 110
<6>[ 1862.338159] usb 3-3: new high-speed USB device number 111 using xhci_hcd
<6>[ 1862.468090] usb 3-3: New USB device found, idVendor=346d, idProduct=5678, bcdDevice= 2.00
<6>[ 1862.468105] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=(Serial: 8)
<6>[ 1862.468111] usb 3-3: Product: Disk 2.0
<6>[ 1862.468115] usb 3-3: Manufacturer: USB
<6>[ 1862.468119] usb 3-3: SerialNumber: (Serial: 9)
<6>[ 1862.469962] usb-storage 3-3:1.0: USB Mass Storage device detected
<6>[ 1862.470642] scsi host3: usb-storage 3-3:1.0
<3>[ 1862.476447] Buffer I/O error on dev sdd1, logical block 0, lost async page write
<5>[ 1863.514018] scsi 3:0:0:0: Direct-Access VendorCo ProductCode 2.00 PQ: 0 ANSI: 4
<5>[ 1863.515489] sd 3:0:0:0: [sdd] 122880000 512-byte logical blocks: (62.9 GB/58.6 GiB)
<5>[ 1863.515640] sd 3:0:0:0: [sdd] Write Protect is off
<7>[ 1863.515646] sd 3:0:0:0: [sdd] Mode Sense: 03 00 00 00
<4>[ 1863.515797] sd 3:0:0:0: [sdd] No Caching mode page found
<4>[ 1863.515802] sd 3:0:0:0: [sdd] Assuming drive cache: write through
<6>[ 1863.518227] sdd: sdd1
<5>[ 1863.518551] sd 3:0:0:0: [sdd] Attached SCSI removable disk
<6>[ 1865.018356] usb 3-3: USB disconnect, device number 111
<6>[ 1865.285091] usb 3-3: new high-speed USB device number 112 using xhci_hcd
<3>[ 1865.605088] usb 3-3: device descriptor read/64, error -71
<6>[ 1865.844873] usb 3-3: New USB device found, idVendor=346d, idProduct=5678, bcdDevice= 2.00
<6>[ 1865.844892] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=(Serial: 8)
<6>[ 1865.844898] usb 3-3: Product: Disk 2.0
<6>[ 1865.844903] usb 3-3: Manufacturer: USB
<6>[ 1865.844906] usb 3-3: SerialNumber: (Serial: 9)
<6>[ 1865.847205] usb-storage 3-3:1.0: USB Mass Storage device detected
<6>[ 1865.847806] scsi host4: usb-storage 3-3:1.0
<3>[ 1865.853941] Buffer I/O error on dev sdd1, logical block 0, lost async page write
<6>[ 1866.436729] usb 3-3: USB disconnect, device number 112
<6>[ 1866.700998] usb 3-3: new high-speed USB device number 113 using xhci_hcd
<6>[ 1866.829449] usb 3-3: New USB device found, idVendor=346d, idProduct=5678, bcdDevice= 2.00
<6>[ 1866.829466] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=(Serial: 8)
<6>[ 1866.829473] usb 3-3: Product: Disk 2.0
<6>[ 1866.829478] usb 3-3: Manufacturer: USB
<6>[ 1866.829482] usb 3-3: SerialNumber: (Serial: 9)
<6>[ 1866.831605] usb-storage 3-3:1.0: USB Mass Storage device detected
<6>[ 1866.832173] scsi host3: usb-storage 3-3:1.0
<5>[ 1867.866118] scsi 3:0:0:0: Direct-Access VendorCo ProductCode 2.00 PQ: 0 ANSI: 4
<5>[ 1867.868213] sd 3:0:0:0: [sdd] 122880000 512-byte logical blocks: (62.9 GB/58.6 GiB)
<5>[ 1867.868604] sd 3:0:0:0: [sdd] Write Protect is off
<7>[ 1867.868616] sd 3:0:0:0: [sdd] Mode Sense: 03 00 00 00
<4>[ 1867.869071] sd 3:0:0:0: [sdd] No Caching mode page found
<4>[ 1867.869081] sd 3:0:0:0: [sdd] Assuming drive cache: write through
<6>[ 1867.871429] sdd: sdd1
<5>[ 1867.871857] sd 3:0:0:0: [sdd] Attached SCSI removable disk
<6>[ 1868.423593] usb 3-3: USB disconnect, device number 113
<6>[ 1868.431172] sdd: detected capacity change from 122880000 to 0
<28>[ 1928.670962] udevd[203]: sdd: Worker [9839] processing SEQNUM=6508 is taking a long time
<3>[ 2004.633104] INFO: task kworker/0:3:187 blocked for more than 122 seconds.
<3>[ 2004.633125] Tainted: G U 6.6.41-03520-gd3d77f15f842 #1
<3>[ 2004.633131] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>[ 2004.633149] task:kworker/0:3 state:D stack:0 pid:187 ppid:2 flags:0x00004000
<6>[ 2004.633149] Workqueue: usb_hub_wq hub_event
<6>[ 2004.633166] Call Trace:
<6>[ 2004.633172] <TASK>
<6>[ 2004.633179] schedule+0x4f4/0x1540
<6>[ 2004.633190] ? default_wake_function+0x388/0xcd0
<6>[ 2004.633200] schedule_preempt_disabled+0x15/0x30
<6>[ 2004.633206] __mutex_lock_slowpath+0x2b5/0x4d0
<6>[ 2004.633212] del_gendisk+0x136/0x370
<6>[ 2004.633222] sd_remove+0x30/0x60
<6>[ 2004.633230] device_release_driver_internal+0x1a2/0x2a0
<6>[ 2004.633239] bus_remove_device+0x154/0x180
<6>[ 2004.633248] device_del+0x207/0x370
<6>[ 2004.633256] ? __pfx_transport_remove_classdev+0x10/0x10
<6>[ 2004.633264] ? attribute_container_device_trigger+0xe3/0x110
<6>[ 2004.633272] __scsi_remove_device+0xc0/0x170
<6>[ 2004.633279] scsi_forget_host+0x45/0x60
<6>[ 2004.633287] scsi_remove_host+0x87/0x170
<6>[ 2004.633295] usb_stor_disconnect+0x63/0xb0
<6>[ 2004.633302] usb_unbind_interface+0xbe/0x250
<6>[ 2004.633309] device_release_driver_internal+0x1a2/0x2a0
<6>[ 2004.633315] bus_remove_device+0x154/0x180
<6>[ 2004.633322] device_del+0x207/0x370
<6>[ 2004.633328] ? kobject_release+0x56/0xb0
<6>[ 2004.633336] usb_disable_device+0x72/0x170
<6>[ 2004.633342] usb_disconnect+0xeb/0x280
<6>[ 2004.633350] hub_event+0xac7/0x1760
<6>[ 2004.633359] worker_thread+0x355/0x900
<6>[ 2004.633367] kthread+0xed/0x110
<6>[ 2004.633374] ? __pfx_worker_thread+0x10/0x10
<6>[ 2004.633381] ? __pfx_kthread+0x10/0x10
<6>[ 2004.633387] ret_from_fork+0x38/0x50
<6>[ 2004.633393] ? __pfx_kthread+0x10/0x10
<6>[ 2004.633399] ret_from_fork_asm+0x1b/0x30
<6>[ 2004.633407] </TASK>
<3>[ 2004.633496] INFO: task cros-disks:1614 blocked for more than 122 seconds.
<3>[ 2004.633502] Tainted: G U 6.6.41-03520-gd3d77f15f842 #1
<3>[ 2004.633506] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>[ 2004.633519] task:cros-disks state:D stack:0 pid:1614 ppid:1 flags:0x00004002
<6>[ 2004.633519] Call Trace:
<6>[ 2004.633523] <TASK>
<6>[ 2004.633527] schedule+0x4f4/0x1540
<6>[ 2004.633533] ? xas_store+0xc57/0xcc0
<6>[ 2004.633539] ? lru_add_drain+0x4d8/0x6e0
<6>[ 2004.633548] blk_queue_enter+0x172/0x250
<6>[ 2004.633557] ? __pfx_autoremove_wake_function+0x10/0x10
<6>[ 2004.633565] blk_mq_alloc_request+0x167/0x210
<6>[ 2004.633573] scsi_execute_cmd+0x65/0x240
<6>[ 2004.633580] ioctl_internal_command+0x6c/0x150
<6>[ 2004.633590] scsi_set_medium_removal+0x63/0xc0
<6>[ 2004.633598] sd_release+0x42/0x50
<6>[ 2004.633606] blkdev_put+0x13b/0x1f0
<6>[ 2004.633615] blkdev_release+0x2b/0x40
<6>[ 2004.633623] __fput_sync+0x9b/0x2c0
<6>[ 2004.633632] __se_sys_close+0x69/0xc0
<6>[ 2004.633639] do_syscall_64+0x60/0x90
<6>[ 2004.633649] ? exit_to_user_mode_prepare+0x49/0x130
<6>[ 2004.633657] ? do_syscall_64+0x6f/0x90
<6>[ 2004.633665] ? do_syscall_64+0x6f/0x90
<6>[ 2004.633672] ? do_syscall_64+0x6f/0x90
<6>[ 2004.633680] ? irq_exit_rcu+0x38/0x90
<6>[ 2004.633687] ? exit_to_user_mode_prepare+0x49/0x130
<6>[ 2004.633694] entry_SYSCALL_64_after_hwframe+0x73/0xdd
<6>[ 2004.633703] RIP: 0033:0x786d55239960
<6>[ 2004.633711] RSP: 002b:00007ffd1c6d8c28 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
<6>[ 2004.633719] RAX: ffffffffffffffda RBX: 00005a5ffe743fd0 RCX: 0000786d55239960
<6>[ 2004.633725] RDX: 0000786d55307b00 RSI: 0000000000000000 RDI: 000000000000000c
<6>[ 2004.633730] RBP: 00007ffd1c6d8d30 R08: 0000000000000007 R09: 00005a5ffe78a9f0
<6>[ 2004.633735] R10: 8a1ecef621fff8a0 R11: 0000000000000202 R12: 0000000000000831
<6>[ 2004.633741] R13: 00005a5ffe743f60 R14: 00005a5ffe743f80 R15: 000000000000000c
<6>[ 2004.633746] </TASK>
