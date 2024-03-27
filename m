Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E3131E54
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562683; cv=none; b=fso6UQantQHMuv4o2aTAJrJGyVFSn2eq+7dNeCG8SWkB3CQMCfp7LsWyAugfX38xNrii+oqXGUtE91fbP1+Tf4ojRj+i4w3L1m44R7HEIIveTgxxPvhGRWxKcxNLpd76cheBvuhV7EtwiOyHn00dLk0JNSsrppSi3xQXi6I+C34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562683; c=relaxed/simple;
	bh=xWB8XWxCZgb2qItt9Xl6ufQrSL6nG/2L7TcBeUeBOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jde9LXJEcqe/I5CEFbKtCHWk+FOkU832g/Jv23QIATz5lgYLzr7PAGUluKkz68wRI5FWHEwdXbJ/H9zFkEyu9z0nhjiWpN0Yc1mW1gwfkuApGfpK2QfhQadtoHnoej6zJjwUQIkP0ghRbMrBcl8UHIhoUeCZbDjkOQ65xRF5hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtbYowk/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtbYowk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711562679; x=1743098679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xWB8XWxCZgb2qItt9Xl6ufQrSL6nG/2L7TcBeUeBOXU=;
  b=VtbYowk/pIlWH8ilSSlCBvd4rBH+agCtisAOgL8p9by9FeHRbNMZLwUI
   LGxMBSx4ylM+Yu97JX/gV02L+lqyse6QpFwSMF6ZpuzQqMlFYkm+GkLsp
   tMQ/2meB9opmerKy6nnHqlnUSLXgHtN+WA1BYQRKi6JGtNje/4HA17ZwY
   OdbvNYyQSt1kGxlpo3sndsqD6InBRuTU6XPJPbC+iTq63QxQB0ZCHevOR
   Bi+bg+YZhELcnhaPdn8VCmYT8NzjZY8dxLidlOqdzy1zMRTCTH5EBhsEh
   Ni2FAUdtfEA9vzVkA2fbtT8vecNbsjSD/hQjxUFqHhZ39m4j+6DDJ6Sr4
   g==;
X-CSE-ConnectionGUID: KTvf63zRQ9+9+/Tscp80sA==
X-CSE-MsgGUID: 2S695nU6Rk2Tr5kl65t1sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6542645"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6542645"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16411980"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Mar 2024 11:04:35 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpXdZ-0001Ln-0x;
	Wed, 27 Mar 2024 18:04:33 +0000
Date: Thu, 28 Mar 2024 02:03:55 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202403280137.o1GjQ6cI-lkp@intel.com>
References: <20240326153529.75989-2-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326153529.75989-2-hare@kernel.org>

Hi Hannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.9-rc1 next-20240327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240326-234521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240326153529.75989-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240328/202403280137.o1GjQ6cI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280137.o1GjQ6cI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280137.o1GjQ6cI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/blk-integrity.h:5,
                    from block/bdev.c:15:
>> include/linux/blk-mq.h:1240:15: error: unknown type name 'in'
    1240 | static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
         |               ^~
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for 'blk_nodelat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^~


vim +/in +1240 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nodelat_enable(struct request_queue *q);
  1236	void blk_nodelat_disable(struct request_queue *q);
  1237	u64 blk_nodelat_latency(struct request_queue *q, int node);
  1238	int blk_nodelat_init(struct gendisk *disk);
  1239	#else
> 1240	static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
  1241	static inline void blk_nodelat_disable(struct request_queue *q) {}
> 1242	u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
