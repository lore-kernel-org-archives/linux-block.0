Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C807117B50F
	for <linux-block@vger.kernel.org>; Sun,  9 Mar 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741505468; cv=none; b=IK4UE/SXM9jUfCdnaSrIMUcb9B2YSAe7xgfZN508yZhfQOC4aP8wF0M8acPGEoIg9kTqzL95UfDhsFvZQOMrbIEphC5S7+wGVm/VOxtJH2OhL6Ukw9wYNVFKJCzu0VufKXwrBE2awoT+xIyT1rewnifruNn5p3hhwgdnNdpIG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741505468; c=relaxed/simple;
	bh=ZKJSAixtGa8EYM786HG4a7BBHv/1ACcxuJ/EoQKKgBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0+s74kImCYEdAk1Q1Yivmj4HGDoDrREROgV8HZjWVeuB1WQ6t4dutH9w5mWZ7SH1jcx/ksyZa2Euv20+B2dPgtleBeyf1DbMiTMSYhOAcDBfYaDYW5mPCx4eI8YNpNJiwiQ3Ag8ehCjNcfrcA2SfNGX71jg+43Hj7FU0oJSGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAPPoDG6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAPPoDG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741505464; x=1773041464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZKJSAixtGa8EYM786HG4a7BBHv/1ACcxuJ/EoQKKgBI=;
  b=EAPPoDG6ryex3O7npIQwmfr3mgHhv3ktD8ULikq8VFjxJf45ttTsE5mP
   uvWbJ8mB11LcY+dnuqYZu7S6g7Fbytjc7ZyLAzaveudz0mojD5KD+bcxj
   XgVECwuEj5q0TQLbFUtN5Bl5ULY0vMJDv3vN+4eIR4Sm1l22bEcc67nab
   cuXuFdRvigbPVeeIQhPd8uMr2eO85tECSyanAcRmXz2NN1J4h+m2p8Lcx
   f2RkxUNXmqfhBAB082ExRPRbHKhKDBoGK4R3lNqrYg32yl8zrrdyRn/7r
   jyk+3ogSA7CZ2/hZMsGVwH5thAc7Kg3L/qwXB6U77/iTsXQFg8BtR8vC9
   Q==;
X-CSE-ConnectionGUID: CUW/w9KNReCWOhpQcvUchw==
X-CSE-MsgGUID: mKqhsmg8QpWqES4ojFIqyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="46294100"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="46294100"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 23:31:03 -0800
X-CSE-ConnectionGUID: ue1gO0WMR5+lcH41ApZx1A==
X-CSE-MsgGUID: s9AjcIKbQlSBzq2PnIQnJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120419004"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 08 Mar 2025 23:31:02 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trB7g-0002nm-1P;
	Sun, 09 Mar 2025 07:30:57 +0000
Date: Sun, 9 Mar 2025 15:30:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ming Lei <ming.lei@redhat.com>
Subject: Re: [RESEND PATCH 3/5] loop: add helper loop_queue_work_prep
Message-ID: <202503091413.vbFFy32o-lkp@intel.com>
References: <20250308162312.1640828-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308162312.1640828-4-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/loop-remove-rw-parameter-from-lo_rw_aio/20250309-002548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250308162312.1640828-4-ming.lei%40redhat.com
patch subject: [RESEND PATCH 3/5] loop: add helper loop_queue_work_prep
config: arc-randconfig-001-20250309 (https://download.01.org/0day-ci/archive/20250309/202503091413.vbFFy32o-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503091413.vbFFy32o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503091413.vbFFy32o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/block/loop.c: In function 'loop_queue_work_prep':
>> drivers/block/loop.c:862:25: warning: unused variable 'rq' [-Wunused-variable]
     862 |         struct request *rq = blk_mq_rq_from_pdu(cmd);
         |                         ^~


vim +/rq +862 drivers/block/loop.c

   859	
   860	static void loop_queue_work_prep(struct loop_cmd *cmd)
   861	{
 > 862		struct request *rq = blk_mq_rq_from_pdu(cmd);
   863	
   864		/* always use the first bio's css */
   865		cmd->blkcg_css = NULL;
   866		cmd->memcg_css = NULL;
   867	#ifdef CONFIG_BLK_CGROUP
   868		if (rq->bio) {
   869			cmd->blkcg_css = bio_blkcg_css(rq->bio);
   870	#ifdef CONFIG_MEMCG
   871			if (cmd->blkcg_css) {
   872				cmd->memcg_css =
   873					cgroup_get_e_css(cmd->blkcg_css->cgroup,
   874							&memory_cgrp_subsys);
   875			}
   876	#endif
   877		}
   878	#endif
   879	}
   880	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
