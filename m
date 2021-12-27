Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB2C433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Dec 2021 18:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhL0Stg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Dec 2021 13:49:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:32551 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhL0Stf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Dec 2021 13:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640630975; x=1672166975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wqi9+sKwm2vC++423JmaqCHB1wNc1hYUmf0h4FyVQ1I=;
  b=RWrOIvuz5gcaLQRVCeZ58jrwSb1c4yTChGFpODmPSeJLvmKFjGwlLZtt
   S5/RYqPysaJh02XvsRLfqroRJUskhP/YylVf+WCEY+4HHtg1wxEystkVp
   z+zjcXZXRGcfFdj1wTefVXa2e/eXnOXf6/X5Kl7UPL91leUadSH5vbKc3
   cZpTolfj/J/PMDc953k3nso7BPuaGH/tq7bqSc16VZ5IwFql5suJFZRge
   yFAX3q4jhP0mshW98X0PD35hZG1/rOCOcwe5radBZgDrAIbtDeeFUU/mZ
   O16MeI6wExHc4LNUTCY/Qd4tR2PkQI7q7pceRi+zHtYWGaYSDcIOYB+wA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="304615334"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="304615334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 10:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="509940859"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Dec 2021 10:49:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1v3s-0006hk-O3; Mon, 27 Dec 2021 18:49:32 +0000
Date:   Tue, 28 Dec 2021 02:49:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, hch@lst.de, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/3] block: introduce rq_list_move
Message-ID: <202112280210.F89j103t-lkp@intel.com>
References: <20211227164138.2488066-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-2-kbusch@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linux-review/Xie-Yongji/nbd-Don-t-use-workqueue-to-handle-recv-work/20211227-171406 linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Keith-Busch/block-introduce-rq_list_for_each_safe-macro/20211228-004304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211228/202112280210.F89j103t-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/81098ed2c64adf477eae9c21a4188916e0ef5918
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Keith-Busch/block-introduce-rq_list_for_each_safe-macro/20211228-004304
        git checkout 81098ed2c64adf477eae9c21a4188916e0ef5918
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/um/drivers/ubd_kern.c:27:
>> include/linux/blk-mq.h:227:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     227 | static void inline rq_list_move(struct request **src, struct request **dst,
         | ^~~~~~
--
   In file included from include/linux/blktrace_api.h:5,
                    from block/bfq-iosched.h:9,
                    from block/bfq-cgroup.c:16:
>> include/linux/blk-mq.h:227:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     227 | static void inline rq_list_move(struct request **src, struct request **dst,
         | ^~~~~~
   block/bfq-cgroup.c:1437:6: warning: no previous prototype for 'bfqg_and_blkg_get' [-Wmissing-prototypes]
    1437 | void bfqg_and_blkg_get(struct bfq_group *bfqg) {}
         |      ^~~~~~~~~~~~~~~~~


vim +/inline +227 include/linux/blk-mq.h

   215	
   216	#define rq_dma_dir(rq) \
   217		(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
   218	
   219	/**
   220	 * rq_list_move() - move a struct request from one list to another
   221	 * @src: The source list @rq is currently in
   222	 * @dst: The destination list that @rq will be appended to
   223	 * @rq: The request to move
   224	 * @prv: The request preceding @rq in @src (NULL if @rq is the head)
   225	 * @nxt: The request following @rq in @src (NULL if @rq is the tail)
   226	 */
 > 227	static void inline rq_list_move(struct request **src, struct request **dst,
   228					struct request *rq, struct request *prv,
   229					struct request *nxt)
   230	{
   231		if (prv)
   232			prv->rq_next = nxt;
   233		else
   234			*src = nxt;
   235		rq_list_add(dst, rq);
   236	}
   237	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
