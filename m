Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC72F3C09
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897418; cv=none; b=sZut1Wp/6TTngxW+uqyozYx7YeNHBrD/zKDyXVL19uqyYL+tWWS5FtKUv+awwBmNdVRT3E8n1ypr/zShej2X3DVm6zQvZb+UPFiJgdAdezddnw9x/CTQWpIznyFZX4Xh03A2nXfIapOyOxQHBwslPpd6oZGR/lXbeCu4sfzbhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897418; c=relaxed/simple;
	bh=mK48HJuRtxhk+rOliRCyAqWX/GoUBTZ5QYLNKbcRyYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp8zOxV47G5+WJoV882TnODjJmKtf8HcNa8VAn2lvDHiLMaE+lWbQ7gIes3DwbC7BBNx4QP7V6oDM3lX2NNUXEa0HBvi1+NrOaqlGV0lckC2Xr8CbZeFNvR0pBpNkYjzwdKQVcPBpGXPYUFIxI8DPkPF/MnSITTNqiUYjZW1W8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmpt6gbm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmpt6gbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756897416; x=1788433416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mK48HJuRtxhk+rOliRCyAqWX/GoUBTZ5QYLNKbcRyYw=;
  b=cmpt6gbmUbo8rJdCHuNx0ZlxhNttluzmgr8vaSBGg6JKSliIXNzzDO6p
   5/Q07s4GSvQoAhlllIWIRhLddZGXLtj+Xoas4gk5n3lPZoOmLcU642/hb
   b/JtqCZzmwC/B5bq9vgFRy74y3zktnoDvFQxWpmB5EGI1xR6OiWRtxgZw
   Nfs5O0ADx/0VyqW/YDSEPs9tOGpphOLAiY5CQAgIT4wuSHC7Ti1B4v3q8
   TA7HgHK5O8Nrym3MiLqDG8M3/LD7EuXdpdOoVAxxcvCjWkLpaVaC8TPal
   SYEmOgFLizi+YfOkvEgpn3sSHSVbEZUfluRGv/Gfd6B4+TAvehHBvzERX
   g==;
X-CSE-ConnectionGUID: Cob3sI4PSNSjRdeZoYzxxg==
X-CSE-MsgGUID: qP35KmvaQ8GEYOeif+GVDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58904961"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="58904961"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:03:36 -0700
X-CSE-ConnectionGUID: gRJxoQ3FRNGAf1Y59gxKfg==
X-CSE-MsgGUID: VBmY371+T4aCAUCQNZWhcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="175914870"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 03 Sep 2025 04:03:33 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utlH0-0003lf-2w;
	Wed, 03 Sep 2025 11:03:30 +0000
Date: Wed, 3 Sep 2025 19:02:40 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, axboe@kernel.dk,
	martin.petersen@oracle.com, jgg@nvidia.com, leon@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <202509031816.qq7ODYRv-lkp@intel.com>
References: <20250902200121.3665600-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902200121.3665600-3-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on next-20250903]
[cannot apply to linus/master linux-nvme/for-next hch-configfs/for-next v6.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-integrity-enable-p2p-source-and-destination/20250903-040417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250902200121.3665600-3-kbusch%40meta.com
patch subject: [PATCHv2 2/2] blk-mq-dma: bring back p2p request flags
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20250903/202509031816.qq7ODYRv-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031816.qq7ODYRv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031816.qq7ODYRv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/bdev.c:15:
>> include/linux/blk-integrity.h:127:20: error: redefinition of 'blk_rq_dma_unmap'
     127 | static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
         |                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/blk-integrity.h:7:
   include/linux/blk-mq-dma.h:71:20: note: previous definition of 'blk_rq_dma_unmap' with type 'bool(struct request *, struct device *, struct dma_iova_state *, size_t)' {aka '_Bool(struct request *, struct device *, struct dma_iova_state *, unsigned int)'}
      71 | static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
         |                    ^~~~~~~~~~~~~~~~


vim +/blk_rq_dma_unmap +127 include/linux/blk-integrity.h

   101	
   102	/*
   103	 * Return the current bvec that contains the integrity data. bip_iter may be
   104	 * advanced to iterate over the integrity data.
   105	 */
   106	static inline struct bio_vec rq_integrity_vec(struct request *rq)
   107	{
   108		return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
   109					 rq->bio->bi_integrity->bip_iter);
   110	}
   111	#else /* CONFIG_BLK_DEV_INTEGRITY */
   112	static inline int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
   113					   struct logical_block_metadata_cap __user *argp)
   114	{
   115		return -ENOIOCTLCMD;
   116	}
   117	static inline int blk_rq_count_integrity_sg(struct request_queue *q,
   118						    struct bio *b)
   119	{
   120		return 0;
   121	}
   122	static inline int blk_rq_map_integrity_sg(struct request *q,
   123						  struct scatterlist *s)
   124	{
   125		return 0;
   126	}
 > 127	static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
   128			struct dma_iova_state *state, size_t mapped_len)
   129	{
   130		return false;
   131	}
   132	static inline int blk_rq_integrity_map_user(struct request *rq,
   133						    void __user *ubuf,
   134						    ssize_t bytes)
   135	{
   136		return -EINVAL;
   137	}
   138	static inline bool blk_rq_integrity_dma_map_iter_start(struct request *req,
   139			struct device *dma_dev,  struct dma_iova_state *state,
   140			struct blk_dma_iter *iter)
   141	{
   142		return false;
   143	}
   144	static inline bool blk_rq_integrity_dma_map_iter_next(struct request *req,
   145			struct device *dma_dev, struct blk_dma_iter *iter)
   146	{
   147		return false;
   148	}
   149	static inline struct blk_integrity *bdev_get_integrity(struct block_device *b)
   150	{
   151		return NULL;
   152	}
   153	static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
   154	{
   155		return NULL;
   156	}
   157	static inline bool
   158	blk_integrity_queue_supports_integrity(struct request_queue *q)
   159	{
   160		return false;
   161	}
   162	static inline unsigned short
   163	queue_max_integrity_segments(const struct request_queue *q)
   164	{
   165		return 0;
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
