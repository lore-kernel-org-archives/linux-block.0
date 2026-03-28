Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81935AC01;
	Sat, 28 Mar 2026 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774700552; cv=none; b=iSqbJS7C4esgFtKmb/YbWpWZjZOHboSy3a4DqVh2uqqwfi/A+nVUpg0I1uWG2julZ2ojQGqd6Y1WSm5h9DVfz6KBlk0yd8p7Mwxq0KNCos3YRfT98O0IMBiM6Xg/990KDNVRulN8YRYq7lqpLXgKS0UllVHt2WzpIKxXxF5ynUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774700552; c=relaxed/simple;
	bh=01Mfx2yhrdKt7kNgZD6z/YZFVAtYMbYQCfPVplKHSds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BerZfF2xtAx+FBLDfnFvSgxJQcd1jKsvJ+CehfJj/tpXMvAzo4jeSI78mBvodj+lThHaKjO9MCQZSXueKL2DG9nNgYqZGTa2Vf+cjh9jXc4HRhp4JW48WiqFWBKmR9xXcFOfvJqHp6M2VJWVkecscWmM18as5t1zuT5HiYD9Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7h+0/k3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7h+0/k3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774700551; x=1806236551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=01Mfx2yhrdKt7kNgZD6z/YZFVAtYMbYQCfPVplKHSds=;
  b=E7h+0/k3g8RIabM96YyiFTbFF7BfC2kMEFmgZDRrcKDIIa3GgpgvBmuA
   TPSJo/hCCQJSWZ8hNJgg6mFuA8QXe6wiaGzW/9WxMJWkWPIjtGt2l9CLa
   Feb5ilHTjn7qo/GeSFYp0CrtSHmkzFqZDpBvezTMzsFCBg6xxeaHo/Vu+
   ZbbxcyyosASZL/B3+5umrdDTZhitLn740YFiBBgxF/GZVMLj/kdd2bfYU
   TPORk6sYovwxl7d+yJQXWIv65uA30vmIkOSkdYdGRCYH93YUvN4BjTatr
   zTSq9wAwSdb4Eqi9erBHbyvSC0cTZFoeBrG7rETZRVpafjSoUmOmgdpFI
   Q==;
X-CSE-ConnectionGUID: A4EFOAA8T3W61ZWOipzzDQ==
X-CSE-MsgGUID: JhuaS0/rRRqg0OXptvQUvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86834373"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="86834373"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 05:22:31 -0700
X-CSE-ConnectionGUID: 6B6jVEZkT86z4g1TmEz80A==
X-CSE-MsgGUID: D8lZGgLmTb+DeV7JCHHGdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="225817333"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Mar 2026 05:22:28 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6SgM-00000000BOv-0Rrq;
	Sat, 28 Mar 2026 12:22:26 +0000
Date: Sat, 28 Mar 2026 20:21:48 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 20/20] drbd: remove BROKEN for DRBD
Message-ID: <202603282006.UELjhGio-lkp@intel.com>
References: <20260327223820.2244227-21-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327223820.2244227-21-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 67807fbaf12719fca46a622d759484652b79c7c3]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20260328-153634
base:   67807fbaf12719fca46a622d759484652b79c7c3
patch link:    https://lore.kernel.org/r/20260327223820.2244227-21-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 20/20] drbd: remove BROKEN for DRBD
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260328/202603282006.UELjhGio-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603282006.UELjhGio-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603282006.UELjhGio-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/block/drbd/drbd_receiver.c:496 function parameter 'peer_device' not described in 'drbd_alloc_peer_req'
>> Warning: drivers/block/drbd/drbd_receiver.c:496 function parameter 'peer_device' not described in 'drbd_alloc_peer_req'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
