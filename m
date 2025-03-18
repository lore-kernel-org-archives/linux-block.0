Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBD1EEA5D;
	Tue, 18 Mar 2025 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285736; cv=none; b=rU2irjvM5JlTAJztdBjEGCzHgFfi8zOqO/XxwAr4ZZOeZHW4brArw5T3Qti/EaI3GaetyVpFz0MnatcLUnN6FoP4K8XHhvh2NgrNJEBh4PwI2ZRZBPuXrN1VX5pZIZndMykZH6fAbNE4qEdwcysstZfOePnb2H2w2ilprFOQiWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285736; c=relaxed/simple;
	bh=GOH2xhBMFEGxfM//+pfgHfqRcH9vIbAtgCXTwxoE1Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAP9KEKrk8i3QoKnEpXAWWfsSg259Zi30p+RluefcKNgHExIwxsqiTQKsTlWpK3Oal304p/pelqE52uc0VOBkJs3u3xe78RkvW29DU4CUiYae4il7T8dshCDUUNk2S5QpqBlJbXZM4HJc6DOBuHhblO3ff3iibnn4QpagqtKTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7iH4LeN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7iH4LeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437FBC4CEF7;
	Tue, 18 Mar 2025 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285735;
	bh=GOH2xhBMFEGxfM//+pfgHfqRcH9vIbAtgCXTwxoE1Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7iH4LeN+716af4PfUJBivMp2JUJYhen3EN0YQl2FGbyklx2tQQ2YFcrUPPhf5Mtm
	 dSGhh+YQ0IefTEwBuLWM3HwoegS3SJd7n2uJEDYWuF3vyjUCQ20UAluQBiERAx02Gz
	 pYg7xGldrQMQoR7D+Or3umeWBNlKRpgYh8VfQP6lzRZ2mIu5dWklhKW/91d/6QuAMI
	 ImOnVNQpZmEdLLX7eBvBA2ohVkItfGeoapQf2WYO7CcqmQRyTimERLwvYA1giFPQZ6
	 e+HKFbcwu5pxjuylOEmtE646RTeT+wZhKk+i3f9yESb18fCDVGUc0+5Y5nCfLj66yw
	 D2S5huFjlb1bA==
Date: Tue, 18 Mar 2025 01:15:33 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@suse.de>,
	oe-lkp@lists.linux.dev, lkp@intel.com,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	ltp@lists.linux.it, Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>

On Tue, Mar 18, 2025 at 01:28:20PM +0800, Oliver Sang wrote:
> hi, Christian Brauner,
> 
> On Tue, Mar 11, 2025 at 01:10:43PM +0100, Christian Brauner wrote:
> > On Mon, Mar 10, 2025 at 03:43:49PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/util.c" on:
> > > 
> > > commit: 3c20917120ce61f2a123ca0810293872f4c6b5a4 ("block/bdev: enable large folio support for large logical block sizes")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > Is this also already fixed by:
> > 
> > commit a64e5a596067 ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")
> > 
> > ?
> 
> sorry for late.
> 
> commit a64e5a596067 cannot fix the issue. one dmesg is attached FYI.
> 
> we also tried to check linux-next/master tip, but neither below one can boot
> successfully in our env which we need further check.
> 
> da920b7df70177 (tag: next-20250314, linux-next/master) Add linux-next specific files for 20250314
> 
> e94bd4ec45ac1 (tag: next-20250317, linux-next/master) Add linux-next specific files for 20250317
> 
> so we are not sure the status of latest linux-next/master.
> 
> if you want us to check other commit or other patches, please let us know. thanks!

I cannot reproduce the issue by running the LTP test manually in a loop
for a long time:

export LTP_RUNTIME_MUL=2

while true; do \
	./testcases/kernel/syscalls/close_range/close_range01; done

What's the failure rate of just running the test alone above?
Does it always fail on this system? Is this a deterministic failure
or does it have a lower failure rate?

I also can't see how the patch ("("block/bdev: enable large folio
support for large logical block sizes") would trigger this.

You could try this patch but ...

https://lore.kernel.org/all/20250312050028.1784117-1-mcgrof@kernel.org/

we decided this is not right and not needed, and if we have a buggy
block driver we can address that.

I just can't see how this LTP test actually doing anything funky with block
devices at all.

The associated sleeping while atomic warning is triggered during
compaction though:

[  218.143642][  T299] Architecture:                         x86_64
[  218.143659][  T299] 
[  218.427851][   T51] BUG: sleeping function called from invalid context at mm/util.c:901
[  218.435981][   T51] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 51, name: kcompactd0
[  218.444773][   T51] preempt_count: 1, expected: 0
[  218.449601][   T51] RCU nest depth: 0, expected: 0
[  218.454476][   T51] CPU: 2 UID: 0 PID: 51 Comm: kcompactd0 Tainted: G S                 6.14.0-rc1-00006-g3c20917120ce #1
[  218.454486][   T51] Tainted: [S]=CPU_OUT_OF_SPEC
[  218.454488][   T51] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
[  218.454492][   T51] Call Trace:
[  218.454495][   T51]  <TASK>
[  218.454498][   T51]  dump_stack_lvl+0x4f/0x70
[  218.454508][   T51]  __might_resched+0x2c6/0x450
[  218.454517][   T51]  folio_mc_copy+0xca/0x1f0
[  218.454525][   T51]  ? _raw_spin_lock+0x81/0xe0
[  218.454532][   T51]  __migrate_folio+0x11a/0x2d0
[  218.454541][   T51]  __buffer_migrate_folio+0x558/0x660
[  218.454548][   T51]  move_to_new_folio+0xf5/0x410
[  218.454555][   T51]  migrate_folio_move+0x211/0x770
[  218.454562][   T51]  ? __pfx_compaction_free+0x10/0x10
[  218.454572][   T51]  ? __pfx_migrate_folio_move+0x10/0x10
[  218.454578][   T51]  ? compaction_alloc_noprof+0x441/0x720
[  218.454587][   T51]  ? __pfx_compaction_alloc+0x10/0x10
[  218.454594][   T51]  ? __pfx_compaction_free+0x10/0x10
[  218.454601][   T51]  ? __pfx_compaction_free+0x10/0x10
[  218.454607][   T51]  ? migrate_folio_unmap+0x329/0x890
[  218.454614][   T51]  migrate_pages_batch+0xddf/0x1810
[  218.454621][   T51]  ? __pfx_compaction_free+0x10/0x10
[  218.454631][   T51]  ? __pfx_migrate_pages_batch+0x10/0x10
[  218.454638][   T51]  ? cgroup_rstat_updated+0xf1/0x860
[  218.454648][   T51]  migrate_pages_sync+0x10c/0x8e0
[  218.454656][   T51]  ? __pfx_compaction_alloc+0x10/0x10
[  218.454662][   T51]  ? __pfx_compaction_free+0x10/0x10
[  218.454669][   T51]  ? lru_gen_del_folio+0x383/0x820
[  218.454677][   T51]  ? __pfx_migrate_pages_sync+0x10/0x10
[  218.454683][   T51]  ? set_pfnblock_flags_mask+0x179/0x220
[  218.454691][   T51]  ? __pfx_lru_gen_del_folio+0x10/0x10
[  218.454699][   T51]  ? __pfx_compaction_alloc+0x10/0x10
[  218.454705][   T51]  ? __pfx_compaction_free+0x10/0x10
[  218.454713][   T51]  migrate_pages+0x846/0xe30
[  218.454720][   T51]  ? __pfx_compaction_alloc+0x10/0x10
[  218.454726][   T51]  ? __pfx_compaction_free+0x10/0x10
[  218.454733][   T51]  ? __pfx_buffer_migrate_folio_norefs+0x10/0x10
[  218.454740][   T51]  ? __pfx_migrate_pages+0x10/0x10
[  218.454748][   T51]  ? isolate_migratepages+0x32d/0xbd0
[  218.454757][   T51]  compact_zone+0x9e1/0x1680
[  218.454767][   T51]  ? __pfx_compact_zone+0x10/0x10
[  218.454774][   T51]  ? _raw_spin_lock_irqsave+0x87/0xe0
[  218.454780][   T51]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  218.454788][   T51]  compact_node+0x159/0x250
[  218.454795][   T51]  ? __pfx_compact_node+0x10/0x10
[  218.454807][   T51]  ? __pfx_extfrag_for_order+0x10/0x10
[  218.454814][   T51]  ? __pfx_mutex_unlock+0x10/0x10
[  218.454822][   T51]  ? finish_wait+0xd1/0x280
[  218.454831][   T51]  kcompactd+0x582/0x960
[  218.454839][   T51]  ? __pfx_kcompactd+0x10/0x10
[  218.454846][   T51]  ? _raw_spin_lock_irqsave+0x87/0xe0
[  218.454852][   T51]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  218.454858][   T51]  ? __pfx_autoremove_wake_function+0x10/0x10
[  218.454867][   T51]  ? __kthread_parkme+0xba/0x1e0
[  218.454874][   T51]  ? __pfx_kcompactd+0x10/0x10
[  218.454880][   T51]  kthread+0x3a1/0x770
[  218.454887][   T51]  ? __pfx_kthread+0x10/0x10
[  218.454895][   T51]  ? __pfx_kthread+0x10/0x10
[  218.454902][   T51]  ret_from_fork+0x30/0x70
[  218.454910][   T51]  ? __pfx_kthread+0x10/0x10
[  218.454915][   T51]  ret_from_fork_asm+0x1a/0x30
[  218.454924][   T51]  </TASK>

So the only thing I can think of the patch which the patch can do is
push more large folios to be used and so compaction can be a secondary
effect which managed to trigger another mm issue. I know there was a
recent migration fix but I can't see the relationship at all either.

  Luis
