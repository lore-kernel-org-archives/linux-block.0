Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572096AB6;
	Sat,  4 May 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714806984; cv=none; b=ms/46olCMPGAEdisng5W4U2mgTpzylCzGCUb12sI5jbkcmjlrOjXCEqetaWHDbQb6G1sdwYEZzv6cFUCx4Jle5O/8tfSEUG+s0kiawvt5YIcSFa1dz0ij+Dbuf+43V1UW67aP3lM5Q8CtmpH2cdyCErkPuceWlSGSijtICMRZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714806984; c=relaxed/simple;
	bh=AGnZTvpBoxJWy6rzbFF15qCrGC/No9YalvIbOMG99Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgR4Q+jALNScMuetw4oHu0QAL+/ArpCzNxF2fnDMkkQ0Q4iKUt3ZuxBpB8/u6TIxRaJ1ZmzJhLDf1URKny6tO5uvaC/mULXEjXKf5xZ1O0+BfcWzDp62Lcj1HABXuOQFgwdk2jELSaWvtY9ST9y2hM/bs3M7xPEAW8aTJfcn36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmzM3irP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmzM3irP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714806982; x=1746342982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AGnZTvpBoxJWy6rzbFF15qCrGC/No9YalvIbOMG99Rs=;
  b=DmzM3irPxf5jkpT1fsUaVm9lmohRJtpw4QibmaeeK/5+0sDtIvnxBzeu
   V6po6+hObFkZmntFRhowdZNIdXxHBtTYTOXc+argAWTc2eG/pDvqmlj5h
   sJBIJDdNGmMs2z3lZYVpUKAHPTZ80ZYOxne5wog/A8RSisravZOwYDkkQ
   VevGKfccVgT9wymcHlYgUJ4wvpgmmNmJ2mVtLmpS4OTh2AkzeZt95CUMT
   XKnrkrTkPdWaR1eFoLkxEPjIHpZCVLNxNcSy7yjJFqDKrLQ325KlmZ8si
   /xQzXJvpqxPOBOvofu4xdGyTqTAMGYOcmZUvysezo1bboFnM/Ys6tKOcY
   g==;
X-CSE-ConnectionGUID: PPgvsPsrQtmHGZYyJ1GzWg==
X-CSE-MsgGUID: +HMdSQ2WQSKIU4RR09vVXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10742041"
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="10742041"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 00:16:22 -0700
X-CSE-ConnectionGUID: WTNh5QHqQ2KlCLvs5fQhLw==
X-CSE-MsgGUID: EDJTmVutShCs4ocV9Ml+nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="58568468"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 May 2024 00:16:19 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s39d3-000CWm-1u;
	Sat, 04 May 2024 07:16:17 +0000
Date: Sat, 4 May 2024 15:15:24 +0800
From: kernel test robot <lkp@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <202405041458.j3L25KZg-lkp@intel.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503091823.3616962-9-senozhatsky@chromium.org>

Hi Sergey,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Senozhatsky/zram-move-from-crypto-API-to-custom-comp-backends-API/20240503-172335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240503091823.3616962-9-senozhatsky%40chromium.org
patch subject: [PATCH 08/14] zram: check that backends array has at least one backend
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240504/202405041458.j3L25KZg-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405041458.j3L25KZg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405041458.j3L25KZg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/block/zram/zcomp.c: In function 'zcomp_create':
>> include/linux/compiler_types.h:449:45: error: call to '__compiletime_assert_419' declared with attribute error: BUILD_BUG_ON failed: ARRAY_SIZE(backends) <= 1
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:430:25: note: in definition of macro '__compiletime_assert'
     430 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:449:9: note: in expansion of macro '_compiletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/block/zram/zcomp.c:214:9: note: in expansion of macro 'BUILD_BUG_ON'
     214 |         BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_419 +449 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  435  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  436  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  437  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  438  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  439  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  440   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  441   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  442   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  443   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  444   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  445   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  446   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  447   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  448  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @449  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  450  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
