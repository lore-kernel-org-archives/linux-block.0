Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2111C6AF
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256549; cv=none; b=QT22k0FNKT8ID6fzWkVXPyH7/I3v8j2mL/jel2wOC0MyMjzNWIf82TuLVi0ae6HA4jYhHj8FL5ROfp67YUpbRSCbBXybYMPKNu2tihtvihlfyHmthyu9cN/HsCaM//UuJTM15B3Yw8JywxXN+I80qF88t1gMHzlmvb0nxvhC7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256549; c=relaxed/simple;
	bh=O1yHR13LMvqMhssupELkMLJy9srd8c4LfjZpuES3zNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX4P8tzbSHbhOskHJmLqU2PC1efOgKDGjlJEGd5hhzVZFsXSFl92H7u4CTeL884JgK4PsNsOpxaFsTQXaFcpI1YGzRDpAxsj4Se4IlKJDu/m6SqMZ6g5FHXntx33dJa0eZB4kUSIU79QQ/kxm/bJ6PEGdCqZaiR/h66nA5rwHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCybFS4/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCybFS4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712256548; x=1743792548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1yHR13LMvqMhssupELkMLJy9srd8c4LfjZpuES3zNQ=;
  b=LCybFS4/xAdTpuJpxpQxmAn2YvsJODkCv7mky42j6tt3E1jyTcLu80Z4
   l9sPgtx5j8Go/UlRnVVhbLmW7PgcGfj8zao+SIDtbpLuzVuY9Q17CLZvt
   Hw3SAMlSXE7jwKthczrPC4OJsDI3rE5fR0s9Zb/EB0ke0mI2wXOrtbFrt
   2i60htFpekgCjlJZSA4g+1fWcthRJSmt0mj16zZHe7zAioNaUZVv3XdES
   mcJm2HyUgHnNWN6+PDPkRMA3JdKi5Lf1vk6+4IiNstcwC5x5jX+txIL0M
   Y7WFaIcnvZOkluLBSjn3AojA3VLSyI8WfCB95BgBdkP3UjHdvP7wjfu8r
   Q==;
X-CSE-ConnectionGUID: 1sxcgAzwTySmNboJkmdpoA==
X-CSE-MsgGUID: /aDwWz7pSBS91q5Q2kLHAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7800049"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7800049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:49:07 -0700
X-CSE-ConnectionGUID: Gjwf6HfMTtKWRqxdtEmlOA==
X-CSE-MsgGUID: ZplNi7DnQimuLodTgr0YUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23542046"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2024 11:49:05 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsS91-0001O2-0K;
	Thu, 04 Apr 2024 18:49:03 +0000
Date: Fri, 5 Apr 2024 02:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202404050222.vYNG4y3i-lkp@intel.com>
References: <20240403141756.88233-2-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-2-hare@kernel.org>

Hi Hannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.9-rc2 next-20240404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240403-222254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240403141756.88233-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240405/202404050222.vYNG4y3i-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050222.vYNG4y3i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050222.vYNG4y3i-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/block/loop.c:36:
   include/linux/blk-mq.h:1242:5: warning: no previous prototype for 'blk_nlat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         |     ^~~~~~~~~~~~~~~~
>> include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^~


vim +/in +1243 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nlat_enable(struct gendisk *disk);
  1236	void blk_nlat_disable(struct gendisk *disk);
  1237	u64 blk_nlat_latency(struct gendisk *disk, int node);
  1238	int blk_nlat_init(struct gendisk *disk);
  1239	#else
  1240	static inline int blk_nlat_enable(struct gendisk *disk) { return 0; }
  1241	static inline void blk_nlat_disable(struct gendisk *disk) {}
  1242	u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
> 1243	static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
