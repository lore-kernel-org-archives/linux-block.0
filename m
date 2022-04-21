Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8303AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392609AbiDUU5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392612AbiDUU5j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 16:57:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C04EA29
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650574488; x=1682110488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sc+XCwLCTGokbGmO7cIsT8byYFNPcCk0Y5S6uGaHrFI=;
  b=VtuvwIaBDfobKG8nGFI3Sz5AzutOPSLZi4meSsNMH98QFed6T63nzAzk
   qlEi/3xqEQydQyJqgb1jCsq6+dxgHDWXFiaW3qKcC8i8I9Gem1nIvgdue
   +EpagE6V6yPATz3Pqgy+I+LDqg+M2CWivhUA/YnL1GakejZZgqfjWouZ0
   6iblxfMkoB+r7NTFym6FHLBrfyJDlQs2rsxY07Gdpo/W2TdAGeaFPzuDF
   PV1otlC4HDCTdboe5hXMkp4qyN7yYeCzLxOEjZ71hkiRUDTcAgp1THtmj
   LCnkRgmHcYftUqHPP3k3GRFg+tSOpkPF4njJQkuopoOuXZSnnV2tTQEwM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264252208"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="264252208"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 13:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="593838090"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 13:54:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhdp7-0008mk-5X;
        Thu, 21 Apr 2022 20:54:45 +0000
Date:   Fri, 22 Apr 2022 04:54:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Message-ID: <202204220422.9SM0r5ue-lkp@intel.com>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421083431.2917311-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.18-rc3 next-20220421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/block-fix-Directory-XXXXX-with-parent-block-already-present/20220421-163556
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: csky-randconfig-r036-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220422.9SM0r5ue-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/746684a4668ee70b284126159a10f98ff7ebb319
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ming-Lei/block-fix-Directory-XXXXX-with-parent-block-already-present/20220421-163556
        git checkout 746684a4668ee70b284126159a10f98ff7ebb319
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/blk-sysfs.c: In function 'blk_register_queue':
>> block/blk-sysfs.c:841:43: warning: passing argument 4 of 'debugfs_rename' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     841 |                         blk_debugfs_root, kobject_name(q->kobj.parent));
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from block/blk-sysfs.c:13:
   include/linux/debugfs.h:252:47: note: expected 'char *' but argument is of type 'const char *'
     252 |                 struct dentry *new_dir, char *new_name)
         |                                         ~~~~~~^~~~~~~~


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
