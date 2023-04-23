Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C8C6FD18
	for <linux-block@archiver.kernel.org>; Sun, 23 Apr 2023 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDWQfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Apr 2023 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWQfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2023 12:35:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39CBE76
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682267716; x=1713803716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWz9rtPgJTTHL93sX+efb11H9SigKy4vznwwIU2qdhc=;
  b=fNLpMrNLwR25VfmELWyx4eikQi1s2ddkFrewYGvPUSluDpEvsGRnFNIL
   SBjAh5NA9mgSu/Vil/hZhwer/lH9FsLJRm0UuKTTCtROPSEkEE1uEJV4v
   4JcLtJ+81QRxknV/642Is01Io62VzM7qYoT0KOC+lG0Dril5E278DWe/b
   a3OORnrAnasxE2a1Xj8PNSov+roFGSbVDKs563lvTxwKmK013eUYJQkzG
   9LXbvhcZK+VTijes+xHYhVA5OFuh3M32kEgdoy0f4JYxAF3DjN+SBq0eL
   2ZihPddymTJ7S6xeH8PkkOxlJnG5cqQ/92fGLLXW4RZyy33cWpbALwLq/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="349095261"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="349095261"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 09:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686471140"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="686471140"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2023 09:35:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqcgC-000hyO-0H;
        Sun, 23 Apr 2023 16:35:12 +0000
Date:   Mon, 24 Apr 2023 00:34:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, martin.petersen@oracle.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
        israelr@nvidia.com, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v1 1/2] block: bio-integrity: export bio_integrity_free
 func
Message-ID: <202304240037.LakzPMU9-lkp@intel.com>
References: <20230423141330.40437-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423141330.40437-2-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on hch-configfs/for-next linus/master v6.3-rc7 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Gurtovoy/block-bio-integrity-export-bio_integrity_free-func/20230423-222054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230423141330.40437-2-mgurtovoy%40nvidia.com
patch subject: [PATCH v1 1/2] block: bio-integrity: export bio_integrity_free func
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230424/202304240037.LakzPMU9-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1459ddb310ef47b008de7669cc2c57e02edf4edb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Max-Gurtovoy/block-bio-integrity-export-bio_integrity_free-func/20230423-222054
        git checkout 1459ddb310ef47b008de7669cc2c57e02edf4edb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304240037.LakzPMU9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/libnvdimm.h:14,
                    from arch/powerpc/lib/pmem.c:9:
>> include/linux/bio.h:768:6: error: no previous prototype for 'bio_integrity_free' [-Werror=missing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/bio_integrity_free +768 include/linux/bio.h

   767	
 > 768	void bio_integrity_free(struct bio *bio)
   769	{
   770	}
   771	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
