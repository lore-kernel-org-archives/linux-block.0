Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6391E0E03;
	Wed, 30 Oct 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278311; cv=none; b=oybaC631OrGgHb3dHoKFe8r8ZRKzWQ6A1fWVosBrFLPwzWu6RBLnl9m91ATvqhhZDAjTfOmSPGMq2/xaN6O/6l82suN4fNG8PBbNlMywkeNi8edp8VvTg8Sq6k9Er6WDHT65iBjTdpVw0qfzwEjgK2yHAo7c3kcEgHNpaT4EYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278311; c=relaxed/simple;
	bh=AhKdvisDpSClwgC8YNU/ASf0PDjLfeptkIVFGD2128E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkGhLQt9ibhH4eKkNJZZolTRhajccgKamxqcAi/Xq9A8zHfc/6WiMMmYVlTRTc+OlLMCPVZfGd7ApHFC2qY7qdQMke7aKQDySSiaR6p6lO47tCB0FeZJnC/O1a4bZq/XNZR5vdKwZddb+soDUMLeVeT0UwunSPweHS8FIGs7ouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUc2suRZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUc2suRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730278309; x=1761814309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhKdvisDpSClwgC8YNU/ASf0PDjLfeptkIVFGD2128E=;
  b=BUc2suRZfEXil2jYkDklGwU9HFRy3s2Ifv1OfY9QG0WmvCyXFIilO2h6
   /kJVR66n6lRT6Jyqv+ofoiDLCqCVq5qVImVB+WMFWwEhXjGSa9mOl/kHd
   4VvzYVkGtjiNywOVwmuHEr8Hq/SGg9St8SwbFFM2/WM4Q1JzN198i5DZf
   xLrYORsEE1ZSRaWz+k0tgkvWYlwCB8WQtW3B/DkVxASloMBqCIHBqBkHE
   wqObwAJLBK6D0fOwcELtkfTAmZO4FNd3rrFfh3ixqDby2uXRLzWb8iezO
   dVoW2fFWh5db19DecoVucnWymMwQdRT78vFzuhG4SCgrdPUfMkqIRjtOS
   g==;
X-CSE-ConnectionGUID: +6H12AFkTpuXrYLuUbA75w==
X-CSE-MsgGUID: uHbFwsmRQ8KmBbNiTVszng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29923405"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29923405"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:51:48 -0700
X-CSE-ConnectionGUID: j2nsqERHQCKjHHVpKJuSxg==
X-CSE-MsgGUID: ga76S+eEQ9+NBKNygLqk1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82346154"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:51:45 -0700
Date: Wed, 30 Oct 2024 16:50:55 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <ZyHzb8ExdDG4b8lo@ly-workstation>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyHchfaUe2cEzFMm@fedora>

On Wed, Oct 30, 2024 at 03:13:09PM +0800, Ming Lei wrote:
> On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
> > Hi Ming,
> > 
> > Greetings!
> > 
> > I used Syzkaller and found that there is possible deadlock in __submit_bio in linux-next next-20241029.
> > 
> > After bisection and the first bad commit is:
> > "
> > f1be1788a32e block: model freeze & enter queue as lock for supporting lockdep
> > "
> > 
> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.c
> > Syzkaller repro syscall steps:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.prog
> > Syzkaller report:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.report
> > Kconfig(make olddefconfig):
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/kconfig_origin
> > Bisect info:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/bisect_info.log
> > bzImage:
> > https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241029_183511___submit_bio/bzImage_6fb2fa9805c501d9ade047fc511961f3273cdcb5
> > Issue dmesg:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/241029_183511___submit_bio/6fb2fa9805c501d9ade047fc511961f3273cdcb5_dmesg.log
> > 
> > "
> > [   22.219103] 6.12.0-rc5-next-20241029-6fb2fa9805c5 #1 Not tainted
> > [   22.219512] ------------------------------------------------------
> > [   22.219827] repro/735 is trying to acquire lock:
> > [   22.220066] ffff888010f1a768 (&q->q_usage_counter(io)#25){++++}-{0:0}, at: __submit_bio+0x39f/0x550
> > [   22.220568] 
> > [   22.220568] but task is already holding lock:
> > [   22.220884] ffffffff872322a0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x76b/0x21e0
> > [   22.221453] 
> > [   22.221453] which lock already depends on the new lock.
> > [   22.221453] 
> > [   22.221862] 
> > [   22.221862] the existing dependency chain (in reverse order) is:
> > [   22.222247] 
> > [   22.222247] -> #1 (fs_reclaim){+.+.}-{0:0}:
> > [   22.222630]        lock_acquire+0x80/0xb0
> > [   22.222920]        fs_reclaim_acquire+0x116/0x160
> > [   22.223244]        __kmalloc_cache_node_noprof+0x59/0x470
> > [   22.223528]        blk_mq_init_tags+0x79/0x1a0
> > [   22.223771]        blk_mq_alloc_map_and_rqs+0x1f4/0xdd0
> > [   22.224127]        blk_mq_init_sched+0x33d/0x6d0
> > [   22.224376]        elevator_init_mq+0x2b2/0x400
> 
> It should be addressed by the following patch:
> 
> https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/
>

I have applied proposed fix patch on top of next-20241029. Issue can
still be reproduced.

It seems the dependency chain is different from Marek's log and mine.


> Thanks,
> Ming
> 
