Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695531BC9E2
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739120116; cv=none; b=Irazzc8bVI3noJA0rpgi9hyoVCNTcfeqXJzQmA8H1qognDN22xcqwNP13ZLvNAG9ShHO7MJJSDGGtseJkif3v4KA/rZiWukBN1EW0okjfmXTRIk7MeKsypCeDf8IpohZrnwr8/oozoOwB1bxJiGUJ+w0F8c6vXzS0zVagrIsMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739120116; c=relaxed/simple;
	bh=14Gbc40vH/LGvz81BBABcSPKxrmHTY1anjXiSgClj5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFzTZIchYRj7+97aMbgQKl0ss+lVq2QI1MdWJ3vfCfNUVm+Yqx4B/f6Be+frYVzuTmJ3XAHaYf1XfXrLqThQ7YvO+xNOoWP0ZQ/isyBQFRN731cDGVS83JcnRs5k4jDUQLtROnoU+sicHhBGl1jCURZnWrsf8H03EKP1JBIVvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgUN8wlc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgUN8wlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739120115; x=1770656115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=14Gbc40vH/LGvz81BBABcSPKxrmHTY1anjXiSgClj5s=;
  b=XgUN8wlc1r6XCu1JzUszpPOedgjHTv1QOzajbJggLIDHIYDiI58YJe/c
   acF4mKB40utoipYcGrCkGpa+qUQ1Ca+X+RnNPyZfZ3O7Wmyjr6SqnZ+gA
   CEZFYbLqcK/9mUq0efLTsGJDdFhOZxPSswSrFm8/eER19meGVBokmMAdK
   8tDH1iEc5v+Xm/fk/IUv4LzR0rCT0AgopakQbXbKOw2PsRa/psHJ39vWu
   rQd+ChRh4we4kxr0TPZm21PvfmA30TiZSo0WjtUN7qaYWj1yKXdwobgOP
   ZrvL2nx26sa12NIXYh1vdP9x61sV9v7rKjjoUXQM+zRNrWOSt3yvcxUkc
   w==;
X-CSE-ConnectionGUID: ZSX6Rw0lSZWXieuDMSJxsQ==
X-CSE-MsgGUID: Ndo4jnVRRJe5gZWVU92cqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39613212"
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="39613212"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 08:55:14 -0800
X-CSE-ConnectionGUID: QebUnKI4SZKqYzxRDLEmwA==
X-CSE-MsgGUID: /NsRg2IrQLS2Rwp9vrQzTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116057560"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Feb 2025 08:55:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thAaL-0011hP-3C;
	Sun, 09 Feb 2025 16:55:09 +0000
Date: Mon, 10 Feb 2025 00:54:37 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/7] block: don't grab q->debugfs_mutex
Message-ID: <202502100010.Kok1H3KF-lkp@intel.com>
References: <20250209122035.1327325-8-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209122035.1327325-8-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.14-rc1 next-20250207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/block-remove-hctx-debugfs_dir/20250209-202320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250209122035.1327325-8-ming.lei%40redhat.com
patch subject: [PATCH 7/7] block: don't grab q->debugfs_mutex
config: arc-randconfig-001-20250209 (https://download.01.org/0day-ci/archive/20250210/202502100010.Kok1H3KF-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250210/202502100010.Kok1H3KF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502100010.Kok1H3KF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   block/blk-sysfs.c: In function 'blk_debugfs_remove':
>> block/blk-sysfs.c:745:31: warning: unused variable 'q' [-Wunused-variable]
     745 |         struct request_queue *q = disk->queue;
         |                               ^


vim +/q +745 block/blk-sysfs.c

8324aa91d1e11a Jens Axboe        2008-01-29  742  
6fc75f309d291d Christoph Hellwig 2022-11-14  743  static void blk_debugfs_remove(struct gendisk *disk)
6fc75f309d291d Christoph Hellwig 2022-11-14  744  {
6fc75f309d291d Christoph Hellwig 2022-11-14 @745  	struct request_queue *q = disk->queue;
6fc75f309d291d Christoph Hellwig 2022-11-14  746  
6fc75f309d291d Christoph Hellwig 2022-11-14  747  	blk_trace_shutdown(q);
abe3d073fa86b7 Ming Lei          2025-02-09  748  	debugfs_lookup_and_remove(disk->disk_name, blk_debugfs_root);
6fc75f309d291d Christoph Hellwig 2022-11-14  749  }
6fc75f309d291d Christoph Hellwig 2022-11-14  750  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
