Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AD23D7CF;
	Sat, 18 Apr 2026 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776487041; cv=none; b=hHT+nRMM8ZUA3+mtyudzGjsOQ9ZywQfuPr/EjJYtQA6KMLTol2on+HM9I7vb/gHQSfJgsn3IB7Fg5IKQnnj2nGs1A8geBt9yEYpOD8Sgmbg/u65JaVNKX0tvEgfuZ9I48ZS3epFVX94UKkQjx+daW6x5AQuZ5FHKZ7lV0uVIX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776487041; c=relaxed/simple;
	bh=xrp5vB4dF8Q5/OFxNbUSr02qvZFZti74t7aLT7p3eAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgKPbZLFHyz6/DQEgeBTRC30xBtncwV7ap4cjQyEOFFHS/AJuJDU6OynReFYOtj2Y9CbZQa87lDKYSqbktJ5p8bhux5/uplwLJ7E8Nw3HQMs50H3jv0sZIKZUzdVdiM0q++lq2cPoren3Bg/vUrAPhkHdMcCz+8+ukeRQiPwJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4CDmBwV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4CDmBwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776487039; x=1808023039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xrp5vB4dF8Q5/OFxNbUSr02qvZFZti74t7aLT7p3eAE=;
  b=M4CDmBwViZ29BlcfTfdtNbgbjtYYg8DFJIRlJedpuZqg1tvhpsZfMi97
   HfVE7AQKeS+6UeKW3HHOyOZyMFbnoJ9XkpwFpwI3s2HTEd46+9IDc7UUS
   hPgoSPofcgt3bBeRCGSlM3/RwSEOm4rsJ7dS9PfpIRu2LtXl/6VvovyM7
   YSrCJ4eGl26U7c6Sy+fH3N97Ohu8aSRMMz9mkhiYp5rkehBCJwkq6DR79
   hE2NDdsmHMqWMBiN824yGhNXYNN4zBpdiUNH02U26EcKjqkPs51xIT/HQ
   JEANDIYXN7giI7PneiBDUBhN+xZPoXU2L3nDnt9dPdJ22gk5ufPYToXeD
   Q==;
X-CSE-ConnectionGUID: aqUsmo20QTyPfglu4n2YCw==
X-CSE-MsgGUID: 8cuJEW39SfeSUXMGwt9QWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81374545"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="81374545"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 21:37:19 -0700
X-CSE-ConnectionGUID: sa3N1YucRCijMp0yd0C09A==
X-CSE-MsgGUID: uvHzvjV5Rhy8912mKhzLKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="228067315"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 17 Apr 2026 21:37:16 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDxQf-000000001Vh-1IGK;
	Sat, 18 Apr 2026 04:37:13 +0000
Date: Sat, 18 Apr 2026 06:36:19 +0200
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 4/4] drbd: switch from genl_magic macros to YNL-generated
 code
Message-ID: <202604180607.iqIlyAER-lkp@intel.com>
References: <20260407173356.873887-5-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407173356.873887-5-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on a9c4b1d37622ed01b75f94a4f68cf55f33153a31]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-move-UAPI-headers-to-include-uapi-linux/20260417-214347
base:   a9c4b1d37622ed01b75f94a4f68cf55f33153a31
patch link:    https://lore.kernel.org/r/20260407173356.873887-5-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 4/4] drbd: switch from genl_magic macros to YNL-generated code
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260418/202604180607.iqIlyAER-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260418/202604180607.iqIlyAER-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604180607.iqIlyAER-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/drbd.h:18:10: fatal error: sys/types.h: No such file or directory
      18 | #include <sys/types.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
