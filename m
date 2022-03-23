Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94777C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 00:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiCWAQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWAQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 20:16:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCF46E378
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 17:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647994478; x=1679530478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GdbhgEPHZMj7WIxYHBgfeYmYBcS8yHQZhp9NkEy1/AU=;
  b=KUGzZrodVbp4v9VE/ztxAzL+37Xp1dyUW/0g9MBpdS5Hj5Ca4EK/hMKs
   RuarDPsBSP95cYfzOjZehTNqav7b9D+5Y8ufCp7dnGMPnKNIoIPPU8iGQ
   mMry9wwMIV2LJpiLrzI3JZrhLo0B+Z1N+19B/kK45dlNgX4nso//m3t/4
   rCaeWO6COvNi5A8tTQvJNwanQwccgNYIAGEfDNVMcbCMY4VEOv0qxaF0L
   1lJyf1ko4UUhtIFCQrmz6vMvMWaaQK/mjWCWXA7JPQBUVFqrp7n4SLfHy
   DIxW4Jw6ChSu6H07p0T5pCv4tFTMizHYvIyI9BwvZsa9hYvRLIp8bT/5F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="238591415"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="238591415"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 17:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="500807058"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2022 17:14:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWoe3-000JRj-Fu; Wed, 23 Mar 2022 00:14:35 +0000
Date:   Wed, 23 Mar 2022 08:13:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: avoid to call blkg_free() in atomic context
Message-ID: <202203230833.LMKQ6DdX-lkp@intel.com>
References: <20220322161238.2006448-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322161238.2006448-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.17 next-20220322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lei/block-avoid-to-call-blkg_free-in-atomic-context/20220323-001434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-a005-20220321 (https://download.01.org/0day-ci/archive/20220323/202203230833.LMKQ6DdX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c40ac630dd1d94497e427b4933efad4dbfaa0b5b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ming-Lei/block-avoid-to-call-blkg_free-in-atomic-context/20220323-001434
        git checkout c40ac630dd1d94497e427b4933efad4dbfaa0b5b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/blk-cgroup.c:75: warning: Function parameter or member 'work' not described in 'blkg_free_workfn'
>> block/blk-cgroup.c:75: warning: expecting prototype for blkg_free(). Prototype was for blkg_free_workfn() instead


vim +75 block/blk-cgroup.c

a2b1693bac45ea Tejun Heo 2012-04-13  67  
0381411e4b1a52 Tejun Heo 2012-03-05  68  /**
0381411e4b1a52 Tejun Heo 2012-03-05  69   * blkg_free - free a blkg
0381411e4b1a52 Tejun Heo 2012-03-05  70   * @blkg: blkg to free
0381411e4b1a52 Tejun Heo 2012-03-05  71   *
0381411e4b1a52 Tejun Heo 2012-03-05  72   * Free @blkg which may be partially allocated.
0381411e4b1a52 Tejun Heo 2012-03-05  73   */
c40ac630dd1d94 Ming Lei  2022-03-23  74  static void blkg_free_workfn(struct work_struct *work)
0381411e4b1a52 Tejun Heo 2012-03-05 @75  {
c40ac630dd1d94 Ming Lei  2022-03-23  76  	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
c40ac630dd1d94 Ming Lei  2022-03-23  77  					     free_work);
e8989fae38d983 Tejun Heo 2012-03-05  78  	int i;
549d3aa872cd1a Tejun Heo 2012-03-05  79  
549d3aa872cd1a Tejun Heo 2012-03-05  80  	if (!blkg)
549d3aa872cd1a Tejun Heo 2012-03-05  81  		return;
549d3aa872cd1a Tejun Heo 2012-03-05  82  
db61367038dcd2 Tejun Heo 2013-05-14  83  	for (i = 0; i < BLKCG_MAX_POLS; i++)
001bea73e70efd Tejun Heo 2015-08-18  84  		if (blkg->pd[i])
001bea73e70efd Tejun Heo 2015-08-18  85  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
e8989fae38d983 Tejun Heo 2012-03-05  86  
0a9a25ca78437b Ming Lei  2022-03-18  87  	if (blkg->q)
0a9a25ca78437b Ming Lei  2022-03-18  88  		blk_put_queue(blkg->q);
f73316482977ac Tejun Heo 2019-11-07  89  	free_percpu(blkg->iostat_cpu);
ef069b97feec11 Tejun Heo 2019-06-13  90  	percpu_ref_exit(&blkg->refcnt);
549d3aa872cd1a Tejun Heo 2012-03-05  91  	kfree(blkg);
0381411e4b1a52 Tejun Heo 2012-03-05  92  }
0381411e4b1a52 Tejun Heo 2012-03-05  93  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
