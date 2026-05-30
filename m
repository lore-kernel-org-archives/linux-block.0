Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE01233952;
	Sat, 30 May 2026 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170568; cv=none; b=UWHo903PlgoL4Nrmwb0PXkQnTR5lbkWpiUcwLJYNiUWd8UMuigfg5j1bWmcNfgkbHuBOLZEhgvXGtWdEz/LK7SZiysvW/RtmGel9WqzJUw9ZObpL6n0hDAXN4CaEQNS/7TBNLsvHLdZbhskXar/ypSUpetjac4sM4J880KlWnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170568; c=relaxed/simple;
	bh=r2HYZ1309/OZlVyvOT2l/OJyonDxhgfEY4CEmE5YdKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjjSvZCjVR8zEnlnilfYms2fT/k6z5Nv749/YSkKk1CsY/APbCyQvUvyGOMt2/xFnqfUjjnZImJkgIVm6YTLs9l1KA2KiWt1Jl5FgFgCM9NbAVr9U6ZfPp8uUAu7LdhNbTAK7DRT1FGR49sQv46QFen1eJ3mKj9p6w7tDaOAUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bj83evpA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bj83evpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780170567; x=1811706567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2HYZ1309/OZlVyvOT2l/OJyonDxhgfEY4CEmE5YdKQ=;
  b=Bj83evpAQbHIiFwQMJzLgSJSzWgmfTQOGsl6rOS3Bx6BqK3NniDMw9wD
   Ln+OGxI9TdgFsvzIp8R9K+5GaO5OKKPiTLUU67q16+EyEnEctNG2yzvh/
   7735MJF//0lNhaVkQBsUVtQLzEkEEPDYWy16v8m+01UT2FN7QKLXz5uOn
   nf/8Mu96MyEXvEfrJtOGs/XIu9nezHK9QQegKoEqGmiicjw5ldwblKPCH
   k4eT7xE0YD7Xgi28z6UpPmHIiRd/M03Tnz2khQ/qtApHK1QpV+PiRqdxE
   bs4iudqCYlhp8JdXuUdBSPn4vZdOlxaKI6CO1Bzqnrcda3k1LxPGvF5Cr
   g==;
X-CSE-ConnectionGUID: DYIu6K1HQDaPLtysDbCNGQ==
X-CSE-MsgGUID: QWlFQJumRCm+QSwyc3BMgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="92367061"
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="92367061"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 12:49:26 -0700
X-CSE-ConnectionGUID: WrVI3wmXSVSZaKetzgcb6g==
X-CSE-MsgGUID: neI8wEgjR/qzIuBfSXLVLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="244979562"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 May 2026 12:49:23 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTPgN-000000008p8-3PBB;
	Sat, 30 May 2026 19:49:19 +0000
Date: Sun, 31 May 2026 03:48:44 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] loop: reject binding to procfs and sysfs files
Message-ID: <202605310318.dbidMe6W-lkp@intel.com>
References: <148efba2-a0b6-47d7-ac76-b19d2f4b696c@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148efba2-a0b6-47d7-ac76-b19d2f4b696c@I-love.SAKURA.ne.jp>

Hi Tetsuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.1-rc5 next-20260529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/loop-reject-binding-to-procfs-and-sysfs-files/20260530-214900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/148efba2-a0b6-47d7-ac76-b19d2f4b696c%40I-love.SAKURA.ne.jp
patch subject: [PATCH] loop: reject binding to procfs and sysfs files
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20260531/202605310318.dbidMe6W-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9409c07de6378507397ecdb6f05f628f58110112)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605310318.dbidMe6W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605310318.dbidMe6W-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/block/loop.c:504:7: error: use of undeclared identifier 'PROC_SUPER_MAGIC'
     504 |         case PROC_SUPER_MAGIC: /* e.g. "losetup -f /proc/sys/kernel/version" */
         |              ^~~~~~~~~~~~~~~~
>> drivers/block/loop.c:505:7: error: use of undeclared identifier 'SYSFS_MAGIC'
     505 |         case SYSFS_MAGIC: /* e.g. "losetup -f /sys/power/state" */
         |              ^~~~~~~~~~~
   2 errors generated.


vim +/PROC_SUPER_MAGIC +504 drivers/block/loop.c

   478	
   479	static int loop_validate_file(struct file *file, struct block_device *bdev)
   480	{
   481		struct inode	*inode = file->f_mapping->host;
   482		struct file	*f = file;
   483	
   484		/* Avoid recursion */
   485		while (is_loop_device(f)) {
   486			struct loop_device *l;
   487	
   488			lockdep_assert_held(&loop_validate_mutex);
   489			if (f->f_mapping->host->i_rdev == bdev->bd_dev)
   490				return -EBADF;
   491	
   492			l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
   493			if (l->lo_state != Lo_bound)
   494				return -EINVAL;
   495			/* Order wrt setting lo->lo_backing_file in loop_configure(). */
   496			rmb();
   497			f = l->lo_backing_file;
   498		}
   499		if (S_ISBLK(inode->i_mode))
   500			return 0;
   501		if (!S_ISREG(inode->i_mode))
   502			return -EINVAL;
   503		switch (inode->i_sb->s_magic) {
 > 504		case PROC_SUPER_MAGIC: /* e.g. "losetup -f /proc/sys/kernel/version" */
 > 505		case SYSFS_MAGIC: /* e.g. "losetup -f /sys/power/state" */
   506			return -EINVAL;
   507		}
   508		return 0;
   509	}
   510	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
