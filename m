Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9D1DE8B5
	for <linux-block@vger.kernel.org>; Sat,  2 Aug 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754176317; cv=none; b=IsPyKf/uC+gY7H++7AK7F1WhuQsQg5NGfYuRfMfWAca+jtayDEn0v96s3417WyaRa2g8tXu2LcCEdlvO1pn/ObJDAQod5+uA+BqkJctmzdwShe0ylWBzEF93nxiP2L9m4HMpa2uaiU49z/+C2l8yoRnP3hxNj/0aabBrBqgpvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754176317; c=relaxed/simple;
	bh=J8kmkc6Y6J6DlHjbF2pMDHETrUO3O1dG6KMFJF1BrhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqWtpnKyqoDFcUt25+Q73M8/c4UNqQUvxRkLphIfO5BI0uOeNZrHTTWk86P0tujsI7MSBePZIcQgQ5uvzF0oa6rxJryqNgaG1v0poFzReEp/B803C8vvxWU925eZ/sR3tXAQHdT2NLKwU4O8kTyJ5dBPYZl7CQJ77YOq/J3lVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNndWx7C; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNndWx7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754176316; x=1785712316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J8kmkc6Y6J6DlHjbF2pMDHETrUO3O1dG6KMFJF1BrhI=;
  b=mNndWx7CQ1ZYW5HOLArP27Ico7wHv8LL13YHI9YyyxWYfZRqjSUQPfKL
   1cHu4zDU49hRKEx3ppUyJ1bKib/PAVs8hTu0cytS6e/aY/9Y9ePfSKwSC
   IpAVtNbimxydbr4k/Q8uf0UYGf0TMxQDxFySyU8YmLI+tC+XZtDQhxeFh
   jlbWiBDGsU/I3zQvcGAldj9NHJ/RPgxFiI4vFyozv/yUEciP8vOsK38rZ
   rxXE3w1ZsPE4E+e9I/9vmkjACLiCqRIqjffYnuFd2J1DS0NgKDqRCLKgy
   fDUzHZf4yBl/cdoPTWJ5qE/BFBpei7Tle0xETETZiVRGpMkaul9R9Bbd6
   Q==;
X-CSE-ConnectionGUID: BA+6Y/OlQSexAF5vBAPGGA==
X-CSE-MsgGUID: DpXccReGTIOkRPDGr8w+Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="67933634"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67933634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 16:11:56 -0700
X-CSE-ConnectionGUID: wFtY3sCrS1SgLDt3sFAuXg==
X-CSE-MsgGUID: 9e9MmVThTU+KGBsCfkksVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="169155890"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Aug 2025 16:11:52 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiLOI-0005eG-1c;
	Sat, 02 Aug 2025 23:11:50 +0000
Date: Sun, 3 Aug 2025 07:11:29 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 6/8] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <202508030710.X3P9snty-lkp@intel.com>
References: <20250731150513.220395-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731150513.220395-7-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master next-20250801]
[cannot apply to linux-nvme/for-next hch-configfs/for-next v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-dma-introduce-blk_map_iter/20250731-230719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250731150513.220395-7-kbusch%40meta.com
patch subject: [PATCHv4 6/8] blk-mq-dma: add support for mapping integrity metadata
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250803/202508030710.X3P9snty-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250803/202508030710.X3P9snty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508030710.X3P9snty-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-mq-dma.c:18:27: error: no member named 'bi_integrity' in 'struct bio'
      18 |                 iter->iter = iter->bio->bi_integrity->bip_iter;
         |                              ~~~~~~~~~  ^
   block/blk-mq-dma.c:19:27: error: no member named 'bi_integrity' in 'struct bio'
      19 |                 iter->bvec = iter->bio->bi_integrity->bip_vec;
         |                              ~~~~~~~~~  ^
   2 errors generated.


vim +18 block/blk-mq-dma.c

     8	
     9	static bool __blk_map_iter_next(struct blk_map_iter *iter)
    10	{
    11		if (iter->iter.bi_size)
    12			return true;
    13		if (!iter->bio || !iter->bio->bi_next)
    14			return false;
    15	
    16		iter->bio = iter->bio->bi_next;
    17		if (iter->is_integrity) {
  > 18			iter->iter = iter->bio->bi_integrity->bip_iter;
    19			iter->bvec = iter->bio->bi_integrity->bip_vec;
    20		} else {
    21			iter->iter = iter->bio->bi_iter;
    22			iter->bvec = iter->bio->bi_io_vec;
    23		}
    24		return true;
    25	}
    26	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
