Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155623B62B
	for <linux-block@vger.kernel.org>; Sat,  1 Nov 2025 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761972921; cv=none; b=ZNtBI46fdiJ8gEa2t0xZelCWl7/EcqjpMaKXT67S8YXTOVDGBFOYHrLnk8M7onpHZhd1/muQBl6qQmj43VXWuOzLSpb1YtkZOCsn62MEi8/Imi2csKAD9MvxjOPQ3joINU4sNvnWojF8lGDWETuqGn17bKGh6rOTlwl1d90sY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761972921; c=relaxed/simple;
	bh=k2Ta0V4Zi5yChgA3g73y84ZiYczegwmoupUhOgDn8og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByT3IDqn3jxelyUE7HeKRKrGq5k213teCovH8pKnoeoew4xI1UCVDzdqF0LZM+x9syNczx4Gxc38FSoL322UJu66liPNir0yysI31T0mAcQ3QDXTxUdCC2mzhTTygNIe8TjfIWsY0Dxi2d5ehCNWAphbK1/kHIVTav7ZhIEnhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8xyeY32; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8xyeY32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761972920; x=1793508920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2Ta0V4Zi5yChgA3g73y84ZiYczegwmoupUhOgDn8og=;
  b=K8xyeY32Jn+5x3hLXODvrdNgW9lfBb0Qxz0K8EHsvE1qGbRSHTp09gZv
   VLXnoEyXEEqQTjWgpIbiUfNXp6QmpyF/RE74W3kWaeQvu/UKyCqLcC8fk
   Q86UHgzhsxJpv0KjNh3Up/L3jhlpdeinfP0eMta6wsEULrLw1ZnU9UWnM
   eVxKqtkci7G8OGwyNoYBC55t3JSJnHKfLtmTxyT7t7f4zjRcn6eA4/otK
   qQJ7DeANkpup3dCST+T4VtzmpJIIyG6R8daKRm+jks9Z2dmLeazBycdzY
   2gSyps11H+9NwUdWL1ETNhg8zeS0e+dMr+EVRSgFfP3pyh0bVTMXs/PX0
   w==;
X-CSE-ConnectionGUID: ADG342/0SeO4pl+lY7DlsQ==
X-CSE-MsgGUID: jM+QGFJ+R/+FyZs2yp9OYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74809938"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="74809938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 21:55:19 -0700
X-CSE-ConnectionGUID: kSs1uohTRsG4Slfx4QHWlA==
X-CSE-MsgGUID: jN/YVgw5QWqGV0x3jrUupg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="186727222"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 31 Oct 2025 21:55:17 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF3dz-000NvQ-1b;
	Sat, 01 Nov 2025 04:55:15 +0000
Date: Sat, 1 Nov 2025 12:55:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 12/25] ublk: add batch I/O dispatch infrastructure
Message-ID: <202511011248.dCy9UFHa-lkp@intel.com>
References: <20251023153234.2548062-13-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023153234.2548062-13-ming.lei@redhat.com>

Hi Ming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes axboe-block/for-next linus/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/ublk-add-parameter-struct-io_uring_cmd-to-ublk_prep_auto_buf_reg/20251023-234335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20251023153234.2548062-13-ming.lei%40redhat.com
patch subject: [PATCH V2 12/25] ublk: add batch I/O dispatch infrastructure
config: i386-randconfig-061-20250510 (https://download.01.org/0day-ci/archive/20251101/202511011248.dCy9UFHa-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011248.dCy9UFHa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011248.dCy9UFHa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:108,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/linux/list.h:11,
                    from include/linux/module.h:12,
                    from drivers/block/ublk_drv.c:12:
   drivers/block/ublk_drv.c: In function '__ublk_batch_dispatch':
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:565:9: note: in expansion of macro 'printk'
     565 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:565:16: note: in expansion of macro 'KERN_WARNING'
     565 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/block/ublk_drv.c:1546:17: note: in expansion of macro 'pr_warn'
    1546 |                 pr_warn("%s: copy tags or post CQE failure, move back "
         |                 ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
