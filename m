Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA732AE78;
	Sat, 29 Nov 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407279; cv=none; b=RDZsq704WU/mW5T/VJZMIhcVe3C6RFFr98USJb6itU/R8IDVBqIkmv+T6BAhHniYEwhZPyb03vqre4i1atYCcf70j+vn0U+EB9LTFmv4az7FOSxP3e12MVNbW99K26ZiIVaOtf2lOQjbNUON4LopKsx92DPzaYfaJYNrN/YNG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407279; c=relaxed/simple;
	bh=LaFWmCSuL4KQQ+UT/MEIhGMRgAIrz8Sy2tDbRWfHTC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePmtTWW7xkAoPbT/Nnd2D/26bm3wQgpJJU4u1Mi6+RlL7IwhWODZhMSZ+S6eXLPptzuAUtv8TLWFrTg739C7clIN8Z0vkFjsFXwy0Bceg4Pav904d3WXFcpVdwvEfU3YB4X5ghNJFkS77BVei4/C5RQP0aHdPSElHTkDpqS8rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/vN6QfU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/vN6QfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764407277; x=1795943277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LaFWmCSuL4KQQ+UT/MEIhGMRgAIrz8Sy2tDbRWfHTC8=;
  b=k/vN6QfU4CBWujrdj/sHFhpODHlC5EHgnpQH6lkFiEPbYG3kyQFVrPgp
   3gMz9adH9SlIcWMIWnzv69rPt6dQ44eIazTCiws+vB2BctZKO3lHCLFcE
   QJ7BcrwGlGgDAVRfTJWqw1TjT17YJ38/SA15WRXeyx9isGuq7W5TOg6uq
   j2tHOXlIwSHHQDG/MV8F3Co+I3E7zr6JaBHlJtriowcRJBkqDyLLSJeJn
   JNN28Qq488MGqGY4+fHGYYNw2td2GrhE/qhaai8YOX9sqkrYKv9Lc0wq8
   u61N+EZqCmLA43Y9Fv2FbJ1+BUQZaZSjKWAR/FPlDIsB5dAYrmFO0IrAF
   A==;
X-CSE-ConnectionGUID: o+5XY5E1SfeTH8XAbKl22A==
X-CSE-MsgGUID: KH2H2Eg+TGqkNUlEMGfXuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="65419288"
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="65419288"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 01:07:56 -0800
X-CSE-ConnectionGUID: fmPpZhEQRmiKI3VGGnD6Uw==
X-CSE-MsgGUID: Iv5FX28QRx6kcI6sEUS0Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="193289632"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 Nov 2025 01:07:54 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vPGvo-0000000074r-1bCf;
	Sat, 29 Nov 2025 09:07:52 +0000
Date: Sat, 29 Nov 2025 17:07:17 +0800
From: kernel test robot <lkp@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/2] zram: introduce compressed data writeback
Message-ID: <202511291628.NZif1jdx-lkp@intel.com>
References: <20251128170442.2988502-2-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128170442.2988502-2-senozhatsky@chromium.org>

Hi Sergey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20251128]
[cannot apply to axboe/for-next linus/master v6.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Senozhatsky/zram-introduce-compressed-data-writeback/20251129-010716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251128170442.2988502-2-senozhatsky%40chromium.org
patch subject: [PATCH 1/2] zram: introduce compressed data writeback
config: x86_64-randconfig-011-20251129 (https://download.01.org/0day-ci/archive/20251129/202511291628.NZif1jdx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251129/202511291628.NZif1jdx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511291628.NZif1jdx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/zram/zram_drv.c:2099:12: warning: 'zram_read_from_zspool_raw' defined but not used [-Wunused-function]
    2099 | static int zram_read_from_zspool_raw(struct zram *zram, struct page *page,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/zram_read_from_zspool_raw +2099 drivers/block/zram/zram_drv.c

  2098	
> 2099	static int zram_read_from_zspool_raw(struct zram *zram, struct page *page,
  2100					     u32 index)
  2101	{
  2102		struct zcomp_strm *zstrm;
  2103		unsigned long handle;
  2104		unsigned int size;
  2105		void *src;
  2106	
  2107		handle = zram_get_handle(zram, index);
  2108		size = zram_get_obj_size(zram, index);
  2109	
  2110		/*
  2111		 * We need to get stream just for ->local_copy buffer, in
  2112		 * case if object spans two physical pages. No decompression
  2113		 * takes place here, as we read raw compressed data.
  2114		 */
  2115		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
  2116		src = zs_obj_read_begin(zram->mem_pool, handle, zstrm->local_copy);
  2117		memcpy_to_page(page, 0, src, size);
  2118		zs_obj_read_end(zram->mem_pool, handle, src);
  2119		zcomp_stream_put(zstrm);
  2120	
  2121		return 0;
  2122	}
  2123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
