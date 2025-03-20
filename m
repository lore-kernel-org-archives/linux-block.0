Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA141C3C11
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742433873; cv=none; b=t1Zq+miRKeA/6roOM+h2To+IteayD1vSwllv2aGA+TkG8099swEs+TutLCs5szO3mREf4omxuot6JWj2KqOFD3JI7aEjDYQjtvOJbelHxiWzEIu7gYPt0AjbTbEwNFszw4RBtj2/UCYv0CQkH8sH3J3XFpy8+e/riPnSUGfMpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742433873; c=relaxed/simple;
	bh=mVjHOvtZt3NxlZEmYD6UIjkVerVA4XASUbcf/dG+FVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyEBNyoJHPzVg9W6hVML6IO4l0y+atvYeEibXLK09hagGgl5V8wVtUcrZvCIgphkoUPKw9CF1f9OP23NPJu0VBroghJko+Q0YAQK2BHz3tX5pbhtwo2PpO7oE/QIWaI+LQ4/nWBrYVC6W1pBeKw8Z4aBgAF6nTQtojdLcdH4zNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTYrx6HT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTYrx6HT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742433871; x=1773969871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mVjHOvtZt3NxlZEmYD6UIjkVerVA4XASUbcf/dG+FVs=;
  b=ZTYrx6HTGsGULcSq3MCARlzT8KImZZ/aWXH9DxYydQmL2ZRyKhCnFYKm
   saGYh8RaoTzpZF/mMTKCQFst620ZtQQh1gvtK5n/hQYl0kPNc4sthl0AZ
   h9C3h6sH7+AVg+6bj4ZOd5PqGBNJYJsASNl0tmUycrREHojSshewIgTRQ
   v9qtEyRTmWttbp1Mbfb4UQVesbjtO3swQXC//lmdjFNSSz7sIGyo8d9Lr
   HHRL9whAzxDGZ/PKB5ZLLXEc4qtmV6N75nZPzgdMRyjuh4Tl0BcBwJX8l
   Q21/SwCXMKWVRYRCibpO/QH+8mWXhpS1fBSCc3VA/WKnNcJUy5QBG/Qvr
   A==;
X-CSE-ConnectionGUID: xAaEOLMjQ2SoePk3TLcbpA==
X-CSE-MsgGUID: 5fMi9WC9TzOpkO9r/wGYJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="42819319"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="42819319"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 18:24:30 -0700
X-CSE-ConnectionGUID: DbN0uQkNRpeSpgiOBLvoZg==
X-CSE-MsgGUID: qfJrijahQaOY85HhtQR5NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122600501"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 18:24:27 -0700
Date: Thu, 20 Mar 2025 09:24:51 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	ltp@lists.linux.it, Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>, yi1.lai@intel.com
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9tuY5hCGOOVrSVL@ly-workstation>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9krpfrKjnFs6mfE@bombadil.infradead.org>

On Tue, Mar 18, 2025 at 01:15:33AM -0700, Luis Chamberlain wrote:
> On Tue, Mar 18, 2025 at 01:28:20PM +0800, Oliver Sang wrote:
> > hi, Christian Brauner,
> > 
> > On Tue, Mar 11, 2025 at 01:10:43PM +0100, Christian Brauner wrote:
> > > On Mon, Mar 10, 2025 at 03:43:49PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/util.c" on:
> > > > 
> > > > commit: 3c20917120ce61f2a123ca0810293872f4c6b5a4 ("block/bdev: enable large folio support for large logical block sizes")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > Is this also already fixed by:
> > > 
> > > commit a64e5a596067 ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")
> > > 
> > > ?
> > 
> > sorry for late.
> > 
> > commit a64e5a596067 cannot fix the issue. one dmesg is attached FYI.
> > 
> > we also tried to check linux-next/master tip, but neither below one can boot
> > successfully in our env which we need further check.
> > 
> > da920b7df70177 (tag: next-20250314, linux-next/master) Add linux-next specific files for 20250314
> > 
> > e94bd4ec45ac1 (tag: next-20250317, linux-next/master) Add linux-next specific files for 20250317
> > 
> > so we are not sure the status of latest linux-next/master.
> > 
> > if you want us to check other commit or other patches, please let us know. thanks!
> 
> I cannot reproduce the issue by running the LTP test manually in a loop
> for a long time:
> 
> export LTP_RUNTIME_MUL=2
> 
> while true; do \
> 	./testcases/kernel/syscalls/close_range/close_range01; done
> 
> What's the failure rate of just running the test alone above?
> Does it always fail on this system? Is this a deterministic failure
> or does it have a lower failure rate?
>
Hi Luis,

Greetings!

I used Syzkaller and found that this issue can also be reproduced using Syzkaller reproduction binary.

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250320_033346_folio_mc_copy
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250320_033346_folio_mc_copy/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250320_033346_folio_mc_copy/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250320_033346_folio_mc_copy/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250320_033346_folio_mc_copy/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250320_033346_folio_mc_copy/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250320_033346_folio_mc_copy/bzImage_e94bd4ec45ac156616da285a0bf03056cd7430fc
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250320_033346_folio_mc_copy/e94bd4ec45ac156616da285a0bf03056cd7430fc_dmesg.log


After bisection and the first bad commit is:
"
3c20917120ce block/bdev: enable large folio support for large logical block sizes
"

"
[   23.399326]  dump_stack+0x19/0x20
[   23.399332]  __might_resched+0x37b/0x5a0
[   23.399345]  ? __kasan_check_read+0x15/0x20
[   23.399354]  folio_mc_copy+0x111/0x240
[   23.399368]  __migrate_folio.constprop.0+0x173/0x3c0
[   23.399377]  __buffer_migrate_folio+0x6a2/0x7b0
[   23.399389]  buffer_migrate_folio_norefs+0x3d/0x50
[   23.399398]  move_to_new_folio+0x153/0x5b0
[   23.399403]  ? __pfx_buffer_migrate_folio_norefs+0x10/0x10
[   23.399412]  migrate_pages_batch+0x19e0/0x2890
[   23.399424]  ? __pfx_compaction_free+0x10/0x10
[   23.399444]  ? __pfx_migrate_pages_batch+0x10/0x10
[   23.399450]  ? __kasan_check_read+0x15/0x20
[   23.399455]  ? __lock_acquire+0xdb6/0x5d60
[   23.399475]  ? __pfx___lock_acquire+0x10/0x10
[   23.399486]  migrate_pages+0x18de/0x2450
[   23.399500]  ? __pfx_compaction_free+0x10/0x10
[   23.399505]  ? __pfx_compaction_alloc+0x10/0x10
[   23.399514]  ? __pfx_migrate_pages+0x10/0x10
[   23.399519]  ? __this_cpu_preempt_check+0x21/0x30
[   23.399533]  ? rcu_is_watching+0x19/0xc0
[   23.399546]  ? isolate_migratepages_block+0x2253/0x41c0
[   23.399565]  ? __pfx_isolate_migratepages_block+0x10/0x10
[   23.399578]  compact_zone+0x1d66/0x4480
[   23.399600]  ? perf_trace_lock+0xe0/0x4f0
[   23.399612]  ? __pfx_compact_zone+0x10/0x10
[   23.399617]  ? __pfx_perf_trace_lock+0x10/0x10
[   23.399627]  ? __pfx_lock_acquire+0x10/0x10
[   23.399639]  compact_node+0x190/0x2c0
[   23.399647]  ? __pfx_compact_node+0x10/0x10
[   23.399653]  ? __pfx_lock_release+0x10/0x10
[   23.399678]  ? _raw_spin_unlock_irqrestore+0x45/0x70
[   23.399694]  kcompactd+0x784/0xde0
[   23.399705]  ? __pfx_kcompactd+0x10/0x10
[   23.399711]  ? lockdep_hardirqs_on+0x89/0x110
[   23.399721]  ? __pfx_autoremove_wake_function+0x10/0x10
[   23.399731]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   23.399742]  ? __kthread_parkme+0x15d/0x230
[   23.399753]  ? __pfx_kcompactd+0x10/0x10
[   23.399761]  kthread+0x444/0x980
[   23.399769]  ? __pfx_kthread+0x10/0x10
[   23.399776]  ? _raw_spin_unlock_irq+0x3c/0x60
[   23.399784]  ? __pfx_kthread+0x10/0x10
[   23.399792]  ret_from_fork+0x56/0x90
[   23.399802]  ? __pfx_kthread+0x10/0x10
[   23.399809]  ret_from_fork_asm+0x1a/0x30
[   23.399827]  </TASK>
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

> I also can't see how the patch ("("block/bdev: enable large folio
> support for large logical block sizes") would trigger this.
> 
> You could try this patch but ...
> 
> https://lore.kernel.org/all/20250312050028.1784117-1-mcgrof@kernel.org/
> 
> we decided this is not right and not needed, and if we have a buggy
> block driver we can address that.
> 
> I just can't see how this LTP test actually doing anything funky with block
> devices at all.
> 
> The associated sleeping while atomic warning is triggered during
> compaction though:
> 
> [  218.143642][  T299] Architecture:                         x86_64
> [  218.143659][  T299] 
> [  218.427851][   T51] BUG: sleeping function called from invalid context at mm/util.c:901
> [  218.435981][   T51] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 51, name: kcompactd0
> [  218.444773][   T51] preempt_count: 1, expected: 0
> [  218.449601][   T51] RCU nest depth: 0, expected: 0
> [  218.454476][   T51] CPU: 2 UID: 0 PID: 51 Comm: kcompactd0 Tainted: G S                 6.14.0-rc1-00006-g3c20917120ce #1
> [  218.454486][   T51] Tainted: [S]=CPU_OUT_OF_SPEC
> [  218.454488][   T51] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
> [  218.454492][   T51] Call Trace:
> [  218.454495][   T51]  <TASK>
> [  218.454498][   T51]  dump_stack_lvl+0x4f/0x70
> [  218.454508][   T51]  __might_resched+0x2c6/0x450
> [  218.454517][   T51]  folio_mc_copy+0xca/0x1f0
> [  218.454525][   T51]  ? _raw_spin_lock+0x81/0xe0
> [  218.454532][   T51]  __migrate_folio+0x11a/0x2d0
> [  218.454541][   T51]  __buffer_migrate_folio+0x558/0x660
> [  218.454548][   T51]  move_to_new_folio+0xf5/0x410
> [  218.454555][   T51]  migrate_folio_move+0x211/0x770
> [  218.454562][   T51]  ? __pfx_compaction_free+0x10/0x10
> [  218.454572][   T51]  ? __pfx_migrate_folio_move+0x10/0x10
> [  218.454578][   T51]  ? compaction_alloc_noprof+0x441/0x720
> [  218.454587][   T51]  ? __pfx_compaction_alloc+0x10/0x10
> [  218.454594][   T51]  ? __pfx_compaction_free+0x10/0x10
> [  218.454601][   T51]  ? __pfx_compaction_free+0x10/0x10
> [  218.454607][   T51]  ? migrate_folio_unmap+0x329/0x890
> [  218.454614][   T51]  migrate_pages_batch+0xddf/0x1810
> [  218.454621][   T51]  ? __pfx_compaction_free+0x10/0x10
> [  218.454631][   T51]  ? __pfx_migrate_pages_batch+0x10/0x10
> [  218.454638][   T51]  ? cgroup_rstat_updated+0xf1/0x860
> [  218.454648][   T51]  migrate_pages_sync+0x10c/0x8e0
> [  218.454656][   T51]  ? __pfx_compaction_alloc+0x10/0x10
> [  218.454662][   T51]  ? __pfx_compaction_free+0x10/0x10
> [  218.454669][   T51]  ? lru_gen_del_folio+0x383/0x820
> [  218.454677][   T51]  ? __pfx_migrate_pages_sync+0x10/0x10
> [  218.454683][   T51]  ? set_pfnblock_flags_mask+0x179/0x220
> [  218.454691][   T51]  ? __pfx_lru_gen_del_folio+0x10/0x10
> [  218.454699][   T51]  ? __pfx_compaction_alloc+0x10/0x10
> [  218.454705][   T51]  ? __pfx_compaction_free+0x10/0x10
> [  218.454713][   T51]  migrate_pages+0x846/0xe30
> [  218.454720][   T51]  ? __pfx_compaction_alloc+0x10/0x10
> [  218.454726][   T51]  ? __pfx_compaction_free+0x10/0x10
> [  218.454733][   T51]  ? __pfx_buffer_migrate_folio_norefs+0x10/0x10
> [  218.454740][   T51]  ? __pfx_migrate_pages+0x10/0x10
> [  218.454748][   T51]  ? isolate_migratepages+0x32d/0xbd0
> [  218.454757][   T51]  compact_zone+0x9e1/0x1680
> [  218.454767][   T51]  ? __pfx_compact_zone+0x10/0x10
> [  218.454774][   T51]  ? _raw_spin_lock_irqsave+0x87/0xe0
> [  218.454780][   T51]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  218.454788][   T51]  compact_node+0x159/0x250
> [  218.454795][   T51]  ? __pfx_compact_node+0x10/0x10
> [  218.454807][   T51]  ? __pfx_extfrag_for_order+0x10/0x10
> [  218.454814][   T51]  ? __pfx_mutex_unlock+0x10/0x10
> [  218.454822][   T51]  ? finish_wait+0xd1/0x280
> [  218.454831][   T51]  kcompactd+0x582/0x960
> [  218.454839][   T51]  ? __pfx_kcompactd+0x10/0x10
> [  218.454846][   T51]  ? _raw_spin_lock_irqsave+0x87/0xe0
> [  218.454852][   T51]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  218.454858][   T51]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  218.454867][   T51]  ? __kthread_parkme+0xba/0x1e0
> [  218.454874][   T51]  ? __pfx_kcompactd+0x10/0x10
> [  218.454880][   T51]  kthread+0x3a1/0x770
> [  218.454887][   T51]  ? __pfx_kthread+0x10/0x10
> [  218.454895][   T51]  ? __pfx_kthread+0x10/0x10
> [  218.454902][   T51]  ret_from_fork+0x30/0x70
> [  218.454910][   T51]  ? __pfx_kthread+0x10/0x10
> [  218.454915][   T51]  ret_from_fork_asm+0x1a/0x30
> [  218.454924][   T51]  </TASK>
> 
> So the only thing I can think of the patch which the patch can do is
> push more large folios to be used and so compaction can be a secondary
> effect which managed to trigger another mm issue. I know there was a
> recent migration fix but I can't see the relationship at all either.
> 
>   Luis
