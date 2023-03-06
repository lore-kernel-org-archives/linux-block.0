Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7140C64EC4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 16:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFQMM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjCFQJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 11:09:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746D3CE38
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678118747; x=1709654747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PCa9V1N75id5GSrVTMlEG2cvhZe7atD9OfJGwcHX1j0=;
  b=mZs6MwjH3Y9/S4cLWn/vNXNsMjpyFDuSu8HzMV2fZgSw6/UjTML/F0ke
   IskImfwlVkML3Mj47Cs+fFqb3U2397sN+dDhcVYxO3ilLR/tf0UppOrd+
   9bqPkWxp33Cyqu9Ev+pi9o722A7voR9oW21vXyLJXcaA12BM8ahn7dDMh
   HtuZdILa8Vk97iffHAoO/N3JIOnVETgSk9FGqIh8Nvu5Fghq/CWvMObJJ
   W/uQ3Hox48kDkgqoYG7fEVMCL6DthX4l5ArZgI6x6ad+O/JAnH1QwAqDt
   H1LzJg5rXVZHSTNQtfd4ctx/ZsHXTLv+OixfDdjQSfiVUak3IZlCiCfK1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337110137"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="337110137"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="765269433"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="765269433"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Mar 2023 08:04:26 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZDK5-0000Rv-2b;
        Mon, 06 Mar 2023 16:04:25 +0000
Date:   Tue, 7 Mar 2023 00:04:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/5] brd: convert to folios
Message-ID: <202303062339.fe53AMz1-lkp@intel.com>
References: <20230306120127.21375-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-2-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hannes,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/brd-convert-to-folios/20230306-200223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230306120127.21375-2-hare%40suse.de
patch subject: [PATCH 1/5] brd: convert to folios
config: hexagon-randconfig-r045-20230306 (https://download.01.org/0day-ci/archive/20230306/202303062339.fe53AMz1-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b29fb9873ddbb2efb157e5d6548abf3c88b3458c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hannes-Reinecke/brd-convert-to-folios/20230306-200223
        git checkout b29fb9873ddbb2efb157e5d6548abf3c88b3458c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303062339.fe53AMz1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/block/brd.c:17:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/block/brd.c:17:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/block/brd.c:17:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/block/brd.c:325:8: error: call to undeclared function 'brd_do_bvec'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = brd_do_bvec(brd, page, PAGE_SIZE, 0, op, sector);
                 ^
   6 warnings and 1 error generated.


vim +/brd_do_bvec +325 drivers/block/brd.c

9db5579be4bb53 Nicholas Piggin 2008-02-08  316  
a72132c31d5809 Matthew Wilcox  2014-06-04  317  static int brd_rw_page(struct block_device *bdev, sector_t sector,
86947df3a92364 Bart Van Assche 2022-07-14  318  		       struct page *page, enum req_op op)
a72132c31d5809 Matthew Wilcox  2014-06-04  319  {
a72132c31d5809 Matthew Wilcox  2014-06-04  320  	struct brd_device *brd = bdev->bd_disk->private_data;
98cc093cba1e92 Huang Ying      2017-09-06  321  	int err;
98cc093cba1e92 Huang Ying      2017-09-06  322  
98cc093cba1e92 Huang Ying      2017-09-06  323  	if (PageTransHuge(page))
98cc093cba1e92 Huang Ying      2017-09-06  324  		return -ENOTSUPP;
3f289dcb4b2654 Tejun Heo       2018-07-18 @325  	err = brd_do_bvec(brd, page, PAGE_SIZE, 0, op, sector);
3f289dcb4b2654 Tejun Heo       2018-07-18  326  	page_endio(page, op_is_write(op), err);
a72132c31d5809 Matthew Wilcox  2014-06-04  327  	return err;
a72132c31d5809 Matthew Wilcox  2014-06-04  328  }
a72132c31d5809 Matthew Wilcox  2014-06-04  329  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
