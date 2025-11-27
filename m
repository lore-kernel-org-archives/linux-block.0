Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0173FBA7
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764269188; cv=none; b=YZb98BGKGvkwM/7acMit157NguGnPxfQr3OZgk+KiyCD/rmCbLLR2qy/hZFy420FGeKZ5aeOIe2a2APxlHdBJfFXckHIJAebBMstKdOt9iW8ov1vVjmqtEbEi51AJo2yCL4ewWxKEtgMF67btrhQ2lmTSMCK0YZCwFUBnUmgnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764269188; c=relaxed/simple;
	bh=iC1cz2v6n1DN5/WOAgDJjUMB7/6WgvXm1FqIKUusd/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDqyJNFUukejMiuEpqzAMhC7X/EUMbwSkFUp/r/Kg47rrCIYfvlZyXl+mmBTcSuSEiZ28i08UV7ZY9do4CqMUEWqcK2pi2huB2TjNouKr0K2NjwylYRrHYvHBRmYkxbYcGpNiP29Wt4XrTNSDuUWG5sVWokRV+x34xHRl/OI0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHb6byCt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHb6byCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764269186; x=1795805186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iC1cz2v6n1DN5/WOAgDJjUMB7/6WgvXm1FqIKUusd/s=;
  b=lHb6byCtgyx0vDD9Co4q9f7GZ0FoL04lknhVJNZV4iPMjFoRGJJ2avU1
   lRl4CwR9F/E6Mv2r9HUKUquWVVOD/eXIlwzaLLMAUtNyecvS8y/QaDx2b
   9MIg43Jk+oO1rtdWXKfVqgmPb9U7g0q0K0Z5rLKsD0Gr9jBYBBtTcAW2M
   a3GGD16dWwssL1/nSOBsTUiF/NAofSutgGY2cLpLHnuuSNe9kCA0fTZCO
   cFNWv4IpH89KauSjln9w+7kLxNYcmJ552weE2kvq/TmCXWbaEjDmgPd06
   YviuPVey78GDWOI17pwS4TzpoMl0ohF5yEpwjnC+MVvX2sDfhf5Vydk+f
   A==;
X-CSE-ConnectionGUID: oCZV5/fPTti0lj9SfVAAaA==
X-CSE-MsgGUID: 4rI9FNuiTTiXN/wyWjQOoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66479162"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66479162"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:46:25 -0800
X-CSE-ConnectionGUID: sADK5HrFT/GHOcUwAQeJBA==
X-CSE-MsgGUID: q8W76CdBT8a5WDShbgPsPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192417806"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Nov 2025 10:46:23 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOh0W-000000005Wr-3qb6;
	Thu, 27 Nov 2025 18:46:20 +0000
Date: Fri, 28 Nov 2025 02:46:09 +0800
From: kernel test robot <lkp@intel.com>
To: Fengnan Chang <fengnanchang@gmail.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de,
	hch@lst.de, yukuai3@huawei.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <202511280210.BjxdaKJc-lkp@intel.com>
References: <20251127013908.66118-3-fengnanchang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127013908.66118-3-fengnanchang@gmail.com>

Hi Fengnan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4941a17751c99e17422be743c02c923ad706f888]

url:    https://github.com/intel-lab-lkp/linux/commits/Fengnan-Chang/blk-mq-use-array-manage-hctx-map-instead-of-xarray/20251127-094243
base:   4941a17751c99e17422be743c02c923ad706f888
patch link:    https://lore.kernel.org/r/20251127013908.66118-3-fengnanchang%40gmail.com
patch subject: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251128/202511280210.BjxdaKJc-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251128/202511280210.BjxdaKJc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511280210.BjxdaKJc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/block/rnbd/rnbd-clt.c:1324:2: error: call to undeclared function 'queue_hctx'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1324 |         queue_for_each_hw_ctx(dev->queue, hctx, i) {
         |         ^
   include/linux/blk-mq.h:1004:17: note: expanded from macro 'queue_for_each_hw_ctx'
    1004 |              ({ hctx = queue_hctx((q), i); 1; }); (i)++)
         |                        ^
>> drivers/block/rnbd/rnbd-clt.c:1324:2: error: incompatible integer to pointer conversion assigning to 'struct blk_mq_hw_ctx *' from 'int' [-Wint-conversion]
    1324 |         queue_for_each_hw_ctx(dev->queue, hctx, i) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1004:15: note: expanded from macro 'queue_for_each_hw_ctx'
    1004 |              ({ hctx = queue_hctx((q), i); 1; }); (i)++)
         |                      ^ ~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/queue_hctx +1324 drivers/block/rnbd/rnbd-clt.c

f7a7a5c228d45e Jack Wang 2020-05-11  1317  
f7a7a5c228d45e Jack Wang 2020-05-11  1318  static void rnbd_init_mq_hw_queues(struct rnbd_clt_dev *dev)
f7a7a5c228d45e Jack Wang 2020-05-11  1319  {
4f481208749a22 Ming Lei  2022-03-08  1320  	unsigned long i;
f7a7a5c228d45e Jack Wang 2020-05-11  1321  	struct blk_mq_hw_ctx *hctx;
f7a7a5c228d45e Jack Wang 2020-05-11  1322  	struct rnbd_queue *q;
f7a7a5c228d45e Jack Wang 2020-05-11  1323  
f7a7a5c228d45e Jack Wang 2020-05-11 @1324  	queue_for_each_hw_ctx(dev->queue, hctx, i) {
f7a7a5c228d45e Jack Wang 2020-05-11  1325  		q = &dev->hw_queues[i];
f7a7a5c228d45e Jack Wang 2020-05-11  1326  		rnbd_init_hw_queue(dev, q, hctx);
f7a7a5c228d45e Jack Wang 2020-05-11  1327  		hctx->driver_data = q;
f7a7a5c228d45e Jack Wang 2020-05-11  1328  	}
f7a7a5c228d45e Jack Wang 2020-05-11  1329  }
f7a7a5c228d45e Jack Wang 2020-05-11  1330  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
