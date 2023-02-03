Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F2C61DA4
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 00:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjBCAFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjBCAFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 19:05:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6D3E094
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 16:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675382702; x=1706918702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/c9lzXaWxw9RKQ4jSykKMadp9jZMJoYdMNi7r0moUWs=;
  b=ITFaAzynQU/glqVZOQJrnHl4knfVZ7dHez5QW1CFrHd+QECXGKwGGlVs
   gCCwy+ADJ6mtFX/xChYSUzIvbicsWs4zz2+aQAyTo8gE4Ypvgl49ETcZA
   MCjJ1dyZuoGY6ndsE1aLLPn3gf3h83axsKnmU7CcqYXUky1wUW8uazJ8C
   +U7PdOd8V/ScO0oRfpbPwf6m2o0vTunVUpAvmJ8uMfpeQpt5mS+FsOKUi
   dhD3AmVxakC/mTLx0mC+9OxGB7Vbqme0fn+GKM59O10SdHnIlwIUosZdj
   0Bakx1uMxMZxQUYJA94z1RngMAFgZ5x9DnfkeAsJWmgwFvbV4fQFWuTKb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326306400"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="326306400"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 16:05:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="994298055"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="994298055"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2023 16:04:57 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNjZY-0006yO-0v;
        Fri, 03 Feb 2023 00:04:56 +0000
Date:   Fri, 3 Feb 2023 08:04:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juhyung Park <qkrwngud825@gmail.com>, linux-block@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
        Juhyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH] block: remove more NULL checks after bdev_get_queue()
Message-ID: <202302030733.TVNhMvP4-lkp@intel.com>
References: <20230202091151.855784-1-qkrwngud825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202091151.855784-1-qkrwngud825@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Juhyung,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.2-rc6 next-20230202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juhyung-Park/block-remove-more-NULL-checks-after-bdev_get_queue/20230202-171443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230202091151.855784-1-qkrwngud825%40gmail.com
patch subject: [PATCH] block: remove more NULL checks after bdev_get_queue()
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20230203/202302030733.TVNhMvP4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f62253701c6bf771227300ca8c572c778c2670bb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Juhyung-Park/block-remove-more-NULL-checks-after-bdev_get_queue/20230202-171443
        git checkout f62253701c6bf771227300ca8c572c778c2670bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/blk-zoned.c: In function 'blkdev_report_zones_ioctl':
>> block/blk-zoned.c:337:31: warning: variable 'q' set but not used [-Wunused-but-set-variable]
     337 |         struct request_queue *q;
         |                               ^
   block/blk-zoned.c: In function 'blkdev_zone_mgmt_ioctl':
   block/blk-zoned.c:392:31: warning: variable 'q' set but not used [-Wunused-but-set-variable]
     392 |         struct request_queue *q;
         |                               ^


vim +/q +337 block/blk-zoned.c

d41003513e61dd Christoph Hellwig 2019-11-11  327  
56c4bddb970658 Bart Van Assche   2018-03-08  328  /*
3ed05a987e0f63 Shaun Tancheff    2016-10-18  329   * BLKREPORTZONE ioctl processing.
3ed05a987e0f63 Shaun Tancheff    2016-10-18  330   * Called from blkdev_ioctl.
3ed05a987e0f63 Shaun Tancheff    2016-10-18  331   */
3ed05a987e0f63 Shaun Tancheff    2016-10-18  332  int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
3ed05a987e0f63 Shaun Tancheff    2016-10-18  333  			      unsigned int cmd, unsigned long arg)
3ed05a987e0f63 Shaun Tancheff    2016-10-18  334  {
3ed05a987e0f63 Shaun Tancheff    2016-10-18  335  	void __user *argp = (void __user *)arg;
d41003513e61dd Christoph Hellwig 2019-11-11  336  	struct zone_report_args args;
3ed05a987e0f63 Shaun Tancheff    2016-10-18 @337  	struct request_queue *q;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  338  	struct blk_zone_report rep;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  339  	int ret;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  340  
3ed05a987e0f63 Shaun Tancheff    2016-10-18  341  	if (!argp)
3ed05a987e0f63 Shaun Tancheff    2016-10-18  342  		return -EINVAL;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  343  
3ed05a987e0f63 Shaun Tancheff    2016-10-18  344  	q = bdev_get_queue(bdev);
3ed05a987e0f63 Shaun Tancheff    2016-10-18  345  
edd1dbc83b1de3 Christoph Hellwig 2022-07-06  346  	if (!bdev_is_zoned(bdev))
3ed05a987e0f63 Shaun Tancheff    2016-10-18  347  		return -ENOTTY;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  348  
3ed05a987e0f63 Shaun Tancheff    2016-10-18  349  	if (copy_from_user(&rep, argp, sizeof(struct blk_zone_report)))
3ed05a987e0f63 Shaun Tancheff    2016-10-18  350  		return -EFAULT;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  351  
3ed05a987e0f63 Shaun Tancheff    2016-10-18  352  	if (!rep.nr_zones)
3ed05a987e0f63 Shaun Tancheff    2016-10-18  353  		return -EINVAL;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  354  
d41003513e61dd Christoph Hellwig 2019-11-11  355  	args.zones = argp + sizeof(struct blk_zone_report);
d41003513e61dd Christoph Hellwig 2019-11-11  356  	ret = blkdev_report_zones(bdev, rep.sector, rep.nr_zones,
d41003513e61dd Christoph Hellwig 2019-11-11  357  				  blkdev_copy_zone_to_user, &args);
d41003513e61dd Christoph Hellwig 2019-11-11  358  	if (ret < 0)
3ed05a987e0f63 Shaun Tancheff    2016-10-18  359  		return ret;
d41003513e61dd Christoph Hellwig 2019-11-11  360  
d41003513e61dd Christoph Hellwig 2019-11-11  361  	rep.nr_zones = ret;
82394db7383d33 Matias Bjørling   2020-06-29  362  	rep.flags = BLK_ZONE_REP_CAPACITY;
d41003513e61dd Christoph Hellwig 2019-11-11  363  	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
d41003513e61dd Christoph Hellwig 2019-11-11  364  		return -EFAULT;
d41003513e61dd Christoph Hellwig 2019-11-11  365  	return 0;
3ed05a987e0f63 Shaun Tancheff    2016-10-18  366  }
3ed05a987e0f63 Shaun Tancheff    2016-10-18  367  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
