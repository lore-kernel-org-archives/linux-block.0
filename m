Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04E28FD
	for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751226749; cv=none; b=BvwVS1Xibj0Jae2VzggyQCct26ObvwBQZk4EgznRW4fMxGefMa34RrRxR4zkqbmysY+5udV/HnpaywTthlA+44bRJkRRu3IT8Qr8rlkypemLBcBLQTIG/UPxR+oKtuunBJXVcjoFAPhlgjxbtMZgPGEB1t6rkmZBQuhKmrJkexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751226749; c=relaxed/simple;
	bh=BR6kmsTPzLd4OoHvb5QjGG3Bg6BRYLVtkCK/9eWzkxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3M46T5OAjhO3I89AzydyEttJQBPDuEmC3D7BIE2qcQ6T6eA/067/hmbgQwKKiS+Nf4NUhjb5/p/f72Sbx0XGgX7FDpnkUJ441m9mo0CE/LNC20DbGgn9rGley+K8h93IIYLQkZ+Rv8sFjUOrZ7T9J9p6kQwo0VOPLc45J/w64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXoqF7i+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXoqF7i+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751226748; x=1782762748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BR6kmsTPzLd4OoHvb5QjGG3Bg6BRYLVtkCK/9eWzkxY=;
  b=NXoqF7i+cRNr0oJgwYdMVsiRQZzqVIBxqFk+sQV3jeMgczPTtzLm9rT+
   w09pH0PPZTuaZDS5ep87R1gHRSHSGcHYMpRevzjBCPxJM6Wm634yCSE+W
   3UrNb+GN4CXV+o7IT5BVkT8NCR7VpJiGpu85FFuaLzRSMakTRGLkTly5B
   26nH9u8TkIpBTSbXCwU4zE/fjmjGtpdvMsniIs8p7MzDsQgVjYAcyf04g
   MZcUGCfBXZaIE3f9k3J4b3rmI7IeLaCD9zr3WucrDB29+aN/LojYtCO1/
   L7l/YTe+csEPvgKZxgei2aAcZV/mmSTYfWQlLeOyP0Hgxr7wAUhOH+9Fa
   g==;
X-CSE-ConnectionGUID: lxY97pQQSNGzxcrq5IdLLg==
X-CSE-MsgGUID: fmc4Wh6CQsquJYWBN9zTDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="63707353"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="63707353"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 12:52:27 -0700
X-CSE-ConnectionGUID: WfSIBD8AQveEYPQ6edgGFw==
X-CSE-MsgGUID: k0JjEzOtS7G27F+vwK0kew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="153367256"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Jun 2025 12:52:24 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVy4c-000YBY-0z;
	Sun, 29 Jun 2025 19:52:22 +0000
Date: Mon, 30 Jun 2025 03:52:14 +0800
From: kernel test robot <lkp@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, ming.lei@redhat.com,
	axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv5 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
Message-ID: <202506300509.2S1tygch-lkp@intel.com>
References: <20250627175544.1063910-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627175544.1063910-3-nilay@linux.ibm.com>

Hi Nilay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.16-rc3 next-20250627]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/block-move-elevator-queue-allocation-logic-into-blk_mq_init_sched/20250628-020013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250627175544.1063910-3-nilay%40linux.ibm.com
patch subject: [PATCHv5 2/3] block: fix lockdep warning caused by lock dependency in elv_iosched_store
config: i386-randconfig-r072-20250629 (https://download.01.org/0day-ci/archive/20250630/202506300509.2S1tygch-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506300509.2S1tygch-lkp@intel.com/

New smatch warnings:
block/blk-mq-sched.c:472 blk_mq_alloc_sched_tags() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'
block/blk-mq-sched.c:472 blk_mq_alloc_sched_tags() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'

Old smatch warnings:
block/blk-mq-sched.c:383 blk_mq_sched_tags_teardown() warn: iterator 'i' not incremented
block/blk-mq-sched.c:397 blk_mq_sched_reg_debugfs() warn: iterator 'i' not incremented
block/blk-mq-sched.c:408 blk_mq_sched_unreg_debugfs() warn: iterator 'i' not incremented
block/blk-mq-sched.c:512 blk_mq_init_sched() warn: iterator 'i' not incremented
block/blk-mq-sched.c:544 blk_mq_sched_free_rqs() warn: iterator 'i' not incremented
block/blk-mq-sched.c:558 blk_mq_exit_sched() warn: iterator 'i' not incremented

vim +472 block/blk-mq-sched.c

   429	
   430	struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
   431			unsigned int nr_hw_queues)
   432	{
   433		unsigned int nr_tags, i;
   434		struct elevator_tags *et;
   435		gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
   436	
   437		if (blk_mq_is_shared_tags(set->flags))
   438			nr_tags = 1;
   439		else
   440			nr_tags = nr_hw_queues;
   441	
   442		et = kmalloc(sizeof(struct elevator_tags) +
   443				nr_tags * sizeof(struct blk_mq_tags *), gfp);
   444		if (!et)
   445			return NULL;
   446		/*
   447		 * Default to double of smaller one between hw queue_depth and
   448		 * 128, since we don't split into sync/async like the old code
   449		 * did. Additionally, this is a per-hw queue depth.
   450		 */
   451		et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
   452				BLKDEV_DEFAULT_RQ);
   453		et->nr_hw_queues = nr_hw_queues;
   454	
   455		if (blk_mq_is_shared_tags(set->flags)) {
   456			/* Shared tags are stored at index 0 in @tags. */
   457			et->tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
   458						MAX_SCHED_RQ);
   459			if (!et->tags[0])
   460				goto out;
   461		} else {
   462			for (i = 0; i < et->nr_hw_queues; i++) {
   463				et->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
   464						et->nr_requests);
   465				if (!et->tags[i])
   466					goto out_unwind;
   467			}
   468		}
   469	
   470		return et;
   471	out_unwind:
 > 472		while (--i >= 0)
   473			blk_mq_free_map_and_rqs(set, et->tags[i], i);
   474	out:
   475		kfree(et);
   476		return NULL;
   477	}
   478	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
