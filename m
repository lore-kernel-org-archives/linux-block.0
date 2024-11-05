Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3605C1F7570
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839149; cv=none; b=mVKhTfAyyWEViOixpa1wjo7856QX9zzrmd7Iv4Jn8w1HnTqExYiCu2dUXIFHwSIlvfc2AsJPaCJ2JEnrOYvUA4Yt5n3FnQ5g3dXj5VtFwRSrobTXfn2k76QD6PT8XTyzFmnRNKohTy6BGoknHpwFMVKRTxbovTydOJkZII2H1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839149; c=relaxed/simple;
	bh=2/MlzhKoh44yrorz/XVydm1palRfWk9z4YDY4t7UfdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV0IOMhUvj2M6/BOQjvM5KURt+qvnyet2LPHe7dUpszvo9cG/FYSJN1aF5Ob+P2lrVfnibm7LNgbOcIo6GMgIwO7/JqlAg+WB21+gPCa2M0HxINGReZMUzi9Z5o/v5a/pbZeHCa5G+DApcsmAapkyck60lXDF5R7JFzZ6NRjXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W266Cgc8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W266Cgc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730839147; x=1762375147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/MlzhKoh44yrorz/XVydm1palRfWk9z4YDY4t7UfdA=;
  b=W266Cgc8uGa84OIaLdCN5vLpAI0s+Vs6H6ufdTVbnfD4GhZfEVNkaCeZ
   KgNs8LCHcL8bTp4mdHXQvFK5BGVRHajwaX1/x42xfAI3FeL1dgKKKmhKh
   DCdAVu02XbtuwI3Nlnqj1Iyr9C+Uksbzj+cpavzpl9gA9w8Ax/c/5jg+L
   N377N2Cd9WDmvc8ShMoxLS5VE7KjBViP4u1DrFxxgER5Xy8aZ4woDJB/N
   eEbAftTnl3Gtbkp9bhbQMZr5RJUiXTarlyVojdA5bTfltqDF3Sk9hwDep
   RKFwsUnzRjwsnebSlxtxp4G9fC7OLOzgUof9QYOtHVRtVwb6VH4nqayYd
   A==;
X-CSE-ConnectionGUID: u4pmTw5eSayNLllIjGSDNw==
X-CSE-MsgGUID: CK8vgNGjTXmXV/Kc7YuN+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="18231081"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="18231081"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 12:39:06 -0800
X-CSE-ConnectionGUID: wpUO2zOPTKKppmm6WwZHVQ==
X-CSE-MsgGUID: UQ58kimxTBeUOj0eW6DUcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="121646957"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2024 12:38:47 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8QK5-000mRV-1Q;
	Tue, 05 Nov 2024 20:38:45 +0000
Date: Wed, 6 Nov 2024 04:38:00 +0800
From: kernel test robot <lkp@intel.com>
To: LongPing Wei <weilongping@oppo.com>, axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, LongPing Wei <weilongping@oppo.com>
Subject: Re: [PATCH] block: fix the initial value of wp_offset for npo2 zone
 size
Message-ID: <202411060445.EVXgwLvF-lkp@intel.com>
References: <20241105101120.1207567-1-weilongping@oppo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105101120.1207567-1-weilongping@oppo.com>

Hi LongPing,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.12-rc6 next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LongPing-Wei/block-fix-the-initial-value-of-wp_offset-for-npo2-zone-size/20241105-181423
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241105101120.1207567-1-weilongping%40oppo.com
patch subject: [PATCH] block: fix the initial value of wp_offset for npo2 zone size
config: x86_64-buildonly-randconfig-002-20241106 (https://download.01.org/0day-ci/archive/20241106/202411060445.EVXgwLvF-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060445.EVXgwLvF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060445.EVXgwLvF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/blk-zoned.c:15:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> block/blk-zoned.c:540:49: error: incompatible integer to pointer conversion passing 'sector_t' (aka 'unsigned long long') to parameter of type 'struct bio *' [-Wint-conversion]
     540 |         zwplug->wp_offset = bio_offset_from_zone_start(sector);
         |                                                        ^~~~~~
   include/linux/blkdev.h:1371:63: note: passing argument to parameter 'bio' here
    1371 | static inline sector_t bio_offset_from_zone_start(struct bio *bio)
         |                                                               ^
   4 warnings and 1 error generated.


vim +540 block/blk-zoned.c

   494	
   495	/*
   496	 * Get a reference on the write plug for the zone containing @sector.
   497	 * If the plug does not exist, it is allocated and hashed.
   498	 * Return a pointer to the zone write plug with the plug spinlock held.
   499	 */
   500	static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
   501						sector_t sector, gfp_t gfp_mask,
   502						unsigned long *flags)
   503	{
   504		unsigned int zno = disk_zone_no(disk, sector);
   505		struct blk_zone_wplug *zwplug;
   506	
   507	again:
   508		zwplug = disk_get_zone_wplug(disk, sector);
   509		if (zwplug) {
   510			/*
   511			 * Check that a BIO completion or a zone reset or finish
   512			 * operation has not already removed the zone write plug from
   513			 * the hash table and dropped its reference count. In such case,
   514			 * we need to get a new plug so start over from the beginning.
   515			 */
   516			spin_lock_irqsave(&zwplug->lock, *flags);
   517			if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED) {
   518				spin_unlock_irqrestore(&zwplug->lock, *flags);
   519				disk_put_zone_wplug(zwplug);
   520				goto again;
   521			}
   522			return zwplug;
   523		}
   524	
   525		/*
   526		 * Allocate and initialize a zone write plug with an extra reference
   527		 * so that it is not freed when the zone write plug becomes idle without
   528		 * the zone being full.
   529		 */
   530		zwplug = mempool_alloc(disk->zone_wplugs_pool, gfp_mask);
   531		if (!zwplug)
   532			return NULL;
   533	
   534		INIT_HLIST_NODE(&zwplug->node);
   535		INIT_LIST_HEAD(&zwplug->link);
   536		atomic_set(&zwplug->ref, 2);
   537		spin_lock_init(&zwplug->lock);
   538		zwplug->flags = 0;
   539		zwplug->zone_no = zno;
 > 540		zwplug->wp_offset = bio_offset_from_zone_start(sector);
   541		bio_list_init(&zwplug->bio_list);
   542		INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
   543		zwplug->disk = disk;
   544	
   545		spin_lock_irqsave(&zwplug->lock, *flags);
   546	
   547		/*
   548		 * Insert the new zone write plug in the hash table. This can fail only
   549		 * if another context already inserted a plug. Retry from the beginning
   550		 * in such case.
   551		 */
   552		if (!disk_insert_zone_wplug(disk, zwplug)) {
   553			spin_unlock_irqrestore(&zwplug->lock, *flags);
   554			mempool_free(zwplug, disk->zone_wplugs_pool);
   555			goto again;
   556		}
   557	
   558		return zwplug;
   559	}
   560	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
