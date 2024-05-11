Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADE524B8
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715419263; cv=none; b=vBC5fcTLrSu+a4757PVgtHj9J+sMCUlvs8x+BLlph20oHo1BbOtT7gjTZtMi+Vw/W93jdcH8VbpM0qZPwOQyd4666fjQJygJYGchspY3zcnDFucAaoVoe/zZ1WZZknksSbVmBEaBQ77JjRYskhufXaU/k+UR4atqpROTn5trEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715419263; c=relaxed/simple;
	bh=DQpBtq68IfqYnNb/DPavjwmyzLGM9CygTz2lBL5qqeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKE5+gHfrm+hgUJz59wgsMKzjG/bQis9ug9Vyo0RmZuBBNRQ+trsj6GCcSWqOn0jrf2RTh268bG9r5C7fzjqAcufYNwfUHqsd8iY7nez/HNN9wsDNmsrjkQvrWm0Kv2tvaH204SpUudV9fh6Yb1Siane8Ev6ZWETvarGLnkXF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xnrhu2Z4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xnrhu2Z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715419261; x=1746955261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQpBtq68IfqYnNb/DPavjwmyzLGM9CygTz2lBL5qqeQ=;
  b=Xnrhu2Z47cEcLWJA5XwEJyZIicQWmdKhAQfGDNhGhtWsOu0DSYCizlh9
   x+nq4Uh8/UP0ijy9txNS6vDjfd4xxfFy/tbZW/Qn5K+tlqWsQCf8NP+e2
   nuY4ZNx3NTvBlGVf8eeoJvyOZzTQcu6KJFYHzl23MfCMeDBLcl1VvLH68
   9ArWzIfd9Q6VXXY0pVenj3BglEtN0ATghw+vJaYcMjqYQeNw+cgcbFhES
   iWAxihlNW4zk5JMch7rOIFSIP+uFk2wNEf9olea65v4D2vYf4iFY4vMPk
   kHv+CX1D7z1ETfXwe1h4tRwhxxJfQFeAZ9f7O+CceXmHDjUONOwmLs8e3
   w==;
X-CSE-ConnectionGUID: 1pjToKvaQiW05hEse+zFkQ==
X-CSE-MsgGUID: 5ma+MyVRS4KX1AGuEoOJng==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22085915"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="22085915"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 02:21:01 -0700
X-CSE-ConnectionGUID: nl1xlx3/T5KwlxtJMV0OuA==
X-CSE-MsgGUID: Kvgj9g/tQYm3dL8Jt8bxyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34406985"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2024 02:20:57 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5iuV-0007BA-0k;
	Sat, 11 May 2024 09:20:55 +0000
Date: Sat, 11 May 2024 17:20:00 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, javier.gonz@samsung.com,
	bvanassche@acm.org, david@fromorbit.com, slava@dubeyko.com,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH] nvme: enable FDP support
Message-ID: <202405111758.Ts2xnoZH-lkp@intel.com>
References: <20240510134015.29717-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510134015.29717-1-joshi.k@samsung.com>

Hi Kanchan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/nvme-enable-FDP-support/20240510-214900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240510134015.29717-1-joshi.k%40samsung.com
patch subject: [PATCH] nvme: enable FDP support
config: x86_64-randconfig-121-20240511 (https://download.01.org/0day-ci/archive/20240511/202405111758.Ts2xnoZH-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111758.Ts2xnoZH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111758.Ts2xnoZH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/core.c:2120:30: sparse: sparse: cast to restricted __le16
   drivers/nvme/host/core.c:2126:38: sparse: sparse: cast to restricted __le16
   drivers/nvme/host/core.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +2120 drivers/nvme/host/core.c

  2098	
  2099	static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
  2100	{
  2101		struct nvme_command c = {};
  2102		struct nvme_fdp_ruh_status *ruhs;
  2103		struct nvme_fdp_ruh_status_desc *ruhsd;
  2104		int size, ret, i;
  2105	
  2106		size = sizeof(*ruhs) + NVME_MAX_PLIDS * sizeof(*ruhsd);
  2107		ruhs = kzalloc(size, GFP_KERNEL);
  2108		if (!ruhs)
  2109			return -ENOMEM;
  2110	
  2111		c.imr.opcode = nvme_cmd_io_mgmt_recv;
  2112		c.imr.nsid = cpu_to_le32(nsid);
  2113		c.imr.mo = 0x1;
  2114		c.imr.numd =  cpu_to_le32((size >> 2) - 1);
  2115	
  2116		ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
  2117		if (ret)
  2118			goto out;
  2119	
> 2120		ns->head->nr_plids = le16_to_cpu(ruhs->nruhsd);
  2121		ns->head->nr_plids =
  2122			min_t(u16, ns->head->nr_plids, NVME_MAX_PLIDS);
  2123	
  2124		for (i = 0; i < ns->head->nr_plids; i++) {
  2125			ruhsd = &ruhs->ruhsd[i];
  2126			ns->head->plids[i] = le16_to_cpu(ruhsd->pid);
  2127		}
  2128	out:
  2129		kfree(ruhs);
  2130		return ret;
  2131	}
  2132	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
