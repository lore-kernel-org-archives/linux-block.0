Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9A3838A
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746970; cv=none; b=bS44d/s78NgZnqJgUFPEIvNgW3/XU5dt5JkRHF+bYUutw9WO8umFIpkNqwTVeVcRYZw+niqcB948ljaLDO2hTIuH4ndtlvsh8DuB5XltsZ5pW+AC4fYzDy+sPPVHVv+e6mJ8kpNWTXancTgb6tAQNwOZ0yPtU9J3K7NQjdPcieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746970; c=relaxed/simple;
	bh=UfvTxTsJGM30yB6JUP6qcnmueYS7+adWFARHTPLXG/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrDsu6/DQJBGh9sCvNr8t2AV09PbDfYVg9829VrJ0VGmlCgKL8REvwKJM+KxTO72zUVChn9aa6HFluX5zMirmV3QG55FeuyBp3sBouhRg4buX2Vl65swMYAdv6wsAbN2hoOJBk12s0IuCplTnB+v8k7cxFrr1+4Kin2Yfu03HZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/3btKER; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/3btKER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715746969; x=1747282969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfvTxTsJGM30yB6JUP6qcnmueYS7+adWFARHTPLXG/8=;
  b=J/3btKERTG6LOfHKwIYADFMBFYTrAvi6oRvzOIpxZJncZMQwS42mIFD1
   y/mQVHna4Np5f3RYXlNms8QUVDRagc0L40zuOjO0mptkTsu1a+cp0j2q2
   /mcy5Q+M5wp/Vkq+asu52/qsXeGBUIyGm/eGG8Y7cPgMVDoUvNxmDT6h9
   uQw38zNIgh6vCfqprvf+wjp6OYo4qy4tPbQw7kYUP0IbJ+OhHwrXqs+Kh
   sD5pa1PqSjir7BiUPMuizVpqg652gEbbahDyArtdXcdJn+V3JCcI8+pOD
   7mdAhXPcYQKezcfFZt8za2kL2pH72m/TIc7eSsNqieCjysSXITm1T2zBM
   A==;
X-CSE-ConnectionGUID: K+GTLf20SYqAvVbuT45hGA==
X-CSE-MsgGUID: pZAHOfIxR9WRXKc/Wd0ajw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29292537"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29292537"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 21:22:48 -0700
X-CSE-ConnectionGUID: UfaLV5ZhQmeGHhCIH1mdFA==
X-CSE-MsgGUID: 9m3SOfKSTjW4zDwa8XcXSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="68375794"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 May 2024 21:22:46 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s769j-000CQ9-1j;
	Wed, 15 May 2024 04:22:19 +0000
Date: Wed, 15 May 2024 12:21:30 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 4/6] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <202405151219.H2vlwtc0-lkp@intel.com>
References: <20240514173900.62207-5-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514173900.62207-5-hare@kernel.org>

Hi Hannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.9]
[cannot apply to next-20240514]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/fs-mpage-avoid-negative-shift-for-large-blocksize/20240515-014146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240514173900.62207-5-hare%40kernel.org
patch subject: [PATCH 4/6] block/bdev: enable large folio support for large logical block sizes
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240515/202405151219.H2vlwtc0-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405151219.H2vlwtc0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405151219.H2vlwtc0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/bdev.c:145:2: error: call to undeclared function 'mapping_set_folio_min_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     145 |         mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |         ^
   block/bdev.c:163:3: error: call to undeclared function 'mapping_set_folio_min_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     163 |                 mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |                 ^
   2 errors generated.


vim +/mapping_set_folio_min_order +145 block/bdev.c

   133	
   134	static void set_init_blocksize(struct block_device *bdev)
   135	{
   136		unsigned int bsize = bdev_logical_block_size(bdev);
   137		loff_t size = i_size_read(bdev->bd_inode);
   138	
   139		while (bsize < PAGE_SIZE) {
   140			if (size & bsize)
   141				break;
   142			bsize <<= 1;
   143		}
   144		bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 > 145		mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
   146					    get_order(bsize));
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
