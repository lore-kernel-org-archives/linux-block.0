Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20C36826E
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525848; cv=none; b=Eylli4jeHQ4SjCXz+MooVF+Bqg/ZQBadh/GOystIhAeScvEsVM/+edlp47fZtHZxs3Aqol5LgpTbA+ugP8N31GmqKctlFfELuOWiP3mE2DwCc6QPuApCfzOkwqoc5XM1+RTeyzT/G8VXuBOUb67PiAeit0p9ZB/x1caJmtzaClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525848; c=relaxed/simple;
	bh=0qDXwnI0ayia0RfWEehAZWocFepIlfvwxRO+KFDh2DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/DE4aYpaZ/JBfszhL7Ylig7ebU9UOC5uT6CyO/HPsCHAad4zZBDbTdETrVgo0NpmdfbBMfcU6yfQvPdL8D7MGuCyODPTiKTug4sr24IclbhAKBX/J0ot6kEQ1cYUX/utf9M8EPhkDikiBoyZhnX9cW/QlIyEOhF6eG2fDzQzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ku1rVycv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ku1rVycv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777525846; x=1809061846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0qDXwnI0ayia0RfWEehAZWocFepIlfvwxRO+KFDh2DY=;
  b=ku1rVycvGq6e1ptkysZ2kjZicZ5Ch4fD2qKNXqxIHxjJNreqT6Pow6JT
   dOblY3hS3nJck7bxU4ZfUgQmtMS/W4Vy/g1U8TYKpxyE2aj1qMh6FZ4H/
   6vrRPWoEWfbYRoqjmhKvBUNKYKfG+tR9uBZq5K4XTeVrAL5tdcF/Nekc8
   ydpI6fqlSih9d4nYh47aY3bQIRy5sByEdqPZlWcot8TrpDezJox9FrAvG
   RYRvQzD930ivS84cZ2ZvYkrBUZ9LMQ/IqYGpY59TMk5IeqTpN3pIpgTJ/
   d7RSXssSNrcmpOYOOX9FVGbGfOhqiTG0hB4YcLGZ3SGmCMy5PNw55YYN+
   w==;
X-CSE-ConnectionGUID: Q9pPwl7uTf23ApFyvuTf8Q==
X-CSE-MsgGUID: kOAfoerBS5KWskMIlyY6AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="96029900"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="96029900"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 22:10:46 -0700
X-CSE-ConnectionGUID: KzXkT50qQNOS3IL1/SgNvw==
X-CSE-MsgGUID: fJkbInRwSnu18BIqqQi63Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234742878"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2026 22:10:45 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIJfd-00000000ByK-39Au;
	Thu, 30 Apr 2026 05:10:41 +0000
Date: Thu, 30 Apr 2026 13:09:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ramesh Adhikari <adhikari.resume@gmail.com>, axboe@kernel.dk,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: Re: [PATCH] badblocks: fix infinite loop due to incorrect rounding
 and overflow
Message-ID: <202604301231.IpPh4AiH-lkp@intel.com>
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
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20260430/202604301231.IpPh4AiH-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604301231.IpPh4AiH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604301231.IpPh4AiH-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: block/badblocks.o: in function `badblocks_check':
   badblocks.c:(.text+0x10af): undefined reference to `__umoddi3'
>> ld: badblocks.c:(.text+0x1109): undefined reference to `__umoddi3'
   ld: block/badblocks.o: in function `_badblocks_set':
   badblocks.c:(.text+0x12b0): undefined reference to `__umoddi3'
   ld: badblocks.c:(.text+0x12f4): undefined reference to `__umoddi3'
   ld: block/badblocks.o: in function `_badblocks_clear':
   badblocks.c:(.text+0x1bfc): undefined reference to `__umoddi3'
   ld: block/badblocks.o:badblocks.c:(.text+0x1c1c): more undefined references to `__umoddi3' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
