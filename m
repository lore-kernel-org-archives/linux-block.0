Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738CD2AD00
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763779879; cv=none; b=OsIP4Hty0mR2LIM1Buql3m+Wmd16BfIhE8X5u4QcmuQZS88TJ3/QFo/MbTeE7uvQ2v9P2LGmVSaRXf+m1w90tc/WrjQVvACNuwYOQz2DBCRm852MtrVCDfng0+8YoMLGadSvSB0U60ciu2qphOGRtXIRO7IPcHyPhL18C2qAgRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763779879; c=relaxed/simple;
	bh=44O1P9Kh+X2x5t8v4+evMnRC0Cq949l+h+wDWdkLXP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyFsfHQ5+vQA6toZPXfk29P33zhaaPKx9ywlg22uuL/fgs4Jg2iMPE2izezAlACqQL4/YInIfgYGrq8222k7ETZwwxaW/UjhIiGdyHM7vHeAoUbwcBQIFJ1Jfl22NFHrlPj7G1kljI3+HALnfhFkIoBOfJRJuK6PC4fPwutEIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMf2v9Q9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMf2v9Q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763779877; x=1795315877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=44O1P9Kh+X2x5t8v4+evMnRC0Cq949l+h+wDWdkLXP0=;
  b=TMf2v9Q9x0enMG6NPwlNeSfHk3Sx/eTtP4JEL+OFx5qmWOkp4Ne1cyff
   GhIqXRdjSO9DBn6RwPdMobmer/F/Rh5uzu6Pu6Cqtf/2uuW9ib3E1/0+K
   9hXQc8MZoOU9kw199k37ZQrEQL2eyel0leS69ayYF4mEoUxeDBVc+8ZUE
   6rbBIP52PopvsWHYhoAnr13W8MH4rComiUFv7RVQ7RqfDd7IM8xgjnCdP
   ci194C4O60KVLLSQUo8k/Rjrik4KT8GOM4c5qesYdzRiv76XWQ0BB7Ctm
   d4GHOK3qUAPP41DAzqilXAYOeK4DS5wjc3qWwKdV9MuLWDxpxK4vr+OFg
   g==;
X-CSE-ConnectionGUID: jfvwXSBhRsqUjdxH9sIe/w==
X-CSE-MsgGUID: /WQXO9uLSQClmPqFJIRNUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65958253"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="65958253"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 18:51:17 -0800
X-CSE-ConnectionGUID: 2kwv1t9yTrGE31s3BvdbsA==
X-CSE-MsgGUID: MZS4OgLYSSesOeGk6pBC4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="196789971"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Nov 2025 18:51:15 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMdiS-00075z-19;
	Sat, 22 Nov 2025 02:51:12 +0000
Date: Sat, 22 Nov 2025 10:50:55 +0800
From: kernel test robot <lkp@intel.com>
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, bvanassche@acm.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, yukuai@fnnas.com
Subject: Re: [PATCH v2 4/9] blk-mq-debugfs: warn about possible deadlock
Message-ID: <202511221056.dAY0duWw-lkp@intel.com>
References: <20251121062829.1433332-5-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121062829.1433332-5-yukuai@fnnas.com>

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v6.18-rc6 next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-mq-debugfs-factor-out-a-helper-to-register-debugfs-for-all-rq_qos/20251121-143315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20251121062829.1433332-5-yukuai%40fnnas.com
patch subject: [PATCH v2 4/9] blk-mq-debugfs: warn about possible deadlock
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20251122/202511221056.dAY0duWw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221056.dAY0duWw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511221056.dAY0duWw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-mq-debugfs.c:628:30: error: no member named 'blkcg_mutex' in 'struct request_queue'
     628 |         lockdep_assert_not_held(&q->blkcg_mutex);
         |                                  ~  ^
   include/linux/lockdep.h:393:49: note: expanded from macro 'lockdep_assert_not_held'
     393 | #define lockdep_assert_not_held(l)              do { (void)(l); } while (0)
         |                                                             ^
   1 error generated.


vim +628 block/blk-mq-debugfs.c

   612	
   613	static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
   614					 void *data,
   615					 const struct blk_mq_debugfs_attr *attr)
   616	{
   617		/*
   618		 * Creating new debugfs entries with queue freezed has the risk of
   619		 * deadlock.
   620		 */
   621		WARN_ON_ONCE(q->mq_freeze_depth != 0);
   622		/*
   623		 * debugfs_mutex should not be nested under other locks that can be
   624		 * grabbed while queue is frozen.
   625		 */
   626		lockdep_assert_not_held(&q->elevator_lock);
   627		lockdep_assert_not_held(&q->rq_qos_mutex);
 > 628		lockdep_assert_not_held(&q->blkcg_mutex);
   629	
   630		if (IS_ERR_OR_NULL(parent))
   631			return;
   632	
   633		for (; attr->name; attr++)
   634			debugfs_create_file_aux(attr->name, attr->mode, parent,
   635					    (void *)attr, data, &blk_mq_debugfs_fops);
   636	}
   637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
