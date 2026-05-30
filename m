Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2D2E8B98;
	Sat, 30 May 2026 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173993; cv=none; b=ipu3+fKBvONR5GS0bSj2dCycP45SMwL8S7HrvnOFxeDClv5bLcyqmmpqK+ZQJDNRreAk1QLdV0NBtJ1qg6H2tP7hZbU/d+9uheY0RQhbd3/TsDXmI/A276jXRyiP/PZ8qHenfxHB52G/0QNIkBdCOTniqX381GeC+AaJtMzzaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173993; c=relaxed/simple;
	bh=IKhWW7LSJTC41x0mWNouiX5kSdHnHIBXrgOzOcenlZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzKWoIeBrppJlzqjJuwQSeTZ3UABABchfvFywFsBXY6Vy54ZBT9haz5lLwTP38megqnA0X1aS/Cxu8CddIC8aePDeY/4eiw6YYZJHYfMA/awnAdrCsKERmGn9Jufwvz48OvaYeAU+muFCIkFqT6uKq2HfzUJWKorVvuK0xklQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEAWEJtb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEAWEJtb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780173991; x=1811709991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IKhWW7LSJTC41x0mWNouiX5kSdHnHIBXrgOzOcenlZ4=;
  b=IEAWEJtb9yUJ/cm8RwZU4DSn2KERzRIoYjpXG9UedVSF7M8pISL1CqxR
   lmSxjg5rUI2BmC+j/1YBFvwwkaM29iD7IhRBY6aoC/KUhEXZMSbkS2gbT
   Gvr/vZIBYmcFJBNOn4gkMI6JmyxlELUGvkFdud4q2nAN91naPLCi4bcCM
   WOXRV7cKOlEGeEJjZWZsbmE1gQcDsgVyaHLL/HD4FhNoSG+3tCYSNuYYO
   VG4C5F0s6BsR6UvFjZRvcX1ikY8lCXp7uQu1xMVodvZ43C83pkRMVJpYY
   cJ30Q79wnStsXyc0aKMBrwsRvuFSU7JMQFjl9oVY0OklUWJxa0m77O1qN
   w==;
X-CSE-ConnectionGUID: OgSUpJe8RraFrxiMHwe5Mg==
X-CSE-MsgGUID: fvK2EnlERTm6caE3gI8hDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80716608"
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="80716608"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 13:46:31 -0700
X-CSE-ConnectionGUID: DGrd7KQqQsK+ayMD8X3rew==
X-CSE-MsgGUID: MmoRbom1RdK7+lt6il1nYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="238985489"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 May 2026 13:46:27 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTQZc-000000008t4-1F25;
	Sat, 30 May 2026 20:46:24 +0000
Date: Sun, 31 May 2026 04:45:53 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] loop: reject binding to procfs and sysfs files
Message-ID: <202605310413.Xgk6vCeB-lkp@intel.com>
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
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20260531/202605310413.Xgk6vCeB-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605310413.Xgk6vCeB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605310413.Xgk6vCeB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/block/loop.c: In function 'loop_validate_file':
>> drivers/block/loop.c:504:14: error: 'PROC_SUPER_MAGIC' undeclared (first use in this function)
     504 |         case PROC_SUPER_MAGIC: /* e.g. "losetup -f /proc/sys/kernel/version" */
         |              ^~~~~~~~~~~~~~~~
   drivers/block/loop.c:504:14: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/block/loop.c:505:14: error: 'SYSFS_MAGIC' undeclared (first use in this function)
     505 |         case SYSFS_MAGIC: /* e.g. "losetup -f /sys/power/state" */
         |              ^~~~~~~~~~~


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
