Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70C1CD2F
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199388; cv=none; b=Dn0uNgTYi2jY6Ffy8LemAdo2kbui/vLvzo4724YjbKkz4vipx8lulkCjcZTvPrDhb2hed1TXEDY5V1BvlMXt2YMmAd5tzPY8zqENqwlq178A1GYJ1l21BDVY35ugfUKC2zsZ7T14wyYkoPNUTJm+rOBVsvC30O1CCF1sWyfkZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199388; c=relaxed/simple;
	bh=iZ3B+Y3kGLvbRC1vtgiD3hn88kEkWmHYb5d0DaFyzRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma9d7BGOUGEPyTZeJ/FOuHs6oLnPy4fZ2EcZFBFHnOR+et4Eez0xHdqcrGyK+IV/y+Jinj+dxfk24IpgsR8/ohzeQ3/kPK0u32UFQ9GaT7BDQ6BZamt80zRi1QNPwJSqRmwuD8MydYfPEmgjHyUWUotrBLPoA3Kd5Evy1esD1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PC+Ddkz3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PC+Ddkz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712199387; x=1743735387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZ3B+Y3kGLvbRC1vtgiD3hn88kEkWmHYb5d0DaFyzRk=;
  b=PC+Ddkz3qxcIsCPALx36V6qoGImY7r9xr2Gsa8kbLOwAT1siovRNzDrH
   sQ79LpYXnYDgYnx9dbbpDgm8UmSEL8sXR0VbGDEgpb9GVC1AX1cBQhdRU
   9vq3CN69g6sPyup0l21DOvoMUQPqf1Qkd0+H+nmCbLYcSJf+iZpCSAloQ
   GoYoD5imt2IwgX9YLicoRbId+Xs7NdXGPYAqas8Cy+IphZmQeXn2Or3l+
   U3gSThTMzmZEaE5Rap3DVqPg/vb2I58GA2XvQZpE3UXNvDz6XPEYs+ft5
   OntXYBJu3ahqWRSWHDODmFF3kSSM1YsY2etApCy8oeoVtuBzes272+f6p
   g==;
X-CSE-ConnectionGUID: GywWnpeHQR2wqLPXy/+UQQ==
X-CSE-MsgGUID: DVFK1ZP8R3GEtUIcRAWoeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7321321"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7321321"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 19:56:26 -0700
X-CSE-ConnectionGUID: rlCLA8E1ReqDLCu14DKmBQ==
X-CSE-MsgGUID: fQJ5gaW4QcWFE2DzzaqJxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="49587626"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Apr 2024 19:56:23 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsDH2-0000Wk-2L;
	Thu, 04 Apr 2024 02:56:20 +0000
Date: Thu, 4 Apr 2024 10:55:25 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202404041045.bLSpHDFH-lkp@intel.com>
References: <20240403141756.88233-2-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-2-hare@kernel.org>

Hi Hannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.9-rc2 next-20240403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240403-222254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240403141756.88233-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240404/202404041045.bLSpHDFH-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 546dc2245ffc4cccd0b05b58b7a5955e355a3b27)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240404/202404041045.bLSpHDFH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404041045.bLSpHDFH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from block/bdev.c:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for function 'blk_nlat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         |     ^
   include/linux/blk-mq.h:1242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         | ^
         | static 
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^
   14 warnings and 1 error generated.


vim +/blk_nlat_latency +1242 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nlat_enable(struct gendisk *disk);
  1236	void blk_nlat_disable(struct gendisk *disk);
  1237	u64 blk_nlat_latency(struct gendisk *disk, int node);
  1238	int blk_nlat_init(struct gendisk *disk);
  1239	#else
  1240	static inline int blk_nlat_enable(struct gendisk *disk) { return 0; }
  1241	static inline void blk_nlat_disable(struct gendisk *disk) {}
> 1242	u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
