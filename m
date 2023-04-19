Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B85C77B75
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 12:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjDSMjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjDSMi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 08:38:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294EA1BD2
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681907933; x=1713443933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U0OhEmkyN374yvgpmdDmLbFBPlNFpp5IE/9XwHhYyqM=;
  b=FmNIVK5eTMy3nKPxE24OtHTlO6Dmk86wkuocoftXqytkIwK3YnedpjcR
   n0UGWxJRTigP7lKA08OlhsQ0Pm2hndLjtSvoObd4KwrEMehiTX103QTt8
   H20D/iR41VH416+KAwLzkg1JMfI/1lXrubim5JMTkDgWdDsvosrcl16zV
   /qPaCExF5Ns3KigRd25rfnZ4+rRDT5O+LCy+zKmR0eQX1ZqQ52e8xUZgI
   FWgs3Wvy7xeBY6Po3cfLr/aIcyIhTQ+nsE92JYP5PrbaPVsMG/rqTWd5I
   qJavwaJDngX9vefah7sno68k2rb9j/1cO5z4rRc0XbEu2fty7SzKWaxr8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431711218"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431711218"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865821365"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="865821365"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2023 05:38:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp75G-000esf-0m;
        Wed, 19 Apr 2023 12:38:50 +0000
Date:   Wed, 19 Apr 2023 20:37:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Message-ID: <202304192001.KzxpDQmK-lkp@intel.com>
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
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20230419/202304192001.KzxpDQmK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c1197e1a4ff5b38b73d3ec923987ca857f5e2695
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-Hellwig/blk-mq-reflow-blk_insert_flush/20230417-051014
        git checkout c1197e1a4ff5b38b73d3ec923987ca857f5e2695
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304192001.KzxpDQmK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/blk-mq.c:1461:6: warning: no previous prototype for 'blk_flush_queue_insert' [-Wmissing-prototypes]
    1461 | void blk_flush_queue_insert(struct request *rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~


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
