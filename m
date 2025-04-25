Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E51BD9CE
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599661; cv=none; b=E1FVS0+7ZdNb8PdWJliq77SKFpgK8ZUidSkWDzkeqovWfQOHKuR0t6/QIBrimB547Odl01frQKjY0cpGzc69NMwIixGn+qw1czMMl3Zfskk3ImA6hpvs1QDzq2cqf5n+hfbxBBHTCmvo1ekvuTi3nMv+ouq7GLXsNt5ihGwEhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599661; c=relaxed/simple;
	bh=hwG+pdjLnd6wglShxbgGb83Rzua664zBs06F82XQdZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb43c9bb5hu+DIsny4roh1cT2R/6DCXzEENubS9gn+jBDDUXSjNOniXIQDzuBVEQlTCi+mOk72MyTEDd6Xe57WMhcL8P3zmhaOALSQdgtnt+GdW4i7tg0o9h1tPfCH7zL9VCJXh8ZiEzh4VfAC7qCxB0lbSnXf5NenNy2z9Dnbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1wUYNsa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1wUYNsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745599659; x=1777135659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hwG+pdjLnd6wglShxbgGb83Rzua664zBs06F82XQdZ8=;
  b=T1wUYNsacdAo28U8sullKB2v2oghm/0vy0LkWul+aZk7IuQ4eolghB2L
   Qy05sJ0JQl3W1vi649uH/wVPWGInycJFfu5nFWBeJb2Q6DVKi0u3ejtsR
   OLDPkwVGCWMRtmuDC8R6louulLC6Od3Nrg/NaX+UTdeBJZU6iBsEFj7Ii
   5y4tps6jUUD+IYLUOU9n+UGB7qibkruGwtSQiYkYT+bt5g7Q+Sket+bXE
   WbKQu575MH7vRh0M37JG8tau9pdWD1hEafUMaHlihzDmHwQGIB3GmPQog
   k0tGryYqaZCJFAI10X0JzmKeEWtpbX/HQvyXzLudLerC+Ot6B2BuRu8EC
   g==;
X-CSE-ConnectionGUID: tq4/HJaTT5yPbvNsoRqC2A==
X-CSE-MsgGUID: On1f+06OTO2isxFlLsAB/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="57464918"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="57464918"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 09:47:38 -0700
X-CSE-ConnectionGUID: i0TzlsbCToCnmfU2Y8MLDg==
X-CSE-MsgGUID: 4F/7qLmVQAaoWn0AJrx5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137004382"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Apr 2025 09:47:35 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8MD7-0005N3-0a;
	Fri, 25 Apr 2025 16:47:33 +0000
Date: Sat, 26 Apr 2025 00:46:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V3 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
Message-ID: <202504260007.SFrJbSQ8-lkp@intel.com>
References: <20250424152148.1066220-8-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424152148.1066220-8-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.15-rc3 next-20250424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/block-move-blk_mq_add_queue_tag_set-after-blk_mq_map_swqueue/20250424-232508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250424152148.1066220-8-ming.lei%40redhat.com
patch subject: [PATCH V3 07/20] block: prevent adding/deleting disk during updating nr_hw_queues
config: i386-buildonly-randconfig-004-20250425 (https://download.01.org/0day-ci/archive/20250426/202504260007.SFrJbSQ8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504260007.SFrJbSQ8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504260007.SFrJbSQ8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/genhd.c:406: warning: expecting prototype for add_disk_fwnode(). Prototype was for __add_disk_fwnode() instead


vim +406 block/genhd.c

9301fe73438499 block/genhd.c         Christoph Hellwig 2020-09-21  391  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  392  /**
9dfd9ea93aeab5 block/genhd.c         Christian Marangi 2024-10-03  393   * add_disk_fwnode - add disk information to kernel list with fwnode
e63a46bef01ff3 block/genhd.c         Dan Williams      2016-06-15  394   * @parent: parent device for the disk
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  395   * @disk: per-device partitioning information
fef912bf860e8e block/genhd.c         Hannes Reinecke   2018-09-28  396   * @groups: Additional per-device sysfs groups
9dfd9ea93aeab5 block/genhd.c         Christian Marangi 2024-10-03  397   * @fwnode: attached disk fwnode
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  398   *
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  399   * This function registers the partitioning information in @disk
9dfd9ea93aeab5 block/genhd.c         Christian Marangi 2024-10-03  400   * with the kernel. Also attach a fwnode to the disk device.
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  401   */
54650b49b7412c block/genhd.c         Ming Lei          2025-04-24  402  static int __add_disk_fwnode(struct device *parent, struct gendisk *disk,
9dfd9ea93aeab5 block/genhd.c         Christian Marangi 2024-10-03  403  			     const struct attribute_group **groups,
9dfd9ea93aeab5 block/genhd.c         Christian Marangi 2024-10-03  404  			     struct fwnode_handle *fwnode)
d1254a8749711e block/genhd.c         Christoph Hellwig 2021-08-04  405  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16 @406  {
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  407  	struct device *ddev = disk_to_dev(disk);
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  408  	int ret;
cf0ca9fe5dd9e3 block/genhd.c         Peter Zijlstra    2008-04-30  409  
3d9a9e9a77c5eb block/genhd.c         Ming Lei          2025-01-15  410  	if (WARN_ON_ONCE(bdev_nr_sectors(disk->part0) > BLK_DEV_MAX_SECTORS))
3d9a9e9a77c5eb block/genhd.c         Ming Lei          2025-01-15  411  		return -EINVAL;
3d9a9e9a77c5eb block/genhd.c         Ming Lei          2025-01-15  412  
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  413  	if (queue_is_mq(disk->queue)) {
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  414  		/*
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  415  		 * ->submit_bio and ->poll_bio are bypassed for blk-mq drivers.
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  416  		 */
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  417  		if (disk->fops->submit_bio || disk->fops->poll_bio)
69fe0f29892077 block/genhd.c         Ming Lei          2022-03-04  418  			return -EINVAL;
69fe0f29892077 block/genhd.c         Ming Lei          2022-03-04  419  
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  420  		/*
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  421  		 * Initialize the I/O scheduler code and pick a default one if
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  422  		 * needed.
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  423  		 */
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  424  		elevator_init_mq(disk->queue);
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  425  	} else {
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  426  		if (!disk->fops->submit_bio)
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  427  			return -EINVAL;
ac2b6f9dee8f41 block/genhd.c         Al Viro           2024-04-12  428  		bdev_set_flag(disk->part0, BD_HAS_SUBMIT_BIO);
6783811569aef2 block/genhd.c         Christoph Hellwig 2025-01-06  429  	}
9f4107b07b17b5 block/genhd.c         Jens Axboe        2023-04-14  430  
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  431  	/*
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  432  	 * If the driver provides an explicit major number it also must provide
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  433  	 * the number of minors numbers supported, and those will be used to
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  434  	 * setup the gendisk.
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  435  	 * Otherwise just allocate the device numbers for both the whole device
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  436  	 * and all partitions from the extended dev_t space.
3e1a7ff8a0a7b9 block/genhd.c         Tejun Heo         2008-08-25  437  	 */
02341a08c9dec5 block/genhd.c         Yu Kuai           2022-10-22  438  	ret = -EINVAL;
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  439  	if (disk->major) {
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  440  		if (WARN_ON(!disk->minors))
02341a08c9dec5 block/genhd.c         Yu Kuai           2022-10-22  441  			goto out_exit_elevator;
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  442  
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  443  		if (disk->minors > DISK_MAX_PARTS) {
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  444  			pr_err("block: can't allocate more than %d partitions\n",
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  445  				DISK_MAX_PARTS);
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  446  			disk->minors = DISK_MAX_PARTS;
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  447  		}
4c434392c47778 block/genhd.c         Li Nan            2023-12-19  448  		if (disk->first_minor > MINORMASK ||
4c434392c47778 block/genhd.c         Li Nan            2023-12-19  449  		    disk->minors > MINORMASK + 1 ||
4c434392c47778 block/genhd.c         Li Nan            2023-12-19  450  		    disk->first_minor + disk->minors > MINORMASK + 1)
02341a08c9dec5 block/genhd.c         Yu Kuai           2022-10-22  451  			goto out_exit_elevator;
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  452  	} else {
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  453  		if (WARN_ON(disk->minors))
02341a08c9dec5 block/genhd.c         Yu Kuai           2022-10-22  454  			goto out_exit_elevator;
3e1a7ff8a0a7b9 block/genhd.c         Tejun Heo         2008-08-25  455  
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  456  		ret = blk_alloc_ext_minor();
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  457  		if (ret < 0)
02341a08c9dec5 block/genhd.c         Yu Kuai           2022-10-22  458  			goto out_exit_elevator;
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  459  		disk->major = BLOCK_EXT_MAJOR;
539711d7d6fe38 block/genhd.c         Christoph Hellwig 2021-08-24  460  		disk->first_minor = ret;
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  461  	}
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  462  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  463  	/* delay uevents, until we scanned partition table */
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  464  	dev_set_uevent_suppress(ddev, 1);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  465  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  466  	ddev->parent = parent;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  467  	ddev->groups = groups;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  468  	dev_set_name(ddev, "%s", disk->disk_name);
9dfd9ea93aeab5 block/genhd.c         Christian Marangi 2024-10-03  469  	if (fwnode)
9dfd9ea93aeab5 block/genhd.c         Christian Marangi 2024-10-03  470  		device_set_node(ddev, fwnode);
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  471  	if (!(disk->flags & GENHD_FL_HIDDEN))
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  472  		ddev->devt = MKDEV(disk->major, disk->first_minor);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  473  	ret = device_add(ddev);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  474  	if (ret)
99d8690aae4b2f block/genhd.c         Christoph Hellwig 2021-12-21  475  		goto out_free_ext_minor;
99d8690aae4b2f block/genhd.c         Christoph Hellwig 2021-12-21  476  
99d8690aae4b2f block/genhd.c         Christoph Hellwig 2021-12-21  477  	ret = disk_alloc_events(disk);
99d8690aae4b2f block/genhd.c         Christoph Hellwig 2021-12-21  478  	if (ret)
99d8690aae4b2f block/genhd.c         Christoph Hellwig 2021-12-21  479  		goto out_device_del;
99d8690aae4b2f block/genhd.c         Christoph Hellwig 2021-12-21  480  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  481  	ret = sysfs_create_link(block_depr, &ddev->kobj,
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  482  				kobject_name(&ddev->kobj));
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  483  	if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  484  		goto out_device_del;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  485  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  486  	/*
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  487  	 * avoid probable deadlock caused by allocating memory with
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  488  	 * GFP_KERNEL in runtime_resume callback of its all ancestor
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  489  	 * devices
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  490  	 */
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  491  	pm_runtime_set_memalloc_noio(ddev, true);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  492  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  493  	disk->part0->bd_holder_dir =
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  494  		kobject_create_and_add("holders", &ddev->kobj);
fe7d064fa3faec block/genhd.c         Luis Chamberlain  2021-11-03  495  	if (!disk->part0->bd_holder_dir) {
fe7d064fa3faec block/genhd.c         Luis Chamberlain  2021-11-03  496  		ret = -ENOMEM;
ff53cd52d9bdbf block/genhd.c         Thomas Weißschuh  2023-03-18  497  		goto out_del_block_link;
fe7d064fa3faec block/genhd.c         Luis Chamberlain  2021-11-03  498  	}
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  499  	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
fe7d064fa3faec block/genhd.c         Luis Chamberlain  2021-11-03  500  	if (!disk->slave_dir) {
fe7d064fa3faec block/genhd.c         Luis Chamberlain  2021-11-03  501  		ret = -ENOMEM;
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  502  		goto out_put_holder_dir;
fe7d064fa3faec block/genhd.c         Luis Chamberlain  2021-11-03  503  	}
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  504  
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  505  	ret = blk_register_queue(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  506  	if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  507  		goto out_put_slave_dir;
75f4dca59694df block/genhd.c         Christoph Hellwig 2021-08-18  508  
9f18db572c97bc block/genhd.c         Christoph Hellwig 2021-11-22  509  	if (!(disk->flags & GENHD_FL_HIDDEN)) {
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  510  		ret = bdi_register(disk->bdi, "%u:%u",
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  511  				   disk->major, disk->first_minor);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  512  		if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  513  			goto out_unregister_queue;
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  514  		bdi_set_owner(disk->bdi, ddev);
9d5ee6767c8576 block/genhd.c         Christoph Hellwig 2021-08-18  515  		ret = sysfs_create_link(&ddev->kobj,
9d5ee6767c8576 block/genhd.c         Christoph Hellwig 2021-08-18  516  					&disk->bdi->dev->kobj, "bdi");
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  517  		if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  518  			goto out_unregister_bdi;
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  519  
e5cfefa97bccf9 block/genhd.c         Yu Kuai           2023-02-17  520  		/* Make sure the first partition scan will be proceed */
140ce28dd3bee8 block/genhd.c         Christoph Hellwig 2024-05-02  521  		if (get_capacity(disk) && disk_has_partscan(disk))
e5cfefa97bccf9 block/genhd.c         Yu Kuai           2023-02-17  522  			set_bit(GD_NEED_PART_SCAN, &disk->state);
e5cfefa97bccf9 block/genhd.c         Yu Kuai           2023-02-17  523  
9d5ee6767c8576 block/genhd.c         Christoph Hellwig 2021-08-18  524  		bdev_add(disk->part0, ddev->devt);
e16e506ccd673a block/genhd.c         Christoph Hellwig 2021-11-22  525  		if (get_capacity(disk))
05bdb9965305bb block/genhd.c         Christoph Hellwig 2023-06-08  526  			disk_scan_partitions(disk, BLK_OPEN_READ);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  527  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  528  		/*
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  529  		 * Announce the disk and partitions after all partitions are
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  530  		 * created. (for hidden disks uevents remain suppressed forever)
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  531  		 */
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  532  		dev_set_uevent_suppress(ddev, 0);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  533  		disk_uevent(disk, KOBJ_ADD);
a0a6314ae774f8 block/genhd.c         Christoph Hellwig 2022-10-10  534  	} else {
a0a6314ae774f8 block/genhd.c         Christoph Hellwig 2022-10-10  535  		/*
a0a6314ae774f8 block/genhd.c         Christoph Hellwig 2022-10-10  536  		 * Even if the block_device for a hidden gendisk is not
a0a6314ae774f8 block/genhd.c         Christoph Hellwig 2022-10-10  537  		 * registered, it needs to have a valid bd_dev so that the
a0a6314ae774f8 block/genhd.c         Christoph Hellwig 2022-10-10  538  		 * freeing of the dynamic major works.
a0a6314ae774f8 block/genhd.c         Christoph Hellwig 2022-10-10  539  		 */
a0a6314ae774f8 block/genhd.c         Christoph Hellwig 2022-10-10  540  		disk->part0->bd_dev = MKDEV(disk->major, disk->first_minor);
8ddcd653257c18 block/genhd.c         Christoph Hellwig 2017-11-02  541  	}
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  542  
73781b3b81e765 block/genhd.c         Christoph Hellwig 2024-06-26  543  	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
77ea887e433ad8 block/genhd.c         Tejun Heo         2010-12-08  544  	disk_add_events(disk);
76792055c4c8b2 block/genhd.c         Christoph Hellwig 2022-02-15  545  	set_bit(GD_ADDED, &disk->state);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  546  	return 0;
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  547  
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  548  out_unregister_bdi:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  549  	if (!(disk->flags & GENHD_FL_HIDDEN))
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  550  		bdi_unregister(disk->bdi);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  551  out_unregister_queue:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  552  	blk_unregister_queue(disk);
fa81cbafbf5764 block/genhd.c         Chen Zhongjin     2022-10-29  553  	rq_qos_exit(disk->queue);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  554  out_put_slave_dir:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  555  	kobject_put(disk->slave_dir);
d90db3b1c8676b block/genhd.c         Christoph Hellwig 2022-11-15  556  	disk->slave_dir = NULL;
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  557  out_put_holder_dir:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  558  	kobject_put(disk->part0->bd_holder_dir);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  559  out_del_block_link:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  560  	sysfs_remove_link(block_depr, dev_name(ddev));
5fa3d1a00c2d4b block/genhd.c         Li Nan            2023-12-11  561  	pm_runtime_set_memalloc_noio(ddev, false);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  562  out_device_del:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  563  	device_del(ddev);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  564  out_free_ext_minor:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  565  	if (disk->major == BLOCK_EXT_MAJOR)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  566  		blk_free_ext_minor(disk->first_minor);
02341a08c9dec5 block/genhd.c         Yu Kuai           2022-10-22  567  out_exit_elevator:
1bf70d08cc3b55 block/genhd.c         Nilay Shroff      2025-03-04  568  	if (disk->queue->elevator) {
1bf70d08cc3b55 block/genhd.c         Nilay Shroff      2025-03-04  569  		mutex_lock(&disk->queue->elevator_lock);
02341a08c9dec5 block/genhd.c         Yu Kuai           2022-10-22  570  		elevator_exit(disk->queue);
1bf70d08cc3b55 block/genhd.c         Nilay Shroff      2025-03-04  571  		mutex_unlock(&disk->queue->elevator_lock);
1bf70d08cc3b55 block/genhd.c         Nilay Shroff      2025-03-04  572  	}
278167fd2f8ffe block/genhd.c         Luis Chamberlain  2021-11-09  573  	return ret;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  574  }
54650b49b7412c block/genhd.c         Ming Lei          2025-04-24  575  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
