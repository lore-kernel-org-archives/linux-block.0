Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C430E0F8;
	Sat, 28 Mar 2026 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707249; cv=none; b=lgzGEMaT4nMXioPyNRddh/wRsXLEl86Opgtx45va4zft9/s8+LEEApvr/YH1mpb1hM4nlEowEVcFHwXAZr2MZklCwQynSVqzhbjvsS51LWcVSvLqIS9BV/YBOlQKTztBgF8PkwqyYahIdq+yvKEQVxSQlDfFHSPEnVBTpTIO91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707249; c=relaxed/simple;
	bh=/BGl0+Oz49k5tPl3ySgr/pb+u1t6ujQqJ5mp27HxMDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0CL7u5TcQVKSD2obxCnYEz8ifAF6h7Bvc+0/f7GY89uaQz8EFYwO2hNmpNizMMxdVIYV9LCeoc8TmJ2HEm2uDmwiFJgL8UTnkrRCcMBsH/p5RDNhRXtvHXlQPCbAIR03pw8JWjytCplYhWehPQZJrpkB/MGXpTzTcXXLyb8VGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3ODqVsq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3ODqVsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774707247; x=1806243247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/BGl0+Oz49k5tPl3ySgr/pb+u1t6ujQqJ5mp27HxMDw=;
  b=Y3ODqVsquWlyJFtGWX/gafDt/72nPIzLw/mw9Q/+D82hMrbu4AZysEOO
   CiVapRyHWIE+D0jtGfo3dI+gHRX/Ar/eooSxluY5/7zQJEbkpeWgd9Q4o
   xx8CUiFRvReLJqnke1cGNYpsQ8tM7jwrVW5NMn2x+GINRafgB/Cl05NyB
   KFdjwh2ZUrm4WLSoxMruxXCub761la9c2JS9+Rsg2gti1wFZnkwPxzUEs
   +/45CL76JqkCQRXEGDkbzUrdk5NgXMbI/dTIWPJkSZfCqJDNoUsYu4y1Q
   PYVoxHo1aDfY2xtL4dFKHkpKIkhnNzMQmKVezkpdND9xB9LAuq6pYexF/
   w==;
X-CSE-ConnectionGUID: 9WBj1l+XRSmS+7J5Eabfww==
X-CSE-MsgGUID: 6Ah1qm/SQPyjoJOCcQ4/0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="74794144"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="74794144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 07:14:06 -0700
X-CSE-ConnectionGUID: xU7hdjRVT2C/niVXf//eRg==
X-CSE-MsgGUID: 43dgNcz4TJGPHkxmuhIwYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="227187146"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 28 Mar 2026 07:14:03 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6UQL-000000007gb-2MoE;
	Sat, 28 Mar 2026 14:14:01 +0000
Date: Sat, 28 Mar 2026 15:13:44 +0100
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: Re: [PATCH 02/20] drbd: extend wire protocol definitions for DRBD 9
Message-ID: <202603281537.rTtvjPOL-lkp@intel.com>
References: <20260327223820.2244227-3-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327223820.2244227-3-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 67807fbaf12719fca46a622d759484652b79c7c3]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20260328-153634
base:   67807fbaf12719fca46a622d759484652b79c7c3
patch link:    https://lore.kernel.org/r/20260327223820.2244227-3-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 02/20] drbd: extend wire protocol definitions for DRBD 9
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260328/202603281537.rTtvjPOL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603281537.rTtvjPOL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/networking/xfrm_proc.rst references a file that doesn't exist: Documentation/networking/xfrm_proc.rst
   Warning: Documentation/translations/zh_CN/scsi/scsi_mid_low_api.rst references a file that doesn't exist: Documentation/Configure.help
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/ABI/testing/sysfs-platform-ayaneo
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
   Warning: arch/powerpc/sysdev/mpic.c references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
>> Warning: drivers/block/drbd/drbd_protocol.h references a file that doesn't exist: Documentation/application-resync-synchronization.rst
   Warning: rust/kernel/sync/atomic/ordering.rs references a file that doesn't exist: srctree/tools/memory-model/Documentation/explanation.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/virtual/lguest/lguest.c
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,\b(\S*)(Documentation/[A-Za-z0-9
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/devicetree/dt-object-internal.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,^Documentation/scheduler/sched-pelt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
