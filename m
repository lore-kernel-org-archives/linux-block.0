Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDAF9E9
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735053; cv=none; b=CStTDwBhB3cfn5A+pU43y06dF2BnDZRgozQUp327YVYEn2OexDN1oPENiqTYY6V0/rAygmJBpcmDVAOiHXBsuauEdO4ZmEIgmvGWQz9MY0Ab9XAfYKa2BKU3L9lnE1SeBvTbIp0+arQFjlg8MykxbbjxGV/s+juHvpJ5h1uptfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735053; c=relaxed/simple;
	bh=JR0EyROUPsAs/gj4aRFKaKKp/XxKJGSvUQck05tirXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+UU/QpboI9gAxkgLY3JAWs9TS0qrwukRmRRwHRuaf0Rbg8u62dvkSJkuWJzSj4e7JlTENQocycDJzaNhIdnCCfP8CXVf6vS+9u036gKmb2lBYii/RxkeBDTc0gA7zonYLuBsiEIQzaS0kYzUV5qOvSVxLAmwJd1CS4pwLc6thY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7M0+NtJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7M0+NtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715735052; x=1747271052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JR0EyROUPsAs/gj4aRFKaKKp/XxKJGSvUQck05tirXY=;
  b=b7M0+NtJYn/MnUdPybIfVMUGP4RW7aWrLbTVsmm2PlTj+vClGXlII55d
   ihAEiXsq8nZXmVC+01weW+k7ZEyN68e92K5y97PaIBVxPsZhtDQ4XePDI
   82N9/KfPEQIAE2rMHzLrG5XcnZfINGwzhWhcnSHITfvudVBMtQl8xa1I2
   vI4LSw652kutijqXb8Duq+RRDH26JeOTFfsf9IFdqox4K0Gu3jQp5U0Nc
   3wWz5zUmZNMfDYdGHBtgpyOFtKodGXAsbwHA4qVVjxOH884mnWxty4Xni
   bvGi+6iqlvNf05IE7cNrrecplh/1fXnzA+BSbcTLMML/B34DAc+X915KP
   g==;
X-CSE-ConnectionGUID: gz034bQ8Qp+T34EVDN7W3Q==
X-CSE-MsgGUID: AgqoHIDpTnuywc28kk55Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11614522"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="11614522"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 18:04:11 -0700
X-CSE-ConnectionGUID: SdpTbBksTFazk3jzjJepSA==
X-CSE-MsgGUID: Drlff/oITP2CaBqvcdteBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="30943297"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 May 2024 18:04:08 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s733u-000CBL-1S;
	Wed, 15 May 2024 01:04:06 +0000
Date: Wed, 15 May 2024 09:03:41 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 5/6] block/bdev: lift restrictions on supported blocksize
Message-ID: <202405150852.LoiNtqk4-lkp@intel.com>
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
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240515/202405150852.LoiNtqk4-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405150852.LoiNtqk4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405150852.LoiNtqk4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/bdev.c:9:
   In file included from include/linux/mm.h:2210:
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
   block/bdev.c:145:2: error: call to undeclared function 'mapping_set_folio_min_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     145 |         mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |         ^
>> block/bdev.c:152:16: error: use of undeclared identifier 'bs'
     152 |         if (get_order(bs) > MAX_PAGECACHE_ORDER || size < 512 ||
         |                       ^
   block/bdev.c:164:3: error: call to undeclared function 'mapping_set_folio_min_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     164 |                 mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |                 ^
   13 warnings and 3 errors generated.


vim +/bs +152 block/bdev.c

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
