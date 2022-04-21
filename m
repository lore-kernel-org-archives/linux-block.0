Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0281CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 23:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384584AbiDUXJu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiDUXJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 19:09:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663643395
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650582419; x=1682118419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQT9aEysMXXsjvzcG5V3WWcbMoPa0tWlFbbMxcv7ek4=;
  b=JvaYFOhW8Elj6X1/afq0Wi2N9+AsiZKuopoCVaw3DChEfagnruN0UznE
   2frTdcKtX6M4lYIAn/4LMo9SQmPXwWHPkaDDcdNpiVRB+MYRnP0HkMbTL
   EOZ6E4/NBUQoN4Q27VAXq2pbqc5oCLddCA+XyyBGxGw0TzydKcjcv/klO
   W5Y9kpY37ENSbAIkq6xXnI7G9imcgL5U4vurB4pRqUxlVpzYB+49OJXvB
   RUnRIQdLISfAXjq3n2/ejxkc2BbPHxu3D+mx9lgm4bdN3JTOBjrhcPvDK
   w0yM/RmQBRaF+/vg7H2sj85mn5vpXlqmDHciTFyTlBI9TJByVr6Mk++gQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289623736"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="289623736"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 16:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615137201"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 16:06:57 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhft2-0008s4-Eq;
        Thu, 21 Apr 2022 23:06:56 +0000
Date:   Fri, 22 Apr 2022 07:06:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Message-ID: <202204220614.mF9U5ks7-lkp@intel.com>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421083431.2917311-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on v5.18-rc3 next-20220421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/block-fix-Directory-XXXXX-with-parent-block-already-present/20220421-163556
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm64-randconfig-r034-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220614.mF9U5ks7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/746684a4668ee70b284126159a10f98ff7ebb319
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ming-Lei/block-fix-Directory-XXXXX-with-parent-block-already-present/20220421-163556
        git checkout 746684a4668ee70b284126159a10f98ff7ebb319
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> block/blk-sysfs.c:841:22: error: passing 'const char *' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                           blk_debugfs_root, kobject_name(q->kobj.parent));
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/debugfs.h:252:47: note: passing argument to parameter 'new_name' here
                   struct dentry *new_dir, char *new_name)
                                                 ^
   1 error generated.


vim +841 block/blk-sysfs.c

   808	
   809	/**
   810	 * blk_register_queue - register a block layer queue with sysfs
   811	 * @disk: Disk of which the request queue should be registered with sysfs.
   812	 */
   813	int blk_register_queue(struct gendisk *disk)
   814	{
   815		int ret;
   816		struct device *dev = disk_to_dev(disk);
   817		struct request_queue *q = disk->queue;
   818	
   819		ret = blk_trace_init_sysfs(dev);
   820		if (ret)
   821			return ret;
   822	
   823		mutex_lock(&q->sysfs_dir_lock);
   824	
   825		ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
   826		if (ret < 0) {
   827			blk_trace_remove_sysfs(dev);
   828			goto unlock;
   829		}
   830	
   831		ret = sysfs_create_group(&q->kobj, &queue_attr_group);
   832		if (ret) {
   833			blk_trace_remove_sysfs(dev);
   834			kobject_del(&q->kobj);
   835			kobject_put(&dev->kobj);
   836			goto unlock;
   837		}
   838	
   839		mutex_lock(&q->debugfs_mutex);
   840		q->debugfs_dir = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
 > 841				blk_debugfs_root, kobject_name(q->kobj.parent));
   842		mutex_unlock(&q->debugfs_mutex);
   843	
   844		if (queue_is_mq(q)) {
   845			__blk_mq_register_dev(dev, q);
   846			blk_mq_debugfs_register(q);
   847		}
   848	
   849		mutex_lock(&q->sysfs_lock);
   850	
   851		ret = disk_register_independent_access_ranges(disk, NULL);
   852		if (ret)
   853			goto put_dev;
   854	
   855		if (q->elevator) {
   856			ret = elv_register_queue(q, false);
   857			if (ret)
   858				goto put_dev;
   859		}
   860	
   861		ret = blk_crypto_sysfs_register(q);
   862		if (ret)
   863			goto put_dev;
   864	
   865		blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
   866		wbt_enable_default(q);
   867		blk_throtl_register_queue(q);
   868	
   869		/* Now everything is ready and send out KOBJ_ADD uevent */
   870		kobject_uevent(&q->kobj, KOBJ_ADD);
   871		if (q->elevator)
   872			kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
   873		mutex_unlock(&q->sysfs_lock);
   874	
   875	unlock:
   876		mutex_unlock(&q->sysfs_dir_lock);
   877	
   878		/*
   879		 * SCSI probing may synchronously create and destroy a lot of
   880		 * request_queues for non-existent devices.  Shutting down a fully
   881		 * functional queue takes measureable wallclock time as RCU grace
   882		 * periods are involved.  To avoid excessive latency in these
   883		 * cases, a request_queue starts out in a degraded mode which is
   884		 * faster to shut down and is made fully functional here as
   885		 * request_queues for non-existent devices never get registered.
   886		 */
   887		if (!blk_queue_init_done(q)) {
   888			blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
   889			percpu_ref_switch_to_percpu(&q->q_usage_counter);
   890		}
   891	
   892		return ret;
   893	
   894	put_dev:
   895		elv_unregister_queue(q);
   896		disk_unregister_independent_access_ranges(disk);
   897		mutex_unlock(&q->sysfs_lock);
   898		mutex_unlock(&q->sysfs_dir_lock);
   899		kobject_del(&q->kobj);
   900		blk_trace_remove_sysfs(dev);
   901		kobject_put(&dev->kobj);
   902	
   903		return ret;
   904	}
   905	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
