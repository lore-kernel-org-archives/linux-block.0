Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93738228C;
	Wed, 13 May 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663352; cv=none; b=c2pmzRAooqywHXBA1/jIEB0bXTFliZwEDfm5oZapI+cgb6A102CIT1QfwxENKWXykeS//4idjK87DhJsEGXOXn7Z+JbG1JfteCSuAXVQ264ihdltkPabjqT4Eq5KQ9qMawFcL+0ovEAPV0tjLy3ZHNyhxiKb62h91HwB5G2oqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663352; c=relaxed/simple;
	bh=/fqe0KaoKedQpKh/0AwxeUGmfv5zpXXkYLxsWAO1RN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyiIzie8vpxIAk6FM1aul4g+Kn3Yororcn5O97f1seZ4uDTC0CjlKc3PaKxUqkws1Rm8EdPb5Ht8ZjkwDUAzz0gVCVxqtnIm2Ly7SePFakMmRvuWC9zVMXScS79etF2vPdJi42oSYLZXc5KRGKPRgTtN23xDn6BSf2ycp9iOnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6i1njgX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6i1njgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778663350; x=1810199350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/fqe0KaoKedQpKh/0AwxeUGmfv5zpXXkYLxsWAO1RN8=;
  b=A6i1njgXb8tuXdb8rKTiKjhNLtNn6hwC6zCf91jzFgu6nkbQxjhvR/5w
   8o1N+l0yqg3PIsgEHLtYpJ6ywBAfzZlWVDgE+bgPeyZMn5SV+DcfDgLFb
   v1L1gM8+Wov1xxq5Q/4w9Lo6SGoL2bjHRNq1ywxxJnGb3VWNHo2R+R41a
   GUK0/X/7kRXthTpmX2JL/2rc1G6VYU/ACq7M15xkHujBFkurBIDSH0awS
   Sg+dxHwcMo7/q79D+MLIkw3Q+ASnx2IRYDHy+ZWSHhBcAOpEINjBPhGDw
   l3cLt3fRZzLObjRBJQVa9BBaxqHFybPb6exFnKMW6mA0/ZXb4cunVzb0e
   A==;
X-CSE-ConnectionGUID: BQLhFM6ATCGeAABJzTxhIw==
X-CSE-MsgGUID: SSOkwxRITmWwO5lrjmQMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79297879"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79297879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 02:09:10 -0700
X-CSE-ConnectionGUID: Cpbewn+aRiCY3V1ek5iZBQ==
X-CSE-MsgGUID: 5iE9vM7wQUqCBWiQxZ64Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231643691"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 May 2026 02:09:08 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN5aT-000000003oJ-2MlF;
	Wed, 13 May 2026 09:09:05 +0000
Date: Wed, 13 May 2026 17:08:15 +0800
From: kernel test robot <lkp@intel.com>
To: Li kunyu <likunyu10@163.com>, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li kunyu <likunyu10@163.com>
Subject: Re: [PATCH v2] block/blk-iolatency: Add the processing flow of the
 chained bio in the QoS and define the related types to solve the problem of
 incorrect inflight processing in the QoS. The usage of the done_split_bio
 abstract function in the blk-iolatency project.
Message-ID: <202605131714.5UCGE4aF-lkp@intel.com>
References: <20260506024244.2741-1-likunyu10@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506024244.2741-1-likunyu10@163.com>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-kunyu/block-blk-iolatency-Add-the-processing-flow-of-the-chained-bio-in-the-QoS-and-define-the-related-types-to-solve-the-prob/20260513-135008
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260506024244.2741-1-likunyu10%40163.com
patch subject: [PATCH v2] block/blk-iolatency: Add the processing flow of the chained bio in the QoS and define the related types to solve the problem of incorrect inflight processing in the QoS. The usage of the done_split_bio abstract function in the blk-iolatency project.
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260513/202605131714.5UCGE4aF-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131714.5UCGE4aF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131714.5UCGE4aF-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: block/bio.o: in function `bio_endio':
   bio.c:(.text+0x260c): undefined reference to `__rq_qos_done_split_bio'
>> bio.c:(.text+0x260c): relocation truncated to fit: R_NIOS2_CALL26 against `__rq_qos_done_split_bio'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
