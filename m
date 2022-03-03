Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1249C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 09:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiCCJKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiCCJKg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 04:10:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE0496BF
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646298591; x=1677834591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QLkQheywK/eOPP8dw6CSHCGH7r92F3CpGGBljfCzb1Q=;
  b=ieserScUBBxQ6QbewaR3fSZipMEpnZJ9fOmKWsJKrxsBD8Z0i/2Jtdpb
   lDrH7AKivom2H/0lrQ2z+GjpL0xtKMCYdQ4QbcPG2mPaHQD7s2qzVgKT4
   GHPI4jMwk0rgelFwx1gkA9dHLUCMYM0e9MPLeRI2sfKiGjNqi43JSLzmy
   s05Jo5Bf69e1+VSIgMyLKqISiW3oGjA62GVudG6QPV6j0++6dvuRw1UmX
   n0Rt2E2ciwh5fozFIhp4/eDC1MKZhtXaEntzZGKRyq0D48QG4Yuu1zeJA
   xZWYqhKsNNq88Q7z5LjIg895ZBKzT6lABZtcFwz6ZC9mh2OV1Ef6qTODZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233586788"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="233586788"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 01:09:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642044774"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 01:09:49 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPhT2-0000Lm-Pr; Thu, 03 Mar 2022 09:09:48 +0000
Date:   Thu, 3 Mar 2022 17:08:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 5/6] blk-mq: prepare for implementing hctx table via
 xarray
Message-ID: <202203031651.z0z86F6E-lkp@intel.com>
References: <20220302121407.1361401-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302121407.1361401-6-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.17-rc6 next-20220302]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220302-201636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: m68k-randconfig-m031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203031651.z0z86F6E-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
block/blk-mq-sysfs.c:282 __blk_mq_register_dev() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'
block/blk-mq-sysfs.c:282 __blk_mq_register_dev() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'

vim +282 block/blk-mq-sysfs.c

67aec14ce87fe2 Jens Axboe      2014-05-30  254  
2d0364c8c1a97a Bart Van Assche 2017-04-26  255  int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
320ae51feed5c2 Jens Axboe      2013-10-24  256  {
320ae51feed5c2 Jens Axboe      2013-10-24  257  	struct blk_mq_hw_ctx *hctx;
44849be579332c Ming Lei        2022-03-02  258  	unsigned long i;
44849be579332c Ming Lei        2022-03-02  259  	int ret;
320ae51feed5c2 Jens Axboe      2013-10-24  260  
2d0364c8c1a97a Bart Van Assche 2017-04-26  261  	WARN_ON_ONCE(!q->kobj.parent);
cecf5d87ff2035 Ming Lei        2019-08-27  262  	lockdep_assert_held(&q->sysfs_dir_lock);
4593fdbe7a2f44 Akinobu Mita    2015-09-27  263  
1db4909e76f64a Ming Lei        2018-11-20  264  	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
320ae51feed5c2 Jens Axboe      2013-10-24  265  	if (ret < 0)
4593fdbe7a2f44 Akinobu Mita    2015-09-27  266  		goto out;
320ae51feed5c2 Jens Axboe      2013-10-24  267  
1db4909e76f64a Ming Lei        2018-11-20  268  	kobject_uevent(q->mq_kobj, KOBJ_ADD);
320ae51feed5c2 Jens Axboe      2013-10-24  269  
320ae51feed5c2 Jens Axboe      2013-10-24  270  	queue_for_each_hw_ctx(q, hctx, i) {
67aec14ce87fe2 Jens Axboe      2014-05-30  271  		ret = blk_mq_register_hctx(hctx);
320ae51feed5c2 Jens Axboe      2013-10-24  272  		if (ret)
f05d1ba7871a2c Bart Van Assche 2017-04-26  273  			goto unreg;
320ae51feed5c2 Jens Axboe      2013-10-24  274  	}
320ae51feed5c2 Jens Axboe      2013-10-24  275  
4593fdbe7a2f44 Akinobu Mita    2015-09-27  276  	q->mq_sysfs_init_done = true;
2d0364c8c1a97a Bart Van Assche 2017-04-26  277  
4593fdbe7a2f44 Akinobu Mita    2015-09-27  278  out:
2d0364c8c1a97a Bart Van Assche 2017-04-26  279  	return ret;
f05d1ba7871a2c Bart Van Assche 2017-04-26  280  
f05d1ba7871a2c Bart Van Assche 2017-04-26  281  unreg:
f05d1ba7871a2c Bart Van Assche 2017-04-26 @282  	while (--i >= 0)
f05d1ba7871a2c Bart Van Assche 2017-04-26  283  		blk_mq_unregister_hctx(q->queue_hw_ctx[i]);
f05d1ba7871a2c Bart Van Assche 2017-04-26  284  
1db4909e76f64a Ming Lei        2018-11-20  285  	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
1db4909e76f64a Ming Lei        2018-11-20  286  	kobject_del(q->mq_kobj);
f05d1ba7871a2c Bart Van Assche 2017-04-26  287  	kobject_put(&dev->kobj);
f05d1ba7871a2c Bart Van Assche 2017-04-26  288  	return ret;
2d0364c8c1a97a Bart Van Assche 2017-04-26  289  }
2d0364c8c1a97a Bart Van Assche 2017-04-26  290  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
