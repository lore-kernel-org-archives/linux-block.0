Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232332B996;
	Thu, 26 Feb 2026 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150164; cv=none; b=suB0H4v65znnPqyGVBPQKenTOhBus9C0SUe+yeOKusSspeso/kJlxQPXPig35o6PXifGt/IuMjUBfR6qrZgobJTryFwzQpMIcqJPHcV7/qwx/BXKi/DdnKZUcU4rsFlJKeiXxabf1yiGNDy7Kfv1TTAxtbU87zzeBcgd79NTLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150164; c=relaxed/simple;
	bh=SmmrWtMSwUw+hrAhOFKeqnpp76D7j72JxFhTZwm44L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krIKhtyoPWAKE3i7ljw2I5BXnXvhQBACVQSCsCRznf0fID1PMHfiznHgjYaFTx75c06GBAVTjLzcAhIf7dlEqstY6eeE6dPPMM6nMGc81YpJQubnUX4AD8Gh0BEMenqOgjDdfGsdmSalkFvXXDLpwtfi1kQQeJjhI8lcSd3dNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdLduD/H; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdLduD/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772150164; x=1803686164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SmmrWtMSwUw+hrAhOFKeqnpp76D7j72JxFhTZwm44L0=;
  b=FdLduD/HZ/vyjBQ8NpUO0s+q+KbtfMcO4dlmCZMAkw8pIus1MmVi7tuZ
   P4CP9fKwwNFTTAzt5Tww55feGs/lfIr7ye4/UAcv4fX7Vk4Xef/SFemZs
   eHMABlfZKN0OliIVH/XEH0283/Jkn6nPdRXuTXoR4O5yETES5DjcyLCrk
   /xzOqkomiJ7G7XoTmnO5H3TAU3se+iRrvYwSzKedRqRVFf7klGgso06bi
   ek49WWYrxEFLMinJMImCwmqJTzRF4igiOIAj4fcSeMtoWYLnQBCE7k41z
   lFeTAgarvqBzakRV7YPC2JOi951aBRSj6sHGDdznRt8LnxpEw8Tgncc6V
   Q==;
X-CSE-ConnectionGUID: 1WUFlwMcSmaRqZBfL4kuvg==
X-CSE-MsgGUID: nwiH848zQtuMEnwEt2zyrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73198706"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73198706"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 15:56:03 -0800
X-CSE-ConnectionGUID: 2qR8cDV4SxCwUYtkZLTPtA==
X-CSE-MsgGUID: HgtHMzKwTHatOts0Xal6UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216751162"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2026 15:55:59 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvlD2-00000000A1X-2NdK;
	Thu, 26 Feb 2026 23:55:56 +0000
Date: Fri, 27 Feb 2026 07:55:49 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/3] nvme: failover requests for inactive hctx
Message-ID: <202602270720.cugNS3m1-lkp@intel.com>
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
config: x86_64-randconfig-r071-20260227 (https://download.01.org/0day-ci/archive/20260227/202602270720.cugNS3m1-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270720.cugNS3m1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270720.cugNS3m1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/core.c:457:13: error: redefinition of 'nvme_failover_req'
     457 | static void nvme_failover_req(struct request *req)
         |             ^~~~~~~~~~~~~~~~~
   In file included from drivers/nvme/host/core.c:27:
   drivers/nvme/host/nvme.h:1020:20: note: previous definition of 'nvme_failover_req' with type 'void(struct request *)'
    1020 | static inline void nvme_failover_req(struct request *req)
         |                    ^~~~~~~~~~~~~~~~~
   drivers/nvme/host/core.c: In function 'nvme_failover_req':
>> drivers/nvme/host/core.c:472:50: error: 'struct nvme_ctrl' has no member named 'ana_log_buf'
     472 |         if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
         |                                                  ^~
>> drivers/nvme/host/core.c:474:48: error: 'struct nvme_ctrl' has no member named 'ana_work'; did you mean 'ka_work'?
     474 |                 queue_work(nvme_wq, &ns->ctrl->ana_work);
         |                                                ^~~~~~~~
         |                                                ka_work
   In file included from include/linux/sched.h:37,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/async.h:14,
                    from drivers/nvme/host/core.c:7:
>> drivers/nvme/host/core.c:477:36: error: 'struct nvme_ns_head' has no member named 'requeue_lock'
     477 |         spin_lock_irqsave(&ns->head->requeue_lock, flags);
         |                                    ^~
   include/linux/spinlock.h:244:48: note: in definition of macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   drivers/nvme/host/core.c:477:9: note: in expansion of macro 'spin_lock_irqsave'
     477 |         spin_lock_irqsave(&ns->head->requeue_lock, flags);
         |         ^~~~~~~~~~~~~~~~~
>> drivers/nvme/host/core.c:494:33: error: 'struct nvme_ns_head' has no member named 'requeue_list'
     494 |         blk_steal_bios(&ns->head->requeue_list, req);
         |                                 ^~
   drivers/nvme/host/core.c:495:41: error: 'struct nvme_ns_head' has no member named 'requeue_lock'
     495 |         spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
         |                                         ^~
>> drivers/nvme/host/core.c:499:40: error: 'struct nvme_ns_head' has no member named 'requeue_work'
     499 |         kblockd_schedule_work(&ns->head->requeue_work);
         |                                        ^~


vim +/nvme_failover_req +457 drivers/nvme/host/core.c

   456	
 > 457	static void nvme_failover_req(struct request *req)
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
