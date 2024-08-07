Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628911448C7;
	Wed,  7 Aug 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061186; cv=none; b=Mgeh4ELADpYwMfDzgXf+n7bs8EusmADJS6DC9Ei4uCTatdli1VBry2CHB3gOh37O9+bXYcecHMVr/egZh5KhlPgS2zDly5V/pvOZCVgdDpBnYDxVuBBXAP8cUhaGcjMAs16gxiEY35nKqUoSrPDae0K/o0SNQ40puqQx4Wn7HHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061186; c=relaxed/simple;
	bh=PROBiw0sarCM3nOobK70TOAENhBCdBEH39cijO+nsW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edj7gI+Ybnpay+OxWTjCs0md+XQL2CCGYLcN86vqVrsjofpehEydhi4mtJWInH1By76krGZTiO8ZxEANSQEcF9gGzCWENlXmePI9dt6Y9WOUBQowLiIcEC82gcWNwvvQOMUh9yb28oKaPrcuo1C8+yO6Xm6Iy0vw3vKDnxqxd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lw6sEx9b; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lw6sEx9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723061184; x=1754597184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PROBiw0sarCM3nOobK70TOAENhBCdBEH39cijO+nsW0=;
  b=Lw6sEx9bTAniWCHreS04uxbyLHzSZG3/6KXbkkvYCEsOQunHzeJh0Vbe
   63AhytopqhAz+kJMzQw4Pwe2CVKvhL9IZuvQdqCwh9nIgc/6ZxhOIyxSe
   /HkpU7lDxYt+NbUbv84+vD0XN/Wg+oflMdFENQ2bef9hS4jLtNT2YQbod
   IzuA6ANAKniSiXrnWIoVPZKZ1zvWSrAOZ2/764L5JhfFMZtn/FZa6N9Rm
   0KMqm0SkgMpNuggPWA2MKlpcJ510EL14Zg3jX5ECttJXpy82g7WqXZgcK
   N4ZKGjl9WGaiVRO97DHc80d0DA+tf1sbewNeqShjQayah9+vtRup+Tzwl
   Q==;
X-CSE-ConnectionGUID: SBD719i6QdGquvcMxx61fw==
X-CSE-MsgGUID: kcycni7wQ2+oJ673SWg5mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31826399"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="31826399"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 13:06:24 -0700
X-CSE-ConnectionGUID: V83V2bC7SHOzgT8cTDJKtQ==
X-CSE-MsgGUID: kwcFdcVaQnG70uwLbTcSwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56918330"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 07 Aug 2024 13:06:21 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbmvL-0005gW-1r;
	Wed, 07 Aug 2024 20:06:19 +0000
Date: Thu, 8 Aug 2024 04:05:29 +0800
From: kernel test robot <lkp@intel.com>
To: 824731276@qq.com, axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	baiguo@kylinos.cn
Subject: Re: [PATCH] block:added printing when bio->bi_status fails
Message-ID: <202408080348.jL0uiVq7-lkp@intel.com>
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
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240808/202408080348.jL0uiVq7-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080348.jL0uiVq7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080348.jL0uiVq7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/bio.c:1620:29: error: no member named 'bi_disk' in 'struct bio'
    1620 |         if (bio->bi_status && bio->bi_disk)
         |                               ~~~  ^
   block/bio.c:1622:36: error: no member named 'bi_disk' in 'struct bio'
    1622 |                                 __func__, bio->bi_status, bio->bi_disk->major,\
         |                                                           ~~~  ^
   include/linux/printk.h:465:60: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   block/bio.c:1623:10: error: no member named 'bi_disk' in 'struct bio'
    1623 |                                 bio->bi_disk->first_minor);
         |                                 ~~~  ^
   include/linux/printk.h:465:60: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   3 errors generated.


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
