Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F23381B9
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745693; cv=none; b=IMLrgfo87XjcQawbtaejGp4CY4miUZTViXQhoGxJ9aXvZdDP6CQ/3b/Zn/KpWwvRXjCbjbFAZw/CYp6wZHAoj0AnnALRcMBm3I5NLQ+AukbImAmUfhT698FODuzKus/ThXCaxtjR8HQJVOd/htYKFnks/86C/4C7y4dBiFbIV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745693; c=relaxed/simple;
	bh=i4o5o8/E/agz++Q0onYaGr6q+aONflbBNmjrrJGqeJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOp6a7tcXzZlMOxGHVcK7HSSY5/w+kU82oxK6H22h95oKwMpZ10Y+p90nrPbzrxyaYQEa45OLMXUC3F74vz//l2ukHnnMOku2NELYRf0kr4uMSwkdekVzD/mxVKwwVM7bmo/XK+hLH9YFH17Sj9dAYOeOocf+VUe7ijfC0/FYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktb+spZq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktb+spZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715745690; x=1747281690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i4o5o8/E/agz++Q0onYaGr6q+aONflbBNmjrrJGqeJ8=;
  b=ktb+spZqEOR6TiK5oUxo/NueFaQk9GMB45pPH/uWwQBwJSUuXVPzoTi8
   rPiUR4ntMh5iGbfHUvUG3+UnwSTO/n23hMMY1ijTMC9YlMBlkIATDKLlS
   jwD4dleQ7gcq+B1Ysq9SzDnMjKgzpVvpdZ6HH3X1NT9n+WFSb4WBv2zN8
   6cVeirmZyTKs2phQzwTJBC7rxaRsvBXz3n2tjUHrCdE1QdBgMfhLOl0UZ
   llziJdk7lteEJDm1/GjdICo4w9T3qyx5qWvZgv1UHTSLmz1oT4LKs+Ex9
   XN65shT0GaO8oaiLnCKOyoXF8RjMNYrML0Mj3uI/VoatwLLOZbXK9IeCA
   g==;
X-CSE-ConnectionGUID: ybSd1JI8RouVIaSq2nGs8g==
X-CSE-MsgGUID: MvhohhJcSo60mWtZjW2iNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15605254"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="15605254"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 21:01:23 -0700
X-CSE-ConnectionGUID: eoBQM39LSJ2YM2c1j8zSrg==
X-CSE-MsgGUID: 3rlZ+wnqQrCLAeRrJQSEJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="31330119"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 May 2024 21:01:20 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s75pO-000COd-0o;
	Wed, 15 May 2024 04:01:18 +0000
Date: Wed, 15 May 2024 12:00:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 5/6] block/bdev: lift restrictions on supported blocksize
Message-ID: <202405151142.8COQSJsa-lkp@intel.com>
References: <20240514173900.62207-6-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514173900.62207-6-hare@kernel.org>

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
patch link:    https://lore.kernel.org/r/20240514173900.62207-6-hare%40kernel.org
patch subject: [PATCH 5/6] block/bdev: lift restrictions on supported blocksize
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240515/202405151142.8COQSJsa-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405151142.8COQSJsa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405151142.8COQSJsa-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/bdev.c: In function 'set_init_blocksize':
   block/bdev.c:145:9: error: implicit declaration of function 'mapping_set_folio_min_order' [-Werror=implicit-function-declaration]
     145 |         mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   block/bdev.c: In function 'set_blocksize':
>> block/bdev.c:152:23: error: 'bs' undeclared (first use in this function); did you mean 'abs'?
     152 |         if (get_order(bs) > MAX_PAGECACHE_ORDER || size < 512 ||
         |                       ^~
         |                       abs
   block/bdev.c:152:23: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +152 block/bdev.c

   148	
   149	int set_blocksize(struct block_device *bdev, int size)
   150	{
   151		/* Size must be a power of two, and between 512 and MAX_PAGECACHE_ORDER*/
 > 152		if (get_order(bs) > MAX_PAGECACHE_ORDER || size < 512 ||
   153		    !is_power_of_2(size))
   154			return -EINVAL;
   155	
   156		/* Size cannot be smaller than the size supported by the device */
   157		if (size < bdev_logical_block_size(bdev))
   158			return -EINVAL;
   159	
   160		/* Don't change the size if it is same as current */
   161		if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
   162			sync_blockdev(bdev);
   163			bdev->bd_inode->i_blkbits = blksize_bits(size);
   164			mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
   165						    get_order(size));
   166			kill_bdev(bdev);
   167		}
   168		return 0;
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
