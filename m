Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635171;
	b=woqmv7NIRGocvzex6k9P5+DITi8CKb0C5SZSNov6r3Aa3rhEo7HWVLOTzwz0U/0zaP8x
	 4PpPkdCluPRw1nqO8WhebMscj82AD1MUGNqhCW+7c/3nPp1DqJKue/1RPfrcTh90ZIK1N
	 dy9aXeszBxzxVWtLyddOvC5gNmHPSXfvsujKrpIgqDTbpSdE9sgZ2o1wk/cZQgvwFP3e3
	 QXXBIEISHXT5tc1DlrkSTH/04nvSoQtSq2Trk4SLj1PVRyTE33QQciL7AjXYpMmf4frY6
	 BBah/6jp8t9YoeUwysUIwkxBKdEqSKIyzw0k6deUrW8E4ENKHxAkwgH86qnPukuFCdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635171;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=D0i2eJhct4lVnv3jYqFiTKy7E3ET5Ck8DgYNv8uqdd0=;
	b=5SyiXpjLUdbJVBRQpdBwWCnMWEPb4q6sXj8gAhuMWo9pI+JbVOvUYXRfGywzYJ7SyglY
	 BduYsfGiKVueqwGSjUqpyhXZxKy3VIl46Me4B60N5dTCmf6ifSuEWRIhF4UmYtX7WAcqP
	 h5IvMvHN1bW9NwP7Ygo8Xa/G483nIY0RBoqASzv/FtdsdZz7mbkXtPdCCyZrRqTA30iLd
	 Uvoqc77rECMoNFjmGqboqR4ACTBXK6cCixZtNrQ6zTgQkAWa4k4asByRqGkuDK8Ahdf5Y
	 H0eepyfuOHCLbU0tZzoeY1rjhf4nSB3+15Eu0ofyg3NaiWhy653nVGXQTEPb5W+P79A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GBmluQLi;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A261606A59A;
	Mon,  2 Nov 2026 15:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A261606A59A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GBmluQLi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793635170; x=1825171170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jr72uMiZ8lu5SNyAIaR1hpnAnxC9sKbALEfjKIcjjAQ=;
  b=GBmluQLil8w079rixOALqNQCPqNV2hkVnkR5Rdh6bpXnn98J6wX4txxM
   ujZ9lRAvpNA7PNe9BLjCQ52+qvCAqa+9U87msxLIRHVJch6pzWesv7yoJ
   nEc8v4cdifx+TdfIlkuoGjnT952j/vOmq7fOOls4F4FvLhjoD/noJ2905
   s+0q9L0qi52a07sxsnXYUUlFZ/RB3bsPUny8XTqBuAwKdEFeUcDUDZMLg
   IAQMYUZbezrfaCmZG8qLVQTL7YlBxmf+Bu7F8LEVNPtygkb1fJScy9jRN
   7u3cX3LBXhzLgxQf7Z/H99VwI2S01nqTX12GV8vGCBthUgHYrdaTDRKsm
   g==;
X-CSE-ConnectionGUID: b48c9BnySxejLWovPdyHfw==
X-CSE-MsgGUID: k17Wo8QQRPaZUhYZ1rL3CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2345743"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2345743"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 07:59:29 -0800
X-CSE-ConnectionGUID: /5C42JiUTUujHcmaqrrNPg==
X-CSE-MsgGUID: wPutJd7vRz6N5JHbqLgYMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7947234"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 02 Nov 2026 07:59:28 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNuRQ-00000000hFQ-3mJR;
	Mon, 02 Nov 2026 15:59:24 +0000
Date: Mon, 2 Nov 2026 23:59:21 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@sina.com>,
	syzbot+a31cda410a4ccd419712@syzkaller.appspotmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] loop: prohibit the use of sysfs as a backing file
Message-ID: <202611022315.fQUGv982-lkp@intel.com>
References: <20261102103354.427722-1-eadavis@sina.com>
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
In-Reply-To: <20261102103354.427722-1-eadavis@sina.com>

Hi Edward,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/loop-prohibit-the-use-of-sysfs-as-a-backing-file/20261102-183354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20261102103354.427722-1-eadavis%40sina.com
patch subject: [PATCH] loop: prohibit the use of sysfs as a backing file
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20261102/202611022315.fQUGv982-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 65303e81f481bbfe386b8596423f94c43198ba94)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261102/202611022315.fQUGv982-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611022315.fQUGv982-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/block/loop.c:537:41: error: use of undeclared identifier 'SYSFS_MAGIC'
     537 |         if (file_inode(file)->i_sb->s_magic == SYSFS_MAGIC)
         |                                                ^~~~~~~~~~~
   1 error generated.


vim +/SYSFS_MAGIC +537 drivers/block/loop.c

   528	
   529	static int loop_check_backing_file(struct file *file)
   530	{
   531		if (!file->f_op->read_iter)
   532			return -EINVAL;
   533	
   534		if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
   535			return -EINVAL;
   536	
 > 537		if (file_inode(file)->i_sb->s_magic == SYSFS_MAGIC)
   538			return -EINVAL;
   539	
   540		return 0;
   541	}
   542	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
