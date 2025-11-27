Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B554A0C
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764286431; cv=none; b=bcFFZRY36t3oJLZCvyyaFJQXbRc9k4qzM8gAggyc01KyX4HiGVxtn6myOtmthiRAJSJ642fdQHmzGpw0LVVrruCx7thNkG5EA9lmW264njiGTUQH7OlvXvWUI8oeGjuqyEhtns187fp2JEDBaeukGEyvf43vpYvsHtfybLqQ1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764286431; c=relaxed/simple;
	bh=Jt6bIBbJZKvU6woJ8tklLnbeoSLj9AH1hVcMc319y+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpdJ30uX0RkIrPP064yUNiL9wIjk3ka+vKZcmUx03kmyN36kzcob4vJJEloy0nhnTfThbSNpx3gvHdfidPHTJaUaq3XdzvTLmohYw0suZ3sPgH6O7vhpXNcXWNCS0090sxw+VAcQxOCVznjGTH+URbmqhAJQ4iDfB1b1sYn/+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/ZBsf1E; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/ZBsf1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764286428; x=1795822428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jt6bIBbJZKvU6woJ8tklLnbeoSLj9AH1hVcMc319y+g=;
  b=O/ZBsf1ELjKQBINWLPrG4WJr2tGaJ4CEGr435D0t7tgtDORtvtpLhl42
   prFF9cvmk7TaFuRp5lturnSVYTtCUvygFT6h3xnSBGFgEbFIvvBeBooTp
   D5bEShDT32N49/nEFJvvq/KkVggvjqTSFvJDo86+kqeKdzbG9WyoKpOpe
   SrGsvtOB6Wi1erPP7bky+i56isaLQvVQK1c4FwpDQ5XeldwQCuG21hbjy
   +bEtXrtCA21/IkTOIHav9w6EI/38rWj+P2+NxIVB4BELO4YBpRXPFIm5h
   co5ylDG+2PGFvmdgvh1Ks7k+mfycTf/HJogVeXSwDI/jIjYDAXmjA8CsS
   Q==;
X-CSE-ConnectionGUID: J2F89hrtRc2/h1DxszXMAA==
X-CSE-MsgGUID: yDD4CBrZQyOaFnAPctsd1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66491161"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66491161"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 15:33:48 -0800
X-CSE-ConnectionGUID: bK4EJGhiQ0i/xl8GjRkzZQ==
X-CSE-MsgGUID: Vd+CKkBaT5CPkFNSPwlO4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="224028726"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2025 15:33:46 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOlUc-000000005qP-2I4v;
	Thu, 27 Nov 2025 23:33:42 +0000
Date: Fri, 28 Nov 2025 07:32:55 +0800
From: kernel test robot <lkp@intel.com>
To: Fengnan Chang <fengnanchang@gmail.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de,
	hch@lst.de, yukuai3@huawei.com
Cc: oe-kbuild-all@lists.linux.dev,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <202511280714.MCsRsCmR-lkp@intel.com>
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
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20251128/202511280714.MCsRsCmR-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251128/202511280714.MCsRsCmR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511280714.MCsRsCmR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/block/rnbd/rnbd-clt.h:16,
                    from drivers/block/rnbd/rnbd-clt.c:19:
   drivers/block/rnbd/rnbd-clt.c: In function 'rnbd_init_mq_hw_queues':
>> include/linux/blk-mq.h:1004:24: error: implicit declaration of function 'queue_hctx' [-Wimplicit-function-declaration]
    1004 |              ({ hctx = queue_hctx((q), i); 1; }); (i)++)
         |                        ^~~~~~~~~~
   drivers/block/rnbd/rnbd-clt.c:1324:9: note: in expansion of macro 'queue_for_each_hw_ctx'
    1324 |         queue_for_each_hw_ctx(dev->queue, hctx, i) {
         |         ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/blk-mq.h:1004:22: error: assignment to 'struct blk_mq_hw_ctx *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1004 |              ({ hctx = queue_hctx((q), i); 1; }); (i)++)
         |                      ^
   drivers/block/rnbd/rnbd-clt.c:1324:9: note: in expansion of macro 'queue_for_each_hw_ctx'
    1324 |         queue_for_each_hw_ctx(dev->queue, hctx, i) {
         |         ^~~~~~~~~~~~~~~~~~~~~


vim +/queue_hctx +1004 include/linux/blk-mq.h

  1001	
  1002	#define queue_for_each_hw_ctx(q, hctx, i)				\
  1003		for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
> 1004		     ({ hctx = queue_hctx((q), i); 1; }); (i)++)
  1005	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
