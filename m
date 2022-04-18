Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3529C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 22:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiDRXBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 19:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiDRXBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 19:01:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F1C2D1FF
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650322746; x=1681858746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7PLccr/Upm/I6pl/4kUES8CA5eoxBQ2Zn3L36OtMuzo=;
  b=QPH0oQB+PSoUjCLMYsiZRNCOw33+y7Zrx/Uf6OfQADvaNKbDx38xB/fK
   6pny6bOFQNbQCK9tdCNtk8dgchsdjROOrUpxyldYeRFaeJG/lCTYQjPVB
   boPd71vGPrzjVw1s7qVqBGeuaybowCz1g9MDTqu7QcdLeHVGh4HyaZeCZ
   f4DK4ycrPyfmzOUlJxIHzzAH4pzatp9jucevsbBbcQ5FHkgl6iI5BCA1T
   WHvMY8jtvijD210TDeqjAwYkrIFyWm1GI4R8saSIVAh71HWXGKOWYAwJX
   rr+7e6/CCfjba4TxMmjybL2BQ0+kOcPneF0mQWXswgdUVtvi5TBl/BuoT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350077665"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350077665"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 15:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="509912649"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2022 15:59:04 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngaKl-00054E-Aj;
        Mon, 18 Apr 2022 22:59:03 +0000
Date:   Tue, 19 Apr 2022 06:58:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Justin Sanders <justin@coraid.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] aoe: Avoid flush_scheduled_work() usage
Message-ID: <202204190659.PmftNpOE-lkp@intel.com>
References: <9d1759e0-2f93-d49f-48b3-12b8d47e95cd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1759e0-2f93-d49f-48b3-12b8d47e95cd@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/aoe-Avoid-flush_scheduled_work-usage/20220418-231118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arc-randconfig-r023-20220419 (https://download.01.org/0day-ci/archive/20220419/202204190659.PmftNpOE-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b1ae05b7bd5a2a2abad4aba03f55e7f4b4599789
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tetsuo-Handa/aoe-Avoid-flush_scheduled_work-usage/20220418-231118
        git checkout b1ae05b7bd5a2a2abad4aba03f55e7f4b4599789
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: drivers/block/aoe/aoeblk.o: in function `queue_work':
>> include/linux/workqueue.h:502: undefined reference to `aoe_wq'
>> arceb-elf-ld: include/linux/workqueue.h:502: undefined reference to `aoe_wq'
   arceb-elf-ld: drivers/block/aoe/aoecmd.o: in function `queue_work':
>> include/linux/workqueue.h:502: undefined reference to `aoe_wq'
>> arceb-elf-ld: include/linux/workqueue.h:502: undefined reference to `aoe_wq'
   arceb-elf-ld: drivers/block/aoe/aoedev.o: in function `flush':
>> drivers/block/aoe/aoedev.c:324: undefined reference to `aoe_wq'
   arceb-elf-ld: drivers/block/aoe/aoedev.o:drivers/block/aoe/aoedev.c:324: more undefined references to `aoe_wq' follow


vim +502 include/linux/workqueue.h

dcd989cb73ab0f Tejun Heo    2010-06-29  475  
8425e3d5bdbe8e Tejun Heo    2013-03-13  476  /**
8425e3d5bdbe8e Tejun Heo    2013-03-13  477   * queue_work - queue work on a workqueue
8425e3d5bdbe8e Tejun Heo    2013-03-13  478   * @wq: workqueue to use
8425e3d5bdbe8e Tejun Heo    2013-03-13  479   * @work: work to queue
8425e3d5bdbe8e Tejun Heo    2013-03-13  480   *
8425e3d5bdbe8e Tejun Heo    2013-03-13  481   * Returns %false if @work was already on a queue, %true otherwise.
8425e3d5bdbe8e Tejun Heo    2013-03-13  482   *
8425e3d5bdbe8e Tejun Heo    2013-03-13  483   * We queue the work to the CPU on which it was submitted, but if the CPU dies
8425e3d5bdbe8e Tejun Heo    2013-03-13  484   * it can be processed by another CPU.
dbb92f88648d62 Andrea Parri 2020-01-22  485   *
dbb92f88648d62 Andrea Parri 2020-01-22  486   * Memory-ordering properties:  If it returns %true, guarantees that all stores
dbb92f88648d62 Andrea Parri 2020-01-22  487   * preceding the call to queue_work() in the program order will be visible from
dbb92f88648d62 Andrea Parri 2020-01-22  488   * the CPU which will execute @work by the time such work executes, e.g.,
dbb92f88648d62 Andrea Parri 2020-01-22  489   *
dbb92f88648d62 Andrea Parri 2020-01-22  490   * { x is initially 0 }
dbb92f88648d62 Andrea Parri 2020-01-22  491   *
dbb92f88648d62 Andrea Parri 2020-01-22  492   *   CPU0				CPU1
dbb92f88648d62 Andrea Parri 2020-01-22  493   *
dbb92f88648d62 Andrea Parri 2020-01-22  494   *   WRITE_ONCE(x, 1);			[ @work is being executed ]
dbb92f88648d62 Andrea Parri 2020-01-22  495   *   r0 = queue_work(wq, work);		  r1 = READ_ONCE(x);
dbb92f88648d62 Andrea Parri 2020-01-22  496   *
dbb92f88648d62 Andrea Parri 2020-01-22  497   * Forbids: r0 == true && r1 == 0
8425e3d5bdbe8e Tejun Heo    2013-03-13  498   */
8425e3d5bdbe8e Tejun Heo    2013-03-13  499  static inline bool queue_work(struct workqueue_struct *wq,
8425e3d5bdbe8e Tejun Heo    2013-03-13  500  			      struct work_struct *work)
8425e3d5bdbe8e Tejun Heo    2013-03-13  501  {
8425e3d5bdbe8e Tejun Heo    2013-03-13 @502  	return queue_work_on(WORK_CPU_UNBOUND, wq, work);
8425e3d5bdbe8e Tejun Heo    2013-03-13  503  }
8425e3d5bdbe8e Tejun Heo    2013-03-13  504  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
