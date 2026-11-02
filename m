Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644640;
	b=qttIpnu9WmXd5V5R+NQuAWsHFtjqt2FICzaPEYdTFYIFIXpMzTKMXxCcmCe/fvmZTiMq
	 /qhG4vuMrhD85XYyP0NMVVfovH3F39SdAPrjIhB4Cmz9fm5hfx03jj4l9xZGvP15yBwwn
	 iBzJLiZmIypbH3cs1QHfvsVUkDDdws7rVEWriJ19+YynaWYQ7T6GOp7T+6CAxWd2c5EWC
	 VoGQ0pLRVKlRuknR6BJHfwdvIAuzpBaKFVqj/jQ++sD2fZH3vvaDLi0EhUzfP50rLf22q
	 Zl2GjbZW38OiRTlW4TymZWvIl2GKT0wfVKFLXVxkYCQtc7HQyicijBQVY5Jwl4w2LXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644640;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=abqkswgtFQmiFmU7+ExKU8DN2+g3xHYN90rasaD8iGY=;
	b=pL8FaLW8G03xYui0ncDRDza63jan2DPwuAptGo9n6uVcB2XcbkB7RR8x1vKJpIzoyunS
	 QkRghUFoQaoUETINOdmUbG/KkCMGeSs/WOomnq4yf0A0dJrRCYiq3hXBnpWYxPz+BXmU0
	 7W4IXkWjHUqOrJxgrdAaC146CwSK5myAqwZvN3KPc+sD7OVMOjE3JeP2ZUj2ohq4jJIhr
	 M7J22vq0Wn48/e5upYzfkPVZu3KH1GIPqWVwfvVx1Vtm5cwKJLJfdwcq2qpKI7f1KAFL/
	 9YmmVLXYRibTah417voGltJebTAiXvYrs5jFBzuZ0IXBN4a5RSWRsddiIFyYUQnYgRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b5vfuRa1;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70532606A326;
	Mon,  2 Nov 2026 18:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70532606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b5vfuRa1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793644639; x=1825180639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XBBSxBJM4dbAmhw9qJHLVU5PGpaTLbyMmJayE5/gdWA=;
  b=b5vfuRa1YCBnl5GCe7xI9NJo265n/Y2WNPDyBu2GdKE2GRKo9IzWiloJ
   YQU7eNuV9wQpsKQIBurLJ9gDYIcu5gCC5DF5ni6ReJ7DDMY3GydoT0aeP
   t9UYx7Bph8STqeMfjrV99vvnpaJLI1DpfJH2nrgQSZ+3aSiOZqzBquwAu
   8Gu2hiDsXomd2nGevVB7iNKTQ7m8A/qJjf/K34KOXUEHKidMrPCdHz++k
   bl4Rnin7MRx7gq+Tb6jiJv6Eq5U0GMFfzpwgWpdpmu/0EGG3Wpc5gR/Hk
   t0Yd76r/52hwbawasen172aV7d9eo2URh/W2cQ/iQ+th9vwTEtuNf275L
   A==;
X-CSE-ConnectionGUID: VKSE0XA8Sl+lt+vBLOs8Kw==
X-CSE-MsgGUID: F0GYaJBNRficM0fJF4lBqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2241902"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2241902"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:37:18 -0800
X-CSE-ConnectionGUID: PwC639boRYutcH2UfyYAcQ==
X-CSE-MsgGUID: tzPbWeIfSDu1ced30xPCeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="8035743"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 10:37:16 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNwu9-00000000heW-2SzP;
	Mon, 02 Nov 2026 18:37:13 +0000
Date: Tue, 3 Nov 2026 02:36:56 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@sina.com>,
	syzbot+a31cda410a4ccd419712@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] loop: prohibit the use of sysfs as a backing file
Message-ID: <202611030239.QMvbuUI3-lkp@intel.com>
References: <20261102103354.427722-1-eadavis@sina.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102103354.427722-1-eadavis@sina.com>

Hi Edward,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/loop-prohibit-the-use-of-sysfs-as-a-backing-file/20261102-183354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20261102103354.427722-1-eadavis%40sina.com
patch subject: [PATCH] loop: prohibit the use of sysfs as a backing file
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20261103/202611030239.QMvbuUI3-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030239.QMvbuUI3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030239.QMvbuUI3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/block/loop.c: In function 'loop_check_backing_file':
>> drivers/block/loop.c:537:48: error: 'SYSFS_MAGIC' undeclared (first use in this function)
     537 |         if (file_inode(file)->i_sb->s_magic == SYSFS_MAGIC)
         |                                                ^~~~~~~~~~~
   drivers/block/loop.c:537:48: note: each undeclared identifier is reported only once for each function it appears in


vim +/SYSFS_MAGIC +537 drivers/block/loop.c

   528	
   529	static int loop_check_backing_file(struct file *file)
   530	{
   531		if (!file->f_op->read_iter)
   532			return -EINVAL;
   533	
   534		if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
   535			return -EINVAL;
   536	
 > 537		if (file_inode(file)->i_sb->s_magic == SYSFS_MAGIC)
   538			return -EINVAL;
   539	
   540		return 0;
   541	}
   542	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
