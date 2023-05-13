Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C6EC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 16:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEMQmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEMQmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 12:42:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10162D58
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683996135; x=1715532135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OwNjPceV71+aWBV4fEF/G0q/Gi+UdMHfh518RarTyas=;
  b=UdxW6+4vYqEazisZ4MXA8NE2SpFBK+U10WCFbCzT6gXkCX/EPBq5AsL8
   TYfj57smVu8OL3jlol8tf8NiQUXK3eIaiUGatb414iU7Cnilv4KW8I/TT
   +nhSBUu+yaBLS0+C+gRStvxb6tREXUkOPGbNikap/N1Sag11D3Nlx9fVj
   WLSJk2mJDXXopHRoymYxyNymO+qk0LrqizKObEkDRK/w34+9LCpttJ6Dn
   b2bTJXp80Bju3iD/8rDfqsidin+tmN51topv+qw785lZ4bhTJ6dGyw/BJ
   As5kObjhTSTqmjKtoxMrhp1nn2LSsqe0dagkpBtOwAaIE/ezFnnkstuoL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="330589986"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="330589986"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 09:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="812431269"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="812431269"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2023 09:42:13 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxsJx-0005a8-0t;
        Sat, 13 May 2023 16:42:13 +0000
Date:   Sun, 14 May 2023 00:41:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tian Lan <tilan7663@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Tian Lan <tian.lan@twosigma.com>
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Message-ID: <202305140028.fzLbBFSs-lkp@intel.com>
References: <20230513141234.8395-1-tilan7663@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513141234.8395-1-tilan7663@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tian,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tian-Lan/blk-mq-fix-blk_mq_hw_ctx-active-request-accounting/20230513-221329
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230513141234.8395-1-tilan7663%40gmail.com
patch subject: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20230514/202305140028.fzLbBFSs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f958f858d42c76e1439649993bd485ac02200f87
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tian-Lan/blk-mq-fix-blk_mq_hw_ctx-active-request-accounting/20230513-221329
        git checkout f958f858d42c76e1439649993bd485ac02200f87
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305140028.fzLbBFSs-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/blk-mq.c: In function 'blk_mq_put_rq_ref':
>> block/blk-mq.c:1574:66: error: expected ';' before '__blk_mq_free_request'
    1574 |                         __blk_mq_dec_active_requests(rq->mq_hctx)
         |                                                                  ^
         |                                                                  ;
    1575 | 
    1576 |                 __blk_mq_free_request(rq);
         |                 ~~~~~~~~~~~~~~~~~~~~~                             


vim +1574 block/blk-mq.c

  1566	
  1567	void blk_mq_put_rq_ref(struct request *rq)
  1568	{
  1569		if (is_flush_rq(rq)) {
  1570			if (rq->end_io(rq, 0) == RQ_END_IO_FREE)
  1571				blk_mq_free_request(rq);
  1572		} else if (req_ref_put_and_test(rq)) {
  1573			if (rq->rq_flags & RQF_MQ_INFLIGHT)
> 1574				__blk_mq_dec_active_requests(rq->mq_hctx)
  1575	
  1576			__blk_mq_free_request(rq);
  1577		}
  1578	}
  1579	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
