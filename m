Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892014AD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566526; cv=none; b=WakQCqQNOyPEkVuuIGaTLbGYwH0QbcysBVM9AIcL7TlXtAIIGtNwV4UxmKDb7RX3m/xi/shB0OoByz9l8ARTFrpwrRzOl7/BJuex9AG4AeIntnkvAdiyRxIV18s87awxGiOUPE7oCdJQi3axTXQjNjTYa52igtkwFocRLu94Nvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566526; c=relaxed/simple;
	bh=dg9CniU+jGxHhUB27BzgL5VYvqj6dDZqpx/Kb0r++mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVw17Z2mi/vK19gEqW43mlvbDMjrcrNPCSv6uWKtkYB8C9YDCcIv79ox1KMXqvQ16iZWLn6OUHOX/wS0d5hGlpOXgw5yKRAY6P5Dyt8NwwOEG3nF6scY20o3uNOgn7aYAoVw4tFGYK7edaRSoFfZg0WsOVMzm+gvyAI7kh1qyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbEy2W1p; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbEy2W1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720566525; x=1752102525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dg9CniU+jGxHhUB27BzgL5VYvqj6dDZqpx/Kb0r++mY=;
  b=cbEy2W1pCi+BMfEWbSbJHYo5AUreT2FOzxvrOiSeadaefV3xLxyD3bAe
   3FyZ7PqyaTfPkgHH8XXG3sx7DYzENOmQHbn/kwyY59dqcyh74Du91HTul
   b1qhl9ieu+utDSGjP3e6CZMC190qVLGvBBM1iPN51vrRCOZJvshodByiO
   SRNA6X+2dfyHJBDEuA+aDt4ZEpxpmMjX5rDjYQmcpVvGB1szIQxrttdNn
   LeEXduzhQYI/OROHQntua9WsXzqF+iWQvRXY8ceAfuNDE19ZC1P8nSyBP
   r+IW46r5YDLpZv+v5orOTvnmijQv8U2BsW/+IHYNHmhh3Y5Hfdg4x0i0b
   g==;
X-CSE-ConnectionGUID: pBq76C49SYCE+/BFfVku6Q==
X-CSE-MsgGUID: dKkbT/bRSmKp2m/9N0Demg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21728646"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="21728646"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 16:08:44 -0700
X-CSE-ConnectionGUID: AFh4J6NFSjGsKcFvP8incQ==
X-CSE-MsgGUID: TZRrEp5cSqeTcr7rfJmI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="52301939"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jul 2024 16:08:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRJwt-000XCn-2A;
	Tue, 09 Jul 2024 23:08:39 +0000
Date: Wed, 10 Jul 2024 07:08:29 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 07/11] block: Add missing entries from cmd_flag_name[]
Message-ID: <202407100611.wrfknWDf-lkp@intel.com>
References: <20240709110538.532896-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709110538.532896-8-john.g.garry@oracle.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20240709]
[cannot apply to hch-configfs/for-next linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/block-remove-QUEUE_FLAG_STOPPED/20240709-191356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240709110538.532896-8-john.g.garry%40oracle.com
patch subject: [PATCH 07/11] block: Add missing entries from cmd_flag_name[]
config: x86_64-randconfig-r132-20240710 (https://download.01.org/0day-ci/archive/20240710/202407100611.wrfknWDf-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407100611.wrfknWDf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407100611.wrfknWDf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> block/blk-mq-debugfs.c:231:9: sparse: sparse: Initializer entry defined twice
   block/blk-mq-debugfs.c:237:9: sparse:   also defined here

vim +231 block/blk-mq-debugfs.c

9abb2ad21e8b9b7 Omar Sandoval     2017-01-25  214  
1a435111f8eb30b Omar Sandoval     2017-05-04  215  #define CMD_FLAG_NAME(name) [__REQ_##name] = #name
8658dca8bd5666f Bart Van Assche   2017-04-26  216  static const char *const cmd_flag_name[] = {
1a435111f8eb30b Omar Sandoval     2017-05-04  217  	CMD_FLAG_NAME(FAILFAST_DEV),
1a435111f8eb30b Omar Sandoval     2017-05-04  218  	CMD_FLAG_NAME(FAILFAST_TRANSPORT),
1a435111f8eb30b Omar Sandoval     2017-05-04  219  	CMD_FLAG_NAME(FAILFAST_DRIVER),
1a435111f8eb30b Omar Sandoval     2017-05-04  220  	CMD_FLAG_NAME(SYNC),
1a435111f8eb30b Omar Sandoval     2017-05-04  221  	CMD_FLAG_NAME(META),
1a435111f8eb30b Omar Sandoval     2017-05-04  222  	CMD_FLAG_NAME(PRIO),
1a435111f8eb30b Omar Sandoval     2017-05-04  223  	CMD_FLAG_NAME(NOMERGE),
1a435111f8eb30b Omar Sandoval     2017-05-04  224  	CMD_FLAG_NAME(IDLE),
1a435111f8eb30b Omar Sandoval     2017-05-04  225  	CMD_FLAG_NAME(INTEGRITY),
1a435111f8eb30b Omar Sandoval     2017-05-04  226  	CMD_FLAG_NAME(FUA),
1a435111f8eb30b Omar Sandoval     2017-05-04  227  	CMD_FLAG_NAME(PREFLUSH),
1a435111f8eb30b Omar Sandoval     2017-05-04  228  	CMD_FLAG_NAME(RAHEAD),
1a435111f8eb30b Omar Sandoval     2017-05-04  229  	CMD_FLAG_NAME(BACKGROUND),
22d538213ec4fa6 Bart Van Assche   2017-08-18  230  	CMD_FLAG_NAME(NOWAIT),
1c26010c5e1b9ad Jianchao Wang     2019-01-24 @231  	CMD_FLAG_NAME(NOUNMAP),
6ce913fe3eee14f Christoph Hellwig 2021-10-12  232  	CMD_FLAG_NAME(POLLED),
6c56c597270e732 John Garry        2024-07-09  233  	CMD_FLAG_NAME(ALLOC_CACHE),
6c56c597270e732 John Garry        2024-07-09  234  	CMD_FLAG_NAME(SWAP),
6c56c597270e732 John Garry        2024-07-09  235  	CMD_FLAG_NAME(DRV),
6c56c597270e732 John Garry        2024-07-09  236  	CMD_FLAG_NAME(FS_PRIVATE),
6c56c597270e732 John Garry        2024-07-09  237  	CMD_FLAG_NAME(NOUNMAP),
8658dca8bd5666f Bart Van Assche   2017-04-26  238  };
1a435111f8eb30b Omar Sandoval     2017-05-04  239  #undef CMD_FLAG_NAME
8658dca8bd5666f Bart Van Assche   2017-04-26  240  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
