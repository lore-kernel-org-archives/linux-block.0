Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA9C43217
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiB1Rpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiB1Rpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 12:45:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D879743AF1
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069870; x=1677605870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JirBImR6SV94Y/viGCGklZvtBzmoJ41GxKsuCrrDD9g=;
  b=eU1rOx/juoIhfXBhXWSLRsKhYTtijicGsv9CqmSQ8nf7QRtvphgn3uwE
   Udxc0Sh+O5+NtvsI9fx5gQMVXfb21bGFL4aMPCxv+/pzn2ICF9rJORztf
   yJTbagYpT4cDD/qaIySUXgON1+to0JDyRC0VPMbVRtu1bxln9auz1qd9/
   oHz6ThVgoIKLVaPhCArfjd+7hHwEMhZb4nmM5Sre/9161te7Rndybo7EL
   UNEKnHLMMl3HcaSaa5GwRRfKlrT+M/8/uRCKZb3rXHQnaw5SxKHG4zIQq
   +lzdTXzB7QWGaQw+c3aMSBe0Qj2sE3TrFSU/UOMG1jAAGyUEQm1Jgkmxq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250525646"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="250525646"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="639063298"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2022 09:37:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjxS-0007cO-Kj; Mon, 28 Feb 2022 17:37:14 +0000
Date:   Tue, 1 Mar 2022 01:36:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <202203010021.zTuzL2PG-lkp@intel.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220301/202203010021.zTuzL2PG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/176e39bc0acb20f8fd869d170b429b7253b089c4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220228-170706
        git checkout 176e39bc0acb20f8fd869d170b429b7253b089c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from block/blk-mq-debugfs-zoned.c:7:
>> block/blk-mq-debugfs.h:24:42: warning: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration
      24 |                                   struct blk_mq_hw_ctx *hctx);
         |                                          ^~~~~~~~~~~~~
   block/blk-mq-debugfs.h:25:44: warning: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration
      25 | void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
         |                                            ^~~~~~~~~~~~~
   block/blk-mq-debugfs.h:32:47: warning: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration
      32 |                                        struct blk_mq_hw_ctx *hctx);
         |                                               ^~~~~~~~~~~~~
   block/blk-mq-debugfs.h:33:50: warning: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration
      33 | void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
         |                                                  ^~~~~~~~~~~~~


vim +24 block/blk-mq-debugfs.h

16b738f651c83a0 Omar Sandoval      2017-05-04  20  
6cfc0081b046ebf Greg Kroah-Hartman 2019-06-12  21  void blk_mq_debugfs_register(struct request_queue *q);
d173a25165c1244 Omar Sandoval      2017-05-04  22  void blk_mq_debugfs_unregister(struct request_queue *q);
6cfc0081b046ebf Greg Kroah-Hartman 2019-06-12  23  void blk_mq_debugfs_register_hctx(struct request_queue *q,
9c1051aacde8280 Omar Sandoval      2017-05-04 @24  				  struct blk_mq_hw_ctx *hctx);
9c1051aacde8280 Omar Sandoval      2017-05-04  25  void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
6cfc0081b046ebf Greg Kroah-Hartman 2019-06-12  26  void blk_mq_debugfs_register_hctxs(struct request_queue *q);
9c1051aacde8280 Omar Sandoval      2017-05-04  27  void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
d332ce091813d11 Omar Sandoval      2017-05-04  28  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
