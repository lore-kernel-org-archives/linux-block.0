Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3517335C0
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715404072; cv=none; b=btRLMt+Hkf4o8eDZpl3YlJBJjXVC8IFeeFxFajcpppZj6s3EAYpO6SkSkS8H3tNC9p9Lu84UX8979LujFSu6nixmS2jHOG4Ak1mInimaz0yQfMfHI/Sj40mlT39CyNEC6Wg3frUj2aYK9V1t//p/TVS7jtKM9igtgeXsbDn4NlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715404072; c=relaxed/simple;
	bh=AhuGySNFVnhWhalL8yrD18z/SpIq1B3xcXvrRhoNlFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3o8vd9mqTBRGXAS0lmVFfASYJP9vgUmiVvkMQ6GYMSkcu7com3k2+StKaXF8epbvd2ljg3Qp0RqMMobwegoLF8fZYlKhKEj2FsRRr2eAFlfzM7Dnyj5ztN4V/Ek74Wg+oYmiXpAJOoPxYC8xTzeOses83yyoOblrbCnXBAMXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNcSfH3n; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNcSfH3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715404070; x=1746940070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhuGySNFVnhWhalL8yrD18z/SpIq1B3xcXvrRhoNlFY=;
  b=ZNcSfH3nDPZgNHU4S3N7H4cOJalhoK8vMj1sFaAKXXAwN8b5QlKd0dU/
   4f3q2ZQ02TH//ka3uYuK1gEM2f0MKXCeiKWbSIvFT1QDgdz+DQGY650nj
   BZwz4T26r0Sg83RKuHGei0Hf4k2zcn/lAHsR2ZG7uCAQ2jBduIPtg9gZZ
   oz03PquDm55CjggVqnSET12GBhb6ooYXG6R/xFupgBpUjqNOZ/ItBFUwt
   EWXBCvYdFxeZrOVYgWNIfZNS4kAQp41uLDeOU4tty12oWsRjsZ/MLWeSr
   KZvZKODVpNZU0C0NZ0wHtP4llpb+48gf/gAUEsBsgdFiyIp1RvIYFuQrd
   g==;
X-CSE-ConnectionGUID: LBGvwpNjQZaFAe6VlrWkOg==
X-CSE-MsgGUID: 71pYcrr9QmG6QdevPlVqVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22804986"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="22804986"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:07:50 -0700
X-CSE-ConnectionGUID: X0NDfPKSRN6tw7QcZhAsog==
X-CSE-MsgGUID: T6Ukoa2yQKGF6t5NFw+a6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="29835654"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 May 2024 22:07:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5exV-0006xb-0T;
	Sat, 11 May 2024 05:07:45 +0000
Date: Sat, 11 May 2024 13:07:08 +0800
From: kernel test robot <lkp@intel.com>
To: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/5] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <202405111234.wXN5f0fB-lkp@intel.com>
References: <20240510102906.51844-5-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-5-hare@kernel.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.9-rc7]
[cannot apply to next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hare-kernel-org/fs-mpage-use-blocks_per_folio-instead-of-blocks_per_page/20240510-183146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240510102906.51844-5-hare%40kernel.org
patch subject: [PATCH 4/5] block/bdev: enable large folio support for large logical block sizes
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240511/202405111234.wXN5f0fB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111234.wXN5f0fB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111234.wXN5f0fB-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/bdev.c: In function 'set_init_blocksize':
>> block/bdev.c:145:9: error: implicit declaration of function 'mapping_set_folio_min_order' [-Werror=implicit-function-declaration]
     145 |         mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
