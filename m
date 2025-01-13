Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111D1FDA77
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762293; cv=none; b=UvnAYGfNctmba4oActsvEJNVtHnthVuOhUNO2Rt6HHNA9rEj5VebqPqTjelwhGfpcAYrWtknFVvJupH0zovLLxPTdc+eFH1jUb/uc7GP/4+fyiQ6noFwOMqRaV/H/6RWAa077yiGvYL8F18LC/5iLUS7PV1rVvEgWI5JLAsiI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762293; c=relaxed/simple;
	bh=UokhcMISrT/niETinEWfeCHKX9hcEjvkjNk/uSJI+lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FZiHpo2hpuq1FOG2V5XrIZTFsLJaEGd1qedf4tOie+jvAuXkMPQLSm+C9Jfm8dygJm5vtcFoIZoVg06veuLd8OsYmJGIojX76abIJoKG5/3o/K/ugUdCnnrzHnR9aWIVIVdEDIaacXz1eySd005KrKe79P+E7WYHxXny1uHQaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvtNjJDJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvtNjJDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736762292; x=1768298292;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UokhcMISrT/niETinEWfeCHKX9hcEjvkjNk/uSJI+lw=;
  b=TvtNjJDJPu9JQTcOO20YhQSlQjQRNyrNKv3kuO8T+glVBkp3QTdvvxe1
   Aq4EqefsL096EwhOB0FDxY0czzZ73WJaHPrmo9JGDkzJeIn8PrBi/1SCp
   ZhsRUTVqFhm2XlFdf90kG0yK2Spi5MLmYRGgOscHxUXTB7BQhoA3kN+yu
   l6wzoTdkNmIs/nyaxSdEK3003IO1U2zt5B8XQQOO18ZVioSdO1q+nimrl
   tVmOBqFYrbGK/sJwqYkVG6MYOwfMoP0zeV/Qcn4Q/MhSKaqWwpWRMHhf8
   SoDXAE2x3DSj8FMVlfkuMBzD71bTQqcdj7JMv7FI00yOsWeJ7FZ3GkxM+
   A==;
X-CSE-ConnectionGUID: Idr3UUwDRFuR+ppS3bVCkQ==
X-CSE-MsgGUID: H7g61ds/SmKI9Du7bOqmTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="54429532"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="54429532"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:58:11 -0800
X-CSE-ConnectionGUID: ASTDlJZeTrG0zgTjDJj2QA==
X-CSE-MsgGUID: NHS1RhRoRd2PfNUVeKDVvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141714663"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.246.140]) ([10.245.246.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:58:10 -0800
Message-ID: <197b07435a736825ab40dab8d91db031c7fce37e.camel@linux.intel.com>
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org
Date: Mon, 13 Jan 2025 10:58:07 +0100
In-Reply-To: <Z4TcvNCBXcLJV3vs@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
	 <Z4EO6YMM__e6nLNr@fedora>
	 <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
	 <Z4HgDJjMRv4s5phx@fedora>
	 <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
	 <Z4TcvNCBXcLJV3vs@fedora>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2025-01-13 at 17:28 +0800, Ming Lei wrote:
> On Sun, Jan 12, 2025 at 12:33:13PM +0100, Thomas Hellstr=C3=B6m wrote:
> > On Sat, 2025-01-11 at 11:05 +0800, Ming Lei wrote:
> > > On Fri, Jan 10, 2025 at 03:36:44PM +0100, Thomas Hellstr=C3=B6m wrote=
:
> > > > On Fri, 2025-01-10 at 20:13 +0800, Ming Lei wrote:
> > > > > On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellstr=C3=B6m
> > > > > wrote:
> > > > > > Ming, Others
> > > > > >=20
> >=20
> > #2:
> > [=C2=A0=C2=A0=C2=A0 5.595482]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > [=C2=A0=C2=A0=C2=A0 5.596353] WARNING: possible circular locking depend=
ency
> > detected
> > [=C2=A0=C2=A0=C2=A0 5.597231] 6.13.0-rc6+ #122 Tainted: G=C2=A0=C2=A0=
=C2=A0=C2=A0 U=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> > [=C2=A0=C2=A0=C2=A0 5.598182] -----------------------------------------=
-----------
> > --
> > [=C2=A0=C2=A0=C2=A0 5.599149] (udev-worker)/867 is trying to acquire lo=
ck:
> > [=C2=A0=C2=A0=C2=A0 5.600075] ffff9211c02f7948 (&root->kernfs_rwsem){++=
++}-{4:4},
> > at:
> > kernfs_remove+0x31/0x50
> > [=C2=A0=C2=A0=C2=A0 5.600987]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 but task is already holding lock:
> > [=C2=A0=C2=A0=C2=A0 5.603025] ffff9211e86f41a0 (&q->q_usage_counter(io)=
#3){++++}-
> > {0:0}, at: blk_mq_freeze_queue+0x12/0x20
> > [=C2=A0=C2=A0=C2=A0 5.603033]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 which lock already depends on the new lock.
> >=20
> > [=C2=A0=C2=A0=C2=A0 5.603034]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 the existing dependency chain (in reverse order) is:
> > [=C2=A0=C2=A0=C2=A0 5.603035]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #2 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> > [=C2=A0=C2=A0=C2=A0 5.603038]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 blk_alloc_queue+0x319/0x350
> > [=C2=A0=C2=A0=C2=A0 5.603041]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 blk_mq_alloc_queue+0x63/0xd0
>=20
> The above one is solved in for-6.14/block of block tree:
>=20
> 	block: track queue dying state automatically for modeling
> queue freeze lockdep
>=20
> q->q_usage_counter(io) is killed because disk isn't up yet.
>=20
> If you apply the noio patch against for-6.1/block, the two splats
> should
> have disappeared. If not, please post lockdep log.

That above dependency path is the lockdep priming I suggested, which
establishes the reclaim -> q->q_usage_counter(io) locking order.=C2=A0
A splat without that priming would look slightly different and won't
occur until memory is actually exhausted. But it *will* occur.

That's why I suggested using the priming to catch all fs_reclaim-
>q_usage_counter(io) violations early, perhaps already at system boot,
and anybody accidently adding a GFP_KERNEL memory allocation under the
q_usage_counter(io) lock would get a notification as soon as that
allocation happens.

The actual deadlock sequence is because kernfs_rwsem is taken under
q_usage_counter(io): (excerpt from the report [a]).=C2=A0
If the priming is removed, the splat doesn't happen until reclaim, and
will instead look like [b].

Thanks,
Thomas


[a]
[    5.603115] Chain exists of:
                 &root->kernfs_rwsem --> fs_reclaim --> &q-
>q_usage_counter(io)#3

[    5.603117]  Possible unsafe locking scenario:

[    5.603117]        CPU0                    CPU1
[    5.603117]        ----                    ----
[    5.603118]   lock(&q->q_usage_counter(io)#3);
[    5.603119]                                lock(fs_reclaim);
[    5.603119]                                lock(&q-
>q_usage_counter(io)#3);
[    5.603120]   lock(&root->kernfs_rwsem);
[    5.603121]
                *** DEADLOCK ***

[    5.603121] 6 locks held by (udev-worker)/867:
[    5.603122]  #0: ffff9211c16dd420 (sb_writers#4){.+.+}-{0:0}, at:
ksys_write+0x72/0xf0
[    5.603125]  #1: ffff9211e28f3e88 (&of->mutex#2){+.+.}-{4:4}, at:
kernfs_fop_write_iter+0x121/0x240
[    5.603128]  #2: ffff921203524f28 (kn->active#101){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0x12a/0x240
[    5.603131]  #3: ffff9211e86f46d0 (&q->sysfs_lock){+.+.}-{4:4}, at:
queue_attr_store+0x12b/0x180
[    5.603133]  #4: ffff9211e86f41a0 (&q->q_usage_counter(io)#3){++++}-
{0:0}, at: blk_mq_freeze_queue+0x12/0x20
[    5.603136]  #5: ffff9211e86f41d8 (&q-
>q_usage_counter(queue)#3){++++}-{0:0}, at:
blk_mq_freeze_queue+0x12/0x20
[    5.603139]
               stack backtrace:
[    5.603140] CPU: 4 UID: 0 PID: 867 Comm: (udev-worker) Tainted: G=20
U             6.13.0-rc6+ #122
[    5.603142] Tainted: [U]=3DUSER
[    5.603142] Hardware name: ASUS System Product Name/PRIME B560M-A
AC, BIOS 2001 02/01/2023
[    5.603143] Call Trace:
[    5.603144]  <TASK>
[    5.603146]  dump_stack_lvl+0x6e/0xa0
[    5.603148]  print_circular_bug.cold+0x178/0x1be
[    5.603151]  check_noncircular+0x148/0x160
[    5.603154]  __lock_acquire+0x1339/0x2180
[    5.603156]  lock_acquire+0xd0/0x2e0
[    5.603158]  ? kernfs_remove+0x31/0x50
[    5.603160]  ? sysfs_remove_dir+0x32/0x60
[    5.603162]  ? lock_release+0xd2/0x2a0
[    5.603164]  down_write+0x2e/0xb0
[    5.603165]  ? kernfs_remove+0x31/0x50
[    5.603166]  kernfs_remove+0x31/0x50
[    5.

[b]

[157.543591] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  157.543778] WARNING: possible circular locking dependency detected
[  157.543787] 6.13.0-rc6+ #123 Tainted: G     U           =20
[  157.543796] ------------------------------------------------------
[  157.543805] git/2856 is trying to acquire lock:
[  157.543812] ffff98b6bb882f10 (&q->q_usage_counter(io)#2){++++}-
{0:0}, at: __submit_bio+0x80/0x220
[  157.543830]=20
               but task is already holding lock:
[  157.543839] ffffffffad65e1c0 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x348/0xea0
[  157.543855]=20
               which lock already depends on the new lock.

[  157.543867]=20
               the existing dependency chain (in reverse order) is:
[  157.543878]=20
               -> #2 (fs_reclaim){+.+.}-{0:0}:
[  157.543888]        fs_reclaim_acquire+0x9d/0xd0
[  157.543896]        kmem_cache_alloc_lru_noprof+0x57/0x3f0
[  157.543906]        alloc_inode+0x97/0xc0
[  157.543913]        iget_locked+0x141/0x310
[  157.543921]        kernfs_get_inode+0x1a/0xf0
[  157.543929]        kernfs_get_tree+0x17b/0x2c0
[  157.543938]        sysfs_get_tree+0x1a/0x40
[  157.543945]        vfs_get_tree+0x29/0xe0
[  157.543953]        path_mount+0x49a/0xbd0
[  157.543960]        __x64_sys_mount+0x119/0x150
[  157.543968]        do_syscall_64+0x95/0x180
[  157.543977]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  157.543986]=20
               -> #1 (&root->kernfs_rwsem){++++}-{4:4}:
[  157.543997]        down_write+0x2e/0xb0
[  157.544004]        kernfs_remove+0x31/0x50
[  157.544012]        __kobject_del+0x2e/0x90
[  157.544020]        kobject_del+0x13/0x30
[  157.544026]        elevator_switch+0x44/0x2e0
[  157.544034]        elv_iosched_store+0x174/0x1e0
[  157.544043]        queue_attr_store+0x165/0x1b0
[  157.544050]        kernfs_fop_write_iter+0x168/0x240
[  157.544059]        vfs_write+0x2b2/0x540
[  157.544066]        ksys_write+0x72/0xf0
[  157.544073]        do_syscall_64+0x95/0x180
[  157.544081]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  157.544090]=20
               -> #0 (&q->q_usage_counter(io)#2){++++}-{0:0}:
[  157.544102]        __lock_acquire+0x1339/0x2180
[  157.544110]        lock_acquire+0xd0/0x2e0
[  157.544118]        blk_mq_submit_bio+0x88b/0xb60
[  157.544127]        __submit_bio+0x80/0x220
[  157.544135]        submit_bio_noacct_nocheck+0x324/0x420
[  157.544144]        swap_writepage+0x399/0x580
[  157.544152]        pageout+0x129/0x2d0
[  157.544160]        shrink_folio_list+0x5a0/0xd80
[  157.544168]        evict_folios+0x27d/0x7b0
[  157.544175]        try_to_shrink_lruvec+0x21b/0x2b0
[  157.544183]        shrink_one+0x102/0x1f0
[  157.544191]        shrink_node+0xb8e/0x1300
[  157.544198]        do_try_to_free_pages+0xb3/0x580
[  157.544206]        try_to_free_pages+0xfa/0x2a0
[  157.544214]        __alloc_pages_slowpath.constprop.0+0x36f/0xea0
[  157.544224]        __alloc_pages_noprof+0x34c/0x390
[  157.544233]        alloc_pages_mpol_noprof+0xd7/0x1c0
[  157.544241]        pipe_write+0x3fc/0x7f0
[  157.544574]        vfs_write+0x401/0x540
[  157.544917]        ksys_write+0xd1/0xf0
[  157.545246]        do_syscall_64+0x95/0x180
[  157.545576]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  157.545909]=20
               other info that might help us debug this:

[  157.546879] Chain exists of:
                 &q->q_usage_counter(io)#2 --> &root->kernfs_rwsem -->
fs_reclaim

[  157.547849]  Possible unsafe locking scenario:

[  157.548483]        CPU0                    CPU1
[  157.548795]        ----                    ----
[  157.549098]   lock(fs_reclaim);
[  157.549400]                                lock(&root-
>kernfs_rwsem);
[  157.549705]                                lock(fs_reclaim);
[  157.550011]   rlock(&q->q_usage_counter(io)#2);
[  157.550316]=20
                *** DEADLOCK ***

[  157.551194] 2 locks held by git/2856:
[  157.551490]  #0: ffff98b6a221e068 (&pipe->mutex){+.+.}-{4:4}, at:
pipe_write+0x5a/0x7f0
[  157.551798]  #1: ffffffffad65e1c0 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x348/0xea0
[  157.552115]=20
               stack backtrace:
[  157.552734] CPU: 5 UID: 1000 PID: 2856 Comm: git Tainted: G     U =20
6.13.0-rc6+ #123
[  157.553060] Tainted: [U]=3DUSER
[  157.553383] Hardware name: ASUS System Product Name/PRIME B560M-A
AC, BIOS 2001 02/01/2023
[  157.553718] Call Trace:
[  157.554054]  <TASK>
[  157.554389]  dump_stack_lvl+0x6e/0xa0
[  157.554725]  print_circular_bug.cold+0x178/0x1be
[  157.555064]  check_noncircular+0x148/0x160
[  157.555408]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  157.555747]  ? unwind_get_return_address+0x23/0x40
[  157.556085]  __lock_acquire+0x1339/0x2180
[  157.556425]  lock_acquire+0xd0/0x2e0
[  157.556761]  ? __submit_bio+0x80/0x220
[  157.557110]  ? blk_mq_submit_bio+0x860/0xb60
[  157.557447]  ? lock_release+0xd2/0x2a0
[  157.557784]  blk_mq_submit_bio+0x88b/0xb60
[  157.558137]  ? __submit_bio+0x80/0x220
[  157.558476]  __submit_bio+0x80/0x220
[  157.558828]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  157.559166]  ? submit_bio_noacct_nocheck+0x324/0x420
[  157.559504]  submit_bio_noacct_nocheck+0x324/0x420
[  157.559863]  swap_writepage+0x399/0x580
[  157.560205]  pageout+0x129/0x2d0
[  157.560542]  shrink_folio_list+0x5a0/0xd80
[  157.560879]  ? evict_folios+0x25d/0x7b0
[  157.561212]  evict_folios+0x27d/0x7b0
[  157.561546]  try_to_shrink_lruvec+0x21b/0x2b0
[  157.561890]  shrink_one+0x102/0x1f0
[  157.562222]  shrink_node+0xb8e/0x1300
[  157.562554]  ? shrink_node+0x9c1/0x1300
[  157.562915]  ? shrink_node+0xb64/0x1300
[  157.563245]  ? do_try_to_free_pages+0xb3/0x580
[  157.563576]  do_try_to_free_pages+0xb3/0x580
[  157.563922]  ? lock_release+0xd2/0x2a0
[  157.564252]  try_to_free_pages+0xfa/0x2a0
[  157.564583]  __alloc_pages_slowpath.constprop.0+0x36f/0xea0
[  157.564946]  ? lock_release+0xd2/0x2a0
[  157.565279]  __alloc_pages_noprof+0x34c/0x390
[  157.565613]  alloc_pages_mpol_noprof+0xd7/0x1c0
[  157.565952]  pipe_write+0x3fc/0x7f0
[  157.566283]  vfs_write+0x401/0x540
[  157.566615]  ksys_write+0xd1/0xf0
[  157.566980]  do_syscall_64+0x95/0x180
[  157.567312]  ? vfs_write+0x401/0x540
[  157.567642]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  157.568001]  ? syscall_exit_to_user_mode+0x97/0x290
[  157.568331]  ? do_syscall_64+0xa1/0x180
[  157.568658]  ? do_syscall_64+0xa1/0x180
[  157.569012]  ? syscall_exit_to_user_mode+0x97/0x290
[  157.569337]  ? do_syscall_64+0xa1/0x180
[  157.569658]  ? do_user_addr_fault+0x397/0x720
[  157.569980]  ? trace_hardirqs_off+0x4b/0xc0
[  157.570300]  ? clear_bhb_loop+0x45/0xa0
[  157.570621]  ? clear_bhb_loop+0x45/0xa0
[  157.570968]  ? clear_bhb_loop+0x45/0xa0
[  157.571286]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  157.571605] RIP: 0033:0x7fdf1ec2d484
[  157.571966] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84
00 00 00 00 00 f3 0f 1e fa 80 3d 45 9c 10 00 00 74 13 b8 01 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[  157.572322] RSP: 002b:00007ffd0eb6d068 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[  157.572692] RAX: ffffffffffffffda RBX: 0000000000000331 RCX:
00007fdf1ec2d484
[  157.573093] RDX: 0000000000000331 RSI: 000055693fe2d660 RDI:
0000000000000001
[  157.573470] RBP: 00007ffd0eb6d090 R08: 000055693fdc6010 R09:
0000000000000007
[  157.573875] R10: 0000556941b97c70 R11: 0000000000000202 R12:
0000000000000331
[  157.574249] R13: 000055693fe2d660 R14: 00007fdf1ed305c0 R15:
00007fdf1ed2de80
[  157.574621]  </TASK>

>=20
> Thanks,
> Ming
>=20

