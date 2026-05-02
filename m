Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC91E47CC;
	Sat,  2 May 2026 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777764948; cv=none; b=dUkDQC6vEDHyB3fd2ldMteo6QFtjO9uPZrDphnYth1uTlPPnNMoO18mkVszfUw2qpgmxg26IKNkqC/m72+qJcfPwhOVw0LzM2HfrFVwXDxV4c082QqRfP3+IHOqfaXYhAKPGMLPsgS46Oz4ayP56mvYe7WoBTGllYvkCT8NbsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777764948; c=relaxed/simple;
	bh=HylnNEOE/2/MgljpNoj/dclE/o94Tjuuoy/k/AFwY7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VedHkko+sMtgOvIFOfvJ/VHrae8JAa+Ho0ye7KdoYvXIjiIB1crLY08DRYrZh7+/jdf4Jp1s+aYJ6hJPbDSVoa0YWtiVX6oIiFD2fmTnCWbMohMCZ4xZRcB7oGXuc3AqY7VMeHx6OL0Gq30OCtiyJpvz1UeL4HCVrrNTI3O7wC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE/H2IyE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE/H2IyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777764946; x=1809300946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HylnNEOE/2/MgljpNoj/dclE/o94Tjuuoy/k/AFwY7g=;
  b=bE/H2IyENEW7JKPVDMScPN/F1S2B0yaVvnZGEINDu3D4qK+pKJhnHfYz
   fvajDdvZMztXX6vACuMbh/ZPb7PyWY6VuNxuyCyHD26rUHfOL87uE3Hwi
   REzXm9BTuV+CH2nHGA6+y0hd/Qf52I3ZEzdLfG6Q7s/kxYqkPMSG9L6zi
   fTRVaG9nqYUMUBYsdYTAC3XxwlzmMkaMP80mAW7pKfauuetcdBGVXPHYo
   eLpbyurk9WoGf8ZYBOlQsnqOhBKxYh12RNLay+4nG1fiXAYukB5p9Bqm/
   LKDcsAURM/saUYwU5MmcJW6cgEa0QTigI4TFLf3sTOkORvjlS801MucHT
   w==;
X-CSE-ConnectionGUID: pvQbLbRMS5++LXEl4Mheww==
X-CSE-MsgGUID: wQblZmMbSQeAXqiE7oFrkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="96243772"
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="96243772"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 16:35:46 -0700
X-CSE-ConnectionGUID: 9HozqI7BTveRbIreUeVyJw==
X-CSE-MsgGUID: tV8sUZpnR2CYR5L7kF37uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="234308550"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 May 2026 16:35:44 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJJs4-000000001sv-3Qjr;
	Sat, 02 May 2026 23:35:40 +0000
Date: Sun, 3 May 2026 07:34:56 +0800
From: kernel test robot <lkp@intel.com>
To: Li kunyu <likunyu10@163.com>, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li kunyu <likunyu10@163.com>
Subject: Re: [PATCH] block/blk-iolatency: Add the processing flow of the
 chained bio in the QoS and define the related types to solve the problem of
 incorrect inflight processing in the QoS. The usage of the done_split_bio
 abstract function in the blk-iolatency project.
Message-ID: <202605030725.SpXiNjpU-lkp@intel.com>
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
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20260503/202605030725.SpXiNjpU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605030725.SpXiNjpU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605030725.SpXiNjpU-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/blk-merge.c: In function 'bio_submit_split':
>> block/blk-merge.c:159:38: error: 'split' undeclared (first use in this function); did you mean 'sg_split'?
     159 |                         bio_set_flag(split, BIO_QOS_CHAIN_CHILD);
         |                                      ^~~~~
         |                                      sg_split
   block/blk-merge.c:159:38: note: each undeclared identifier is reported only once for each function it appears in


vim +159 block/blk-merge.c

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
