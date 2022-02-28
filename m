Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiB1SWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiB1SWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 13:22:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A54489CE0
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646071174; x=1677607174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NBJjuEjWCCHJ62pzBKGkvafYbZAfTVrb4v4jYDW/1s=;
  b=AaE3FwNqNo5xOa+bQZDPmKltqKz0BABKpWNzWBV+f5/Ym/qedy29vhA9
   +sGIXGSf/ROYqENSbJeunccwndwCKuovIPifQ55KpCPSV80mPeK/d9Knf
   UR7TA+zNQt4fCwYlfhE/dzYJFxwjjZIz0s6JAx6BhCRDoKT9xFzazz2gZ
   3gzMNbPwDEF/MboyjNtAdT2VprILqp5S7chzmtIqw2haThj23CIALZcTQ
   SQJxAjo0IMkoTLRJtAFX8Hj5Mn4/P0kCBcg006DoOSutXiCmeWX81mgHp
   LYQ+PD+oe9NbJ7tdQLl7+RAXYoTqpaIZvzpkPmxZ3DZiADa8RyOFI0rqd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251778083"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251778083"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="534545174"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 09:58:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOkHn-0007eo-FW; Mon, 28 Feb 2022 17:58:15 +0000
Date:   Tue, 1 Mar 2022 01:57:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <202203010133.JIpKpP2Z-lkp@intel.com>
References: <20220228090430.1064267-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-7-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.17-rc6 next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220228-170706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-a002-20220228 (https://download.01.org/0day-ci/archive/20220301/202203010133.JIpKpP2Z-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/176e39bc0acb20f8fd869d170b429b7253b089c4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220228-170706
        git checkout 176e39bc0acb20f8fd869d170b429b7253b089c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from block/blk-mq-debugfs-zoned.c:7:
>> block/blk-mq-debugfs.h:24:14: warning: declaration of 'struct blk_mq_hw_ctx' will not be visible outside of this function [-Wvisibility]
                                     struct blk_mq_hw_ctx *hctx);
                                            ^
   block/blk-mq-debugfs.h:25:44: warning: declaration of 'struct blk_mq_hw_ctx' will not be visible outside of this function [-Wvisibility]
   void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
                                              ^
   block/blk-mq-debugfs.h:32:19: warning: declaration of 'struct blk_mq_hw_ctx' will not be visible outside of this function [-Wvisibility]
                                          struct blk_mq_hw_ctx *hctx);
                                                 ^
   block/blk-mq-debugfs.h:33:50: warning: declaration of 'struct blk_mq_hw_ctx' will not be visible outside of this function [-Wvisibility]
   void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
                                                    ^
   4 warnings generated.


vim +24 block/blk-mq-debugfs.h

16b738f651c83a Omar Sandoval      2017-05-04  20  
6cfc0081b046eb Greg Kroah-Hartman 2019-06-12  21  void blk_mq_debugfs_register(struct request_queue *q);
d173a25165c124 Omar Sandoval      2017-05-04  22  void blk_mq_debugfs_unregister(struct request_queue *q);
6cfc0081b046eb Greg Kroah-Hartman 2019-06-12  23  void blk_mq_debugfs_register_hctx(struct request_queue *q,
9c1051aacde828 Omar Sandoval      2017-05-04 @24  				  struct blk_mq_hw_ctx *hctx);
9c1051aacde828 Omar Sandoval      2017-05-04  25  void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
6cfc0081b046eb Greg Kroah-Hartman 2019-06-12  26  void blk_mq_debugfs_register_hctxs(struct request_queue *q);
9c1051aacde828 Omar Sandoval      2017-05-04  27  void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
d332ce091813d1 Omar Sandoval      2017-05-04  28  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
