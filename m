Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544422E6CDA
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797358; cv=none; b=j44FSaStjUjvH4LKTRDe/G9H5129ArWr9LYuWhCa5dd8ddib/hqXY21iYymh7hsx5XTSVXObFuOmc4D7MYpa//giEVVhWBm2aq5oIpd6nG2m3gac/6pTleNjEt7zRwhz8lq13w2jjdgwjQE/eqqnmcTK6EwXy8WEsjGvRqZW1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797358; c=relaxed/simple;
	bh=oaOra25jcFBZrMoUSHfE9wW3/OEH/6izRqDrp3mpIyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAtJ8cZ2n//zUVOAUzntEw1uT678qt78Xbg9idoYntSNNztyDEMaM7dC1Q8MuI0U2tqym44ur1zOsnUyvyYLmYULmCY2JxehOfVAYdEVueQ51DGSXx4sIXHeJXvHvSDDIHIPkfnfURtkxr5rjkSlxXjM6xeC+ozft4YM2+bC9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAAzQNj5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAAzQNj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761797358; x=1793333358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oaOra25jcFBZrMoUSHfE9wW3/OEH/6izRqDrp3mpIyc=;
  b=iAAzQNj56VxoFf/It4lPZ+ECx5O3VauDaTX2J5WExB8ajXoBWPJ/Gk1B
   rIebAlSv/LVTOQHFEA8OpmL+WHAMWBZXQYuwpweLRoD1/rwfTihQEuMt4
   Iwqwnmyq++wempSg61KsMMLz0Vwpwt+GZcTNCpqMQa9mM1hICj0xDsDDf
   ED7+YM2OUp0Iy0L5pHhoUnjjXUIw+loNv2hypYo7AvOpnjrJD/rVanPwd
   ZRS3hzlO89hjCZjL80n9OnqZBw63F5ZzT+zvZrSdKHUq1C5lQ9f6aBYiF
   uO70MGlLJDMOJI62XuG4l28DQAhgJc6fk+KwmjxkIKOu6NWaiLZeKSqA6
   g==;
X-CSE-ConnectionGUID: /nLQ5pTOR0KSnxLwfSA85A==
X-CSE-MsgGUID: q6VtWObSQRWkF+yUk/s9oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75380067"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="75380067"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:09:17 -0700
X-CSE-ConnectionGUID: 2JgBIYc/TOKKMYx93jcdZA==
X-CSE-MsgGUID: ZE3C6i5zQcSDNueulDmX8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185099039"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 29 Oct 2025 21:09:14 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEJxv-000LRm-0d;
	Thu, 30 Oct 2025 04:09:00 +0000
Date: Thu, 30 Oct 2025 12:04:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
Message-ID: <202510301107.wrn8eeW8-lkp@intel.com>
References: <20251029031035.258766-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029031035.258766-3-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.18-rc3 next-20251029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/ublk-reorder-tag_set-initialization-before-queue-allocation/20251029-111323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20251029031035.258766-3-ming.lei%40redhat.com
patch subject: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
config: csky-randconfig-r054-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301107.wrn8eeW8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301107.wrn8eeW8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301107.wrn8eeW8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> drivers/block/ublk_drv.c:240:56: error: 'dev_info' undeclared here (not in a function); did you mean '_dev_info'?
     240 |         struct ublk_queue       *queues[] __counted_by(dev_info.nr_hw_queues);
         |                                                        ^~~~~~~~
   include/linux/compiler_types.h:346:71: note: in definition of macro '__counted_by'
     346 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
         |                                                                       ^~~~~~
>> drivers/block/ublk_drv.c:240:34: error: 'counted_by' argument is not an identifier
     240 |         struct ublk_queue       *queues[] __counted_by(dev_info.nr_hw_queues);
         |                                  ^~~~~~


vim +240 drivers/block/ublk_drv.c

   208	
   209	struct ublk_device {
   210		struct gendisk		*ub_disk;
   211	
   212		struct ublksrv_ctrl_dev_info	dev_info;
   213	
   214		struct blk_mq_tag_set	tag_set;
   215	
   216		struct cdev		cdev;
   217		struct device		cdev_dev;
   218	
   219	#define UB_STATE_OPEN		0
   220	#define UB_STATE_USED		1
   221	#define UB_STATE_DELETED	2
   222		unsigned long		state;
   223		int			ub_number;
   224	
   225		struct mutex		mutex;
   226	
   227		spinlock_t		lock;
   228		struct mm_struct	*mm;
   229	
   230		struct ublk_params	params;
   231	
   232		struct completion	completion;
   233		u32			nr_io_ready;
   234		bool 			unprivileged_daemons;
   235		struct mutex cancel_mutex;
   236		bool canceling;
   237		pid_t 	ublksrv_tgid;
   238		struct delayed_work	exit_work;
   239	
 > 240		struct ublk_queue       *queues[] __counted_by(dev_info.nr_hw_queues);
   241	};
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
