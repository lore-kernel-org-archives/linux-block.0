Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2B2EC541
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276096; cv=none; b=EP4OFmeLogd6P1RkU3CiMRgkHq0ashWCWpXfC6g8CHGn5CT9LLqyFNJgxfPWr18i2YjAZfg12lhsO6BbKXqcQSu7ThPnt/Hip+BVpTmJllZOjsUH2CP9vNRLLyUC12RghrhQvCAWZMf+rTFrFOt4F6HK+SwO15496rVLVydvnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276096; c=relaxed/simple;
	bh=QA/ZzFWM8eJy3AO5vcQJsCYO31kNtb0Jm5IzJ4sTa8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZuSF80kWUOZIQ3RMsgd54wpLTov07Hc6znLqpTIrJ5NkshIlvK8hDISFQQrfNxYuIFWN9bi8TMx835rAImxSGEAmKSdk+sm/aS+aRKlv2Yx5xHeMH8T3cvgd7nI4PhFMPOGEaSsLIH71dUWdC3uHXsyPGku7mdBl3ujiH6RDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7T7RjVF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7T7RjVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764276094; x=1795812094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QA/ZzFWM8eJy3AO5vcQJsCYO31kNtb0Jm5IzJ4sTa8Q=;
  b=a7T7RjVFe5/xl4gaS09YwY6weMeHnS5B3c2DnwHwWmsuEPMnKp1Sh3i1
   kpcivprxHaa6tRe+ZfeR3aXSrCzvky+XZr89II9NM9Tj9/DXjptSiyOGh
   yLoy7yQn7n4brtincke0ZHof50135BGlkJ5b6lLBrj9MnFCMgfGADDMIT
   GIUNKahdPAlMWcFxYvCzNn0EE0+l7hosu9P2fwwqAoJCf1Csi7jfebzvC
   bMFSzqHBAeXfBXoKl3f0pLEiHcoFRyOwqJswUs8LyS+e3TNb54cf+jo1u
   3L5mEsHK4HBqDBUriik0jDmmyf0dprwMwc8cTL1lSKHWHy9gboGJbwj+j
   w==;
X-CSE-ConnectionGUID: EOZIDlqlToG/pUVYwIAdBg==
X-CSE-MsgGUID: Dme50l4pTiqAozQw1rFxYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66034046"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66034046"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 12:41:33 -0800
X-CSE-ConnectionGUID: 5Q1S9mF8RpmgmhFfgI1Elg==
X-CSE-MsgGUID: +VzEKHWqQbC/n5LgO7uLSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="224264127"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Nov 2025 12:41:30 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOinw-000000005f3-2B4v;
	Thu, 27 Nov 2025 20:41:28 +0000
Date: Fri, 28 Nov 2025 04:41:07 +0800
From: kernel test robot <lkp@intel.com>
To: Fengnan Chang <fengnanchang@gmail.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de,
	hch@lst.de, yukuai3@huawei.com
Cc: oe-kbuild-all@lists.linux.dev,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <202511280407.DzqlGFFg-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4941a17751c99e17422be743c02c923ad706f888]

url:    https://github.com/intel-lab-lkp/linux/commits/Fengnan-Chang/blk-mq-use-array-manage-hctx-map-instead-of-xarray/20251127-094243
base:   4941a17751c99e17422be743c02c923ad706f888
patch link:    https://lore.kernel.org/r/20251127013908.66118-3-fengnanchang%40gmail.com
patch subject: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
config: arm-randconfig-002-20251128 (https://download.01.org/0day-ci/archive/20251128/202511280407.DzqlGFFg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251128/202511280407.DzqlGFFg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511280407.DzqlGFFg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/block/rnbd/rnbd-clt.h:16,
                    from drivers/block/rnbd/rnbd-clt.c:19:
   drivers/block/rnbd/rnbd-clt.c: In function 'rnbd_init_mq_hw_queues':
   include/linux/blk-mq.h:1004:17: error: implicit declaration of function 'queue_hctx'; did you mean 'queue_work'? [-Werror=implicit-function-declaration]
          ({ hctx = queue_hctx((q), i); 1; }); (i)++)
                    ^~~~~~~~~~
   drivers/block/rnbd/rnbd-clt.c:1324:2: note: in expansion of macro 'queue_for_each_hw_ctx'
     queue_for_each_hw_ctx(dev->queue, hctx, i) {
     ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/blk-mq.h:1004:15: warning: assignment to 'struct blk_mq_hw_ctx *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
          ({ hctx = queue_hctx((q), i); 1; }); (i)++)
                  ^
   drivers/block/rnbd/rnbd-clt.c:1324:2: note: in expansion of macro 'queue_for_each_hw_ctx'
     queue_for_each_hw_ctx(dev->queue, hctx, i) {
     ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from rnbd-clt.h:16,
                    from rnbd-clt.c:19:
   rnbd-clt.c: In function 'rnbd_init_mq_hw_queues':
   include/linux/blk-mq.h:1004:17: error: implicit declaration of function 'queue_hctx'; did you mean 'queue_work'? [-Werror=implicit-function-declaration]
          ({ hctx = queue_hctx((q), i); 1; }); (i)++)
                    ^~~~~~~~~~
   rnbd-clt.c:1324:2: note: in expansion of macro 'queue_for_each_hw_ctx'
     queue_for_each_hw_ctx(dev->queue, hctx, i) {
     ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/blk-mq.h:1004:15: warning: assignment to 'struct blk_mq_hw_ctx *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
          ({ hctx = queue_hctx((q), i); 1; }); (i)++)
                  ^
   rnbd-clt.c:1324:2: note: in expansion of macro 'queue_for_each_hw_ctx'
     queue_for_each_hw_ctx(dev->queue, hctx, i) {
     ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1004 include/linux/blk-mq.h

  1001	
  1002	#define queue_for_each_hw_ctx(q, hctx, i)				\
  1003		for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
> 1004		     ({ hctx = queue_hctx((q), i); 1; }); (i)++)
  1005	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
