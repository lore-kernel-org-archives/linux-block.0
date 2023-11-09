Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B936AED
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKpYCNAm"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176E3C14
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 11:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699558284; x=1731094284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hH9nlVUGJLwdmbsNU0RXFWcoFRP5ACZ+JtBNhRW+Xjk=;
  b=fKpYCNAmxeWO31G5SPl8K7V2rxszRcOlWjmJ5PpSGLd+E4X5sT0c0m3r
   4T17j+S0HMKJIzoGo04/JebeikZYbd1WxPIxnnBGQAysmM/LagMGPaDu5
   o6pqSLxMhzNJWCfIGuVgsd6KSHXkvCXG1dmnpp4ohC6lJ9HPeMdR1FG/L
   8pk2X/EqkKHXJgkF5L4Hco9D2YHjBe9rdTGPxij/LPd3ObESmpjMskuyj
   3tpmmvMI+9Uc1XYgJXdUBoQnErLZs091E42JXYiwcAxyCtZRS83cY12Vy
   mZW6QcwZ3OOFcP2UBIWDGX1LMhm+Kt679iQ458S8vAZfxk9uNG/yGaUGs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="392935574"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="392935574"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:31:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="887122267"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="887122267"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2023 11:31:21 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1AkJ-00095S-0k;
	Thu, 09 Nov 2023 19:31:19 +0000
Date: Fri, 10 Nov 2023 03:30:38 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Ed Tsai <ed.tsai@mediatek.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 2/2] block: try to make aligned bio in case of big
 chunk IO
Message-ID: <202311100354.HYfqOQ7o-lkp@intel.com>
References: <20231109082827.2276696-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109082827.2276696-3-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.6 next-20231109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/block-don-t-call-into-iov_iter_revert-if-nothing-is-left/20231109-190100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20231109082827.2276696-3-ming.lei%40redhat.com
patch subject: [PATCH V2 2/2] block: try to make aligned bio in case of big chunk IO
config: arm-davinci_all_defconfig (https://download.01.org/0day-ci/archive/20231110/202311100354.HYfqOQ7o-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100354.HYfqOQ7o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100354.HYfqOQ7o-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/bio.c:1228:21: warning: variable 'size' is uninitialized when used here [-Wuninitialized]
    1228 |                 return UINT_MAX - size;
         |                                   ^~~~
   block/bio.c:1221:19: note: initialize the variable 'size' to silence this warning
    1221 |         unsigned int size, predicted_space, max_bytes;
         |                          ^
         |                           = 0
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
   Depends on [n]: PINCTRL [=n] && OF [=y] && HAS_IOMEM [=y]
   Selected by [y]:
   - ARCH_DAVINCI [=y] && ARCH_MULTI_V5 [=y] && CPU_LITTLE_ENDIAN [=y]


vim +/size +1228 block/bio.c

  1212	
  1213	/*
  1214	 * Figure out max_size hint of iov_iter_extract_pages() for minimizing
  1215	 * bio & iov iter revert so that bio can be aligned with max io size.
  1216	 */
  1217	static unsigned int bio_get_buffer_size_hint(const struct bio *bio,
  1218			unsigned int left)
  1219	{
  1220		unsigned int nr_bvecs = bio->bi_max_vecs - bio->bi_vcnt;
  1221		unsigned int size, predicted_space, max_bytes;
  1222		unsigned int space = nr_bvecs << PAGE_SHIFT;
  1223		unsigned int align_deviation;
  1224	
  1225		/* If we have enough space really, just try to get all pages */
  1226		if (!bio->bi_bdev || nr_bvecs >= (bio->bi_max_vecs / 4) ||
  1227				!bio->bi_vcnt || left <= space)
> 1228			return UINT_MAX - size;
  1229	
  1230		max_bytes = bdev_max_io_bytes(bio->bi_bdev);
  1231		size = bio->bi_iter.bi_size;
  1232	
  1233		/*
  1234		 * One bvec can hold physically continuous page frames with
  1235		 * multipage bvec and bytes in these pages can be pretty big, so
  1236		 * predict the available space by averaging bytes on all bvecs
  1237		 */
  1238		predicted_space = size * nr_bvecs / bio->bi_vcnt;
  1239		/*
  1240		 * If predicted space is bigger than max io bytes and at least two
  1241		 * vectors left, ask for all pages
  1242		 */
  1243		if (predicted_space > max_bytes && nr_bvecs > 2)
  1244			return UINT_MAX - size;
  1245	
  1246		/*
  1247		 * This bio is close to be full, and stop to add pages if it is
  1248		 * basically aligned, otherwise just get & add pages if the bio
  1249		 * can be kept as aligned, so that we can minimize bio & iov iter
  1250		 * revert
  1251		 */
  1252		align_deviation = max_t(unsigned int, 16U * 1024, max_bytes / 16);
  1253		if ((size & (max_bytes - 1)) > align_deviation) {
  1254			unsigned aligned_bytes = max_bytes - (size & (max_bytes - 1));
  1255	
  1256			/* try to keep bio aligned if we have enough data and space */
  1257			if (aligned_bytes <= left && aligned_bytes <= predicted_space)
  1258				return aligned_bytes;
  1259		}
  1260	
  1261		return 0;
  1262	}
  1263	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
