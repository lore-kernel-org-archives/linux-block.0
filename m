Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD61C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 17:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDSRfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDSRfG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 13:35:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3B46B3
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681925702; x=1713461702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V+63/HRIM6OQU4SjsCOxWii4OO8Ny2FbAhnQKO/QFes=;
  b=JF2E+M4kB1v2teMrtqsliD1xwqGqoLl+KCIzc6DGC18NZ9KLE39E28vL
   N9muVkNsn4CFlZo8luDHQfLgLA1eKYuSXWA8F9PMlYaL7O9NRTP3sGKLU
   bWga3Zqx0ZFWx91ol5Us2uYGczVR842kp2KjsT7Y7b71hvdwSGNuf9z+q
   1L/k3r82gOQj6eQZMNxjNDRjJIQccaNPXAXaMrobdPlD82AYWzIPIQVXk
   FuKR8QUu3dpF0TT+r/XFefCQiH2Wj8Xiox+eSXbln6rqeSAhmRdpokkT+
   Yy63ou0T22131ylZ5ZXzMU2gSJ2HyHAglOBBdydyaig37m6VPyBc8bGm3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347364376"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="347364376"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 10:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="756179872"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="756179872"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2023 10:34:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppBhq-000f3o-1d;
        Wed, 19 Apr 2023 17:34:58 +0000
Date:   Thu, 20 Apr 2023 01:34:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Message-ID: <202304200122.GEFsqxFh-lkp@intel.com>
References: <20230416200930.29542-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416200930.29542-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20230418]
[cannot apply to linus/master v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/blk-mq-reflow-blk_insert_flush/20230417-051014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230416200930.29542-8-hch%40lst.de
patch subject: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush commands
config: x86_64-randconfig-a013-20230417 (https://download.01.org/0day-ci/archive/20230420/202304200122.GEFsqxFh-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c1197e1a4ff5b38b73d3ec923987ca857f5e2695
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-Hellwig/blk-mq-reflow-blk_insert_flush/20230417-051014
        git checkout c1197e1a4ff5b38b73d3ec923987ca857f5e2695
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200122.GEFsqxFh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/blk-mq.c:1461:6: warning: no previous prototype for function 'blk_flush_queue_insert' [-Wmissing-prototypes]
   void blk_flush_queue_insert(struct request *rq)
        ^
   block/blk-mq.c:1461:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void blk_flush_queue_insert(struct request *rq)
   ^
   static 
   1 warning generated.


vim +/blk_flush_queue_insert +1461 block/blk-mq.c

  1460	
> 1461	void blk_flush_queue_insert(struct request *rq)
  1462	{
  1463		struct request_queue *q = rq->q;
  1464		unsigned long flags;
  1465	
  1466		spin_lock_irqsave(&q->requeue_lock, flags);
  1467		list_add_tail(&rq->queuelist, &q->flush_list);
  1468		spin_unlock_irqrestore(&q->requeue_lock, flags);
  1469	}
  1470	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
