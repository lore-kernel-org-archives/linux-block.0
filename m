Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09435BDBE
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556353; cv=none; b=D2dJ/6pk3BHFQLFGOHQsryAbF+ebEwSC8Tb0bGg7adz5Z1GoKwhHRpmXY7zWPpb6Uy39QwPGGji98KL+yURCoLJXsWVYS4Gg8rJUmn9vPyqjhin0tr0uu48yWUvp5sSd+i2wEHvpa5DNU8ejGzRnlHkcqBZJsmxwIS8KMuYyK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556353; c=relaxed/simple;
	bh=ng/O2QW3MktSvdXoUCnhJKqwF78VlPya4qWkFXgX3rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbxf/Fr0JZUPAPbRo1B+rwBnkKq/Oheocnnd+aF4nQ0nuGFzCJi9ziTfltJSWZp64SWUzEGntFeLV4UoabPJD17YBbwfSwke/KqNbrMnjRudPj1N5CWVkq8uk7f5k5iqr9acPK+8OmdLv0wN2GP3rNQ+EH5FBtesXrKxZekVid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLhJAeeb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLhJAeeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763556349; x=1795092349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ng/O2QW3MktSvdXoUCnhJKqwF78VlPya4qWkFXgX3rU=;
  b=YLhJAeebXk9Xqik2Qfba1ajbiTAfI9fncRxWJWnf2vf1nMBZOnlRY9CJ
   fQ3TQ2TaYnDA/1wbIKU9ego7Q8vXjgGlBA60bhprJTVGygWmCtvcCGiSp
   eYSxlduWtAhavhNQ69r+H9RAaxRl8oG2+/svB/CdNSS9bdatJV5s8zOoL
   iRWqN4nokOgiocfY5gLp6FJ5cYX2Y5Lq0lCYnGkyf2sP4jVjW7Q4G+DaU
   Eh3zEFwiG7/DgI9NLaxkL9NqfDrbDddWoNW7phIkVSMJ3ltJLnotCfF4V
   8jv1DW72C9tf1xkE1Mmiu5tBfxUWoe87bL5Zc2ShAltuwGvuQcU7d2/5+
   A==;
X-CSE-ConnectionGUID: 1L9onZ6LRVSU4/NPqepYJQ==
X-CSE-MsgGUID: eqnAx9eDT7mvL6dHH6aMBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91070272"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="91070272"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 04:45:48 -0800
X-CSE-ConnectionGUID: Qi6JUvjLTHSszI2JgmCboQ==
X-CSE-MsgGUID: J8lDMOAfQEyaPBIHH5ePiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190708390"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Nov 2025 04:45:45 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLhZ9-0002sl-2D;
	Wed, 19 Nov 2025 12:45:43 +0000
Date: Wed, 19 Nov 2025 20:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/3] loop: disable writeback throttling and fix nowait
 support
Message-ID: <202511192025.ApZLv3Ly-lkp@intel.com>
References: <20251119093855.3405421-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119093855.3405421-4-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on next-20251119]
[cannot apply to linus/master v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/loop-move-kiocb_start_write-to-aio-prep-phase/20251119-174659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20251119093855.3405421-4-ming.lei%40redhat.com
patch subject: [PATCH 3/3] loop: disable writeback throttling and fix nowait support
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20251119/202511192025.ApZLv3Ly-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511192025.ApZLv3Ly-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511192025.ApZLv3Ly-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/elevator.c:45:
>> block/blk-wbt.h:19:20: error: static declaration of 'wbt_disable_default' follows non-static declaration
      19 | static inline void wbt_disable_default(struct gendisk *disk)
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from block/elevator.c:28:
   include/linux/blkdev.h:452:6: note: previous declaration of 'wbt_disable_default' with type 'void(struct gendisk *)'
     452 | void wbt_disable_default(struct gendisk *disk);
         |      ^~~~~~~~~~~~~~~~~~~


vim +/wbt_disable_default +19 block/blk-wbt.h

e34cbd307477ae Jens Axboe        2016-11-09  18  
04aad37be1a88d Christoph Hellwig 2023-02-03 @19  static inline void wbt_disable_default(struct gendisk *disk)
e34cbd307477ae Jens Axboe        2016-11-09  20  {
e34cbd307477ae Jens Axboe        2016-11-09  21  }
04aad37be1a88d Christoph Hellwig 2023-02-03  22  static inline void wbt_enable_default(struct gendisk *disk)
e34cbd307477ae Jens Axboe        2016-11-09  23  {
e34cbd307477ae Jens Axboe        2016-11-09  24  }
e34cbd307477ae Jens Axboe        2016-11-09  25  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
