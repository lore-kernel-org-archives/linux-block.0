Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BA2D738A
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504030; cv=none; b=FwzewodMwu3QEc1W365gds65wPTZ2hgxkWdUsHhg7CqPKdyR8Snux97/+E6WtK4ev2kNfj6VpTQWANUWPW+hwKfsOKbCtQdSlAqPmep0F0JopFZJNQZvh+tlrdN3eVFvmOULSbVoJXm9cMiGAWRkNfttCwPCkeIpbcmxwp4jG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504030; c=relaxed/simple;
	bh=FN0xJiiaWruxpsEO2QZ9TdrzWfjegcjpfa9QPPdlmdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRUtozr3qE9xYdz0ZNEBbXwwqMw7TaS+0p7g9SjoZtpN0vq2X4GZhq8cxAJKwQ4kxWDCPVVQ0nPj2JlQPbVSSxmHWTo7QPiwQDiOseqjDj8ra3qibGY/W62jhG6n1cGoXL8cUQotKdJYxhZZJqS9APQE2e7c5hgbohhjv0BxMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1b2xXvd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1b2xXvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777504027; x=1809040027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FN0xJiiaWruxpsEO2QZ9TdrzWfjegcjpfa9QPPdlmdo=;
  b=e1b2xXvdIPhP4y/ie/7vnOxP/Oc+cmOqNrrdHDTj3oZOTaLXcUAGhGLm
   zUrB09C8gtm5YxHtfj1hobqbgLBwwwiXxCXl6ioXi4dd20tZQ48+Nu7J2
   zEf/Jv5u7VVrTLjPCPKNtzBK0uxhdwFCS8lPHkLfb/ncbpz88HviErI1X
   PoVzN9MRB2xfNQ0oklV1lN2Ya0SQtnKFym+O0plP3VcnHUHIaEaNSzjZS
   nybNPEg7MMSKkNwgogxUFxvNxRhf1+eNRvNRzdJLKV2BWGXse9NHcbs9W
   TYF8PlnI4oUApLoEBxlnhRFPqIi6TuOg5KR7oTdR759m4tWuk+tautn5P
   w==;
X-CSE-ConnectionGUID: OgNqXyK+SFK/nLIHx04h5Q==
X-CSE-MsgGUID: 4Kk6C3loRN2lJIzKovDEWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77611424"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="77611424"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 16:07:06 -0700
X-CSE-ConnectionGUID: JV8J3VpHQU+QjZf3iERmAw==
X-CSE-MsgGUID: 3WzLT5BrRWqQUvDwQF2cjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234676550"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2026 16:07:05 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIDzi-00000000Bd6-1nS4;
	Wed, 29 Apr 2026 23:07:02 +0000
Date: Thu, 30 Apr 2026 07:06:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ramesh Adhikari <adhikari.resume@gmail.com>, axboe@kernel.dk,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: Re: [PATCH] badblocks: fix infinite loop due to incorrect rounding
 and overflow
Message-ID: <202604300729.gKrAMFdE-lkp@intel.com>
References: <20260427151048.756072-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427151048.756072-1-adhikari.resume@gmail.com>

Hi Ramesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.1-rc1 next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramesh-Adhikari/badblocks-fix-infinite-loop-due-to-incorrect-rounding-and-overflow/20260429-044425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260427151048.756072-1-adhikari.resume%40gmail.com
patch subject: [PATCH] badblocks: fix infinite loop due to incorrect rounding and overflow
config: arm-randconfig-002-20260430 (https://download.01.org/0day-ci/archive/20260430/202604300729.gKrAMFdE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300729.gKrAMFdE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300729.gKrAMFdE-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: block/badblocks.o: in function `badblocks_clear':
>> badblocks.c:(.text+0x1d18): undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: badblocks.c:(.text+0x1d54): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: block/badblocks.o: in function `_badblocks_set':
   badblocks.c:(.text+0x2c90): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: badblocks.c:(.text+0x2ce0): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: block/badblocks.o: in function `badblocks_check':
   badblocks.c:(.text+0x3fb8): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: block/badblocks.o:badblocks.c:(.text+0x4018): more undefined references to `__aeabi_uldivmod' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
