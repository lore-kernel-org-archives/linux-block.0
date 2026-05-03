Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7440DFA8;
	Sun,  3 May 2026 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768193; cv=none; b=l/Zu5EKI8Udw4gE4QThHInt8Y8ex2MPmi870AaX9YHkUnso9w7/+hnHTLjjJgosFTJZ2rNXw89B2pG4TesCQ1MQjxkLeSe00cC8VFEPqhW1/XCTBiJTQtVur0adR5kpF9CiyhFkZLjZ5C69DCfUrBAW9bbg0EqVFQLEzUu+zcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768193; c=relaxed/simple;
	bh=T1MW32aagpDb0Ede1BQyV19Osf7lxJwpq4nF8Yg1XJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF3/Zd7cQbz+i8V+N/6sJe0lbpyk0qIx7rykKxGMrpHHHvO40egoIzFOj7TgKTh7C2Qg8K+ukPoZrMHs5+6OaWJ2362630HDqagXw5AO7WPy9YP9gu4wMFb/AD8s+OXvX6CkFMZsj+TOf7rXOMCQjbXmxcTJaM6AAWl+pBub7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVnGQwuT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVnGQwuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777768191; x=1809304191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1MW32aagpDb0Ede1BQyV19Osf7lxJwpq4nF8Yg1XJQ=;
  b=IVnGQwuTXdasa4TLxwpypceii+VPABWLGHNC9g0ljLA6l6d+0JXKDMWJ
   jc8ik0JxL7hHCd/kBF1ySfdOcJK1TsI4IKaLwhlEdv4K8Vvft/5V6rq4n
   4YBkRdooV2XvTcXkDO5y4HrpYTznpglBUn60Xi+4vo9gTqdVM37nNqSKo
   8fv7r06MzQ3IHSS0sKVL8bIWdtWcGTFpt3sCUxsww1d1LELy6xvOxfjLA
   PZEKhgXIqoTkJn3BjZyBW3g/h6kuccgUKaEVo972u7Yq60mwegc3NUD05
   dZdJprHDLhqbu153+YDHugVgRTFvF1kbzNKjaLC9o+etmOJEO+AXfmERi
   Q==;
X-CSE-ConnectionGUID: Xk9vkQvlRACi8VH1JikUGw==
X-CSE-MsgGUID: cLWLAPNwRrm03QEzzFMI3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="101347483"
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="101347483"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 17:29:50 -0700
X-CSE-ConnectionGUID: ksIZKXcJTCm0d1MeA3SwRA==
X-CSE-MsgGUID: mYMEneWQT6eMtlAwW6a73A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="240163581"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 May 2026 17:29:48 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJKiP-000000001x7-1qCr;
	Sun, 03 May 2026 00:29:45 +0000
Date: Sun, 3 May 2026 08:29:02 +0800
From: kernel test robot <lkp@intel.com>
To: Li kunyu <likunyu10@163.com>, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Li kunyu <likunyu10@163.com>
Subject: Re: [PATCH] block/blk-iolatency: Add the processing flow of the
 chained bio in the QoS and define the related types to solve the problem of
 incorrect inflight processing in the QoS. The usage of the done_split_bio
 abstract function in the blk-iolatency project.
Message-ID: <202605030844.RgfP9Jsd-lkp@intel.com>
References: <20260429094148.2394-1-likunyu10@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429094148.2394-1-likunyu10@163.com>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-kunyu/block-blk-iolatency-Add-the-processing-flow-of-the-chained-bio-in-the-QoS-and-define-the-related-types-to-solve-the-prob/20260502-071718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260429094148.2394-1-likunyu10%40163.com
patch subject: [PATCH] block/blk-iolatency: Add the processing flow of the chained bio in the QoS and define the related types to solve the problem of incorrect inflight processing in the QoS. The usage of the done_split_bio abstract function in the blk-iolatency project.
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20260503/202605030844.RgfP9Jsd-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605030844.RgfP9Jsd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605030844.RgfP9Jsd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-merge.c:159:17: error: use of undeclared identifier 'split'
     159 |                         bio_set_flag(split, BIO_QOS_CHAIN_CHILD);
         |                                      ^~~~~
   1 error generated.


vim +/split +159 block/blk-merge.c

   142	
   143	static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
   144	{
   145		if (unlikely(split_sectors < 0)) {
   146			bio->bi_status = errno_to_blk_status(split_sectors);
   147			bio_endio(bio);
   148			return NULL;
   149		}
   150	
   151		if (split_sectors) {
   152			bio = bio_submit_split_bioset(bio, split_sectors,
   153					&bio->bi_bdev->bd_disk->bio_split);
   154			if (bio) {
   155				bio->bi_opf |= REQ_NOMERGE;
   156				/* Fix the issue where the inflight statistics
   157				 * of the chained bio in the QoS are incorrect.
   158				 */
 > 159				bio_set_flag(split, BIO_QOS_CHAIN_CHILD);
   160			}
   161		}
   162	
   163		return bio;
   164	}
   165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
