Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E98BEE
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051924; cv=none; b=ef33tAHZ5NBUzjD1jHWKvysDL/T+oYUJUA5LDGNrW+/XX2DHU+BxAjpnDpbIlsVH/UEyIrUpf8qqYUqeHtHeXAmyqmLUEupOFk+EWCoHjMHfVSTkNielbc5qGLd2dZqJOB+GhbjLvRMcZMFX9T3m1GtwMU96acXvGVhsy72uu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051924; c=relaxed/simple;
	bh=KccA/LZ+ZXZ6XajYWAUE1auUyN/plqJfyfdq6P7YW1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbhfwt6ZeMyBZFHLM3Gbhu3lcG5kIAAjarBRBH/TSdL3iVyYZ2DZHSP7P3erfJkq5QA8c8q6adEvBIaFa8lqlYiQDmLRD1cM92iWnWUYaqhlxGNmpombvdDvho71BEtUkp2upOeqQIs4JBqiCspb7a1u4idO4xDnaB2WREqQfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbEA5Fo2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbEA5Fo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753051921; x=1784587921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KccA/LZ+ZXZ6XajYWAUE1auUyN/plqJfyfdq6P7YW1o=;
  b=IbEA5Fo2XjT5bxgLCvxAC9Ac9VBThWu9BnrcuQ57Zm+8IXMIPiQiW/Bn
   YDIcOjYahdVJzIatUE0X6GEyS/55SEngOO+P0LPKzMkiod9PdWcLbNJwM
   Njkgo0/dIjncX6B1iKdxgyaDumvkZfrg8O5CNl9QwEnKLHWAUh7JWPv6H
   I4TMKKST/X1jR9CBvGBLUnz3DvYfVFOKRFZbUvbbxQzxlGvcnt3ShPCSa
   gZmdbM2ZZesneP32FqbexbZx6idPGCnp+kYoHBs2TLaTU0vv/VQwlKHol
   /5gtrGoOLoSjVdARb2Jmp3Ye4ppJAh5C3JsyEGJ0S0j+n+qy4nK0OOqAJ
   A==;
X-CSE-ConnectionGUID: x0Xxm6SjQOKt7gsmZBKH4Q==
X-CSE-MsgGUID: N7C6vHC5RkCp0BzB8veWBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="66327327"
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="66327327"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 15:52:00 -0700
X-CSE-ConnectionGUID: 7+vZawjzRW+axfKtJ5xYhA==
X-CSE-MsgGUID: Uyth4+W/SeeVPMlU+gBWuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="159214763"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Jul 2025 15:51:59 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udcsu-000GLR-2I;
	Sun, 20 Jul 2025 22:51:56 +0000
Date: Mon, 21 Jul 2025 06:51:21 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <202507210629.vtm1boC0-lkp@intel.com>
References: <20250720184040.2402790-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-7-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[cannot apply to linux-nvme/for-next hch-configfs/for-next linus/master v6.16-rc6 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-dma-move-the-bio-and-bvec_iter-to-blk_dma_iter/20250721-024616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250720184040.2402790-7-kbusch%40meta.com
patch subject: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity metadata
config: um-randconfig-002-20250721 (https://download.01.org/0day-ci/archive/20250721/202507210629.vtm1boC0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507210629.vtm1boC0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507210629.vtm1boC0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_start
   >>> defined at dm-table.c
   >>>            drivers/md/dm-table.o:(blk_rq_integrity_dma_map_iter_start)
   >>> defined at dm-io-rewind.c
   >>>            drivers/md/dm-io-rewind.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_next
   >>> defined at dm-table.c
   >>>            drivers/md/dm-table.o:(blk_rq_integrity_dma_map_iter_next)
   >>> defined at dm-io-rewind.c
   >>>            drivers/md/dm-io-rewind.o:(.text+0x13)
--
>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_start
   >>> defined at core.c
   >>>            drivers/nvme/host/core.o:(blk_rq_integrity_dma_map_iter_start)
   >>> defined at ioctl.c
   >>>            drivers/nvme/host/ioctl.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_next
   >>> defined at core.c
   >>>            drivers/nvme/host/core.o:(blk_rq_integrity_dma_map_iter_next)
   >>> defined at ioctl.c
   >>>            drivers/nvme/host/ioctl.o:(.text+0x13)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
