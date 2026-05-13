Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BA3DB635;
	Wed, 13 May 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661969; cv=none; b=QLPOokESd9NLMccKGXs3yoLcaao4MhM3MOVyXsliHYIKM4jB4QGr18fO4R4FnG99V1Uf5VGeI7p9ItOoGPVprTr97dLcyWz91dEb7JYqzOd2LoABuoETgjdxMHfheBJaIPNbSB7abHqbWcdfVnuZpXQXjwZKG6RPl1wJ917vHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661969; c=relaxed/simple;
	bh=iX522XgGUZDLFdyN6Ukt+45QlmBrsPc9/sCvHn02tDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyjQG+w43gqUfA+MiXrNYHAguU3l5+Qtz268fojyc4kRLP11saTHQszz0G7HUlebVwcWormR1y7lBETSjqqSGL/JdOSvNUXmZEpyIdCjXB8lOnTK6IgV5CiuudF3P9pQoxZlJlyvm+nOFqtNLnE7LYDhVLL+mpXr9npq7jaEi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH0/J2Tv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH0/J2Tv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778661968; x=1810197968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iX522XgGUZDLFdyN6Ukt+45QlmBrsPc9/sCvHn02tDc=;
  b=JH0/J2TvLZNTJ0JFAzeGRWDTum+ftUJPvWzxFScK5vO+pPZQw2JTDVTm
   5X/3l6w47+BKTM0S3kCEu8si3HVxRiLYF0xdMKXeEOs1RKC6msESkJUe3
   tiscw9RUEiOGynBIZCpJHr7l8UUcvdLuHlBMVkBR3hRdOH91b7eXa+lbe
   vXJW9dZLRclZRSU0aqVmIP8GpRNJB6ByFOmXGsptgHmbyEGOVKITiScQN
   RLH5m6siVH7KgQ3fq8uCKCg3ikYOG8727rcWNfg/MuLlFW7HGTTwmYbUF
   yvnr/Fl6OFHM/wHazIMUTFAOzVn1sgh1s7pkWs88yMIbapKmE7Jrr/fr5
   A==;
X-CSE-ConnectionGUID: X/E28k0lSPKWkWxxhkemNw==
X-CSE-MsgGUID: GJ5teDaDTtWa6UOvYwBDYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="67112019"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="67112019"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 01:46:07 -0700
X-CSE-ConnectionGUID: WF9ZL+iMQLCSzbl0P1+MSw==
X-CSE-MsgGUID: V9lST02qR2avy3w1+OrHJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="235354848"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 May 2026 01:46:05 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN5EB-000000003lP-00zT;
	Wed, 13 May 2026 08:46:03 +0000
Date: Wed, 13 May 2026 16:45:35 +0800
From: kernel test robot <lkp@intel.com>
To: Li kunyu <likunyu10@163.com>, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Li kunyu <likunyu10@163.com>
Subject: Re: [PATCH v2] block/blk-iolatency: Add the processing flow of the
 chained bio in the QoS and define the related types to solve the problem of
 incorrect inflight processing in the QoS. The usage of the done_split_bio
 abstract function in the blk-iolatency project.
Message-ID: <202605131650.wyKmtlTK-lkp@intel.com>
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
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20260513/202605131650.wyKmtlTK-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131650.wyKmtlTK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131650.wyKmtlTK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __rq_qos_done_split_bio
   >>> referenced by bio.c
   >>>               block/bio.o:(bio_endio) in archive vmlinux.a

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
