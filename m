Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201C1CCB2D
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846634; cv=none; b=DkZeCdC+9a+HKTMCRKXpPE+FeKPagGD9/ExYd33/0tqo/ORK/xwrURiqxZqRI2rw+KIifQmU5c9dqxwGMaw5YIwn5/AwUz7rxfHESgm37Dm94dk1MSrarEwPDDBGTeMIx5PF+wCBYJCl/3LSSIRgcqFY6+P1vxVq43UXHQOZrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846634; c=relaxed/simple;
	bh=uvRMY8hQokzZD51R5s8UPXXu6THQmKDB8iJWHfPk0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUOh/TBvjpf7ArZrEd8RindP/8xXU+6dN0qkFddH0LyzD6cU1F2pT1cWAL+NpPn4atfP1hPiHF1NxxnGMgQoed1uccaBBv3FYHysCAsc/nHCIebDsIuyBy2ZyyGnTQnl4yEeCn0cFHREaS2QjmnFRvg4yzlCT3xjQixuIeDW7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iE5z1jzx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iE5z1jzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730846633; x=1762382633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uvRMY8hQokzZD51R5s8UPXXu6THQmKDB8iJWHfPk0Tg=;
  b=iE5z1jzxKPmPrcDTr6HWvH/PLrSm9hoX6+sdW7x9I/NonLd0Fnw0jV4F
   TTljP6CYHV3upzsbx8CO6OKOUWos+NhwfHulzsCMrqFBuWWWxgyq5Jg3K
   n+cmSX0VJlEY+mJWVx86urYLmJsb7YoT0CPEq0H/Mby7yAzu8/nvq64r1
   Y4VWlcbEQ9asopkb1/SrV9R0IKuG0HugGrQrlpG65FJl7k5PEJ9MCTmnh
   FRn8RoqKIb16Einc2KjFAzs99k1REvQkKGwb1iyZnWA14VuiWwCo9/Tfz
   doSa0aga5tvijCTGYPlN2QTXc8kZ1HwvquvrNyfT0eVdq+Ozcd7XdOECS
   w==;
X-CSE-ConnectionGUID: UeAwlh+zSlCoArOUI0wbUA==
X-CSE-MsgGUID: XHy3eMAjT1ehyvP+kABVUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="41249491"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="41249491"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:43:52 -0800
X-CSE-ConnectionGUID: vSfeQLRaRkeJvS8iZXo+fg==
X-CSE-MsgGUID: GHrXa8UWT06oPy6YDhGrQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84327066"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:43:51 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8SH6-000mXn-2H;
	Tue, 05 Nov 2024 22:43:48 +0000
Date: Wed, 6 Nov 2024 06:43:32 +0800
From: kernel test robot <lkp@intel.com>
To: LongPing Wei <weilongping@oppo.com>, axboe@kernel.dk
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	LongPing Wei <weilongping@oppo.com>
Subject: Re: [PATCH] block: fix the initial value of wp_offset for npo2 zone
 size
Message-ID: <202411060615.u1WE9nlu-lkp@intel.com>
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
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20241106/202411060615.u1WE9nlu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060615.u1WE9nlu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060615.u1WE9nlu-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/blk-zoned.c: In function 'disk_get_and_lock_zone_wplug':
>> block/blk-zoned.c:540:56: error: passing argument 1 of 'bio_offset_from_zone_start' makes pointer from integer without a cast [-Wint-conversion]
     540 |         zwplug->wp_offset = bio_offset_from_zone_start(sector);
         |                                                        ^~~~~~
         |                                                        |
         |                                                        sector_t {aka long long unsigned int}
   In file included from block/blk-zoned.c:15:
   include/linux/blkdev.h:1371:63: note: expected 'struct bio *' but argument is of type 'sector_t' {aka 'long long unsigned int'}
    1371 | static inline sector_t bio_offset_from_zone_start(struct bio *bio)
         |                                                   ~~~~~~~~~~~~^~~


vim +/bio_offset_from_zone_start +540 block/blk-zoned.c

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
