Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F21DB34C
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067907; cv=none; b=Jfkl1H+guvdkzv2DHVE/tXF2wIgdG0HY1CPhjlhov2iAQJkXjh1ITtoYYCSQrZiGp0KrtdUie+MUT/n/f7iU781O/HjHoTlvtrOrkzJDptQHhKYEpCw1QBKQaZsG/eMb+VOJKpfvWLKQBaq3YZptjyIih2fdaAKJCySIu1IELAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067907; c=relaxed/simple;
	bh=NB/3g3CKXVMN+VyWjazs/iNfNp4t6kaGPAFZ6ryxo30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH0QJKc2YnxldsuOfGmm5nzabt7JyFSdvUPFFq1Xsgdkc0I8XYXzbdwUTdOqarQiBtwZ7/3g5cSkGtqnjshU8jvAArxWzAowOkvSdjlGYTO0bHdYfcGNvx9Odzz1+OoKnhWsubSFdBfeGjRWGVi6eIfQAqITNCm05nkTXe+57NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcpofzTa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcpofzTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753067906; x=1784603906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NB/3g3CKXVMN+VyWjazs/iNfNp4t6kaGPAFZ6ryxo30=;
  b=XcpofzTa61pICo2C0pGihZ/AQTruqaA0J8OE6lQILaOC11jJJunkxeqM
   KhRwXB0xgIPmzCn0Djf3m0L9necarXOqVYM4WdZKKFT+bz6rxpDx0GLwf
   gbZNKOVgOLAdu3PhtoklCW9IjB+hQ/U1wm6Tx5AYUuXAYMpZRXKd0yCQD
   XletiPgihigxrGzJi0cWBUxs2WaIluYk/GOfEMavN3lxofcG/aizfq/W2
   9hcOiwWPDK40sfU0K9h5l5s2qyJplGO6AslnjgraQdwjo6LGwNW/fZtpK
   epoSych2ytW+qJaawH9B9Wq7BhjrqhGwqWua2Ilc5tfbh2t+w6tYmZSWK
   A==;
X-CSE-ConnectionGUID: Vo49bGewTSKVfPM0jBWSbQ==
X-CSE-MsgGUID: 9LA3MeG+TWCRCND2S4Njdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55154516"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55154516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 20:18:25 -0700
X-CSE-ConnectionGUID: 21tY3aaWT2uX9lHI3haEKQ==
X-CSE-MsgGUID: uatQ71rUTMe5O77rcYQr1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="163264139"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Jul 2025 20:18:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udh2i-000GRB-1z;
	Mon, 21 Jul 2025 03:18:20 +0000
Date: Mon, 21 Jul 2025 11:18:18 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <202507211037.lzkMQLrY-lkp@intel.com>
References: <20250720184040.2402790-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-7-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[cannot apply to linux-nvme/for-next hch-configfs/for-next linus/master v6.16-rc7 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-dma-move-the-bio-and-bvec_iter-to-blk_dma_iter/20250721-024616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250720184040.2402790-7-kbusch%40meta.com
patch subject: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity metadata
config: riscv-randconfig-001-20250721 (https://download.01.org/0day-ci/archive/20250721/202507211037.lzkMQLrY-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507211037.lzkMQLrY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507211037.lzkMQLrY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from block/blk-mq.c:13:
>> include/linux/blk-integrity.h:117:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_start' [-Wmissing-prototypes]
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         |      ^
   include/linux/blk-integrity.h:117:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         | ^
         | static 
>> include/linux/blk-integrity.h:123:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_next' [-Wmissing-prototypes]
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         |      ^
   include/linux/blk-integrity.h:123:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         | ^
         | static 
   2 warnings generated.
--
   In file included from block/blk-mq-dma.c:5:
>> include/linux/blk-integrity.h:117:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_start' [-Wmissing-prototypes]
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         |      ^
   include/linux/blk-integrity.h:117:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         | ^
         | static 
>> include/linux/blk-integrity.h:123:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_next' [-Wmissing-prototypes]
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         |      ^
   include/linux/blk-integrity.h:123:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         | ^
         | static 
   block/blk-mq-dma.c:23:27: error: no member named 'bi_integrity' in 'struct bio'
      23 |                 iter->iter = iter->bio->bi_integrity->bip_iter;
         |                              ~~~~~~~~~  ^
   block/blk-mq-dma.c:24:27: error: no member named 'bi_integrity' in 'struct bio'
      24 |                 iter->bvec = iter->bio->bi_integrity->bip_vec;
         |                              ~~~~~~~~~  ^
   2 warnings and 2 errors generated.


vim +/blk_rq_integrity_dma_map_iter_start +117 include/linux/blk-integrity.h

    90	
    91	/*
    92	 * Return the current bvec that contains the integrity data. bip_iter may be
    93	 * advanced to iterate over the integrity data.
    94	 */
    95	static inline struct bio_vec rq_integrity_vec(struct request *rq)
    96	{
    97		return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
    98					 rq->bio->bi_integrity->bip_iter);
    99	}
   100	#else /* CONFIG_BLK_DEV_INTEGRITY */
   101	static inline int blk_rq_count_integrity_sg(struct request_queue *q,
   102						    struct bio *b)
   103	{
   104		return 0;
   105	}
   106	static inline int blk_rq_map_integrity_sg(struct request *q,
   107						  struct scatterlist *s)
   108	{
   109		return 0;
   110	}
   111	static inline int blk_rq_integrity_map_user(struct request *rq,
   112						    void __user *ubuf,
   113						    ssize_t bytes)
   114	{
   115		return -EINVAL;
   116	}
 > 117	bool blk_rq_integrity_dma_map_iter_start(struct request *req,
   118			struct device *dma_dev,  struct dma_iova_state *state,
   119			struct blk_dma_iter *iter)
   120	{
   121		return false;
   122	}
 > 123	bool blk_rq_integrity_dma_map_iter_next(struct request *req,
   124			struct device *dma_dev, struct blk_dma_iter *iter)
   125	{
   126		return false;
   127	}
   128	static inline struct blk_integrity *bdev_get_integrity(struct block_device *b)
   129	{
   130		return NULL;
   131	}
   132	static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
   133	{
   134		return NULL;
   135	}
   136	static inline bool
   137	blk_integrity_queue_supports_integrity(struct request_queue *q)
   138	{
   139		return false;
   140	}
   141	static inline unsigned short
   142	queue_max_integrity_segments(const struct request_queue *q)
   143	{
   144		return 0;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
