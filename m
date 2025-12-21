Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E3149E17
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766322124; cv=none; b=a3AqDK/JtdeybdhoSo3AMNp5rbne827gc3r0T6F5C/qPBUyonBzovU/pHlL3W4XB5oslzWrE5v4vo9loWE5obZywFcyDkHcP0BM9A8OIlgCLO71wZxyUgpS+a1jumVMyj79niiVjCodVcXi0olbBiz3J0WwGDB3btXapcQAoe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766322124; c=relaxed/simple;
	bh=IelPuQfpRKpMJVdVfQngugsAIYeDlUYPxZTLwugxbgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/K/2Kdt/SLlGDfhjTfu40LjFWSxvBSov90LzlfaPc8kupbqkHJNBy3Oet5e7C8Tqg76YuCilBLc9IpSfVcaW9nxDTes4OcQ7HrxWN06H81G3H74D0LxDxeMY5abfluqACIkPhzvfFvUxUDXhOJv09+tzyPQMZq1f6dyTRukuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ER1Ik8HC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ER1Ik8HC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766322123; x=1797858123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IelPuQfpRKpMJVdVfQngugsAIYeDlUYPxZTLwugxbgg=;
  b=ER1Ik8HCkSNidPJusuCBSOzgpU6+wfTGksbvdFIGtuHm7Y1lcBoU8Y1U
   aBQ0wiVv1AiQk3LOw8kXVa+sV8tKoHOwQH4upbPYSfcnz/EzZ3LvNPW14
   pYfC+flf8P7VtLfdd+UO3qVsC7Vv7cbpX+EfKHDtUt5pNjC6A7YIjqrzQ
   BOPaY4Zfde0tcxKUWxWLtEi+MmzUeDfQ1nplyxjkmj6wtNaGYRnaUjvL0
   AVjKZ3l9gzQxjgAG4y9M6DouCsxZXRSgIrcIUzWh6QloqdavYB/rIkifo
   aVdrNYMjnk0i82vHwQetNotFl0MRMraQPY/WXn7vsUyO862uBVx9CvkZC
   w==;
X-CSE-ConnectionGUID: W3DRQuDKRcK1CZO7xiMGsQ==
X-CSE-MsgGUID: r90nVl9PRZSjKbIKgE3jRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68084632"
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="68084632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 05:02:02 -0800
X-CSE-ConnectionGUID: tSMa9SGsQR6X4MkfEPOybw==
X-CSE-MsgGUID: zpzgTZWNSviZ9bksHBD5rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="198547878"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 21 Dec 2025 05:02:01 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXJ4Q-00000000548-17Dx;
	Sun, 21 Dec 2025 13:01:58 +0000
Date: Sun, 21 Dec 2025 14:01:10 +0100
From: kernel test robot <lkp@intel.com>
To: Vitaliy Filippov <vitalifster@gmail.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vitaliy Filippov <vitalifster@gmail.com>
Subject: Re: [PATCH] Do not require atomic writes to be power of 2 sized and
 aligned on length boundary
Message-ID: <202512211420.W7jr2osh-lkp@intel.com>
References: <20251220173833.71176-1-vitalifster@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220173833.71176-1-vitalifster@gmail.com>

Hi Vitaliy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitaliy-Filippov/Do-not-require-atomic-writes-to-be-power-of-2-sized-and-aligned-on-length-boundary/20251221-014115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251220173833.71176-1-vitalifster%40gmail.com
patch subject: [PATCH] Do not require atomic writes to be power of 2 sized and aligned on length boundary
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251221/202512211420.W7jr2osh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211420.W7jr2osh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211420.W7jr2osh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/read_write.c:1805:9: warning: unused variable 'len' [-Wunused-variable]
    1805 |         size_t len = iov_iter_count(iter);
         |                ^~~
   1 warning generated.


vim +/len +1805 fs/read_write.c

c34fc6f26ab86d Prasad Singamsetty 2024-06-20  1802  
c3be7ebbbce520 John Garry         2024-10-19  1803  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
c34fc6f26ab86d Prasad Singamsetty 2024-06-20  1804  {
c34fc6f26ab86d Prasad Singamsetty 2024-06-20 @1805  	size_t len = iov_iter_count(iter);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
