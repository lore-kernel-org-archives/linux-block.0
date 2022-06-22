Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D2C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 01:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355450AbiFVBlj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 21:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiFVBli (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 21:41:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3B31511
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655862096; x=1687398096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TI0qxXJYU04o+VPhEDdU2KkAmGKtZmmgZVDd0z+UqMo=;
  b=VyQKiz54WY8l98G+EtSymDzvSAOCH0ikBOAu/jm5Bwy5eMlx29tuYO1y
   FyYugAEKPUEueTkffc8aumLn5b2XMnLueaqTn8N1TsXsS86x2naYBHic/
   ge7K3AY5zkzEWyYMAcne2sD7v+LXYVG2djJ3ntc6gBN2AxjR1m70uOcHP
   2CIv57RtOvF7meWjQRTc0SpfCiTH+WVDSLns3Gt520cC+ughsgrB1FRlg
   eSsrxTAKybZb5/LPPzy/efJ/f4Qe1UVimhGZjKSsFLXtQHR3mWxpZtpeD
   e5KiLaOAbNpWK8zqtHnR+8R4/Lxvb/k5GLEaxnUGPt+MzHAj2j8aHI9QH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="279053015"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="279053015"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 18:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="586561184"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2022 18:41:23 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3pMx-0000fh-14;
        Wed, 22 Jun 2022 01:41:23 +0000
Date:   Wed, 22 Jun 2022 09:41:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Message-ID: <202206220956.wXt005QG-lkp@intel.com>
References: <20220621102455.13183-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621102455.13183-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v5.19-rc3 next-20220621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/block-Fix-IO-priority-mess/20220621-183235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: s390-randconfig-r021-20220622 (https://download.01.org/0day-ci/archive/20220622/202206220956.wXt005QG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8421c851d4fe5f4b9d9d6870ada8ccd0b48a4012
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/block-Fix-IO-priority-mess/20220621-183235
        git checkout 8421c851d4fe5f4b9d9d6870ada8ccd0b48a4012
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/test_bitops.c:9:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:160:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:38:
>> include/linux/ioprio.h:60:27: error: incompatible pointer to integer conversion passing 'struct task_struct *' to parameter of type 'int' [-Werror,-Wint-conversion]
           return __get_task_ioprio(current);
                                    ^~~~~~~
   arch/s390/include/asm/current.h:17:17: note: expanded from macro 'current'
   #define current ((struct task_struct *const)S390_lowcore.current_task)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ioprio.h:52:41: note: passing argument to parameter 'ioprio' here
   static inline int __get_task_ioprio(int ioprio)
                                           ^
   1 error generated.


vim +60 include/linux/ioprio.h

    57	
    58	static inline int get_current_ioprio(void)
    59	{
  > 60		return __get_task_ioprio(current);
    61	}
    62	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
