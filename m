Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C257CBB;
	Wed,  7 Aug 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060525; cv=none; b=EwZF7ZiPxJt0t6CMAPLdq5EHRa2QC0805ttrdZI9hNWH38hhXThW7pKSNGa4b8Ax5vgGvznezV6wqTrSozRwdCjqtSd2urTl6q1SRdt3UZLVCfQM0V+oQQnO9ub7h8ECzzIAYSqT2OUtSP9zUvYDDkLfQqKAMbldI8kGNEq9M2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060525; c=relaxed/simple;
	bh=RKALN1MHgOVJVqePwTXnjIhOh9hyZF92BM3lVOga2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtbVnHr+4PFREyON9tigcslUIClcg5/rG06zADDkHjk7L+8pDfserqKV1ykaVXOBuOxxC9ZvWDaLdcfQeiLHpRxzyIysDJRnbLYN55Phx1hfu59HwrLHpD1iYWG6bu1C4c2pwSLtuZWH2fyp3M5trZOk7fh0+MQLYG27l2FKDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbGE+BG2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbGE+BG2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723060524; x=1754596524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKALN1MHgOVJVqePwTXnjIhOh9hyZF92BM3lVOga2yY=;
  b=YbGE+BG2X0xJ9ExIrrcNyIs9qJc2jOwU/Qr33hZsN0TcrC5mNs9kC0Qb
   gPTHSKML99NPz8I31Oghv967hrxBAqrkq6/xdRBx9VBroL+5mp0XWI6La
   /DWT4Saxp3gjFS837MqPeFvhLM6iH+5mPpY/7I8eVjIOZdtP8zQWnpWug
   AZkzvlGplyqFAlwrt1T1yLJHgjQkEK+fXBEUNovD7LFQqUyJlpg+oK55z
   WN9Ca0ywHDFVdd+9fxDDbR3Pmpv/yb4qvbGZWwDKTY1jz4FJ7yNGou69m
   9mmeDICxGDctatymqccqr1FupvJzqLXkxe5VlOu9PpfHywUtdG/xyGl6J
   g==;
X-CSE-ConnectionGUID: Tfyo9vwZRKm0lb+PIBUiIQ==
X-CSE-MsgGUID: BAOU3Xu3RbaSsU0VBxtrnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21326066"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21326066"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 12:55:23 -0700
X-CSE-ConnectionGUID: srXxKOTER3CFdoyls1tzXw==
X-CSE-MsgGUID: WkFTE3fxS5SQE37NlZ7rIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56647724"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 07 Aug 2024 12:55:21 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbmkh-0005fy-19;
	Wed, 07 Aug 2024 19:55:19 +0000
Date: Thu, 8 Aug 2024 03:55:17 +0800
From: kernel test robot <lkp@intel.com>
To: 824731276@qq.com, axboe@kernel.dk
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, baiguo@kylinos.cn
Subject: Re: [PATCH] block:added printing when bio->bi_status fails
Message-ID: <202408080303.bwOWkFK1-lkp@intel.com>
References: <tencent_F71A15579D1E52ED0B58EF2F3607AA883308@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F71A15579D1E52ED0B58EF2F3607AA883308@qq.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.11-rc2 next-20240807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/824731276-qq-com/block-added-printing-when-bio-bi_status-fails/20240807-174005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/tencent_F71A15579D1E52ED0B58EF2F3607AA883308%40qq.com
patch subject: [PATCH] block:added printing when bio->bi_status fails
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240808/202408080303.bwOWkFK1-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080303.bwOWkFK1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080303.bwOWkFK1-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/bio.c: In function 'bio_endio':
>> block/bio.c:1620:34: error: 'struct bio' has no member named 'bi_disk'
    1620 |         if (bio->bi_status && bio->bi_disk)
         |                                  ^~
   In file included from include/asm-generic/bug.h:22,
                    from arch/openrisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from block/bio.c:5:
   block/bio.c:1622:62: error: 'struct bio' has no member named 'bi_disk'
    1622 |                                 __func__, bio->bi_status, bio->bi_disk->major,\
         |                                                              ^~
   include/linux/printk.h:437:33: note: in definition of macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   block/bio.c:1621:17: note: in expansion of macro 'printk'
    1621 |                 printk(KERN_ERR "bio: %s status is %d, disk[%d:%d]\n",\
         |                 ^~~~~~
   block/bio.c:1623:36: error: 'struct bio' has no member named 'bi_disk'
    1623 |                                 bio->bi_disk->first_minor);
         |                                    ^~
   include/linux/printk.h:437:33: note: in definition of macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   block/bio.c:1621:17: note: in expansion of macro 'printk'
    1621 |                 printk(KERN_ERR "bio: %s status is %d, disk[%d:%d]\n",\
         |                 ^~~~~~


vim +1620 block/bio.c

  1589	
  1590	/**
  1591	 * bio_endio - end I/O on a bio
  1592	 * @bio:	bio
  1593	 *
  1594	 * Description:
  1595	 *   bio_endio() will end I/O on the whole bio. bio_endio() is the preferred
  1596	 *   way to end I/O on a bio. No one should call bi_end_io() directly on a
  1597	 *   bio unless they own it and thus know that it has an end_io function.
  1598	 *
  1599	 *   bio_endio() can be called several times on a bio that has been chained
  1600	 *   using bio_chain().  The ->bi_end_io() function will only be called the
  1601	 *   last time.
  1602	 **/
  1603	void bio_endio(struct bio *bio)
  1604	{
  1605	again:
  1606		if (!bio_remaining_done(bio))
  1607			return;
  1608		if (!bio_integrity_endio(bio))
  1609			return;
  1610	
  1611		blk_zone_bio_endio(bio);
  1612	
  1613		rq_qos_done_bio(bio);
  1614	
  1615		if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
  1616			trace_block_bio_complete(bdev_get_queue(bio->bi_bdev), bio);
  1617			bio_clear_flag(bio, BIO_TRACE_COMPLETION);
  1618		}
  1619	
> 1620		if (bio->bi_status && bio->bi_disk)
  1621			printk(KERN_ERR "bio: %s status is %d, disk[%d:%d]\n",\
  1622					__func__, bio->bi_status, bio->bi_disk->major,\
  1623					bio->bi_disk->first_minor);
  1624	
  1625		/*
  1626		 * Need to have a real endio function for chained bios, otherwise
  1627		 * various corner cases will break (like stacking block devices that
  1628		 * save/restore bi_end_io) - however, we want to avoid unbounded
  1629		 * recursion and blowing the stack. Tail call optimization would
  1630		 * handle this, but compiling with frame pointers also disables
  1631		 * gcc's sibling call optimization.
  1632		 */
  1633		if (bio->bi_end_io == bio_chain_endio) {
  1634			bio = __bio_chain_endio(bio);
  1635			goto again;
  1636		}
  1637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
