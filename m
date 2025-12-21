Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA71B808
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766301062; cv=none; b=j3gnxXKJOdaHz99/t7dag2LSmNsuRTXnqwIoSb/jlkyg+XUDQc/nS8fImE/HohMOsmHNaOmv8Xcz2PF5bBzUz3v+7bdWRJiD1oNGzsRLJpso4qQzdfhPDaGPItFylYZ2HpAjDxSNXznwHEaTdJ7CsifV/p+ENzDomJNJSf4iN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766301062; c=relaxed/simple;
	bh=pUcNV5KVp9JG5QHdkt8tf0jL5xiJu4V00/rw6BChgSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRbs8wnjbSV5Zfeab0sSMLLhFKHXfuZwH4NU0CSdvbmhIdmvO8DInYiapa0oiyKVUMZqwCPzR4TcHrzQjUX5h2mv/2Id/cIcOSmt4rq9VAeqk/UB806K8A7TzmFB7GlUzj88uMgyJ8K7YOEk1Bs+XwXe6Ibo1BY0BGCSUg1xZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIgk4B7f; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIgk4B7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766301061; x=1797837061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pUcNV5KVp9JG5QHdkt8tf0jL5xiJu4V00/rw6BChgSk=;
  b=CIgk4B7fByqNyZ/IGbrGcWctzWPjivwroENs5EbKUtg8NWJy3EVEZGmY
   Vf/XveY9jFWQCtUJkpycQOEScdSTJELUsiBSUPW509h0DF67rwL5KXXaa
   yVeeDPfpK2SRoN2EnlPBjuhYcjwsuW/+BvEtjD8LmFKjvYMVfUjWwlZzv
   dOTGPsa+O8GkwKwfBEC2/yDOUhFXDms8pkCcPsBSQ+zGKgpia/EW72ROw
   DWged1/WofoMLltP1cPi3jYSk1oRRyYzzXhDvpEBBA0N8LMZYpth0aqyi
   Nyx9CGYa7Vl8m+fCEIMJiWx08qHwdykEXeqj69XNcoDofnkkwT2kvX2jd
   A==;
X-CSE-ConnectionGUID: BA3DfLrRRkylTuYbRoR/xQ==
X-CSE-MsgGUID: xnJTFdXuR46MfUWHjMSssA==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="68242921"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="68242921"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 23:11:00 -0800
X-CSE-ConnectionGUID: BwKEE3XIT669p95RFe3K0g==
X-CSE-MsgGUID: /MGz7wTwRwmYFW/kePXy7Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2025 23:10:59 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXDai-000000005OH-42S1;
	Sun, 21 Dec 2025 07:10:56 +0000
Date: Sun, 21 Dec 2025 15:10:03 +0800
From: kernel test robot <lkp@intel.com>
To: Vitaliy Filippov <vitalifster@gmail.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Vitaliy Filippov <vitalifster@gmail.com>
Subject: Re: [PATCH] Do not require atomic writes to be power of 2 sized and
 aligned on length boundary
Message-ID: <202512211405.FsWuMZAC-lkp@intel.com>
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
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20251221/202512211405.FsWuMZAC-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211405.FsWuMZAC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211405.FsWuMZAC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/read_write.c: In function 'generic_atomic_write_valid':
>> fs/read_write.c:1805:16: warning: unused variable 'len' [-Wunused-variable]
    1805 |         size_t len = iov_iter_count(iter);
         |                ^~~


vim +/len +1805 fs/read_write.c

c34fc6f26ab86d0 Prasad Singamsetty 2024-06-20  1802  
c3be7ebbbce5201 John Garry         2024-10-19  1803  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
c34fc6f26ab86d0 Prasad Singamsetty 2024-06-20  1804  {
c34fc6f26ab86d0 Prasad Singamsetty 2024-06-20 @1805  	size_t len = iov_iter_count(iter);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
