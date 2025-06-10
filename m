Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877B23C501
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571518; cv=none; b=sKM7yQoV44hMTIzs17FvM03up5B8FsHYFg93gxvfu8m2JOjatLifY7iESGbKtKMGODg+/EydEwwytfLzxlZr5/zT7Ui3BS/dHPuQaGiHfauXPh0QLsSzH+uXEXbAya+/Hsj5olbIcSkvBAq2OAbW5mesPuv2wqoCZXLZ+/4c9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571518; c=relaxed/simple;
	bh=CDpJ2AwbhpNfl0X+51kgcTEGnCmEvHY9Y+LUEO43xXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8tsnKGZGEP+hPVnXsV0o+18eFsaY04yE0xjAsvCSX1bFmycvmQg2GG37Rmyt5WLeaFyGGvpI6uPZ6MZZpXX08Wm5zhg4p5xW9tLpDuLUCq5SY7zn9Z99SdflTAA9TuYx1aRphWf6sEo47wUyVdZFtI0+6d/jW62hjTEYOwDAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade33027bcfso540193566b.1
        for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 09:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571513; x=1750176313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvJjs6LBFVMLMH2akdhDOGez5t7X3T0VJCXiFy6y0Us=;
        b=cOIPPH1l4PDdgLPqlXsSNF3wbOs99mOhEZvhnfzX2P3XHvOpssgm1pZgwAGeyos857
         CPL27myFuj/UHMP1q5FtxTjPAW4qrZGIhymJpW9RP3LJE/ux0oMOSUI3774++5xGQIgd
         ldliV3EixfjZ6gFmxIpzmMsENuI4loNM4Xb3Fbcyn/EaZqu/kGmobGQzSAAf3PDtEijc
         +k6Pr/ibsQS41+YJ+z5Oc/aXyBpJR3xRhXYgjoqbHvTNTTmneDeOPLYHQoIACcUOsPf4
         ONfT+vZXEc+Ni3CS8AeHXBpQO9/rzhFplcOh1A8MVaAxkhAIOWdOVcYsk/efNhUXTeoD
         XYUg==
X-Forwarded-Encrypted: i=1; AJvYcCV1pRd3Jur7sz6/FX0PU+F2lyRjK7UOmKQf+cpPLLWOEHAcKm4E14wChwqoM3UliRN+liQTOBiq+C51Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwePmlmDVIhHQo9MaJWNxW/rHeuF6fR2JH/q3o4KWtPnVct7Rgb
	MWLHftWo3L8i6f0zOKkSAiqQDlosaVAxLd12OprotXvTkQdF72iFACAF
X-Gm-Gg: ASbGncuLAmvcrrnWI+LutvDkH7xPaA4CiuC6JIL1s+0+99ZZvLyLbWRxGU/xJKg9oCM
	zWvvtAkCO4ttqlaR3LN2c5om+gqP97KeiNQsTj/SUR0YPXQPfjoeSrxdVDRAWkZOkFeuSYXfhXz
	JLUX+r1loY/TTha2QvBncZico3dHGzBsDVv2QCMW/WNAgDhFRqC3E3K81YjIb788iAqWfdtFqOl
	KNz8AswzWzwQWigc8RdD8zblSZGhvYn7l433fmdSnRgbajimzOld9PtAL9oEMpT/YQ2g+1MTvVW
	Mh0aF5qJhcPp0nHot7RdyGZQAqyFI3dm49N8fWuq6sJ1VfEH+DIQi5UL0rolxQ0=
X-Google-Smtp-Source: AGHT+IHQN6mmxC4dHUbaDYyYUFRlXAlJ0DovWuXCTrFjlt95FRM/5Laisua8CzaG6WLb83WsM4jdYA==
X-Received: by 2002:a17:906:478a:b0:ad8:9084:4ec0 with SMTP id a640c23a62f3a-ade7ace0d05mr307500066b.35.1749571513356;
        Tue, 10 Jun 2025 09:05:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b202sm735813266b.161.2025.06.10.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:05:12 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:05:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	axboe@kernel.dk, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEhXtsiN9MGMBLbC@gmail.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>

On Tue, Jun 10, 2025 at 10:07:47AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/06/09 17:14, Breno Leitao 写道:
> > On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
> > > Hello
> > > 
> > > The following WARNING was triggered by blktests nvme/fc nvme/012,
> > > please help check and let me know if you need any info/test, thanks.
> > > 
> > > commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
> > > 'block-6.16' into for-next
> > 
> > I am seeing a similar issue on Linus' recent tree as e271ed52b344
> > ("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
> > CCing Jens.
> > 
> > This is my stack, in case it is useful.
> > 
> >             WARNING: CPU: 33 PID: 1865 at block/genhd.c:146 bdev_count_inflight_rw+0x334/0x3b0
> >             Modules linked in: sch_fq(E) tls(E) act_gact(E) tcp_diag(E) inet_diag(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) mlx5_ib(E) iTCO_wdt(E) iTCO_vendor_support(E) xhci_pci(E) evdev(E) irqbypass(E) acpi_cpufreq(E) ib_uverbs(E) ipmi_si(E) i2c_i801(E) xhci_hcd(E) i2c_smbus(E) ipmi_devintf(E) wmi(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
> >             CPU: 33 UID: 0 PID: 1865 Comm: kworker/u144:14 Kdump: loaded Tainted: G S          E    N  6.15.0-0_fbk701_debugnightly_rc0_upstream_12426_ge271ed52b344 #1 PREEMPT(undef)
> >             Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
> >             Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
> >             Workqueue: writeback wb_workfn (flush-btrfs-1)
> >             RIP: 0010:bdev_count_inflight_rw+0x334/0x3b0
> >             Code: 75 5c 41 83 3f 00 78 22 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 41 0f b6 06 84 c0 75 54 41 c7 07 00 00 00 00 eb bb <0f> 0b 48 b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 75 4e 41 c7
> >             RSP: 0018:ffff8882ed786f20 EFLAGS: 00010286
> >             RAX: 0000000000000000 RBX: 1ffff1105daf0df3 RCX: ffffffff829739f7
> >             RDX: 0000000000000024 RSI: 0000000000000024 RDI: ffffffff853f79f8
> >             RBP: 0000606f9ff42610 R08: ffffe8ffffd866a7 R09: 1ffffd1ffffb0cd4
> >             R10: dffffc0000000000 R11: fffff91ffffb0cd5 R12: 0000000000000024
> >             R13: 1ffffffff0dd0120 R14: ffffed105daf0df3 R15: ffff8882ed786f9c
> >             FS:  0000000000000000(0000) GS:ffff88905fd44000(0000) knlGS:0000000000000000
> >             CR2: 00007f904bc6d008 CR3: 0000001075c2b001 CR4: 00000000007726f0
> >             PKRU: 55555554
> >             Call Trace:
> >              <TASK>
> >              bdev_count_inflight+0x28/0x50
> >              update_io_ticks+0x10f/0x1b0
> >              blk_account_io_start+0x3a0/0x690
> >              blk_mq_submit_bio+0xc7e/0x1940
> 
> So, this is blk-mq IO accounting, a different problem than nvme mpath.
> 
> What kind of test you're running, can you reporduce ths problem? I don't
> have a clue yet after a quick code review.

I have a bunch of machines running some Meta prod workloads on them,
and this one was running a webserver.

Unfortunately I don't have a reproducer.
