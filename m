Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C954723
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385041; cv=none; b=W/YbKU6aJDWFvn+4cnBj9W8Wg9LXSWPQaGTnhnWAkRWtaC2TlisoKTiDkqsZ5DB+CD8O0pGsFVJIlJn8oVE6x/FxI3tdUvYJ5NJzFIq5wR0d4GLkmsitqhU4DrEE2uFzVb0TRRWKtTg0FsdIOylqn7xfcNba4rhCVc4ey/B9wTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385041; c=relaxed/simple;
	bh=xnOLbYMGoywA58IwPQcrin2gfn9hbtMOOqyLDQfKno4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QXfYasNGTHYKAtWeHon7zZqvQ0lemWtizLidXx6FOKrWkSV+yYrFZiZxS4vgHeIHBWzDDh0kjWCnu+xxXk7QqJv+wHNFA8W7dE8TjnafPXv8+j7OP8QDTqDgE1Zk5WOzE3vGONyeSQGCzUPpijNI2HQLpZ0TEps+dOnlP/CD2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qIzlBMzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qIzlBMzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE8FC4CEF1;
	Tue,  9 Sep 2025 02:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757385041;
	bh=xnOLbYMGoywA58IwPQcrin2gfn9hbtMOOqyLDQfKno4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qIzlBMzQoreDfbkp+ywx7O5GwWyrc3X34JEXFnprc9N2wl/glmiwdDJlD87YXCgII
	 wXHRJ3VrRL7DlrE08tdkW2ygDGbyh4ZgJ9yHnzZWR7G/E5JcIRJZg+gM4KG4qQ0apj
	 64dslt4SZOjOXzlKQ5qqC3IPrfDXjFgmIXvmBbV4=
Date: Mon, 8 Sep 2025 19:30:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>, linux-mm@kvack.org,
 Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>
Subject: Re: [bug report] BUG zs_handle-zram0 (Tainted: G S ): Objects
 remaining on __kmem_cache_shutdown()
Message-Id: <20250908193040.935144f444ab0e14c2cdde60@linux-foundation.org>
In-Reply-To: <CAGVVp+WN0YvN182wCxTWVY19YQGmUJbDS8t3gOZ-=R8+rEfrhw@mail.gmail.com>
References: <CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=ksN6EcvyypAtFDOUf30A@mail.gmail.com>
	<CAGVVp+U7Sx+pf5ChXHhyWzT_WuyuOKsEtebo8_GjDkut5a0gXg@mail.gmail.com>
	<CAGVVp+WN0YvN182wCxTWVY19YQGmUJbDS8t3gOZ-=R8+rEfrhw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 10:17:17 +0800 Changhui Zhong <czhong@redhat.com> wrote:

> I still see this issue on v6.17.0-rc5, please take a look if you have a chance

Well it might be related to zram, although we haven't done much at all
with zram or zsmalloc in this cycle.

> [ 6915.287305] BUG zs_handle-zram0 (Tainted: G S                 ):
> Objects remaining on __kmem_cache_shutdown()
> [ 6915.298379] -----------------------------------------------------------------------------
> [ 6915.298379]
> [ 6915.309166] Object 0x0000000023ce3ee6 @offset=960
> [ 6915.314421] Slab 0x00000000913eaa62 objects=128 used=1
> fp=0x0000000064bf6df4
> flags=0x17ffffc0000200(workingset|node=0|zone=2|lastcpupid=0x1fffff)
> [ 6915.329002] ------------[ cut here ]------------
> [ 6915.334159] WARNING: CPU: 2 PID: 7198 at mm/slub.c:1176
> __slab_err.part.0+0x19/0x20
> [ 6915.342713] Modules linked in: zram 842_decompress lz4hc_compress
> 842_compress lz4_compress zstd_compress tls rpcsec_gss_krb5
> auth_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_localio netfs
> intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common i10nm_edac skx_edac_common nfit
> libnvdimm x86_pkg_temp_thermal intel_powerclamp rfkill coretemp
> kvm_intel kvm dax_hmem cxl_acpi cxl_port irqbypass cxl_core iTCO_wdt
> cdc_ether rapl iTCO_vendor_support usbnet intel_cstate mii
> intel_uncore mgag200 intel_th_gth isst_if_mbox_pci einj i2c_i801
> i2c_algo_bit isst_if_mmio pcspkr mei_me isst_if_common intel_th_pci
> ioatdma i2c_smbus mei intel_vsec acpi_power_meter ipmi_ssif
> intel_pch_thermal intel_th dca ipmi_si acpi_ipmi ipmi_devintf
> ipmi_msghandler acpi_pad sg fuse loop xfs sd_mod ghash_clmulni_intel
> ahci libahci tg3 libata wmi sunrpc dm_mirror dm_region_hash dm_log
> dm_multipath dm_mod nfnetlink [last unloaded: brd]
> [ 6915.434755] CPU: 2 UID: 0 PID: 7198 Comm: bash Kdump: loaded
> Tainted: G S  B               6.17.0-rc5 #1 PREEMPT(voluntary)
> [ 6915.447281] Tainted: [S]=CPU_OUT_OF_SPEC, [B]=BAD_PAGE
> [ 6915.453016] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> BIOS AFE118M-1.32 06/29/2022
> [ 6915.462728] RIP: 0010:__slab_err.part.0+0x19/0x20
> [ 6915.467981] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 0f 1f 44 00 00 e8 f6 fc ff ff be 01 00 00 00 bf 05 00 00 00 e8 77
> bf 29 00 <0f> 0b c3 cc cc cc cc 48 89 ee 48 c7 c7 eb a2 86 ab c6 05 10
> 13 c4
> [ 6915.488939] RSP: 0018:ffa0000002fcf918 EFLAGS: 00010046
> [ 6915.494773] RAX: 0000000000000000 RBX: ffd400000b6c3b80 RCX: ffffffffa80d3a9a
> [ 6915.502740] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffffadd3f180
> [ 6915.510706] RBP: ff11000149c51140 R08: 0000000000000001 R09: fffffbfff5ba7e30
> [ 6915.518672] R10: ffffffffadd3f187 R11: 0000000062616c53 R12: ff11000285ff0000
> [ 6915.526640] R13: ff11000285ff1000 R14: ff11000149c4f040 R15: ffd400000a17fc00
> [ 6915.534605] FS:  00007f9aa117a740(0000) GS:ff1100043db3d000(0000)
> knlGS:0000000000000000
> [ 6915.543637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6915.550051] CR2: 000056332051e698 CR3: 00000001485c1002 CR4: 0000000000773ef0
> [ 6915.558017] PKRU: 55555554
> [ 6915.561037] Call Trace:
> [ 6915.563766]  <TASK>
> [ 6915.566108]  __kmem_cache_shutdown.cold+0x1c/0x43
> [ 6915.571364]  kmem_cache_destroy+0x68/0x170
> [ 6915.575938]  zs_destroy_pool+0x18b/0x250
> [ 6915.580319]  zram_reset_device+0x233/0x600 [zram]
> [ 6915.585576]  reset_store+0x20b/0x300 [zram]
> [ 6915.590252]  ? __pfx_reset_store+0x10/0x10 [zram]
> [ 6915.595506]  ? sysfs_file_kobj+0xb3/0x1c0
> [ 6915.599982]  ? sysfs_file_kobj+0xbd/0x1c0
> [ 6915.604449]  ? __pfx_sysfs_kf_write+0x10/0x10
> [ 6915.609315]  kernfs_fop_write_iter+0x3a3/0x5a0
> [ 6915.614278]  vfs_write+0x522/0xfd0
> [ 6915.618078]  ? __pfx_vfs_write+0x10/0x10
> [ 6915.622459]  ? local_clock_noinstr+0xd/0xe0
> [ 6915.627130]  ? __lock_release.isra.0+0x1a4/0x2c0
> [ 6915.632287]  ksys_write+0xf9/0x1d0
> [ 6915.636086]  ? __pfx_ksys_write+0x10/0x10
> [ 6915.640561]  ? lockdep_hardirqs_on+0x78/0x100
> [ 6915.645426]  do_syscall_64+0x94/0x8d0
> [ 6915.649515]  ? ktime_get_coarse_real_ts64+0x121/0x180
> [ 6915.655155]  ? lockdep_hardirqs_on+0x78/0x100
> [ 6915.660022]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 6915.665855]  ? lockdep_hardirqs_on+0x78/0x100
> [ 6915.670719]  ? do_syscall_64+0x139/0x8d0
> [ 6915.675089]  ? __x64_sys_openat+0x108/0x1d0
> [ 6915.679762]  ? __pfx___x64_sys_openat+0x10/0x10
> [ 6915.684819]  ? lockdep_hardirqs_on+0x78/0x100
> [ 6915.689684]  ? syscall_trace_enter+0x13e/0x240
> [ 6915.694648]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 6915.700481]  ? lockdep_hardirqs_on+0x78/0x100
> [ 6915.705347]  ? do_syscall_64+0x139/0x8d0
> [ 6915.709726]  ? rcu_is_watching+0x15/0xb0
> [ 6915.714106]  ? clear_bhb_loop+0x50/0xa0
>
> ...
>
> > > reproducer:
> > > # modprobe zram
> > > # zramctl --find --size 4G --algorithm zstd
> > > # fio --name=test \
> > >         --filename=/dev/zram0 \
> > >         --rw=randrw \
> > >         --bs=4k \
> > >         --ioengine=libaio \
> > >         --iodepth=16 \
> > >         --numjobs=4 \
> > >         --runtime=60 \
> > >         --time_based \
> > >         --group_reporting \
> > >         --direct=1
> > > # echo 1 > /sys/block/zram0/reset
> > >
> > > dmesg log:
> > > [ 4861.143371] zsmalloc: Class-80 fullness group 1 is not empty
> > > [ 4861.149696] zsmalloc: Class-112 fullness group 1 is not empty
> > > [ 4861.156121] zsmalloc: Class-144 fullness group 1 is not empty
> > > [ 4861.162541] zsmalloc: Class-160 fullness group 1 is not empty
> > > [ 4861.168963] zsmalloc: Class-176 fullness group 1 is not empty
> > > [ 4861.175379] zsmalloc: Class-192 fullness group 1 is not empty
> > > [ 4861.181797] zsmalloc: Class-224 fullness group 1 is not empty

Minchan & Sergey, could you please give this a try?
