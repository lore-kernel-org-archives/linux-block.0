Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753682E7F06
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946182; cv=none; b=YhfHo47lXoYJOWav9RnHOj667BiWDufgRSPYpmhQC8B/mjsWNQBp2ZdyInthJgZ+Pp6ww4466TBjZEt4pDHghPJsOXuvaH3GshfqMaA+9j/0cTXgfNrjEneIsq0dvP1XLP1Gx0gPlTTg1nmEj9vY99YGNAJw0alQhIEQJBIlk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946182; c=relaxed/simple;
	bh=0vH2/a2V/VmECZw9K44tTUEb5rQkCM220FNYyTlA5C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/B+Da6ywCMDRACfU0ttrUdNFVNVZg2FYV3iSYKKXUS5fhnkB4BvunsLQdk0dh6nRUoayr+jdm2qe88CdtcklkI65dboQgzSbKxsdj5JhmOwU2QdvpPXjYai1zDxeL4xHGw5fhCaf533JFWC7UrPiLru9zc2bDIsvl7+D+0gW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDI55s+Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDI55s+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750946180; x=1782482180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vH2/a2V/VmECZw9K44tTUEb5rQkCM220FNYyTlA5C4=;
  b=RDI55s+QE17je5BPmTfs5/KEGcDydDOe9OIGL25uXiJ9kYmrItRZ+0qs
   v+9axcdM1S7z7iAtNyRgUD9/Ikt489cdnxGS7M5KIw0ltEbnJYgrbi3jz
   8fnXPRFujdFqYig1hOTbEoyQpwjX4vDf7LNpmC9uii1oSGaPmPgtnT8ly
   Z9mOL+uXIZkydLsrNr9FAevGRUcrvyWKuV++F6OSm0MrL+s1K6OE7pqO0
   8A9Zx7fru2oJDDb0aSt+hmvOvfNdOL4GaC7jYGIO4lCZbgtho2/iZJHA7
   TBqKunPCeVqgcBPQfsPR25L/ckWl7h94bua7lDXvNHUSqxCiv1VE2gN8O
   Q==;
X-CSE-ConnectionGUID: 05rQw4X0S+aDRI9lMNiiBw==
X-CSE-MsgGUID: hL9GImXfTySdH3iJQ8/mDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55867919"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="55867919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:56:20 -0700
X-CSE-ConnectionGUID: +PyM5SRpQpuX+koisJ8KSQ==
X-CSE-MsgGUID: Jdwi+C/aSXWmjvua9Le/Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152683922"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jun 2025 06:56:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUn5K-000U70-2O;
	Thu, 26 Jun 2025 13:56:14 +0000
Date: Thu, 26 Jun 2025 21:55:27 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	leon@kernel.org, joshi.k@samsung.com, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Message-ID: <202506262136.WXl2reWF-lkp@intel.com>
References: <20250625204445.1802483-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-1-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on next-20250626]
[cannot apply to linux-nvme/for-next hch-configfs/for-next linus/master v6.16-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/nvme-convert-metadata-mapping-to-dma-iter/20250626-044623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250625204445.1802483-1-kbusch%40meta.com
patch subject: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
config: x86_64-buildonly-randconfig-002-20250626 (https://download.01.org/0day-ci/archive/20250626/202506262136.WXl2reWF-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506262136.WXl2reWF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506262136.WXl2reWF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-integrity.c:194:19: error: use of undeclared identifier 'blk_rq_integrity_map_iter_start'
     194 | EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);
         |                   ^
   1 error generated.


vim +/blk_rq_integrity_map_iter_start +194 block/blk-integrity.c

   165	
   166	bool blk_rq_integrity_dma_map_iter_start(struct request *req,
   167			struct device *dma_dev, struct blk_dma_iter *iter)
   168	{
   169		struct bio_integrity_payload *bip = bio_integrity(req->bio);
   170		struct phys_vec vec;
   171	
   172		iter->iter.bio = req->bio;
   173		iter->iter.iter = bip->bip_iter;
   174		memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
   175		iter->status = BLK_STS_OK;
   176	
   177		if (!blk_rq_integrity_map_iter_next(req, &iter->iter, &vec))
   178			return false;
   179	
   180		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
   181					phys_to_page(vec.paddr))) {
   182		case PCI_P2PDMA_MAP_BUS_ADDR:
   183			return blk_dma_map_bus(iter, &vec);
   184		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
   185		case PCI_P2PDMA_MAP_NONE:
   186			break;
   187		default:
   188			iter->status = BLK_STS_INVAL;
   189			return false;
   190		}
   191	
   192		return blk_dma_map_direct(req, dma_dev, iter, &vec);
   193	}
 > 194	EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);
   195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
