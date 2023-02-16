Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A2C636D6
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 13:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBPNHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBPNHh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 08:07:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A923128
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 05:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676552856; x=1708088856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3npfHYvRpavVZ0jOwSFeUCHxul+3rxwJK6fBemXsx/w=;
  b=LE97dsTkdUQJiAptU28Tpaoe2iT8QXin7a+2+0NpO0Wh9f23ef44Qpug
   PgC9kgvIUbZC2H3FtAFyl8Rxvpbpdig5Sqaqm68/dIWEokbVQMGv2ATaU
   XY5pbBTioPZrqYmdeHe//Zh+vQ50QfXejzeW+kKc39yFwi07QEYy2yPAb
   baZcuijnr1AELDTf5G2e2mK2u4glqud86k8YTcxu0+eA/odgVZYQYoOfw
   k6y4SWmO0quY5uln4nHRP/8nCOiQYWNjP46UeiqxEb6Gn4GFNsCnimAEE
   TvtDvFwn3/rbbBzQyOS/tufnOAcECOp2IopCFPtfTG+s522t+RdvgBa1s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333881456"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333881456"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647672293"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647672293"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:07:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSdyw-000AGZ-2R;
        Thu, 16 Feb 2023 13:07:26 +0000
Date:   Thu, 16 Feb 2023 21:06:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uday Shankar <ushankar@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <202302162040.FaI25ul2-lkp@intel.com>
References: <20230215201507.494152-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215201507.494152-1-ushankar@purestorage.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Uday,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 6bea9ac7c6481c09eb2b61d7cd844fc64a526e3e]

url:    https://github.com/intel-lab-lkp/linux/commits/Uday-Shankar/blk-mq-enforce-op-specific-segment-limits-in-blk_insert_cloned_request/20230216-041718
base:   6bea9ac7c6481c09eb2b61d7cd844fc64a526e3e
patch link:    https://lore.kernel.org/r/20230215201507.494152-1-ushankar%40purestorage.com
patch subject: [PATCH] blk-mq: enforce op-specific segment limits in blk_insert_cloned_request
config: i386-randconfig-a004-20230213 (https://download.01.org/0day-ci/archive/20230216/202302162040.FaI25ul2-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2cd958b09698bedea1a5a5f6298f0d25ec522bf9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Uday-Shankar/blk-mq-enforce-op-specific-segment-limits-in-blk_insert_cloned_request/20230216-041718
        git checkout 2cd958b09698bedea1a5a5f6298f0d25ec522bf9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302162040.FaI25ul2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/blk-mq.c:3032:36: warning: format specifies type 'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                           __func__, rq->nr_phys_segments, max_segments);
                                                           ^~~~~~~~~~~~
   include/linux/printk.h:457:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:429:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +3032 block/blk-mq.c

  2993	
  2994	#ifdef CONFIG_BLK_MQ_STACKING
  2995	/**
  2996	 * blk_insert_cloned_request - Helper for stacking drivers to submit a request
  2997	 * @rq: the request being queued
  2998	 */
  2999	blk_status_t blk_insert_cloned_request(struct request *rq)
  3000	{
  3001		struct request_queue *q = rq->q;
  3002		unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
  3003		unsigned int max_segments = blk_queue_get_max_segments(q, req_op(rq));
  3004		blk_status_t ret;
  3005	
  3006		if (blk_rq_sectors(rq) > max_sectors) {
  3007			/*
  3008			 * SCSI device does not have a good way to return if
  3009			 * Write Same/Zero is actually supported. If a device rejects
  3010			 * a non-read/write command (discard, write same,etc.) the
  3011			 * low-level device driver will set the relevant queue limit to
  3012			 * 0 to prevent blk-lib from issuing more of the offending
  3013			 * operations. Commands queued prior to the queue limit being
  3014			 * reset need to be completed with BLK_STS_NOTSUPP to avoid I/O
  3015			 * errors being propagated to upper layers.
  3016			 */
  3017			if (max_sectors == 0)
  3018				return BLK_STS_NOTSUPP;
  3019	
  3020			printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
  3021				__func__, blk_rq_sectors(rq), max_sectors);
  3022			return BLK_STS_IOERR;
  3023		}
  3024	
  3025		/*
  3026		 * The queue settings related to segment counting may differ from the
  3027		 * original queue.
  3028		 */
  3029		rq->nr_phys_segments = blk_recalc_rq_segments(rq);
  3030		if (rq->nr_phys_segments > max_segments) {
  3031			printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
> 3032				__func__, rq->nr_phys_segments, max_segments);
  3033			return BLK_STS_IOERR;
  3034		}
  3035	
  3036		if (q->disk && should_fail_request(q->disk->part0, blk_rq_bytes(rq)))
  3037			return BLK_STS_IOERR;
  3038	
  3039		if (blk_crypto_insert_cloned_request(rq))
  3040			return BLK_STS_IOERR;
  3041	
  3042		blk_account_io_start(rq);
  3043	
  3044		/*
  3045		 * Since we have a scheduler attached on the top device,
  3046		 * bypass a potential scheduler on the bottom device for
  3047		 * insert.
  3048		 */
  3049		blk_mq_run_dispatch_ops(q,
  3050				ret = blk_mq_request_issue_directly(rq, true));
  3051		if (ret)
  3052			blk_account_io_done(rq, ktime_get_ns());
  3053		return ret;
  3054	}
  3055	EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
  3056	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
