Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDBBC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 23:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhLTXAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:00:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:38171 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhLTXAa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 18:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640041230; x=1671577230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Omie6ZTBOSvpK0f9dMgNND+B6xhaRtYZHUJ6Gv/CKYw=;
  b=NTAVIYi/qIm1urY2FexgulS/8yj2lRuNe12/7pn4oNnJqv0kkdpen8Yd
   4LollbvgqHqKQ+YGHhJTER5fXWpDIbfS3s3zBhv45+3/gOQPoQoaPhAWf
   4fN6Fsb2fsR6gAO4ldljgWkBTOdKjCeJiGiN0sjz2dIRplXp3YP1bOpPR
   bdxfgAh4PGJ/ancnhK6A7Vmof9aA1eec8ULVgqrZm9VHliVuRz6N2RVBq
   1nZH8kw95szg7I/5bFAaqYkhuSZzYiAt6HoovWFsL9/iTk3l0hEKsBeSO
   rdrk4nQyvhZyGGDQLzSbt0f5IQKQMdaT6nKgDB7tzmcbtcebZyS/JSM7s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="220297237"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="220297237"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 15:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="547568082"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2021 15:00:27 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzRdr-0008Nl-8G; Mon, 20 Dec 2021 23:00:27 +0000
Date:   Tue, 21 Dec 2021 06:59:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-mq: check quiesce state before queue_rqs
Message-ID: <202112210618.hCiNGmq9-lkp@intel.com>
References: <20211220205412.151342-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220205412.151342-1-kbusch@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20211220]
[cannot apply to v5.16-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Keith-Busch/blk-mq-check-quiesce-state-before-queue_rqs/20211221-045504
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211221/202112210618.hCiNGmq9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/8004ce63b95d4be66e4ad8655a05ee21a9a148d8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Keith-Busch/blk-mq-check-quiesce-state-before-queue_rqs/20211221-045504
        git checkout 8004ce63b95d4be66e4ad8655a05ee21a9a148d8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-mq.c:2552:6: warning: no previous prototype for '__blk_mq_flush_plug_list' [-Wmissing-prototypes]
    2552 | void __blk_mq_flush_plug_list(struct request_queue *q, struct blk_plug *plug)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/__blk_mq_flush_plug_list +2552 block/blk-mq.c

  2551	
> 2552	void __blk_mq_flush_plug_list(struct request_queue *q, struct blk_plug *plug)
  2553	{
  2554		if (blk_queue_quiesced(q))
  2555			return;
  2556		q->mq_ops->queue_rqs(&plug->mq_list);
  2557	}
  2558	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
