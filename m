Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBE4689;
	Sat,  4 May 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714805724; cv=none; b=bwDzhRPiP12hhrDu6OBDvD6RCUij60AhQWFAIHOmVN/n5IiXkumoa4nl0AQmvAPabSWYVvI94kNIsWeNDh7akwr5dJN52toCI1GbyoiYHr9lkQ1nRa/Izl/xkgvZ3jMCnmo/xN0zVIH/leZibZ64J6vAgyIvhL7ezAkNYOAJES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714805724; c=relaxed/simple;
	bh=Yn0D36pQGFB9Z5N/ogNbWoLa2KEjQsWkGtuLzv3u+O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVwMHTwTXU1H4IAkwvqGd1dXPpvTOVaeGnjp/khJD1uK6kLWQAyJ5K3uiyCdGHZbhyWzDmSlK30lGHOR7ON1sw+VNOxG/Xggbcd9MnAqHIMfW8HPTmcS5UNadN25XV0Oz2cG5VJYMXnztl3+/51zVdkHDzWDx4PujkrpK0fl2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbCPyu5Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbCPyu5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714805723; x=1746341723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yn0D36pQGFB9Z5N/ogNbWoLa2KEjQsWkGtuLzv3u+O0=;
  b=FbCPyu5ZaUzbAamr1MmPgkZGbjfhp3LZ4mHRrK6Yu8UvL5mdOaAz6ZjA
   oMZoFxd5X/Qw0sCWDW/SpjQY6cBo/NALnEB5W64JcNZ/URyPezSQmjjTB
   zNMBNeDxmBCihZqmRZlART+Fj3taImqVNYT2XkZXWo3D5n8CVEDAGHVDH
   WqSMuy7GpdRlByziGEUHfevualvNh5AeO3I1fuvdQ9zrx/Va/pAbeDzBG
   d6lgD9LtsPQvw5s8IXcdTP4Z56mqXhJzg870Pk0jpLBNWgtqbUT8ixaL/
   P7P8BFeLrQJ9YE1+qszTQA96brR9Gddk7ImuUNWJBWI3wP+itGcEzvoDS
   Q==;
X-CSE-ConnectionGUID: HUGe1w1bTNKRvG0pzEzMsA==
X-CSE-MsgGUID: zxAZLb1gQs6ZJ0bEvX3b8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10497685"
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="10497685"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 23:55:22 -0700
X-CSE-ConnectionGUID: 3dSA0I9IRgmC/HVcZTBYZw==
X-CSE-MsgGUID: MG4LmfGMQAOJxy4CtmIt+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="28243294"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 May 2024 23:55:20 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s39Ij-000CW8-0d;
	Sat, 04 May 2024 06:55:17 +0000
Date: Sat, 4 May 2024 14:54:41 +0800
From: kernel test robot <lkp@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <202405041440.UTBQZAaf-lkp@intel.com>
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
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240504/202405041440.UTBQZAaf-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405041440.UTBQZAaf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405041440.UTBQZAaf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/block/zram/zcomp.c:12:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/block/zram/zcomp.c:214:2: error: call to '__compiletime_assert_285' declared with 'error' attribute: BUILD_BUG_ON failed: ARRAY_SIZE(backends) <= 1
     214 |         BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:449:2: note: expanded from macro 'compiletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:437:2: note: expanded from macro '_compiletime_assert'
     437 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:430:4: note: expanded from macro '__compiletime_assert'
     430 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:97:1: note: expanded from here
      97 | __compiletime_assert_285
         | ^
   5 warnings and 1 error generated.


vim +214 drivers/block/zram/zcomp.c

   202	
   203	struct zcomp *zcomp_create(const char *alg)
   204	{
   205		struct zcomp *comp;
   206		int error;
   207	
   208		/*
   209		 * The backends array has a sentinel NULL value, so the minimum
   210		 * size is 1. In order to be valid the array, apart from the
   211		 * sentinel NULL element, should have at least one compression
   212		 * backend selected.
   213		 */
 > 214		BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
