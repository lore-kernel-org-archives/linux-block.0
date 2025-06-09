Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31511459F6
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460471; cv=none; b=Rq/bsAxJlHZU2CGaQlsfRQxYzdiKUrOlBAr1vwXye5NOzMm+oPOgxitDMgOPotYTGHSGE79NZeWZDUrvp5Her4y4R871nCHJhU7Zwig4+Oxg/dTx+k8nAwnYzixHHFnn6NI6XuHwf3XUL59U2jbNk/Ud4brEJ565+lVciDYy8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460471; c=relaxed/simple;
	bh=8t2nBU5sVMCS6np0+zoL4WGWzczdaOtQtQ6Amrkb45Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raSoVaCeodzSyeAE5h3VTEyJCqieDdtHjX56Fy/mQzWO4aD3fgkweceBq4HK2NIJt381GOgwaszayOH7qu/mHkTYrCBO8L2GWFm0063JGGCZHLUtHQyHOkWn9sPKRURWF3oGzkcjB5HRCyezGkSZjPPWW3MGrmxyIjmfIte8hEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso4470221a12.3
        for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 02:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749460465; x=1750065265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2iT7iF2nHxwIVe6zuobE+mx4y8wK3yKHq9Y8EsWumM=;
        b=awIdEvJ+L8GzppHFWBOedBE7qYL/EOI7DF1K5HcVlVMwIBYKHrIRiLTCN1SdcGbItb
         T+r8yDebibgKFEPXAKF8FP5Ym+xum4aXXcTFWLJiu9TqEAjnCIx6GoyAe35mgiJy0ATs
         wYew0DNVqmbspOyFMjbQ/MlJPvtr/ThHX27DcvcHccODg3GMKRx+gEHZD3Wxne/lt3Mb
         KICWyWS5bdo8f9kapE3ucAEahO3NsgdUe4h5pvknWPXmFYRXnLtksXDy9RAPiOKGF99U
         r7ZQGTh8IPFgrTQHyRy59O9xQ8gVNbhIrfWkql518ArP8Qe+kWBR+VbcNsIet9rQv+EL
         EvgA==
X-Gm-Message-State: AOJu0Yz+JnLD2dyD69X6g9UtZR209Zaayn2Hk84SLL/3UogWzEZ4J/ux
	zhlvoKYe63he+vSER5dBYDT30i/D7D8vmA4pSbia0j7lazaB07+QEBAY
X-Gm-Gg: ASbGncudT43W7jiFifmEp+PWOej/r7LC5ygh7Ti6O06pS2Jwtiv154aufAafWzX3qA2
	2aJ6JViQ1GmMsnlSDddg4MW3RCKRhSRbexm9NzK12gvmf/idjjV/A2jod+LeV2LqEC8BqFZCkiI
	DJAQWT86nYqPXXngJsbSfLI0fefsr8L1fPtGx3zW0oWc1MX4J4ts1GVjMVW7w6+hGGresqk3HMX
	QzxiXldDYS0lrVULWUj3+wKsMUXMRduqUTsExUVV3oQBcRYo+5WLlhfdRzULpL2/ia3MA4QMm21
	wRwv3oaSTJQRqjaMmNEdptuW7vIhJNaTg2qVQmx6Bg==
X-Google-Smtp-Source: AGHT+IEIEm4lkJ8D/XEv6ZKn8LexNHcO68JjMgPfSUTspNQS+bWq9F6yp+mQXlfmwvf5P8NqFrR+Zg==
X-Received: by 2002:a05:6402:50d0:b0:605:878:3557 with SMTP id 4fb4d7f45d1cf-60773fc9addmr11099080a12.16.1749460464839;
        Mon, 09 Jun 2025 02:14:24 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6077836ff6csm4482848a12.1.2025.06.09.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:14:24 -0700 (PDT)
Date: Mon, 9 Jun 2025 02:14:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	axboe@kernel.dk
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEal7hIpLpQSMn8+@gmail.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>

On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
> Hello
> 
> The following WARNING was triggered by blktests nvme/fc nvme/012,
> please help check and let me know if you need any info/test, thanks.
> 
> commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
> 'block-6.16' into for-next

I am seeing a similar issue on Linus' recent tree as e271ed52b344
("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
CCing Jens.

This is my stack, in case it is useful.

           WARNING: CPU: 33 PID: 1865 at block/genhd.c:146 bdev_count_inflight_rw+0x334/0x3b0
           Modules linked in: sch_fq(E) tls(E) act_gact(E) tcp_diag(E) inet_diag(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) mlx5_ib(E) iTCO_wdt(E) iTCO_vendor_support(E) xhci_pci(E) evdev(E) irqbypass(E) acpi_cpufreq(E) ib_uverbs(E) ipmi_si(E) i2c_i801(E) xhci_hcd(E) i2c_smbus(E) ipmi_devintf(E) wmi(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
           CPU: 33 UID: 0 PID: 1865 Comm: kworker/u144:14 Kdump: loaded Tainted: G S          E    N  6.15.0-0_fbk701_debugnightly_rc0_upstream_12426_ge271ed52b344 #1 PREEMPT(undef) 
           Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
           Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
           Workqueue: writeback wb_workfn (flush-btrfs-1)
           RIP: 0010:bdev_count_inflight_rw+0x334/0x3b0
           Code: 75 5c 41 83 3f 00 78 22 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 41 0f b6 06 84 c0 75 54 41 c7 07 00 00 00 00 eb bb <0f> 0b 48 b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 75 4e 41 c7
           RSP: 0018:ffff8882ed786f20 EFLAGS: 00010286
           RAX: 0000000000000000 RBX: 1ffff1105daf0df3 RCX: ffffffff829739f7
           RDX: 0000000000000024 RSI: 0000000000000024 RDI: ffffffff853f79f8
           RBP: 0000606f9ff42610 R08: ffffe8ffffd866a7 R09: 1ffffd1ffffb0cd4
           R10: dffffc0000000000 R11: fffff91ffffb0cd5 R12: 0000000000000024
           R13: 1ffffffff0dd0120 R14: ffffed105daf0df3 R15: ffff8882ed786f9c
           FS:  0000000000000000(0000) GS:ffff88905fd44000(0000) knlGS:0000000000000000
           CR2: 00007f904bc6d008 CR3: 0000001075c2b001 CR4: 00000000007726f0
           PKRU: 55555554
           Call Trace:
            <TASK>
            bdev_count_inflight+0x28/0x50
            update_io_ticks+0x10f/0x1b0
            blk_account_io_start+0x3a0/0x690
            blk_mq_submit_bio+0xc7e/0x1940
            __submit_bio+0x125/0x3c0
            ? lock_release+0x4a/0x3c0
            submit_bio_noacct_nocheck+0x3cf/0xa30
            btree_write_cache_pages+0x5eb/0x870
            do_writepages+0x307/0x4d0
            ? rcu_is_watching+0xf/0xa0
            __writeback_single_inode+0x106/0xd10
            writeback_sb_inodes+0x53d/0xd60
            wb_writeback+0x368/0x8d0
            wb_workfn+0x3aa/0xcf0
            ? rcu_is_watching+0xf/0xa0
            ? trace_irq_enable+0x64/0x190
            ? process_scheduled_works+0x959/0x1450
            process_scheduled_works+0x9fe/0x1450
            worker_thread+0x8fd/0xd10
            kthread+0x50c/0x630
            ? rcu_is_watching+0xf/0xa0
            </TASK>
           irq event stamp: 0
           hardirqs last disabled at (0): [<ffffffff81401f85>] copy_process+0x655/0x32d0
           softirqs last  enabled at (0): [<ffffffff81401f85>] copy_process+0x655/0x32d0
