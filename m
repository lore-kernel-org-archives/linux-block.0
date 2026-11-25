Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638271;
	b=UP1R4grrZNYj1PaCSqF6pyRzkClKmPGT/KoXQg6kTa1rvmRKO04aDenzyhOdglnXAYc6
	 J406/Wvkeh09zRBeKsthavutPL8p6wdqDBG6rpHGOui7ZVFZGM5HIhUN761QTSu50ut4F
	 WrmaPv/HgTOzc0aZ82XnPpjwsOnuydJZ3jg+TsVbzqStdHLxN8k4G/sovNqIzYiXut25E
	 ACGNlDDy6bcp4v5h9/qm7cLqJC6oIY54+RwBauhdApFIA5SqV7dKavwiNhZK/6ZZj6Rlz
	 ueXtgLJOvEI4nY5NWfjyMmDFM3yuJdx6e/bx06puVFAQy2+J3bho/jEtX4BZ+p4nRxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638271;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=W6kSkTrweSQ0wcU2dbEyxHrUIkg5Sek2FnfGWXLCYjc=;
	b=LYk5XA1MkfCfkp4XFsSm/wyQvvJn0QgeAPb5d2EQnhKqpMu78LH3aMNITzmEOF5bMqdq
	 w0aZlCkmQ2uwW+E9NE6SS4+VktsdQxO6IM7Gj9l/uTwqnxtZgw1UueM0MLAkRFwaBT6KE
	 ep8RE0dZNh7TvAyWmbnjHAD23BnLfrlm9vKZtZLDIgnZIFEYJJtsldtREqCyX94ZFM5T7
	 yQSfvLxnpKIijHnOWLzEB68JH8t37WF/EmAeQyP8oFkppEwN0uthvAKTeQwy5RrgF8G1X
	 rvE9rUgr83mBMexWhcTFnE63Gf0r2HDk4pFc875oXoOtQGTgAiwgIFsufuVgfGwu9Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQFDt3z5;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24E606A31E;
	Wed, 25 Nov 2026 20:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A24E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQFDt3z5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795638271; x=1827174271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opOUzu9CI5VspuCJ7TqUH2I8StJt23oLfhcFKQY18Qk=;
  b=SQFDt3z5WA4IKyGJB5hlp239vQ5NmWzBWzffMV3Ab6v3pkZc/L23tsCi
   /7Ob2izsFjov8j5st606HAR8fMJXpqwBr6vuUbKDiOE4tKvvW2sdrtY4P
   yy6oHBOhpUIYAu5sdHbblFJo+F1bXIVGVLKozJjLy/M9bR2kWr0wJ6shE
   uRiCwnEW5aH40SlpgW/MH+efxJ9h/Ql08+2S0OW4cXzJJjjGeVpdYjyvv
   tJWZMKU1SMhAbXJQMbDAgq4HnlHNlxmRZgUC2lbCm/r7lyWZnYYwlhxgT
   YDnCiV5LOSkGgIxGVgIUbqveYiDOLojt2kTEvOLcXT7SREwcr3DigmXNy
   w==;
X-CSE-ConnectionGUID: bVxKu0ORRdWzZt4xE9MoDQ==
X-CSE-MsgGUID: nIT1qk85Qbq9EurS8R2sCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4419666"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4419666"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 12:24:30 -0800
X-CSE-ConnectionGUID: fnaUMappR4mcIFMGaoFcEg==
X-CSE-MsgGUID: DG4ecEMZS5Sj2YHpzK1moQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11835676"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Nov 2026 12:24:28 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWJXV-00000001SXe-2kch;
	Wed, 25 Nov 2026 20:24:25 +0000
Date: Thu, 26 Nov 2026 04:23:37 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
Message-ID: <20261126041726.kXD9a5hZ-lkp@intel.com>
References: <20261125153511.3060599-22-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125153511.3060599-22-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa7014f8d7565cfea117eac36a5de0a05eba65a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20261125-163451
base:   aa7014f8d7565cfea117eac36a5de0a05eba65a4
patch link:    https://lore.kernel.org/r/20261125153511.3060599-22-christoph.boehmwalder%40linbit.com
patch subject: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20261126/20261126041726.kXD9a5hZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261126/20261126041726.kXD9a5hZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261126041726.kXD9a5hZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/block/drbd/drbd_receiver.c:407 function parameter 'connection' not described in 'alloc_pages_throttled'
>> Warning: drivers/block/drbd/drbd_receiver.c:407 function parameter 'throttle' not described in 'alloc_pages_throttled'
>> Warning: drivers/block/drbd/drbd_receiver.c:407 expecting prototype for drbd_alloc_pages(). Prototype was for alloc_pages_throttled() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
