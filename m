Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F835A3A8;
	Thu, 26 Feb 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132978; cv=none; b=ddrrL0wt6S1NQSnN2ap17WA4OtsraivE1CQHMhP32oMS3+G3TbOCudYXX4q4/jqSOwplSifLkaOZkZ5fuZOtm85ZNp/8UmDJW08vkaO9WDEi5bCyE0qYmNqusZaH3c3WA28Eu4J9iuWACQ5VWdLoQdV3TRv373t3v9Rif8o39EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132978; c=relaxed/simple;
	bh=noNLMleja5KkzJa/XZrdilXoG6G+OvxB4N81KlMZWL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szz3fIzO1DNqT2HxWf6GSThxVeR4DnDk0sv5kFbeGmKy7WQ7F461w8uFy6JOLVgEnwnZxPgJfeQhgk8SfgNfyJIMUovIKjE+E87t8X18tbQ1941B0uKf6XbsLN6++sqImo5HlX2ReYpXzEzWfXMdw+nPdpUA1/3QK5JI5TzSLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZxOKgB3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZxOKgB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772132976; x=1803668976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=noNLMleja5KkzJa/XZrdilXoG6G+OvxB4N81KlMZWL4=;
  b=eZxOKgB38BelSySrbp5kDVisrrg+40vY0LHr8U1V3RO2cPg4qsqM0Ebs
   XLZDoQZ3I/+Ri31nipPs4fEHW7kmujjbfCoCCkeaG6zw3tCZlIkQtcy7f
   q72CdlwEyvvXy82NpL1FXbbGzt37DhEI9rrMrn3SEHVhX+Gmm8QMnVoqY
   ib1ma25bSdCpd49WcVnwu7vCT9/2C77+fzqZxhB2XWNsTtZdgxDATtOd0
   g5QKEbQNRrBGVj6ZoNzYqKxY/1nK2zYI6KGgpuqOdZMtjuUR+Xw5yYtup
   CzcFYbRiXsNNpRjBC47B0l1Oyt1uSI6f3AibgmzmhJkMTdtpiQ+vO+OGK
   g==;
X-CSE-ConnectionGUID: 4YkrYiPWQr6SQkPP6DB/8A==
X-CSE-MsgGUID: USoZRXKVSYKI/ar/ax92XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="75808668"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="75808668"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 11:09:35 -0800
X-CSE-ConnectionGUID: YzBoAAYlT1Cgm8XTmJ6J2A==
X-CSE-MsgGUID: wOLQ6I1WSZeV9LdOLimqfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="214596012"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Feb 2026 11:09:33 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvgjq-000000009n1-1RbV;
	Thu, 26 Feb 2026 19:09:30 +0000
Date: Fri, 27 Feb 2026 03:09:30 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/3] nvme: failover requests for inactive hctx
Message-ID: <202602270348.j0MMNhUj-lkp@intel.com>
References: <20260226-revert-cpu-read-lock-v1-1-eb005072566e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-revert-cpu-read-lock-v1-1-eb005072566e@kernel.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-failover-requests-for-inactive-hctx/20260226-224213
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260226-revert-cpu-read-lock-v1-1-eb005072566e%40kernel.org
patch subject: [PATCH 1/3] nvme: failover requests for inactive hctx
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20260227/202602270348.j0MMNhUj-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270348.j0MMNhUj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270348.j0MMNhUj-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/core.c:457:13: error: redefinition of 'nvme_failover_req'
     457 | static void nvme_failover_req(struct request *req)
         |             ^
   drivers/nvme/host/nvme.h:1020:20: note: previous definition is here
    1020 | static inline void nvme_failover_req(struct request *req)
         |                    ^
>> drivers/nvme/host/core.c:472:45: error: no member named 'ana_log_buf' in 'struct nvme_ctrl'
     472 |         if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
         |                                          ~~~~~~~~  ^
>> drivers/nvme/host/core.c:474:34: error: no member named 'ana_work' in 'struct nvme_ctrl'
     474 |                 queue_work(nvme_wq, &ns->ctrl->ana_work);
         |                                      ~~~~~~~~  ^
>> drivers/nvme/host/core.c:477:31: error: no member named 'requeue_lock' in 'struct nvme_ns_head'
     477 |         spin_lock_irqsave(&ns->head->requeue_lock, flags);
         |                            ~~~~~~~~  ^
   include/linux/spinlock.h:376:39: note: expanded from macro 'spin_lock_irqsave'
     376 |         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
         |                                              ^~~~
   include/linux/spinlock.h:244:34: note: expanded from macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
>> drivers/nvme/host/core.c:494:28: error: no member named 'requeue_list' in 'struct nvme_ns_head'
     494 |         blk_steal_bios(&ns->head->requeue_list, req);
         |                         ~~~~~~~~  ^
   drivers/nvme/host/core.c:495:36: error: no member named 'requeue_lock' in 'struct nvme_ns_head'
     495 |         spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
         |                                 ~~~~~~~~  ^
>> drivers/nvme/host/core.c:499:35: error: no member named 'requeue_work' in 'struct nvme_ns_head'
     499 |         kblockd_schedule_work(&ns->head->requeue_work);
         |                                ~~~~~~~~  ^
   7 errors generated.


vim +472 drivers/nvme/host/core.c

   456	
   457	static void nvme_failover_req(struct request *req)
   458	{
   459		struct nvme_ns *ns = req->q->queuedata;
   460		u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
   461		unsigned long flags;
   462		struct bio *bio;
   463	
   464		if (nvme_ns_head_multipath(ns->head))
   465			nvme_mpath_clear_current_path(ns);
   466	
   467		/*
   468		 * If we got back an ANA error, we know the controller is alive but not
   469		 * ready to serve this namespace.  Kick of a re-read of the ANA
   470		 * information page, and just try any other available path for now.
   471		 */
 > 472		if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
   473			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 > 474			queue_work(nvme_wq, &ns->ctrl->ana_work);
   475		}
   476	
 > 477		spin_lock_irqsave(&ns->head->requeue_lock, flags);
   478		for (bio = req->bio; bio; bio = bio->bi_next) {
   479			if (nvme_ns_head_multipath(ns->head))
   480				bio_set_dev(bio, ns->head->disk->part0);
   481			if (bio->bi_opf & REQ_POLLED) {
   482				bio->bi_opf &= ~REQ_POLLED;
   483				bio->bi_cookie = BLK_QC_T_NONE;
   484			}
   485			/*
   486			 * The alternate request queue that we may end up submitting
   487			 * the bio to may be frozen temporarily, in this case REQ_NOWAIT
   488			 * will fail the I/O immediately with EAGAIN to the issuer.
   489			 * We are not in the issuer context which cannot block. Clear
   490			 * the flag to avoid spurious EAGAIN I/O failures.
   491			 */
   492			bio->bi_opf &= ~REQ_NOWAIT;
   493		}
 > 494		blk_steal_bios(&ns->head->requeue_list, req);
   495		spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
   496	
   497		nvme_req(req)->status = 0;
   498		nvme_end_req(req);
 > 499		kblockd_schedule_work(&ns->head->requeue_work);
   500	}
   501	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
