Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34837C43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 00:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiFVAu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 20:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFVAu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 20:50:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477462F65A
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 17:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655859025; x=1687395025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Hzxa5kAbBP5oy/J4Hf70NoMQ0qZyFE3jEVrULhaCJM=;
  b=USbq+Yfam4maYXsKJrtf8UNCPQILghleApDxlCaFXRcIxeDiMAW0s5LW
   CPpANgJrMV/sm+jOzVVQ7SaE6wPgUCYwo47otx5TRdGw93vd2TZTI+fMt
   cHELeOLw42CmfsdxHiw2TTOC+aYl1PAYR1fq4fZhywh3bLqOdiTNd6490
   k8uCYukutHFHezt9TrEwG82haXLCG+bsCzPtE0fGaot+wZN42W5gxX+8O
   jOUuiluXg8ThQ0edCIzxFMz4X1EqXujej9n1jYle9a0mm4fOHxol4K9jH
   zNUdEvTjdchCHP4FIBmy8sFCrVpHmBEbSiVXh9luigJQeaNi4f/TERCZt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281349092"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="281349092"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="614952396"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2022 17:50:22 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3oZZ-0000dD-EV;
        Wed, 22 Jun 2022 00:50:21 +0000
Date:   Wed, 22 Jun 2022 08:50:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Message-ID: <202206220810.R6I8vpfk-lkp@intel.com>
References: <20220621102455.13183-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621102455.13183-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.19-rc3 next-20220621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/block-Fix-IO-priority-mess/20220621-183235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20220622/202206220810.R6I8vpfk-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8421c851d4fe5f4b9d9d6870ada8ccd0b48a4012
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/block-Fix-IO-priority-mess/20220621-183235
        git checkout 8421c851d4fe5f4b9d9d6870ada8ccd0b48a4012
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:23,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> arch/riscv/include/asm/current.h:34:17: warning: passing argument 1 of '__get_task_ioprio' makes integer from pointer without a cast [-Wint-conversion]
      34 | #define current get_current()
         |                 ^~~~~~~~~~~~~
         |                 |
         |                 struct task_struct *
   include/linux/ioprio.h:60:34: note: in expansion of macro 'current'
      60 |         return __get_task_ioprio(current);
         |                                  ^~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/ioprio.h:52:41: note: expected 'int' but argument is of type 'struct task_struct *'
      52 | static inline int __get_task_ioprio(int ioprio)
         |                                     ~~~~^~~~~~
--
   In file included from include/linux/thread_info.h:23,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from arch/riscv/include/asm/mmiowb.h:12,
                    from arch/riscv/include/asm/mmio.h:15,
                    from arch/riscv/include/asm/clint.h:10,
                    from arch/riscv/include/asm/timex.h:15,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/clk/clkdev.c:9:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> arch/riscv/include/asm/current.h:34:17: warning: passing argument 1 of '__get_task_ioprio' makes integer from pointer without a cast [-Wint-conversion]
      34 | #define current get_current()
         |                 ^~~~~~~~~~~~~
         |                 |
         |                 struct task_struct *
   include/linux/ioprio.h:60:34: note: in expansion of macro 'current'
      60 |         return __get_task_ioprio(current);
         |                                  ^~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/compat.h:17,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from drivers/clk/clkdev.c:9:
   include/linux/ioprio.h:52:41: note: expected 'int' but argument is of type 'struct task_struct *'
      52 | static inline int __get_task_ioprio(int ioprio)
         |                                     ~~~~^~~~~~
   drivers/clk/clkdev.c: In function 'vclkdev_alloc':
   drivers/clk/clkdev.c:173:17: warning: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     173 |                 vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
         |                 ^~~~~~~~~~
--
   In file included from include/linux/thread_info.h:23,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> arch/riscv/include/asm/current.h:34:17: warning: passing argument 1 of '__get_task_ioprio' makes integer from pointer without a cast [-Wint-conversion]
      34 | #define current get_current()
         |                 ^~~~~~~~~~~~~
         |                 |
         |                 struct task_struct *
   include/linux/ioprio.h:60:34: note: in expansion of macro 'current'
      60 |         return __get_task_ioprio(current);
         |                                  ^~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/ioprio.h:52:41: note: expected 'int' but argument is of type 'struct task_struct *'
      52 | static inline int __get_task_ioprio(int ioprio)
         |                                     ~~~~^~~~~~


vim +/__get_task_ioprio +34 arch/riscv/include/asm/current.h

7db91e57a0acde Palmer Dabbelt 2017-07-10  33  
7db91e57a0acde Palmer Dabbelt 2017-07-10 @34  #define current get_current()
7db91e57a0acde Palmer Dabbelt 2017-07-10  35  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
