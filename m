Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300C29BD88
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764275496; cv=none; b=bO0jXCMMANC49vvoQN/UQyvEW+Lq9LH4EFsukCoNr5TEunHTsqDSSUF4bJqMF3aa253O6Qu2hvGfCx55WqdY1MjTLVxwRLL/ODtg3/xhH45Yj/8K4/4vJzmWFx1mEH9DL6qcMcudLRzlX+K/4HRSHKXj65qx8DW9VgRGmJUBT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764275496; c=relaxed/simple;
	bh=Z4cgVv9G/mfzaI1i5kIPFpdi+3QE1Rr+osG1ukFXuh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojMUEA8Skxv+Higsfxb4Y0N9TcIbp3FpBrUVTduFKCG/jOLG7/uJoOxUnYCaeFJV+VO+Sp4JzJSEUh/TLsQQzPUyswMVywHplna6RINx+aorbIff1oFdvBVUpWjDGB021EsF3x+0VjMISGcopiGuF6MSH9xxHDxa72/9/qi/yYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmGgGkNN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmGgGkNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764275493; x=1795811493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z4cgVv9G/mfzaI1i5kIPFpdi+3QE1Rr+osG1ukFXuh0=;
  b=VmGgGkNNJgrPVhUmqnGoecHUurmV+u+41s74W97kETx+NGn4NW/5yQiU
   zNXj3kDpXMoGY0eaQ8GlRTd8KTKHG8wJG6sLMX2C6rXRZ8uYbKo1J12j9
   d4PVFzdYXsxo8iRv3xhizLaK0ib52R9tnpt1qAY4of53cIXLZ+ntm1djn
   qidq7Ciwd5Xgx8F0FT9CI5hbGy5QckXE5xTsBIQ0c3Du63jH68yihhv/v
   V9S4Z5gMCpoOsybJ7wsNfT14hXAPTDhO3WjFvLcfLy+Y9Uer2HdOI2QLC
   Vrl0A89I8iN/Ul63VIQsbptDvDibrd56CiSUfZp3nJbrqepiQnuyJ84mq
   Q==;
X-CSE-ConnectionGUID: uGNGoopnTfyRvycTUObaWw==
X-CSE-MsgGUID: tmj2O7VfQqmfjYvdrOUznA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="76951450"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="76951450"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 12:31:33 -0800
X-CSE-ConnectionGUID: KScz66ymTMmPlRfG+YmbNw==
X-CSE-MsgGUID: x+star35QpS+VoF4UrkZGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192966498"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Nov 2025 12:31:30 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOieF-000000005eP-3huz;
	Thu, 27 Nov 2025 20:31:27 +0000
Date: Fri, 28 Nov 2025 04:30:45 +0800
From: kernel test robot <lkp@intel.com>
To: Fengnan Chang <fengnanchang@gmail.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de,
	hch@lst.de, yukuai3@huawei.com
Cc: oe-kbuild-all@lists.linux.dev,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <202511280340.4LxTSm2A-lkp@intel.com>
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
config: arm64-randconfig-r131-20251128 (https://download.01.org/0day-ci/archive/20251128/202511280340.4LxTSm2A-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251128/202511280340.4LxTSm2A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511280340.4LxTSm2A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   block/blk-mq-sysfs.c: note: in included file:
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
--
   block/blk-mq-sched.c: note: in included file:
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
--
   block/blk-mq-tag.c: note: in included file:
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
--
   block/blk-mq-debugfs.c: note: in included file:
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
--
   block/kyber-iosched.c: note: in included file (through block/elevator.h):
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
--
   block/blk-mq.c:726:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct blk_mq_hw_ctx *hctx @@     got struct blk_mq_hw_ctx [noderef] __rcu * @@
   block/blk-mq.c:726:19: sparse:     expected struct blk_mq_hw_ctx *hctx
   block/blk-mq.c:726:19: sparse:     got struct blk_mq_hw_ctx [noderef] __rcu *
   block/blk-mq.c:4514:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct blk_mq_hw_ctx **hctxs @@     got struct blk_mq_hw_ctx [noderef] __rcu **queue_hw_ctx @@
   block/blk-mq.c:4514:41: sparse:     expected struct blk_mq_hw_ctx **hctxs
   block/blk-mq.c:4514:41: sparse:     got struct blk_mq_hw_ctx [noderef] __rcu **queue_hw_ctx
   block/blk-mq.c:4527:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.c:4527:17: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.c:4527:17: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.c:5192:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct blk_mq_hw_ctx *hctx @@     got struct blk_mq_hw_ctx [noderef] __rcu * @@
   block/blk-mq.c:5192:48: sparse:     expected struct blk_mq_hw_ctx *hctx
   block/blk-mq.c:5192:48: sparse:     got struct blk_mq_hw_ctx [noderef] __rcu *
   block/blk-mq.c: note: in included file:
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **
>> block/blk-mq.h:95:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu *[noderef] __rcu *
   block/blk-mq.h:95:16: sparse:    struct blk_mq_hw_ctx [noderef] __rcu **

vim +95 block/blk-mq.h

    89	
    90	static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
    91	{
    92		struct blk_mq_hw_ctx *hctx;
    93	
    94		rcu_read_lock();
  > 95		hctx = rcu_dereference(q->queue_hw_ctx)[id];
    96		rcu_read_unlock();
    97	
    98		return hctx;
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
