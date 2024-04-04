Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871E1AAD3
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197406; cv=none; b=ucEM9nUroUSqLzJXYL6jJttg+ojV1OWV0k70UfKAmIxo/D1lk59eDLCyD6XFBWUDsyTgkLAnKUgT7Q79gaoVJ2yVMrGd4xcjPfIjYptv/dMuquLBJhkGKey+zvqvYxzwwDcrWB/xYptN5Vk2pelNmrQ5d9Wkacns1AuRrbUA6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197406; c=relaxed/simple;
	bh=MOXl+c6fjnGSgBdKeGU7MYyvF2VkR4Gp4ish3zSpPUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ873nLbwTqxnHKhhNGl5ouW1Cw3rUz33Nb67iPSKwjPAE6VDs8bqdozKkID9p5Vr0OeZbKiGYAyjvCr7Oz6Fz3pVaFkSC3TFMGpwHzkJ6DKT4BYhospJZhYJjiFGZ1+2ZFI+uN9aEw/S3p+QNJTfuzQY8R3nuduBv1IrDQ9KZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6vOk0tr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6vOk0tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712197405; x=1743733405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MOXl+c6fjnGSgBdKeGU7MYyvF2VkR4Gp4ish3zSpPUs=;
  b=f6vOk0trWL1FWmCQ5kiyovi0WwzmMZcoJ6bjFfHsEcfB74VE04clcNs+
   MHfpssoHsjr4vnuiyZ0sEA2wAU7/dnqd4Nan415C4g8gvMc3ETEp0qyE1
   hroYjBcvm1ZI6m2cTgJcgmcJDNBemJitHurnBbCATFYtptD8YDEbhj69n
   RUmDexRAvvttMqAM+n5xLq9q1/amlvcVHW4R8UmR/sMQby12FUlJcwKv2
   uEIQ0HGWSCiKKULVoT11kFP1scThmgvfT2ePq7MpFWv5v5kow/oOZ2Ehw
   7YxOtXwk6qS53T5EXeZxP4SLKLY8ls5P8OCWc+y8mDuhaSdZ1H9U9sikz
   A==;
X-CSE-ConnectionGUID: 2Kpbngm/RhO9gPsDCuthpA==
X-CSE-MsgGUID: ovGgYQ9lRI6JnY8HhIBjKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7698336"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7698336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 19:23:24 -0700
X-CSE-ConnectionGUID: O2se1tykSFiiDIIO5vVv/A==
X-CSE-MsgGUID: nP6sjbbBTluHPIL8KhE1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18609355"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Apr 2024 19:23:23 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsCl5-0000Uv-2L;
	Thu, 04 Apr 2024 02:23:19 +0000
Date: Thu, 4 Apr 2024 10:22:32 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202404041051.89LVIrNh-lkp@intel.com>
References: <20240403141756.88233-2-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-2-hare@kernel.org>

Hi Hannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.9-rc2 next-20240403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240403-222254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240403141756.88233-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240404/202404041051.89LVIrNh-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240404/202404041051.89LVIrNh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404041051.89LVIrNh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/blk-integrity.h:5,
                    from block/bdev.c:15:
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for 'blk_nlat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         |     ^~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^~


vim +/blk_nlat_latency +1242 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nlat_enable(struct gendisk *disk);
  1236	void blk_nlat_disable(struct gendisk *disk);
  1237	u64 blk_nlat_latency(struct gendisk *disk, int node);
  1238	int blk_nlat_init(struct gendisk *disk);
  1239	#else
  1240	static inline int blk_nlat_enable(struct gendisk *disk) { return 0; }
  1241	static inline void blk_nlat_disable(struct gendisk *disk) {}
> 1242	u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
