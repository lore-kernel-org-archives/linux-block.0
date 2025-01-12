Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525533F7
	for <linux-block@vger.kernel.org>; Sun, 12 Jan 2025 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681600; cv=none; b=KZyokUwUuWfWwZ5eL2bk1AtUJUI9MtEw3Hi0UESW9DI+JMsqs6r1jE/x1OyhAelmV+vG1wBJg90G31vQR3fvVAaR+R/Fe5LjGmizzdQWrXY4FSP+eb2XHMz6IPtcue0oVxMWnTOTcG6ALB2gMEdS2c3VeAIEvgNQWWyJx34k4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681600; c=relaxed/simple;
	bh=8kPS2kDpI6evovNl4IdRHmluMfiJqHZ6mS7ksOteL2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocREDD8HMsiBJCOsefrxofxo0SKy7dNm9Q+fa9s7oRDE3q8PeVuc29u9CXuXBHypnrhocwM+TUNfPno81YL9TnrsyjXjwwL/vtGEt2Hz0qNKxGsBRJTYhVDo3LGzUnvx4Dw7VF1Baq/A6k6tmjIjb6AcaNZcPEhm3RG7wILvD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjrxFnZR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjrxFnZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736681599; x=1768217599;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8kPS2kDpI6evovNl4IdRHmluMfiJqHZ6mS7ksOteL2g=;
  b=VjrxFnZRnGzNOkT95aE8fbwZumCi7mPl5pLtxAAGBVn4eetsvyOJFs7i
   kXNBLtuuCrolCbmOcn9GBmJYco1vfgtibluaeF35fmwVCntPPpj0LCpci
   DvZBFLXw3xt1TzoebyXyyu6PkrsYeRh3WiiqU0WISDVpKFolVnPCjtGn5
   5VQxYqFoLHfwPb+HVJUltC8zMNN/eRjZzGkIkl0UnDmvXv24CQEJBtRZF
   u40g04RiHlYowUGmS2kxFZ0tvhRkxKif4Ut6JiP0wRAlnfl4x0mgHyTLr
   fRRIMk4BWpIh8cRa7oUU01Rc2pQADQwHI6JOdOF4yh4MH5r0pNg051kkE
   A==;
X-CSE-ConnectionGUID: GUglDZIETZCoff+AfuFVIw==
X-CSE-MsgGUID: yeilcvXwSF6es8fB+03qbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="36136018"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="36136018"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 03:33:18 -0800
X-CSE-ConnectionGUID: juWdk/94TV2smfatkyfUvA==
X-CSE-MsgGUID: MoUL9R+tRlmClcopWoYfdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="109206800"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.246.93]) ([10.245.246.93])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 03:33:16 -0800
Message-ID: <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org
Date: Sun, 12 Jan 2025 12:33:13 +0100
In-Reply-To: <Z4HgDJjMRv4s5phx@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
	 <Z4EO6YMM__e6nLNr@fedora>
	 <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
	 <Z4HgDJjMRv4s5phx@fedora>
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

On Sat, 2025-01-11 at 11:05 +0800, Ming Lei wrote:
> On Fri, Jan 10, 2025 at 03:36:44PM +0100, Thomas Hellstr=C3=B6m wrote:
> > On Fri, 2025-01-10 at 20:13 +0800, Ming Lei wrote:
> > > On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellstr=C3=B6m wrote=
:
> > > > Ming, Others
> > > >=20
> > > > On 6.13-rc6 I'm seeing a couple of lockdep splats which appear
> > > > introduced by the commit
> > > >=20
> > > > f1be1788a32e ("block: model freeze & enter queue as lock for
> > > > supporting
> > > > lockdep")
> > >=20
> > > The freeze lock connects all kinds of sub-system locks, that is
> > > why
> > > we see lots of warnings after the commit is merged.
> > >=20
> > > ...
> > >=20
> > > > #1
> > > > [=C2=A0 399.006581]
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > [=C2=A0 399.006756] WARNING: possible circular locking dependency
> > > > detected
> > > > [=C2=A0 399.006767] 6.12.0-rc4+ #1 Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0 U=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N
> > > > [=C2=A0 399.006776] -----------------------------------------------=
-
> > > > ----
> > > > --
> > > > [=C2=A0 399.006801] kswapd0/116 is trying to acquire lock:
> > > > [=C2=A0 399.006810] ffff9a67a1284a28 (&q-
> > > > >q_usage_counter(io)){++++}-
> > > > {0:0},
> > > > at: __submit_bio+0xf0/0x1c0
> > > > [=C2=A0 399.006845]=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 but task is already holding lock:
> > > > [=C2=A0 399.006856] ffffffff8a65bf00 (fs_reclaim){+.+.}-{0:0}, at:
> > > > balance_pgdat+0xe2/0xa20
> > > > [=C2=A0 399.006874]=20
> > >=20
> > > The above one is solved in for-6.14/block of block tree:
> > >=20
> > > 	block: track queue dying state automatically for
> > > modeling
> > > queue freeze lockdep
> >=20
> > Hmm. I applied this series:
> >=20
> > https://patchwork.kernel.org/project/linux-block/list/?series=3D912824&=
archive=3Dboth
> >=20
> > on top of -rc6, but it didn't resolve that splat. Am I using the
> > correct patches?
> >=20
> > Perhaps it might be a good idea to reclaim-prime those lockdep maps
> > taken during reclaim to have the splats happen earlier.
>=20
> for-6.14/block does kill the dependency between fs_reclaim and
> q->q_usage_counter(io) in scsi_add_lun() when scsi disk isn't
> added yet.
>=20
> Maybe it is another warning, care to post the warning log here?

Ah, You're right, it's a different warning this time. Posted the
warning below. (Note: This is also with Christoph's series applied on
top).

May I also humbly suggest the following lockdep priming to be able to
catch the reclaim lockdep splats early without reclaim needing to
happen. That will also pick up splat #2 below.

8<-------------------------------------------------------------

diff --git a/block/blk-core.c b/block/blk-core.c
index 32fb28a6372c..2dd8dc9aed7f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -458,6 +458,11 @@ struct request_queue *blk_alloc_queue(struct
queue_limits *lim, int node_id)
=20
        q->nr_requests =3D BLKDEV_DEFAULT_RQ;
=20
+       fs_reclaim_acquire(GFP_KERNEL);
+       rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+       rwsem_release(&q->io_lockdep_map, _RET_IP_);
+       fs_reclaim_release(GFP_KERNEL);
+
        return q;
=20
 fail_stats:

8<-------------------------------------------------------------

#1:
  106.921533] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  106.921716] WARNING: possible circular locking dependency detected
[  106.921725] 6.13.0-rc6+ #121 Tainted: G     U           =20
[  106.921734] ------------------------------------------------------
[  106.921743] kswapd0/117 is trying to acquire lock:
[  106.921751] ffff8ff4e2da09f0 (&q->q_usage_counter(io)){++++}-{0:0},
at: __submit_bio+0x80/0x220
[  106.921769]=20
               but task is already holding lock:
[  106.921778] ffffffff8e65e1c0 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0xe2/0xa10
[  106.921791]=20
               which lock already depends on the new lock.

[  106.921803]=20
               the existing dependency chain (in reverse order) is:
[  106.921814]=20
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[  106.921824]        fs_reclaim_acquire+0x9d/0xd0
[  106.921833]        __kmalloc_cache_node_noprof+0x5d/0x3f0
[  106.921842]        blk_mq_init_tags+0x3d/0xb0
[  106.921851]        blk_mq_alloc_map_and_rqs+0x4e/0x3d0
[  106.921860]        blk_mq_init_sched+0x100/0x260
[  106.921868]        elevator_switch+0x8d/0x2e0
[  106.921877]        elv_iosched_store+0x174/0x1e0
[  106.921885]        queue_attr_store+0x142/0x180
[  106.921893]        kernfs_fop_write_iter+0x168/0x240
[  106.921902]        vfs_write+0x2b2/0x540
[  106.921910]        ksys_write+0x72/0xf0
[  106.921916]        do_syscall_64+0x95/0x180
[  106.921925]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  106.921935]=20
               -> #0 (&q->q_usage_counter(io)){++++}-{0:0}:
[  106.921946]        __lock_acquire+0x1339/0x2180
[  106.921955]        lock_acquire+0xd0/0x2e0
[  106.921963]        blk_mq_submit_bio+0x88b/0xb60
[  106.921972]        __submit_bio+0x80/0x220
[  106.921980]        submit_bio_noacct_nocheck+0x324/0x420
[  106.921989]        swap_writepage+0x399/0x580
[  106.921997]        pageout+0x129/0x2d0
[  106.922005]        shrink_folio_list+0x5a0/0xd80
[  106.922013]        evict_folios+0x27d/0x7b0
[  106.922020]        try_to_shrink_lruvec+0x21b/0x2b0
[  106.922028]        shrink_one+0x102/0x1f0
[  106.922035]        shrink_node+0xb8e/0x1300
[  106.922043]        balance_pgdat+0x550/0xa10
[  106.922050]        kswapd+0x20a/0x440
[  106.922057]        kthread+0xd2/0x100
[  106.922064]        ret_from_fork+0x31/0x50
[  106.922072]        ret_from_fork_asm+0x1a/0x30
[  106.922080]=20
               other info that might help us debug this:

[  106.922092]  Possible unsafe locking scenario:

[  106.922101]        CPU0                    CPU1
[  106.922108]        ----                    ----
[  106.922115]   lock(fs_reclaim);
[  106.922121]                                lock(&q-
>q_usage_counter(io));
[  106.922132]                                lock(fs_reclaim);
[  106.922141]   rlock(&q->q_usage_counter(io));
[  106.922148]=20
                *** DEADLOCK ***

[  106.922476] 1 lock held by kswapd0/117:
[  106.922802]  #0: ffffffff8e65e1c0 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0xe2/0xa10
[  106.923138]=20
               stack backtrace:
[  106.923806] CPU: 3 UID: 0 PID: 117 Comm: kswapd0 Tainted: G     U =20
6.13.0-rc6+ #121
[  106.924173] Tainted: [U]=3DUSER
[  106.924523] Hardware name: ASUS System Product Name/PRIME B560M-A
AC, BIOS 2001 02/01/2023
[  106.924882] Call Trace:
[  106.925223]  <TASK>
[  106.925559]  dump_stack_lvl+0x6e/0xa0
[  106.925893]  print_circular_bug.cold+0x178/0x1be
[  106.926233]  check_noncircular+0x148/0x160
[  106.926565]  ? unwind_next_frame+0x42a/0x750
[  106.926905]  __lock_acquire+0x1339/0x2180
[  106.927227]  lock_acquire+0xd0/0x2e0
[  106.927546]  ? __submit_bio+0x80/0x220
[  106.927892]  ? blk_mq_submit_bio+0x860/0xb60
[  106.928212]  ? lock_release+0xd2/0x2a0
[  106.928536]  blk_mq_submit_bio+0x88b/0xb60
[  106.928850]  ? __submit_bio+0x80/0x220
[  106.929184]  __submit_bio+0x80/0x220
[  106.929499]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  106.929833]  ? submit_bio_noacct_nocheck+0x324/0x420
[  106.930147]  submit_bio_noacct_nocheck+0x324/0x420
[  106.930464]  swap_writepage+0x399/0x580
[  106.930794]  pageout+0x129/0x2d0
[  106.931114]  shrink_folio_list+0x5a0/0xd80
[  106.931447]  ? evict_folios+0x25d/0x7b0
[  106.931776]  evict_folios+0x27d/0x7b0
[  106.932092]  try_to_shrink_lruvec+0x21b/0x2b0
[  106.932410]  shrink_one+0x102/0x1f0
[  106.932742]  shrink_node+0xb8e/0x1300
[  106.933056]  ? shrink_node+0x9c1/0x1300
[  106.933368]  ? shrink_node+0xb64/0x1300
[  106.933679]  ? balance_pgdat+0x550/0xa10
[  106.933988]  balance_pgdat+0x550/0xa10
[  106.934296]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  106.934607]  ? finish_task_switch.isra.0+0xc4/0x2a0
[  106.934920]  kswapd+0x20a/0x440
[  106.935229]  ? __pfx_autoremove_wake_function+0x10/0x10
[  106.935542]  ? __pfx_kswapd+0x10/0x10
[  106.935881]  kthread+0xd2/0x100
[  106.936191]  ? __pfx_kthread+0x10/0x10
[  106.936501]  ret_from_fork+0x31/0x50
[  106.936810]  ? __pfx_kthread+0x10/0x10
[  106.937120]  ret_from_fork_asm+0x1a/0x30
[  106.937433]  </TASK>

#2:
[    5.595482] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    5.596353] WARNING: possible circular locking dependency detected
[    5.597231] 6.13.0-rc6+ #122 Tainted: G     U           =20
[    5.598182] ------------------------------------------------------
[    5.599149] (udev-worker)/867 is trying to acquire lock:
[    5.600075] ffff9211c02f7948 (&root->kernfs_rwsem){++++}-{4:4}, at:
kernfs_remove+0x31/0x50
[    5.600987]=20
               but task is already holding lock:
[    5.603025] ffff9211e86f41a0 (&q->q_usage_counter(io)#3){++++}-
{0:0}, at: blk_mq_freeze_queue+0x12/0x20
[    5.603033]=20
               which lock already depends on the new lock.

[    5.603034]=20
               the existing dependency chain (in reverse order) is:
[    5.603035]=20
               -> #2 (&q->q_usage_counter(io)#3){++++}-{0:0}:
[    5.603038]        blk_alloc_queue+0x319/0x350
[    5.603041]        blk_mq_alloc_queue+0x63/0xd0
[    5.603043]        scsi_alloc_sdev+0x281/0x3c0
[    5.603045]        scsi_probe_and_add_lun+0x1f5/0x450
[    5.603046]        __scsi_scan_target+0x112/0x230
[    5.603048]        scsi_scan_channel+0x59/0x90
[    5.603049]        scsi_scan_host_selected+0xe5/0x120
[    5.603051]        do_scan_async+0x1b/0x160
[    5.603052]        async_run_entry_fn+0x31/0x130
[    5.603055]        process_one_work+0x21a/0x590
[    5.603058]        worker_thread+0x1c3/0x3b0
[    5.603059]        kthread+0xd2/0x100
[    5.603061]        ret_from_fork+0x31/0x50
[    5.603064]        ret_from_fork_asm+0x1a/0x30
[    5.603066]=20
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[    5.603068]        fs_reclaim_acquire+0x9d/0xd0
[    5.603070]        kmem_cache_alloc_lru_noprof+0x57/0x3f0
[    5.603072]        alloc_inode+0x97/0xc0
[    5.603074]        iget_locked+0x141/0x310
[    5.603076]        kernfs_get_inode+0x1a/0xf0
[    5.603077]        kernfs_get_tree+0x17b/0x2c0
[    5.603080]        sysfs_get_tree+0x1a/0x40
[    5.603081]        vfs_get_tree+0x29/0xe0
[    5.603083]        path_mount+0x49a/0xbd0
[    5.603085]        __x64_sys_mount+0x119/0x150
[    5.603086]        do_syscall_64+0x95/0x180
[    5.603089]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.603092]=20
               -> #0 (&root->kernfs_rwsem){++++}-{4:4}:
[    5.603094]        __lock_acquire+0x1339/0x2180
[    5.603097]        lock_acquire+0xd0/0x2e0
[    5.603099]        down_write+0x2e/0xb0
[    5.603101]        kernfs_remove+0x31/0x50
[    5.603103]        __kobject_del+0x2e/0x90
[    5.603104]        kobject_del+0x13/0x30
[    5.603104]        elevator_switch+0x44/0x2e0
[    5.603106]        elv_iosched_store+0x174/0x1e0
[    5.603107]        queue_attr_store+0x142/0x180
[    5.603108]        kernfs_fop_write_iter+0x168/0x240
[    5.603110]        vfs_write+0x2b2/0x540
[    5.603111]        ksys_write+0x72/0xf0
[    5.603111]        do_syscall_64+0x95/0x180
[    5.603113]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.603114]=20
               other info that might help us debug this:

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
[    5.603121]=20
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
[    5.603139]=20
               stack backtrace:
[    5.603140] CPU: 4 UID: 0 PID: 867 Comm: (udev-worker) Tainted: G =20
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
[    5.603168]  __kobject_del+0x2e/0x90
[    5.603170]  elevator_switch+0x44/0x2e0
[    5.603172]  elv_iosched_store+0x174/0x1e0
[    5.603174]  queue_attr_store+0x142/0x180
[    5.603176]  ? lock_acquire+0xd0/0x2e0
[    5.603177]  ? kernfs_fop_write_iter+0x12a/0x240
[    5.603179]  ? lock_is_held_type+0x9a/0x110
[    5.603182]  kernfs_fop_write_iter+0x168/0x240
[    5.657060]  vfs_write+0x2b2/0x540
[    5.657470]  ksys_write+0x72/0xf0
[    5.657475]  do_syscall_64+0x95/0x180
[    5.657480]  ? lock_acquire+0xd0/0x2e0
[    5.657484]  ? ktime_get_coarse_real_ts64+0x12/0x60
[    5.657486]  ? find_held_lock+0x2b/0x80
[    5.657489]  ? ktime_get_coarse_real_ts64+0x12/0x60
[    5.657490]  ? file_has_perm+0xa9/0xf0
[    5.657494]  ? syscall_exit_to_user_mode_prepare+0x21b/0x250
[    5.657499]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[    5.657501]  ? syscall_exit_to_user_mode+0x97/0x290
[    5.657504]  ? do_syscall_64+0xa1/0x180
[    5.657507]  ? lock_acquire+0xd0/0x2e0
[    5.662389]  ? fd_install+0x3e/0x300
[    5.662395]  ? find_held_lock+0x2b/0x80
[    5.663189]  ? fd_install+0xbb/0x300
[    5.663194]  ? do_sys_openat2+0x9c/0xe0
[    5.664093]  ? kmem_cache_free+0x13e/0x450
[    5.664099]  ? syscall_exit_to_user_mode_prepare+0x21b/0x250
[    5.664952]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[    5.664956]  ? syscall_exit_to_user_mode+0x97/0x290
[    5.664961]  ? do_syscall_64+0xa1/0x180
[    5.664964]  ? syscall_exit_to_user_mode_prepare+0x21b/0x250
[    5.664967]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[    5.664969]  ? syscall_exit_to_user_mode+0x97/0x290
[    5.664972]  ? do_syscall_64+0xa1/0x180
[    5.664974]  ? clear_bhb_loop+0x45/0xa0
[    5.664977]  ? clear_bhb_loop+0x45/0xa0
[    5.664979]  ? clear_bhb_loop+0x45/0xa0
[    5.664982]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.664985] RIP: 0033:0x7fe72d2f4484
[    5.664988] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84
00 00 00 00 00 f3 0f 1e fa 80 3d 45 9c 10 00 00 74 13 b8 01 00
 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec
20 48 89
[    5.664990] RSP: 002b:00007ffe51665998 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[    5.664992] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007fe72d2f4484
[    5.664994] RDX: 0000000000000003 RSI: 00007ffe51665ca0 RDI:
0000000000000038
[    5.664995] RBP: 00007ffe516659c0 R08: 00007fe72d3f51c8 R09:
00007ffe51665a70
[    5.664996] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000000003
[    5.664997] R13: 00007ffe51665ca0 R14: 000055a1bab093b0 R15:
00007fe72d3f4e80
[    5.665001]  </TASK>

Thanks,
Thomas


