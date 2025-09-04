Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0A30FC0D
	for <linux-block@vger.kernel.org>; Thu,  4 Sep 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009032; cv=none; b=oeQCAeLvvx6EjNPFnEmGWdjI3yZZGNCnC9eC1LozQyV58EtWKPlusNYGpMPX0VhpUAPHLVRUgwIcS8Izv+F07yZxpSe21thQcCgR3sYsXvkRUpfIYPrzLjWRaKtooTc0FPwe4Lx9Er6/MCApastl2Q8sGh0sSvqDmb+sdU3OD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009032; c=relaxed/simple;
	bh=ymrXcQJetdvND6FIBkZJMvg9Zf1rW9i5Xw3TcvudkzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBZHDUU1c6EKLWeiR0vof8lHL3iVZd/MUKENjAWzDG+poHyPu34MbSG7Xv8JQJo1QNtTGQ2twcSJ9Hq6/fbLNkuwpiqJSorJBQU80czU0PpbC+/6lglJPLDhmroeya/XlRh8b/F6mTG49Xkkays+VbEiNwPY/CO2LOTCDRxd0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTB/Jyds; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTB/Jyds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757009031; x=1788545031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ymrXcQJetdvND6FIBkZJMvg9Zf1rW9i5Xw3TcvudkzQ=;
  b=cTB/JydsEqqm8HZm+0/xYuM9kG5cQ6nwCq7vmUy7xMFdu0G/3gJ7u78g
   GDlOzFCR5Tig8N1CfjodFzAUag1U0FJ82/WplCzdWITj2NuG/RfoKfA/P
   M2rkTrGsZoNVtw6tGW7XZRDdkXxTbOA7vQppRffTAejfTPtbs2o0chuK8
   +YaDrQqSw1mhDTuAkrleaJoVIcUX5VVGDgZBBpF0py17qBKrcN50h+BgD
   TpsLeZaT/ajD6TZT3Se/aWpXATzCvtBeUFH7xRyWAaqjwKk6mpRHccs+j
   sM9qaCxf7NRZIHedM1PpVrnv2HV+HG7OTRZiGH5jryewL0ofueyPFkoFf
   Q==;
X-CSE-ConnectionGUID: tXB4lbMeRFm7PVtOLIEwrw==
X-CSE-MsgGUID: JkeqEpGnQL2P+D5AuPLICw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="76813766"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="76813766"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:03:51 -0700
X-CSE-ConnectionGUID: FLrroYHCTxqjnDVywxxXNg==
X-CSE-MsgGUID: L/CHNkqlRoGSYBA13Cnh+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="177226633"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Sep 2025 11:03:49 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuEIe-0005aZ-38;
	Thu, 04 Sep 2025 18:03:26 +0000
Date: Fri, 5 Sep 2025 02:03:03 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Yufeng <chenyufeng@iie.ac.cn>, axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: Re: [PATCH] Sanitize set_task_ioprio() permission checks
Message-ID: <202509050122.1DzOHKji-lkp@intel.com>
References: <20250904031312.887-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904031312.887-1-chenyufeng@iie.ac.cn>

Hi Chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.17-rc4 next-20250904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yufeng/Sanitize-set_task_ioprio-permission-checks/20250904-112027
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250904031312.887-1-chenyufeng%40iie.ac.cn
patch subject: [PATCH] Sanitize set_task_ioprio() permission checks
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250905/202509050122.1DzOHKji-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509050122.1DzOHKji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509050122.1DzOHKji-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-ioc.c:249:7: error: call to undeclared function 'ptrace_may_access'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     249 |         if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
         |              ^
>> block/blk-ioc.c:249:31: error: use of undeclared identifier 'PTRACE_MODE_READ_REALCREDS'
     249 |         if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
         |                                      ^
   2 errors generated.


vim +/ptrace_may_access +249 block/blk-ioc.c

   243	
   244	int set_task_ioprio(struct task_struct *task, int ioprio)
   245	{
   246		int err;
   247	
   248		rcu_read_lock();
 > 249		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
   250			rcu_read_unlock();
   251			return -EPERM;
   252		}
   253		rcu_read_unlock();
   254	
   255		err = security_task_setioprio(task, ioprio);
   256		if (err)
   257			return err;
   258	
   259		task_lock(task);
   260		if (unlikely(!task->io_context)) {
   261			struct io_context *ioc;
   262	
   263			task_unlock(task);
   264	
   265			ioc = alloc_io_context(GFP_ATOMIC, NUMA_NO_NODE);
   266			if (!ioc)
   267				return -ENOMEM;
   268	
   269			task_lock(task);
   270			if (task->flags & PF_EXITING) {
   271				kmem_cache_free(iocontext_cachep, ioc);
   272				goto out;
   273			}
   274			if (task->io_context)
   275				kmem_cache_free(iocontext_cachep, ioc);
   276			else
   277				task->io_context = ioc;
   278		}
   279		task->io_context->ioprio = ioprio;
   280	out:
   281		task_unlock(task);
   282		return 0;
   283	}
   284	EXPORT_SYMBOL_GPL(set_task_ioprio);
   285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
