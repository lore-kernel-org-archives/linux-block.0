Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B1231CA7
	for <linux-block@vger.kernel.org>; Sat,  5 Oct 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728163472; cv=none; b=PZt/mto8OGXIkuvUQrl/CMSyzI3nX1eYIis2J0L9QNIFHRmaBuxxTZQ/GLx92yHzTec3eOUnMck6kJ99+tTLk4PxDbm+S4sl+VN+/ut9K6nPid/zHl7l3dXTzTJB3ZAWfNsoFMXwj5k6DQerlX0DQlzM2sjR7f8E51WMLlIJ6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728163472; c=relaxed/simple;
	bh=28EJwOlUFbVmu5cykHKDrdq+PZHi92oXA3lleQu2MM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuAdXJx1SnSN/rvfUJUjFaoXEmskmcgVFQuotmSDHyQyFQ20dN8tAOwv2lbPMT8ZjhwmTz9FYG26yH+KLh6BRKNbPjiGciq768HjtAt1GcN/LMVdHBlsGCXnbXlEQrVqdwighegys3Mmhb1atjUD+o1Qh67NwzzaBMvrBT3aZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6ZLdaGg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6ZLdaGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728163471; x=1759699471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28EJwOlUFbVmu5cykHKDrdq+PZHi92oXA3lleQu2MM4=;
  b=h6ZLdaGg6PfUsy8+vbIWQlgyIZcKvuN8zAsvPZsa21iMUizMWR7k/qr9
   14hOM9I1FXUkfFJa2wJp9HCsecM1lBcOsh0zwYWQo1VEt8nSeB7/u7UmO
   S33T8d3a1bU80ahFTSBuh3KlscLtk4JvNbWk2CqIifxRvxqit4keo+ERa
   gBYBuMmxIO8aOLaD5ONdaTMrOFOFVR9XfCAUZtOFhYx24CJZmLB6pBheH
   /lEXTZIABvJWBD9e4V/waW3kZAPYHC0KPq05TaxAhHCuz3/RNd7haTPJR
   vF3Cq3pSvXvXMMTpxtSk8SjIG1oZVi5UTLEOQ14VT8XfckpB8oNY0gO0I
   A==;
X-CSE-ConnectionGUID: zLjZQh8DT8KKzeyHj6tFYg==
X-CSE-MsgGUID: 57TXMwVxTfifYfBaBUaOjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="44883100"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="44883100"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 14:24:30 -0700
X-CSE-ConnectionGUID: Ko8wKgrUThuw/HWovYsTRQ==
X-CSE-MsgGUID: NILWtGSxSPerWSHD5Dr44A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="75033885"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Oct 2024 14:24:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxCGH-0003Mc-0z;
	Sat, 05 Oct 2024 21:24:25 +0000
Date: Sun, 6 Oct 2024 05:24:24 +0800
From: kernel test robot <lkp@intel.com>
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: decouple hctx and ublk server threads
Message-ID: <202410060518.wRBlN5hY-lkp@intel.com>
References: <20241002224437.3088981-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002224437.3088981-1-ushankar@purestorage.com>

Hi Uday,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ccb1526dda70e0c1bae7fe27aa3b0c96e6e2d0cd]

url:    https://github.com/intel-lab-lkp/linux/commits/Uday-Shankar/ublk-decouple-hctx-and-ublk-server-threads/20241003-064609
base:   ccb1526dda70e0c1bae7fe27aa3b0c96e6e2d0cd
patch link:    https://lore.kernel.org/r/20241002224437.3088981-1-ushankar%40purestorage.com
patch subject: [PATCH] ublk: decouple hctx and ublk server threads
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20241006/202410060518.wRBlN5hY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060518.wRBlN5hY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410060518.wRBlN5hY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/block/ublk_drv.c: In function 'ublk_uring_cmd_cancel_fn':
>> drivers/block/ublk_drv.c:1446:29: warning: variable 'task' set but not used [-Wunused-but-set-variable]
    1446 |         struct task_struct *task;
         |                             ^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/task +1446 drivers/block/ublk_drv.c

216c8f5ef0f209 Ming Lei    2023-10-09  1436  
216c8f5ef0f209 Ming Lei    2023-10-09  1437  /*
216c8f5ef0f209 Ming Lei    2023-10-09  1438   * The ublk char device won't be closed when calling cancel fn, so both
216c8f5ef0f209 Ming Lei    2023-10-09  1439   * ublk device and queue are guaranteed to be live
216c8f5ef0f209 Ming Lei    2023-10-09  1440   */
216c8f5ef0f209 Ming Lei    2023-10-09  1441  static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
216c8f5ef0f209 Ming Lei    2023-10-09  1442  		unsigned int issue_flags)
216c8f5ef0f209 Ming Lei    2023-10-09  1443  {
216c8f5ef0f209 Ming Lei    2023-10-09  1444  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
216c8f5ef0f209 Ming Lei    2023-10-09  1445  	struct ublk_queue *ubq = pdu->ubq;
216c8f5ef0f209 Ming Lei    2023-10-09 @1446  	struct task_struct *task;
216c8f5ef0f209 Ming Lei    2023-10-09  1447  	struct ublk_device *ub;
216c8f5ef0f209 Ming Lei    2023-10-09  1448  	bool need_schedule;
216c8f5ef0f209 Ming Lei    2023-10-09  1449  	struct ublk_io *io;
216c8f5ef0f209 Ming Lei    2023-10-09  1450  
216c8f5ef0f209 Ming Lei    2023-10-09  1451  	if (WARN_ON_ONCE(!ubq))
216c8f5ef0f209 Ming Lei    2023-10-09  1452  		return;
216c8f5ef0f209 Ming Lei    2023-10-09  1453  
216c8f5ef0f209 Ming Lei    2023-10-09  1454  	if (WARN_ON_ONCE(pdu->tag >= ubq->q_depth))
bd23f6c2c2d005 Ming Lei    2023-10-09  1455  		return;
bd23f6c2c2d005 Ming Lei    2023-10-09  1456  
216c8f5ef0f209 Ming Lei    2023-10-09  1457  	task = io_uring_cmd_get_task(cmd);
bd23f6c2c2d005 Ming Lei    2023-10-09  1458  
216c8f5ef0f209 Ming Lei    2023-10-09  1459  	ub = ubq->dev;
216c8f5ef0f209 Ming Lei    2023-10-09  1460  	need_schedule = ublk_abort_requests(ub, ubq);
216c8f5ef0f209 Ming Lei    2023-10-09  1461  
216c8f5ef0f209 Ming Lei    2023-10-09  1462  	io = &ubq->ios[pdu->tag];
216c8f5ef0f209 Ming Lei    2023-10-09  1463  	WARN_ON_ONCE(io->cmd != cmd);
b4e1353f465147 Ming Lei    2023-10-09  1464  	ublk_cancel_cmd(ubq, io, issue_flags);
216c8f5ef0f209 Ming Lei    2023-10-09  1465  
216c8f5ef0f209 Ming Lei    2023-10-09  1466  	if (need_schedule) {
bd23f6c2c2d005 Ming Lei    2023-10-09  1467  		if (ublk_can_use_recovery(ub))
bbae8d1f526b56 ZiyangZhang 2022-09-23  1468  			schedule_work(&ub->quiesce_work);
bbae8d1f526b56 ZiyangZhang 2022-09-23  1469  		else
71f28f3136aff5 Ming Lei    2022-07-13  1470  			schedule_work(&ub->stop_work);
216c8f5ef0f209 Ming Lei    2023-10-09  1471  	}
71f28f3136aff5 Ming Lei    2022-07-13  1472  }
71f28f3136aff5 Ming Lei    2022-07-13  1473  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
