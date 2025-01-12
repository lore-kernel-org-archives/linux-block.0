Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB932F22
	for <linux-block@vger.kernel.org>; Sun, 12 Jan 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736703899; cv=none; b=HN3bhFwQkQqnWStqUT4LWjcBCM7o9o4DPPZdQMoznZK/UuDF7wQlcgmBC+FDMQVl0IgSlvLUm1wNQyW4HVhCDIq9RW8wwPuJ0oiJ69z14D475sOV7iCPinUb0QZ98+QED/0LMnd4RXxO3OUvNWww9s9K795zlPhp3B1uk1HLycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736703899; c=relaxed/simple;
	bh=WS648PR5QryKHurECOi7acd7pi0WR391enBxwjnl7Rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNUfr6C6tSy9mLHerLyKm8B7EXHl6G0fKtzA4L3l9Uvpq/0s2oBBxeKY3D+i4iVsWwteXUTVqZKxwqRwza3mDrq0MVGe3m9r0ExUdi7JEbLdhue/VdzGwSN4BfvNcqsp5VoVXulkCC/e+425BCpQnb7zvu+1UtbRRRyO3KEzm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVKE7Mfe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVKE7Mfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736703899; x=1768239899;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WS648PR5QryKHurECOi7acd7pi0WR391enBxwjnl7Rs=;
  b=IVKE7MfeaRt45EUpBA9R1q6QWP1+ZrwrDw9u/0b53uyVXteGTcNexvKD
   lx19SJSPVBV3se7wgFqUPMGbpLspOEZttY/9xE18BoTf3C/PCxSWneL33
   AaCzPixI+A1VR9P5rIWhV76vcCPm35sS/HCzbNdW3rbyfWYA93wevM6NZ
   MMSgobWE1g1eww+zkpxrTHuVSPgp/PNe2UDiliujxW/egvOcek6e86jru
   38f3QM1e75SCSopXZfjxQ3zANV6Cbhy2qpRe2MMX7cyrS4JazmEgDCZd3
   fbATbecr48szfV9YXOt3yfSmnOY5WPigyQsUA4r3m8ye3AKAMicw2/kF5
   g==;
X-CSE-ConnectionGUID: H72uA7qmTdeRHoSgrLSMCQ==
X-CSE-MsgGUID: M1RWW8hDSlGNPPxrcIjq+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40610383"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="40610383"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 09:44:58 -0800
X-CSE-ConnectionGUID: rx6/7HKkTbSOXqXiQHW83g==
X-CSE-MsgGUID: 8AJlfnG1T/SaAN8UFitD2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="109262405"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.246.93]) ([10.245.246.93])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 09:44:56 -0800
Message-ID: <1310ca51dce185c977055fae131f6ff6fd2e2089.camel@linux.intel.com>
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org
Date: Sun, 12 Jan 2025 18:44:53 +0100
In-Reply-To: <Z4PkzbFVrSJWOrE4@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
	 <Z4EO6YMM__e6nLNr@fedora>
	 <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
	 <Z4HgDJjMRv4s5phx@fedora>
	 <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
	 <Z4PkzbFVrSJWOrE4@fedora>
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

On Sun, 2025-01-12 at 23:50 +0800, Ming Lei wrote:
> On Sun, Jan 12, 2025 at 12:33:13PM +0100, Thomas Hellstr=C3=B6m wrote:
> > On Sat, 2025-01-11 at 11:05 +0800, Ming Lei wrote:
>=20
> ...
>=20
> >=20
> > Ah, You're right, it's a different warning this time. Posted the
> > warning below. (Note: This is also with Christoph's series applied
> > on
> > top).
> >=20
> > May I also humbly suggest the following lockdep priming to be able
> > to
> > catch the reclaim lockdep splats early without reclaim needing to
> > happen. That will also pick up splat #2 below.
> >=20
> > 8<-------------------------------------------------------------
> >=20
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 32fb28a6372c..2dd8dc9aed7f 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -458,6 +458,11 @@ struct request_queue *blk_alloc_queue(struct
> > queue_limits *lim, int node_id)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->nr_requests =3D BLKDEV_DE=
FAULT_RQ;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_reclaim_acquire(GFP_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rwsem_acquire_read(&q->io_lockdep=
_map, 0, 0, _RET_IP_);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rwsem_release(&q->io_lockdep_map,=
 _RET_IP_);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_reclaim_release(GFP_KERNEL);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return q;
>=20
> Looks one nice idea for injecting fs_reclaim, maybe it can be
> added to inject framework?

For the intel gpu drivers, we typically always prime lockdep like this
if we *know* that the lock will be grabbed during reclaim, like if it's
part of shrinker processing or similar.=C2=A0

So sooner or later we *know* this sequence will happen so we add it
near the lock initialization to always be executed when the lock(map)
is initialized.

So I don't really see a need for them to be periodially injected?

>=20
> > =C2=A0
> > =C2=A0fail_stats:
> >=20
> > 8<-------------------------------------------------------------
> >=20
> > #1:
> > =C2=A0 106.921533]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > [=C2=A0 106.921716] WARNING: possible circular locking dependency
> > detected
> > [=C2=A0 106.921725] 6.13.0-rc6+ #121 Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=
 U=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > [=C2=A0 106.921734] ---------------------------------------------------=
-
> > --
> > [=C2=A0 106.921743] kswapd0/117 is trying to acquire lock:
> > [=C2=A0 106.921751] ffff8ff4e2da09f0 (&q->q_usage_counter(io)){++++}-
> > {0:0},
> > at: __submit_bio+0x80/0x220
> > [=C2=A0 106.921769]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 but task is already holding lock:
> > [=C2=A0 106.921778] ffffffff8e65e1c0 (fs_reclaim){+.+.}-{0:0}, at:
> > balance_pgdat+0xe2/0xa10
> > [=C2=A0 106.921791]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 which lock already depends on the new lock.
> >=20
> > [=C2=A0 106.921803]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 the existing dependency chain (in reverse order) is:
> > [=C2=A0 106.921814]=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -> #1 (fs_reclaim){+.+.}-{0:0}:
> > [=C2=A0 106.921824]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_reclai=
m_acquire+0x9d/0xd0
> > [=C2=A0 106.921833]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __kmalloc=
_cache_node_noprof+0x5d/0x3f0
> > [=C2=A0 106.921842]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_in=
it_tags+0x3d/0xb0
> > [=C2=A0 106.921851]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_al=
loc_map_and_rqs+0x4e/0x3d0
> > [=C2=A0 106.921860]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_in=
it_sched+0x100/0x260
> > [=C2=A0 106.921868]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elevator_=
switch+0x8d/0x2e0
> > [=C2=A0 106.921877]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elv_iosch=
ed_store+0x174/0x1e0
> > [=C2=A0 106.921885]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_att=
r_store+0x142/0x180
> > [=C2=A0 106.921893]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernfs_fo=
p_write_iter+0x168/0x240
> > [=C2=A0 106.921902]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfs_write=
+0x2b2/0x540
> > [=C2=A0 106.921910]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksys_writ=
e+0x72/0xf0
> > [=C2=A0 106.921916]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_syscal=
l_64+0x95/0x180
> > [=C2=A0 106.921925]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_SYS=
CALL_64_after_hwframe+0x76/0x7e
>=20
> That is another regression from commit
>=20
> 	af2814149883 block: freeze the queue in queue_attr_store
>=20
> and queue_wb_lat_store() has same risk too.
>=20
> I will cook a patch to fix it.

Thanks. Are these splats going to be silenced for 6.13-rc? Like having
the new lockdep checks under a special config until they are fixed?

Thanks,
Thomas

>=20
> Thanks,
> Ming
>=20

